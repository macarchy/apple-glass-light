-- Apple Glass Light — the Liquid Glass surface treatment, light mode.
--
-- Same structure as the dark theme, inverted where the material demands it.
-- The important difference is not the palette: a light glass pane is *brighter*
-- than the wallpaper behind it, so the backdrop has to be lifted toward white
-- rather than deepened, and the rim reads as a shadow rather than a highlight.

local active_border_color = { colors = { "rgba(00000059)", "rgba(00000018)" }, angle = 135 }
local inactive_border_color = "rgba(00000014)"

hl.config({
  general = {
    border_size = 1,
    gaps_in = 6,
    gaps_out = 12,

    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
      border_locked_active = active_border_color,
      border_locked_inactive = inactive_border_color,
    },
  },

  decoration = {
    rounding = 14,
    rounding_power = 2.6,

    -- Light-mode macOS shadows are shorter and much fainter; a dark shadow at
    -- dark-mode strength reads as grime against a bright wallpaper.
    shadow = {
      enabled = true,
      range = 26,
      render_power = 3,
      offset = { 0, 6 },
      color = "rgba(00000026)",
      color_inactive = "rgba(00000014)",
    },

    blur = {
      enabled = true,
      -- 20/4 to match the dark theme: the deep macOS-style frost over the
      -- aquarium. The 4th pass is the one real cost increase; size alone is
      -- free in dual-kawase.
      size = 20,
      passes = 4,
      new_optimizations = true,
      ignore_opacity = true,

      -- Blur straight through to the aquarium, same as the dark theme: the
      -- desktop is glass over water, and stacked panes stop compounding.
      xray = true,

      -- brightness > 1 is what makes this read as light glass: Apple's light
      -- material lifts the backdrop toward white before tinting it. Over the
      -- deep-blue water it needs a stronger lift than it did over bright
      -- wallpapers, or the panes turn murky. vibrancy drops further still --
      -- the water is already saturated, and a light pane that picks up its
      -- color reads as tinted plastic, not glass. vibrancy_darkness stays at
      -- zero: deepening shadows here would just make the pane look dirty.
      brightness = 1.16,
      contrast = 0.95,
      vibrancy = 0.14,
      vibrancy_darkness = 0.0,
      noise = 0.02,

      popups = true,
      popups_ignorealpha = 0.4,
      special = true,
    },
  },

  misc = {
    session_lock_blur = true,
  },
})

-- Slightly more opaque than the dark theme. Dark text on a translucent light
-- pane loses contrast faster than light text on a dark one, because the
-- wallpaper showing through raises the floor instead of lowering the ceiling.
o.window({ tag = "default-opacity" }, { opacity = "0.93 0.87" })

-- Terminals carry their glass in the terminal itself (window.opacity in this
-- theme's alacritty.toml, alpha in its foot.ini, background_opacity in its kitty.conf): the background is
-- translucent but glyphs stay at full alpha. So the compositor must NOT also
-- dim the surface, or the text fades along with it. Keep a whisper of dimming
-- on unfocused terminals. org.omarchy.agent is foot too (the Claude window).
-- no_blur keeps the aquarium crisp behind the glass: foot skips compositor
-- blur anyway (it hints its surface opaque), which is where this look comes
-- from; kitty declares real alpha, so without this rule the 20/4 material
-- frosts its backdrop into a featureless slab that reads as an opaque window.
o.window({ class = "^(Alacritty|foot|footclient|kitty|org\\.omarchy\\.agent)$" }, { opacity = "1.0 0.95", no_blur = true })

local glass_surfaces = table.concat({
  "omarchy-bar",
  "omarchy-menu",
  "omarchy-notifications",
  -- Notification center sidebar (phmatray.notification-center shell plugin).
  "phmatray-notification-center",
  "omarchy-osd",
  "omarchy-polkit",
  "omarchy-reminders",
  "omarchy-clipboard",
  "omarchy-emojis",
  "omarchy-image-selector",
  "omarchy-keyboard-panel",
  "omarchy-network-qr",
  "omarchy-network-speedtest",
  "omarchy-disk-speedtest",
  "omarchy-speed-test",
  -- The Cmd+Tab app switcher (macarchy.switcher shell plugin).
  "macarchy-switcher",
  -- The dock, when one is running. Harmless when it is not.
  "nwg-dock",
}, "|")

hl.layer_rule({
  match = { namespace = "^(" .. glass_surfaces .. ")$" },
  blur = true,
  blur_popups = true,
  ignore_alpha = 0.1,
})

# Shot list

A gallery for this theme, capturable in one sitting (~10 minutes). The point of
the set is the thing the current single `preview.png` cannot show: **the glass
has moving water behind it**, and light glass is the harder half of the pair —
a bright pane over dark water is exactly where translucency goes grey, and where
this theme's `brightness 1.16` and darkened palette earn their keep.

Save everything into `docs/media/` as `NN-name.png` (or `.gif` / `.mp4`), then
link the ones worth keeping from `README.md`.

## Before you start

```sh
mkdir -p docs/media
omarchy theme set "Apple Glass Light"
omarchy-aquarium-toggle on
```

Shoot in daylight, or at least with the aquarium at a daytime tint — that is the
condition the palette was measured against. Set the screenshot destination:

```sh
export OMARCHY_SCREENSHOT_DIR="$PWD/docs/media"
omarchy screenshot fullscreen save
```

Close anything personal first — the shots are going into a public repo.

## The shots

Numbers are the intended gallery order.

- [x] **01 — hero: light glass over water.** Aquarium **on**. A file manager
      and a terminal (`btop`), overlapping only at the edge. Do *not* overlap
      them by a third as this list first said: terminals are exempt from
      compositor blur here, so a terminal laid over another window shows that
      window's raw text through its own 0.70 alpha, and the result is mud. Keep
      the terminal mostly over the water, where the exemption is the point. Focus
      the terminal so the front window carries the dark active hairline and the
      back one the fainter inactive one. Bar visible. Make sure a fish or a
      caustic highlight is visibly *behind* a pane, not beside it.
- [x] **02 — the same frame, aquarium off.** `omarchy-aquarium-toggle off`, put
      `backgrounds/1-daybreak.jpg` up, do not move a single window, capture
      again. 01 and 02 side by side is the argument. Turn the aquarium back on
      afterwards.
- [ ] **03 — motion (the one that cannot be faked).** A 3–5 second clip of the
      idle desktop from shot 01, water moving behind the panes, nothing else
      happening.

      ```sh
      omarchy screenrecord --fullscreen        # start
      omarchy screenrecord --stop-recording    # stop
      ffmpeg -i <clip>.mp4 -vf "fps=15,scale=960:-1:flags=lanczos,split[a][b];[a]palettegen[p];[b][p]paletteuse" docs/media/03-motion.gif
      ```

      Keep it under ~5 MB so GitHub plays it inline.
- [ ] **04 — the contrast proof.** A terminal at 0.70 alpha over the *darkest*
      part of the aquarium you can arrange, showing colored output that uses the
      whole ANSI set — `git log --oneline --graph --color`, a `rg` result with
      matches highlighted, or `bat` on a source file. This is the shot that
      answers "surely light-on-glass is unreadable": every one of those colors
      was darkened until it cleared WCAG 3:1 on that exact ground.
- [ ] **05 — depth stack.** Three or four *blurred* windows cascaded with
      visible overlap. `blur.xray` means each pane blurs to the water rather
      than to the pane below, so a light stack should not turn to grey mush,
      and that is the claim this shot has to back up. Use GTK apps (files,
      settings, text editor), **not** terminals: terminals carry
      `no_blur = true`, so a terminal stack demonstrates nothing about xray.
- [ ] **06 — the app launcher.** `SUPER + ALT + SPACE` (`omarchy-menu toggle
      apps`). Type a couple of characters so the list is filtered and one row
      carries the blue selection. Do not expect to recognise the windows
      behind it. Light mode does dim toward grey rather than black, but the menu
      layer is blurred as well, and the two together leave a wash rather than a
      readable desktop. That is correct behaviour, not a bug to shoot around.
- [ ] **07 — the Omarchy menu.** `SUPER + SPACE` (`omarchy-menu toggle`), one
      submenu deep, so the scrim, the card and the selected row are all in
      frame.
- [x] **08 — the bar, close up.** Region-capture the top bar over a *busy* part
      of the wallpaper — that is where a 0.68-alpha light surface either holds
      its dark text or does not.

      ```sh
      omarchy screenshot region save
      ```
- [x] **09 — a notification on glass.** Trigger one and catch it before it
      expires:

      ```sh
      notify-send "Apple Glass Light" "Notification banners are 0.78-alpha glass." && sleep 1 && omarchy screenshot fullscreen save
      ```
- [ ] **10 — controls.** The control center or the network / volume panel open,
      with keyboard focus visible so the blue ring shows against the recessed
      black-at-low-alpha fills. That inversion from the dark theme is worth a
      frame of its own.
- [ ] **11 — the lock screen.** `session_lock_blur` is on, so the desktop is
      still there, frosted and lifted toward white. Run the capture from a
      background shell, since you cannot type while locked:

      ```sh
      (sleep 6; grim docs/media/11-lock.png) & omarchy-shell lock lock
      ```

      If the compositor refuses to capture while locked, skip this one rather
      than shipping a black rectangle.
- [ ] **12 — Claude Code in the theme.** This repo ships `claude.json`; open
      Claude Code in a terminal with a diff on screen so the added/removed
      backgrounds and the prompt border show — the dark half does not ship a
      Claude Code theme, so this one is unique to Light.
- [ ] **13 — the pair.** For the auto-appearance story: shot 01's exact window
      arrangement, captured once under `Apple Glass Light` and once under
      `Apple Glass` (`omarchy theme set "Apple Glass"`), so both READMEs can
      show the same desktop at 8am and at 10pm. Set the theme back afterwards,
      or let `omarchy-auto-appearance` do it.

## Afterwards

- [ ] Replace or keep `preview.png` as the single top-of-README image; put the
      rest in a `## Gallery` section.
- [ ] Shots 01–03 and 13 pair up with the identical shots in `apple-glass` —
      capture both themes in the same sitting so the window layout matches.
- [ ] The 01 / 02 pair and the 03 clip are also what an r/unixporn post needs.

# Custom Universal Blue Minimal Desktop - Project Reference

**Last Updated:** October 22, 2025

## Project Overview

Building a minimal, secure, Linux-idiomatic desktop environment inspired by Omarchy, using Universal Blue's Fedora Atomic OS images. The goal is to achieve Omarchy's aesthetic and minimalism while improving security and leveraging atomic/immutable OS benefits.

### Core Philosophy

- **Minimal by design**: Only include what's necessary
- **Security-first**: Fix Omarchy's security issues
- **Atomic/Immutable**: Leverage Universal Blue's image-based approach
- **Terminal aesthetic**: Maintain the clean, terminal-centric workflow
- **Framework-optimized**: Include Framework laptop-specific optimizations

---

## Key Components

### Base System

- **Foundation**: Universal Blue `base` image
- **OS**: Fedora Atomic (image-based/immutable)
- **Architecture**: x86_64
- **Target Hardware**: Framework Laptop

### Window Management

- **Compositor**: mangowc (https://github.com/DreamMaoMao/mangowc)
  - Mango Wayland Compositor
  - Minimal, lightweight Wayland compositor
  - Alternative to Hyprland used in Omarchy

### Display/UI Components

- **Top Bar**: waybar (Omarchy-compatible, highly configurable)
- **Terminal**: ghostty (modern, GPU-accelerated, image rendering)
- **Launcher**: fuzzel (initial) â†’ walker (future, Omarchy-compatible)
- **Notifications**: mako (Omarchy-compatible)
- **Lock Screen**: swaylock-effects
- **Session**: getty autologin (single-user, LUKS password = auth)
- **Shell**: bash (login) + zsh (interactive via ghostty)

---

## Component Decisions - FINALIZED (Oct 22, 2025)

### Core Desktop Components

1. **Top bar**: **waybar**
   - Omarchy uses it (theme compatible)
   - Highly configurable (JSON/CSS)
   - mangowc author recommends it
   - Available in Fedora repos

2. **Terminal emulator**: **ghostty** (primary)
   - Modern, GPU-accelerated
   - Image rendering support
   - User preference (already using on macOS)
   - Omarchy has full theme support
   - Note: Not in Fedora repos, will need to build

3. **Application launcher**: **fuzzel** (initial) â†’ **walker** (future)
   - Start with fuzzel (in Fedora repos, minimal, fast)
   - Migrate to walker later (Omarchy's current choice)
   - walker not in Fedora, will need to build

4. **Notification daemon**: **mako**
   - Omarchy uses it
   - Minimal, lightweight
   - Available in Fedora repos
   - Theme compatible

5. **Screen lock**: **swaylock-effects**
   - Stable, well-documented
   - Aesthetic options (blur, clock, etc.)
   - Available in Fedora repos (COPR)
   - Note: Can't use hyprlock (Hyprland-specific)

6. **Session management**: **getty autologin**
   - Simplest approach
   - No display manager overhead
   - Matches single-user philosophy
   - LUKS password = authentication

7. **Shell**: **bash** (login) + **zsh** (interactive)
   - bash as login shell (required for system boot chain)
   - zsh launched by ghostty for interactive use
   - User already has zsh configs from macOS
   - Configure via ghostty: `command = /usr/bin/zsh`

### Supporting Utilities

| Component       | Choice                  | Status   | Notes                               |
| --------------- | ----------------------- | -------- | ----------------------------------- |
| Wallpaper       | swaybg â†’ swww         | In repos | Start simple, add transitions later |
| Clipboard       | wl-clipboard + cliphist | In repos | Standard Wayland clipboard          |
| Screenshots     | grim + slurp + swappy   | In repos | swappy for quick annotations        |
| Night light     | wlsunset                | In repos | Alternative to hyprsunset           |
| Idle management | swayidle                | In repos | Trigger lock screen, etc.           |
| Portal          | xdg-desktop-portal-wlr  | In repos | Screen sharing support              |
| Audio           | pipewire                | In repos | Modern audio stack                  |
| Bluetooth       | bluez + blueman         | In repos | Standard BT stack                   |
| File manager    | thunar + yazi           | In repos | GUI + TUI options                   |

### Omarchy Component Reference

For theme compatibility and configuration reference:

**What Omarchy uses:**

- Compositor: Hyprland
- Top Bar: waybar âœ… (we're using this)
- Terminal: Alacritty (default), Ghostty âœ…, Kitty (full theme support)
- Launcher: Walker (v1.0+)
- Notifications: mako âœ… (we're using this)
- Lock Screen: hyprlock (Hyprland-specific, we can't use)
- Editor: Neovim (LazyVim)
- Shell: bash (required for boot chain) âœ…

**Theme Integration:**

- Omarchy themes cover: desktop, terminal, neovim, btop, mako, waybar, walker, lock screen
- We can port: waybar, mako, ghostty themes directly
- 12 built-in themes with coordinated color schemes

---

## Build Strategy & Package Management

### Packages by Source

**From Fedora Repos (Easy):**

- waybar, mako, swaylock-effects, swayidle
- fuzzel, swaybg, wlsunset
- grim, slurp, swappy
- wl-clipboard, cliphist
- xdg-desktop-portal-wlr
- pipewire, bluez, blueman
- thunar, yazi
- bash, zsh

**Need to Build from Source (Complex):**

- **mangowc** (compositor) - requires:
  - wlroots 0.19.x (patched or recent)
  - scenefx (window effects library)
  - Standard build deps (meson, ninja, etc.)
- **ghostty** (terminal) - requires:
  - Zig compiler
  - GTK4, libadwaita dependencies
  - Build from GitHub source
- **walker** (launcher) - Phase 7, optional
  - Go-based application
  - Build from source

**From COPR/Third-party:**

- swaylock-effects (may need COPR)

### Container Build Order

```
1. Base Layer: Universal Blue base image
   |
   v
2. Build Dependencies: Install compilers, build tools
   (meson, ninja, gcc, zig, pkg-config, etc.)
   |
   v
3. wlroots: Build and install wlroots 0.19.x
   |
   v
4. scenefx: Build and install scenefx
   |
   v
5. mangowc: Build and install mangowc compositor
   |
   v
6. ghostty: Build and install ghostty terminal
   |
   v
7. Fedora Packages: Install all repo-available packages
   (waybar, mako, fuzzel, etc.)
   |
   v
8. Configuration Layer:
   - Copy dotfiles and configs
   - Set up getty autologin
   - Configure ghostty to launch zsh
   - Set up theme structure
   |
   v
9. Cleanup: Remove build dependencies, clean caches
```

### Initial vs Final Build

**Minimal Viable Desktop (Phase 1-3):**

- mangowc + waybar + ghostty + fuzzel + mako
- Basic configs, no theming
- Getty autologin
- Goal: Bootable, usable desktop

**Feature Complete (Phase 4-6):**

- All supporting utilities
- Framework optimizations
- Full Omarchy theme ports
- Power management tuned

**Polish & Extras (Phase 7):**

- walker launcher
- Additional themes
- Enhanced workflows
- Optional developer tools

---

## Source Inspirations

### 1. Omarchy

- **URLs**:
  - Manual: https://learn.omacom.io/2/the-omarchy-manual/91/welcome-to-omarchy
  - GitHub: https://github.com/basecamp/omarchy
- **What to adopt**:
  - Terminal aesthetic
  - Minimal package selection philosophy
  - Configuration approach
  - Visual design language
- **Security concerns to fix** (from https://Ã£Æ’Å¾Ã£Æ’ÂªÃ£â€šÂ¦Ã£â€šÂ¹.com/a-word-on-omarchy/):
  - World-writable permissions issues
  - Questionable default configurations
  - Need to audit all configs before adoption

### 2. Universal Blue Bluefin

- **URL**: https://projectbluefin.io/
- **What to pull**:
  - Framework laptop optimizations
  - Developer tooling approach
  - Package selections for hardware support
  - Build system methodology
- **What to avoid**:
  - Extra bloat
  - Multiple desktop environments
  - Unnecessary developer tools

### 3. Universal Blue Base

- **URL**: https://github.com/ublue-os/base
- **Starting point**: Clean slate for custom builds
- **Benefits**:
  - Minimal starting point
  - No pre-installed DE/WM
  - Declarative image building

---

## Technical Architecture

### Image-Based OS Approach

```
Custom Image Build
|-- Base: universal-blue/base
|-- Layer: mangowc + dependencies
|-- Layer: Framework optimizations (from bluefin)
|-- Layer: Minimal UI components
|-- Config: Hardened Omarchy-inspired configs
+-- Package: Developer tools (minimal set)
```

### Build System

- **Tool**: GitHub Actions (Universal Blue standard)
- **Format**: Containerfile/Dockerfile
- **Registry**: GitHub Container Registry (ghcr.io)
- **Updates**: Automatic via GitHub Actions

---

## Security Considerations

### Known Omarchy Issues to Address

1. **File Permissions**
   - Review all config file permissions
   - Ensure no world-writable files
   - Proper ownership (user vs root)

2. **Service Configurations**
   - Audit systemd service files
   - Review socket permissions
   - Validate service isolation

3. **Default Passwords/Keys**
   - Ensure no hardcoded credentials
   - Proper key generation
   - Secure defaults

4. **Network Security**
   - Review exposed services
   - Firewall configurations
   - Network manager settings

### Additional Hardening

- SELinux enforcing mode (Fedora default)
- Minimal attack surface (fewer packages)
- Regular automated updates via atomic images
- Immutable base system

---

## Framework Laptop Optimizations

### Hardware Support Needed

- **Display**: High DPI scaling support
- **Power Management**: Battery optimization
- **Firmware**: Framework-specific firmware updates
- **Input**: Touchpad gestures, keyboard backlight
- **Expansion Cards**: USB-C/Thunderbolt support
- **WiFi/Bluetooth**: Intel drivers
- **Audio**: PipeWire configuration

### Packages to Consider (from Bluefin)

- Framework-specific kernel modules
- Power management tools (TLP/auto-cpufreq)
- Firmware updater (fwupd with Framework support)
- Intel graphics optimizations
- Battery threshold management

---

## Development Roadmap

### Phase 1: Foundation Setup âœ… READY TO START

- [ ] Set up Universal Blue base image build
- [ ] Create GitHub repository structure
- [ ] Configure GitHub Actions workflow
- [ ] Test basic image build and deployment

### Phase 2: Core Components

- [ ] Integrate mangowc compositor
  - [ ] Build wlroots 0.19.x
  - [ ] Build scenefx
  - [ ] Build mangowc from source
- [ ] Add minimal Wayland dependencies
- [ ] Configure basic session management (getty autologin)
- [ ] Test compositor functionality

### Phase 3: Essential Desktop Environment

- [ ] Add waybar (status bar)
  - [ ] Basic configuration
  - [ ] System tray support
- [ ] Add ghostty (terminal)
  - [ ] Build from source
  - [ ] Configure zsh launch
  - [ ] Port user's existing zsh configs
- [ ] Add fuzzel (launcher)
- [ ] Add mako (notifications)
- [ ] Test basic desktop workflow

### Phase 4: Supporting Utilities

- [ ] Add swaylock-effects + swayidle (lock/idle)
- [ ] Add swaybg (wallpaper)
- [ ] Add grim + slurp + swappy (screenshots)
- [ ] Add wlsunset (night light)
- [ ] Add wl-clipboard + cliphist (clipboard manager)
- [ ] Add xdg-desktop-portal-wlr (screen sharing)

### Phase 5: Framework Optimizations

- [ ] Identify Framework-specific packages from Bluefin
- [ ] Add power management (TLP or power-profiles-daemon)
- [ ] Include firmware update tools (fwupd)
- [ ] Add Intel graphics optimizations
- [ ] Configure battery threshold management
- [ ] Test on Framework hardware

### Phase 6: Theming & Polish

- [ ] Port Omarchy waybar themes
- [ ] Port Omarchy ghostty/terminal themes
- [ ] Port Omarchy mako themes
- [ ] Create theme switcher mechanism
- [ ] Add wallpaper collection
- [ ] Configure coordinated color schemes

### Phase 7: Advanced Features (Optional)

- [ ] Build walker launcher (Omarchy's current choice)
- [ ] Add swww for wallpaper transitions
- [ ] Add file manager (thunar + yazi)
- [ ] Add additional developer tools
- [ ] Create custom Omarchy-inspired themes

### Phase 8: Testing & Refinement

- [ ] End-to-end testing on Framework
- [ ] Performance optimization
- [ ] Documentation
- [ ] User guides
- [ ] Troubleshooting guide

---

## Technical Resources

### Universal Blue Documentation

- Main docs: https://universal-blue.org/
- Base image: https://github.com/ublue-os/base
- Bluefin: https://github.com/ublue-os/bluefin
- Image guide: https://universal-blue.org/tinker/make-your-own/

### Wayland Compositor Resources

- mangowc: https://github.com/DreamMaoMao/mangowc
- Wayland protocols: https://wayland.freedesktop.org/
- wlroots (if mangowc uses it): https://gitlab.freedesktop.org/wlroots/wlroots

### Framework Resources

- Framework docs: https://frame.work/
- Community guides: https://community.frame.work/
- Linux support: https://github.com/FrameworkComputer/linux-docs

---

## Component Decisions - FINALIZED (Oct 22, 2025)

### Core Desktop Components

1. **Top bar**: **waybar**
   - Omarchy uses it (theme compatible)
   - Highly configurable (JSON/CSS)
   - mangowc author recommends it
   - Available in Fedora repos

2. **Terminal emulator**: **ghostty** (primary)
   - Modern, GPU-accelerated
   - Image rendering support
   - User preference (already using on macOS)
   - Omarchy has full theme support
   - Note: Not in Fedora repos, will need to build

3. **Application launcher**: **fuzzel** (initial) â†’ **walker** (future)
   - Start with fuzzel (in Fedora repos, minimal, fast)
   - Migrate to walker later (Omarchy's current choice)
   - walker not in Fedora, will need to build

4. **Notification daemon**: **mako**
   - Omarchy uses it
   - Minimal, lightweight
   - Available in Fedora repos
   - Theme compatible

5. **Screen lock**: **swaylock-effects**
   - Stable, well-documented
   - Aesthetic options (blur, clock, etc.)
   - Available in Fedora repos (COPR)
   - Note: Can't use hyprlock (Hyprland-specific)

6. **Session management**: **getty autologin**
   - Simplest approach
   - No display manager overhead
   - Matches single-user philosophy
   - LUKS password = authentication

7. **Shell**: **bash** (login) + **zsh** (interactive)
   - bash as login shell (required for system boot chain)
   - zsh launched by ghostty for interactive use
   - User already has zsh configs from macOS
   - Configure via ghostty: `command = /usr/bin/zsh`

### Supporting Utilities

| Component       | Choice                  | Status   | Notes                               |
| --------------- | ----------------------- | -------- | ----------------------------------- |
| Wallpaper       | swaybg â†’ swww         | In repos | Start simple, add transitions later |
| Clipboard       | wl-clipboard + cliphist | In repos | Standard Wayland clipboard          |
| Screenshots     | grim + slurp + swappy   | In repos | swappy for quick annotations        |
| Night light     | wlsunset                | In repos | Alternative to hyprsunset           |
| Idle management | swayidle                | In repos | Trigger lock screen, etc.           |
| Portal          | xdg-desktop-portal-wlr  | In repos | Screen sharing support              |
| Audio           | pipewire                | In repos | Modern audio stack                  |
| Bluetooth       | bluez + blueman         | In repos | Standard BT stack                   |
| File manager    | thunar + yazi           | In repos | GUI + TUI options                   |

### Omarchy Component Reference

For theme compatibility and configuration reference:

**What Omarchy uses:**

- Compositor: Hyprland
- Top Bar: waybar âœ… (we're using this)
- Terminal: Alacritty (default), Ghostty âœ…, Kitty (full theme support)
- Launcher: Walker (v1.0+)
- Notifications: mako âœ… (we're using this)
- Lock Screen: hyprlock (Hyprland-specific, we can't use)
- Editor: Neovim (LazyVim)
- Shell: bash (required for boot chain) âœ…

**Theme Integration:**

- Omarchy themes cover: desktop, terminal, neovim, btop, mako, waybar, walker, lock screen
- We can port: waybar, mako, ghostty themes directly
- 12 built-in themes with coordinated color schemes

### Technical Decisions

1. **Package management approach**:
   - Layering vs toolbox/distrobox for dev tools?
   - Which packages go in base image vs user-space?

2. **Configuration management**:
   - Where to store user configs?
   - How to handle dotfiles?
   - Chezmoi, yadm, or manual?

3. **Update strategy**:
   - How often to rebuild image?
   - Automatic updates vs manual?
   - Rollback strategy?

---

## Notes & Observations

### Omarchy Security Review Notes

- Reference: https://Ã£Æ’Å¾Ã£Æ’ÂªÃ£â€šÂ¦Ã£â€šÂ¹.com/a-word-on-omarchy/
- Need to create detailed audit checklist
- Focus areas: permissions, services, defaults

### mangowc Investigation - COMPLETED (Oct 22, 2025)

**Status: VIABLE but with CAVEATS**

#### Maturity Assessment

- **Active Development**: Latest release v0.10.0 (recent), frequent updates
- **Release History**: Went from v0.8.4 to v0.10.0 in recent months - rapid iteration
- **Community**: 849 stars, 32 forks - growing but still niche
- **Issues**: ~320 open issues (mix of bugs and feature requests)
- **Stability Concern**: Breaking changes between versions (e.g., v0.10.0 removed spiral/dwindle layouts)

#### Technical Foundation

- **Base**: dwl (dwm for Wayland) + wlroots 0.19.x + scenefx
- **Architecture**: Lightweight, dynamic tiling compositor
- **Build System**: Meson/Ninja (standard, clean)
- **Dependencies**: Standard Wayland stack (see below)

#### Core Dependencies

```
Required:
- glibc
- wayland
- wayland-protocols
- libinput
- libdrm
- libxkbcommon
- pixman
- git
- meson
- ninja
- libdisplay-info
- libliftoff
- hwdata
- seatd
- pcre2
- wlroots 0.19.x (patched version initially, now official works)
- scenefx (for window effects)
```

#### Packaging Status

- **Arch Linux**: Available in AUR (`mangowc-git`)
- **Gentoo**: In GURU repository
- **NixOS**: Flake available
- **Fedora**: NOT OFFICIALLY PACKAGED (will need custom build)

#### Configuration Approach

- **Config File**: `~/.config/mango/config.conf` (simple text format)
- **Autostart**: `~/.config/mango/autostart.sh` (shell script)
- **Structure**: Similar to dwm/sway - very straightforward
- **IPC Support**: Yes (can control via external programs)

#### Feature Set (Relevant to Our Project)

**Pros:**

- Extremely lightweight and fast (builds in seconds)
- Excellent XWayland support
- Tag-based (not workspace-based) - more flexible
- Rich animations (window open/close, tag switching, layer animations)
- Good input method support (text-input v2/v3)
- Multiple layout options (tile, scroller, monocle, grid, etc.)
- Window effects via scenefx (blur, shadow, corner radius, opacity)
- Scratchpad support (sway-like)
- Overview mode (hycov-like)
- Hot-reload configuration

**Cons:**

- **CRITICAL**: Automatic tiling only - cannot manually resize tiled windows (v0.10.0 added resize support!)
- Breaking changes between versions (moving target)
- Requires patched wlroots initially (now fixed, but shows instability)
- Limited documentation (mostly README and wiki)
- Small community (fewer resources for troubleshooting)
- Some waybar integration issues reported

#### Security Considerations

- Built on wlroots (well-audited Wayland library)
- No obvious security red flags in codebase structure
- Configuration is simple text files (easy to audit)
- Much simpler than Hyprland (less attack surface)

#### Comparison to Alternatives

| Feature     | mangowc       | sway          | niri          | river         | Hyprland       |
| ----------- | ------------- | ------------- | ------------- | ------------- | -------------- |
| Maturity    | ~ Young       | âœ“ Mature    | ~ Young       | ~ Young       | âœ“ Mature     |
| Performance | âœ“ Excellent | âœ“ Excellent | âœ“ Excellent | âœ“ Excellent | ~ Good         |
| Animations  | âœ“ Built-in  | X None        | âœ“ Built-in  | X Basic       | âœ“ Extensive  |
| Config      | âœ“ Simple    | âœ“ Simple    | âœ“ Simple    | ~ Medium      | ~ Complex      |
| Docs        | ~ Limited     | âœ“ Excellent | âœ“ Good      | ~ Limited     | âœ“ Good       |
| Fedora Pkg  | X No          | âœ“ Yes       | X No          | X No          | âœ“ Yes (COPR) |
| dwm-style   | âœ“ Yes       | X No          | X No          | âœ“ Yes       | X No           |

#### Recommended Supporting Tools (from mangowc docs)

```
Essential:
- rofi-wayland (launcher)
- foot (terminal)
- waybar (status bar - PREFERRED by author)
- xdg-desktop-portal-wlr (screen sharing)
- swaybg / swww (wallpaper)

Nice-to-have:
- swaync / dunst / mako (notifications)
- wl-clipboard + wl-clip-persist + cliphist (clipboard)
- wlsunset / gammastep (night light)
- swaylock-effects (screen lock)
- grim + slurp + satty (screenshots)
- wlogout (logout menu)
```

#### Integration with Universal Blue

**Challenges:**

1. Not in Fedora repos - need to build from source in container
2. Requires scenefx (also not packaged)
3. May need specific wlroots version
4. Build process needs to be reproducible in Containerfile

**Approach:**

1. Build wlroots 0.19.x in image
2. Build scenefx in image
3. Build mangowc in image
4. Package supporting tools (most available in Fedora)

#### Decision Factors

**USE mangowc IF:**

- Y You want dwm-style automatic tiling
- Y You value lightweight/minimal compositor
- Y You want built-in animations without bloat
- Y You're comfortable with bleeding-edge software
- Y You can handle occasional breaking changes
- Y You want tag-based workflow

**AVOID mangowc IF:**

- X You need rock-solid stability
- X You want extensive documentation
- X You need easy Fedora packaging
- X You prefer manual window management
- X You want large community support

#### Recommendation for Our Project

**VERDICT: PROCEED WITH CAUTION** ~

mangowc aligns well with the "minimal Omarchy-inspired" aesthetic and is technically viable for our Universal Blue build. However, we should:

1. **Accept the trade-offs**: Bleeding edge = potential instability
2. **Plan for maintenance**: Need to track upstream changes
3. **Build from source**: Required for Universal Blue image
4. **Have a backup plan**: Consider sway as fallback if mangowc proves too unstable
5. **Test thoroughly**: Especially on Framework hardware

**Alternative Recommendation**: If stability is paramount, consider **sway** instead:

- Mature, stable, well-documented
- Already in Fedora repos (trivial to add to image)
- Can achieve similar minimal aesthetic with proper config
- Larger community for Framework-specific configs

**Next Step**: Should we proceed with mangowc and start building a test image, or would you prefer to reconsider the compositor choice given these findings?

### Universal Blue vs Traditional

- **Advantages**: Atomic updates, reliable rollbacks, reproducible builds
- **Learning curve**: Different from traditional package management
- **Customization**: Layer vs rebase vs override understanding needed

---

## Project Structure (Proposed)

```
custom-ublue-minimal/
|-- README.md
|-- Containerfile (main image definition)
|-- .github/
|   +-- workflows/
|       +-- build.yml (automated builds)
|-- config/
|   |-- mangowc/
|   |-- waybar/
|   |-- terminal/
|   +-- system/
|-- scripts/
|   |-- post-install.sh
|   +-- framework-setup.sh
|-- packages/
|   |-- base.txt (core packages)
|   |-- framework.txt (hardware-specific)
|   +-- optional.txt (user choice)
+-- docs/
    |-- installation.md
    |-- configuration.md
    +-- troubleshooting.md
```

---

## Success Criteria

1. **Functional**: Boots to usable desktop on Framework laptop
2. **Minimal**: Significantly fewer packages than Bluefin
3. **Secure**: All Omarchy security issues addressed
4. **Aesthetic**: Maintains terminal-centric, minimal visual design
5. **Performant**: Better battery life and responsiveness than traditional distros
6. **Maintainable**: Automated builds, easy updates, clear documentation
7. **Framework-optimized**: All hardware working properly

---

## Next Steps

1. **Investigate mangowc** - Verify it's suitable for this use case
2. **Make component decisions** - Top bar, terminal, launcher
3. **Set up repository** - Initialize Universal Blue build structure
4. **Create first build** - Minimal viable image with mangowc
5. **Test and iterate** - Deploy to Framework and refine

---

## Links & References

- [Universal Blue](https://universal-blue.org/)
- [Omarchy Manual](https://learn.omacom.io/2/the-omarchy-manual/91/welcome-to-omarchy)
- [Omarchy GitHub](https://github.com/basecamp/omarchy)
- [Omarchy Security Critique](https://Ã£Æ’Å¾Ã£Æ’ÂªÃ£â€šÂ¦Ã£â€šÂ¹.com/a-word-on-omarchy/)
- [mangowc GitHub](https://github.com/DreamMaoMao/mangowc)
- [Project Bluefin](https://projectbluefin.io/)
- [Universal Blue Base](https://github.com/ublue-os/base)
- [Framework Linux Docs](https://github.com/FrameworkComputer/linux-docs)

```

```

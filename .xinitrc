#!/bin/sh

# xinitrc runs automatically when you run startx.

# There are some small but important commands that need to be run when we start
# the graphical environment. I keep those commands in ~/.xprofile because that
# file is run automatically if someone uses a display manager (login screen)
# and so they are needed there. To prevent doubling up commands, I source them
# here with the line below.

# load user Xresources
[ -f "$HOME/.Xresources" ] && xrdb -merge $HOME/.Xresources
[ -f "$HOME/.Xmodmap" ] && xmodmap $HOME/.Xmodmap
[ -f "$HOME/.local/bin/xr_to_env" ] && . "$HOME/.local/bin/xr_to_env"

[ -f "$HOME/.xprofile" ] && . "$HOME/.xprofile"

# Your default LARBS WM is determined in your `~/.profile` on login.  Here we
# run the proper command to run when the graphical environment starts.

case "$LARBSWM" in
	dwm) while :; do
		ssh-agent dwm || break
		done ;;
	i3) exec i3 ;;
	bspwm) exec bspwm ;;
	*) echo "No valid LARBS window manager detected." ;;
esac

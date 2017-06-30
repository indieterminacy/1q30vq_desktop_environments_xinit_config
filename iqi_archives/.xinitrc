#!/bin/sh

# case $1 in
# bspwm)

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
# Commented out as it seemed to be causing problems
#. /etc/X11/Xsession

# exec dwm
# exec i3-wm
# [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xrdb -merge ~/.Xresources
sxhkd &
# Normal cursor
xsetroot -cursor_name left_ptr
unclutter &
mopidy &
# pulseaudio --start -D
# pasystray &
# nm-applet &
# urxvtd -q -o -f
# unclutter -root &
# nitrogen --restore &
# compton &

# Prepare BAR
export PANEL_FIFO=/tmp/bspwm-fifo
[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"
# For optional conky output; see my conky_wunderground_scripts repo
# $HOME/git/conky_wunderground_scripts/runner_wunderground_min.sh &
xtitle -sf 'T%s' > "$PANEL_FIFO" &
conky -c $HOME/.config/bspwm/conkyrc_bar > "$PANEL_FIFO" &
cat "$PANEL_FIFO" | $HOME/.config/bspwm/panel_bar | bar &
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 4 --transparent true --alpha 0 --tint 0x1C1C1C --height 18 &
# charliebar & # start lemonbar with my configs
# xrdb -merge ~/.Xresources &
# urxvtd -q -f -o &
# urxvtcd &

# Launch bspwm
# exec bspwm
exec bspwm -s "$PANEL_FIFO" -p W -c $HOME/.config/bspwm/bspwmrc
# ;;
# *)
# exec $1
# ;;
# esac

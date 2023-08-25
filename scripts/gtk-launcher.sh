#!/usr/bin/env sh

ROFIDIR=${XDG_CONFIG_HOME:-$HOME/.config}/rofi
SCRIPTDIR=$ROFIDIR/scripts
TEMPDIR=$ROFIDIR/templates
THEMEDIR=$ROFIDIR/themes
SETTINGS=$SCRIPTDIR/settings.ini

function log() {
	echo "> $1"
}

function parse_templates() {
	log "Parsing themes"

	sed -i "s:GTK_THEME=${SETTINGS_GTK_THEME}:GTK_THEME=${CURRENT_GTK_THEME}:g" "${SETTINGS}"

	# if $THEMEDIR not exist, create
	if [ ! -d "$THEMEDIR" ]; then
		mkdir -p "$THEMEDIR"
	fi

	for f in "$TEMPDIR"/*; do
		file=$(basename "${f}")
		python "$SCRIPTDIR"/file_gtk_style.py "$TEMPDIR"/"$file" > "$THEMEDIR"/"gtk-${file}"
	done

	log "Parsing completed"
}

# use this for just generate themes
if [ "$1" == "reset" ]; then
	parse_templates
	exit
fi

# Gets the current gtk using gsettings and removes the quotes
CURRENT_GTK_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme)
CURRENT_GTK_THEME="${CURRENT_GTK_THEME#?}"
CURRENT_GTK_THEME="${CURRENT_GTK_THEME%?}"

# Gets the gtk theme that is in the settings.ini file
SETTINGS_GTK_THEME=$(grep "GTK_THEME" "${SETTINGS}" | cut -b 11-)

# Checks either gtk theme isn't the same
if [ "$SETTINGS_GTK_THEME" != "$CURRENT_GTK_THEME" ]; then
	log "GTK theme are changed, updating settings"
	parse_templates
else
	log "Current GTK theme not are changed, nothing to process"
fi

if [ $# -gt 0 ]; then
	eval "THEME=\${$#}"
	ARGS="$1"
fi

i=2
while [ $i -lt $# ]; do
	eval "var=\${$i}"
	ARGS=$(printf "%s $var" "$ARGS")
	i=$((i+1))
done

if [ -e "$THEMEDIR"/"$THEME".rasi ]; then
	log "'$THEME' theme founded, running..."
	rofi $(echo "${ARGS}") -theme "$THEMEDIR"/"$THEME".rasi

else
	log "'$THEME' theme not exist, please try again or generate themes with 'reset'"
fi

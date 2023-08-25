> A fork of this [amazing project](https://github.com/Git-Fal7/gtk-rofi/fork) with little code fixes, [adw-gtk3](https://github.com/lassekongo83/adw-gtk3) support and more.

# gtk-rofi

Theme your Rofi CSS using GTK

## Installing

Execute this into your terminal

```shell
mv $HOME/.config/rofi $HOME/.config/rofi.bak
git clone https://github.com/Rikiub/gtk-rofi $HOME/.config/rofi
cd $HOME/.config/rofi
chmod +x ./scripts/gtk-launcher.sh
```

## Usage

```shell
./launcher.sh (Rofi arguments) (Your theme (without .rasi extension)
```

**Example:**

```shell
./launcher.sh -show drun spotlight
```

**New command (fork):**

```shell
./launcher.sh reset
```

*Use this for recreate templates manually*

## Theming

The script uses the ``templates`` folder to use the theme as a template, then it replaces ``{@CONTEXT}`` valid tags and turn it onto a proper gtk style context color, then it outputs it into the ``themes`` folder.

[List of style context colors](https://github.com/Rikiub/gtk-rofi/blob/ead60f170fdb05352b67a6401a6804fa0d92d361/scripts/file_gtk_style.py#L31C10-L31C10)

[Heres some themes that works](https://github.com/Rikiub/gtk-rofi/tree/ead60f170fdb05352b67a6401a6804fa0d92d361/templates)

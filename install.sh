#!/bin/bash
# Author: CryoByte33

# Create a hidden directory for the script, if not present
mkdir -p "$HOME/.cryo_utilities" &>/dev/null
cd "$HOME/.cryo_utilities" || exit 1

# Download checksum to compare with local binary, if present
curl https://github.com/CryoByte33/steam-deck-utilities/releases/download/latest/cu.md5
sleep 1
if md5sum -c --quiet cu.md5; then
  zenity --info --text="No update necessary!" --width=300
  exit 0
fi

# Uninstall swap resizer if present
# Delete legacy install directory
rm -rf "$HOME/.swap_resizer" &>/dev/null

# Remove legacy Desktop icons
rm -rf ~/Desktop/SwapResizerUninstall.desktop &>/dev/null
rm -rf ~/Desktop/SwapResizer.desktop &>/dev/null

# Remove old binary
rm -f "$HOME/.cryo_utilities/cryo_utilities" &>/dev/null

# Attempt to download the binary 3 times.
for i in {1..3}; do
  # Download binary
  curl https://github.com/CryoByte33/steam-deck-utilities/releases/download/latest/cryo_utilities

  # Start a loop testing if zenity is running, and if not kill wget (allows for cancel to work)


chmod +x "$HOME/.cryo_utilities/cryo_utilities"
rm -f cu.md5 &>/dev/null

# Remove old launcher
rm -f "$HOME/.cryo_utilities/launcher.sh" &>/dev/null

# Install launcher script
curl https://raw.githubusercontent.com/CryoByte33/steam-deck-utilities/main/launcher.sh -O "$HOME/.cryo_utilities/launcher.sh"
chmod +x "$HOME/.cryo_utilities/launcher.sh"

# Remove old icon
rm -f "$HOME/.cryo_utilities/cryo-utilities.png" &>/dev/null

# Install Icon
curl https://raw.githubusercontent.com/CryoByte33/steam-deck-utilities/main/cmd/cryoutilities/Icon.png
xdg-icon-resource install Icon.png --size 64

# Create Desktop icons
rm -rf "$HOME"/Desktop/CryoUtilitiesUninstall.desktop 2>/dev/null
echo '#!/usr/bin/env xdg-open
[Desktop Entry]
Name=Uninstall CryoUtilities
Exec=curl https://raw.githubusercontent.com/CryoByte33/steam-deck-utilities/main/uninstall.sh | bash -s --
Icon=delete
Terminal=false
Type=Application
StartupNotify=false' >"$HOME"/Desktop/CryoUtilitiesUninstall.desktop
chmod +x "$HOME"/Desktop/CryoUtilitiesUninstall.desktop

rm -rf "$HOME"/Desktop/CryoUtilities.desktop 2>/dev/null
echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Name=CryoUtilities
Exec=bash $HOME/.cryo_utilities/launcher.sh
Icon=cryo-utilities
Terminal=false
Type=Application
StartupNotify=false" >"$HOME"/Desktop/CryoUtilities.desktop
chmod +x "$HOME"/Desktop/CryoUtilities.desktop

rm -rf "$HOME"/Desktop/UpdateCryoUtilities.desktop 2>/dev/null
echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Name=Update CryoUtilities
Exec=curl https://raw.githubusercontent.com/CryoByte33/steam-deck-utilities/main/install.sh | bash -s --
Icon=bittorrent-sync
Terminal=false
Type=Application
StartupNotify=false" >"$HOME"/Desktop/UpdateCryoUtilities.desktop
chmod +x "$HOME"/Desktop/UpdateCryoUtilities.desktop

# Create Start Menu Icons
rm -rf "$HOME"/.local/share/applications/CryoUtilitiesUninstall.desktop 2>/dev/null
echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Name=CryoUtilities - Uninstall
Exec=curl https://raw.githubusercontent.com/CryoByte33/steam-deck-utilities/main/uninstall.sh | bash -s --
Icon=delete
Terminal=false
Type=Application
Categories=Utility
StartupNotify=false" >"$HOME"/.local/share/applications/CryoUtilitiesUninstall.desktop
chmod +x "$HOME"/.local/share/applications/CryoUtilitiesUninstall.desktop

rm -rf "$HOME"/.local/share/applications/CryoUtilities.desktop 2>/dev/null
echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Name=CryoUtilities
Exec=bash $HOME/.cryo_utilities/launcher.sh
Icon=cryo-utilities
Terminal=false
Type=Application
Categories=Utility
StartupNotify=false" >"$HOME"/.local/share/applications/CryoUtilities.desktop
chmod +x "$HOME"/.local/share/applications/CryoUtilities.desktop

rm -rf "$HOME"/.local/share/applications/UpdateCryoUtilities.desktop 2>/dev/null
echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Name=CryoUtilities - Update
Exec=curl https://raw.githubusercontent.com/CryoByte33/steam-deck-utilities/main/install.sh | bash -s --
Icon=bittorrent-sync
Terminal=false
Type=Application
Categories=Utility
StartupNotify=false" >"$HOME"/.local/share/applications/UpdateCryoUtilities.desktop
chmod +x "$HOME"/.local/share/applications/UpdateCryoUtilities.desktop

update-desktop-database ~/.local/share/applications

zenity --info --text="Install/upgrade of CryoUtilities has been completed!" --width=300

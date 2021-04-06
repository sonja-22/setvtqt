#!/bin/sh
# YOU NEED ROOT PRIVILAGES TO RUN THIS SCRIPT

# If you want to change the keymaps, or add more, you need to  add to/change 
# lines 14 & 21, and add/ rename the required keymaps to this dir.

# Making sure to clean up in case of previous installs
sudo rm -f /usr/bin/setvtqt
sudo rm -f /etc/systemd/system/setvtqt.service
sudo rm -Rf /etc/setvtqt
sudo systemctl daemon-reload

sudo mkdir /etc/setvtqt
sudo cp -f vtfont.psfu.gz /etc/setvtqt/vtfont.psfu.gz
sudo cp -f vtgr.map.gz /etc/setvtqt/vtgr.map.gz
sudo cp -f vtclrs /etc/setvtqt/vtclrs

# Change font,keymap and colormap here
# 
sudo echo "/bin/setfont /etc/setvtqt/vtfont.psfu.gz
/bin/loadkeys /etc/setvtqt/vtgr.map.gz
/bin/setvtrgb /etc/setvtqt/vtclrs
">/usr/bin/setvtqt

sudo chmod +x /usr/bin/setvtqt


sudo echo "[Unit]
Description=Set Virtual Terminal Qualities

[Service]
Type=forking
ExecStart=/bin/sh /usr/bin/setvtqt

[Install]
WantedBy=multi-user.target
">/etc/systemd/system/setvtqt.service

#Starting Service
sudo systemctl daemon-reload
sudo systemctl enable --now setvtqt.service

#!/bin/bash
echo "Updating repos..."
apt-get update #>/dev/null 
echo "Upgrading system..."
echo "This might take some time."
apt-get dist-upgrade -y #> /dev/null
echo "Installing some basic tools..."
apt-get install python3-pip vim git samba chromium terminator fonts-powerline software-properties-common apt-transport-https -y #> /dev/null

echo "Installing vscode..."
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - #> /dev/null
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" #> /dev/null
apt update #> /dev/null
apt-get install code -y #> /dev/null 



echo "Cleaning system"
apt-get purge firefox gnome-terminal -y #> /dev/null
apt-get autoremove -y #> /dev/null


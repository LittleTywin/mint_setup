#!/bin/bash
echo "         _nnnn_"
echo "        dGGGGMMb"
echo "       @p~qp~~qMb"
echo "       M|@||@) M|"
echo "       @,----.JM|"
echo "      JS^\__/  qKL"
echo "     dZP        qKRb"
echo "    dZP          qKKb"
echo "   fZP            SMMb"
echo "   HZM            MMMM"
echo "   FqM            MMMM"
echo " __| ".        |\dS"qML"
echo " |    `.       | `' \Zq"
echo "_)      \.___.,|     .'"
echo "\____   )MMMMMP|   .'"
echo "     \`-'       \`--' hjm"

DOTFILES_REMOTE=https://github.com/LittleTywin/dotfiles.git

#check if running as root
if [ "$(id -u)" -ne 0 ];then
    echo "************************************"
    echo "*Must be run with root priviledges!*"
    echo "************************************"
    exit 1
fi

echo "Updating repos..."
apt-get update > /dev/null 
echo "Upgrading system..."
echo "This might take some time."
apt-get upgrade -y  > /dev/null

echo "Downloading my awsome dotfiles"
SUDO_USER_DIR=$(eval echo "~$SUDO_USER")
echo ".dotfiles" >> $SUDO_USER_DIR/.gitignore
git clone --bare $DOTFILES_REMOTE $SUDO_USER_DIR/.dotfiles >> /dev/null
rm -f $SUDO_USER_DIR/.bash* $SUDO_USER_DIR/.profile $SUDO_USER_DIR/.gitignore  
/usr/bin/git --git-dir=$SUDO_USER_DIR/.dotfiles --work-tree=$SUDO_USER_DIR/ checkout
/usr/bin/git --git-dir=$SUDO_USER_DIR/.dotfiles --work-tree=$SUDO_USER_DIR/ config --local status.showUntrackedFiles no

echo "Downloading some more system tools and programms..."
#add vscode repo
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - > /dev/null
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /dev/null
apt update > /dev/null
while read -r line;
do
   apt-get install $line -y >> /dev/null;
done < apt_list.txt

echo "alias dotfiles=/usr/bin/git --git-dir=$SUDO_USER_DIR/.dotfiles --work-tree=$SUDO_USER_DIR" >> $SUDO_USER_DIR/.bash_aliases

echo "Cleaning system"
apt-get purge firefox gnome-terminal -y #> /dev/null
apt-get autoremove -y #> /dev/null

echo "Have fun!"


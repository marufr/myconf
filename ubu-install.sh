#!/bin/bash

# key and repository for chrome installing chrome
# 1. Add key:
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
# 2. Set Repository
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# add repository for gdal
sudo add-apt-repository https://launchpad.net/~ubuntugis/+archive/ppa/

# add the repo for docker
# from https://docs.docker.com/engine/installation/linux/ubuntulinux/
sudo bash -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list'

# update
sudo apt-get update

# purge the old docker repo (should not matter here)
sudo apt-get purge lxc-docker

# key for docker repo
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# and install
sudo apt-get install -y \
    apt-show-verions \
    apt-transport-https \
    build-essential \
    ca-certificates \
    cmake cmake-qt-gui \
    default-jre \
    dos2unix \
    flex \
    gdal-bin libgdal-dev \
    git git-gui \
    gimp \
    google-chrome-stable \
    libboost-doc libboost-all-dev \
    linix-image-extra-$(uname -r) \
    linix-image-extra-virtual \
    lxc-docker \
    nodejs npm \
    passwordsafe \
    python-dev python-examples ipython \
    python-gdal \
    qt4-default \
    r-base \
    tmux \
    tree \
    vim-nox-py2 \
    vlc browser-plugin-vlc \
    xclip

# setup python
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo pip install numpy
sudo pip install pep8
sudo pip install autopep8
sudo pip install django
sudo pip install Pillow

# links to this repository (assumed cloned in ~/.config/myconf)
ln -s ~/.config/myconf/vimrc ~/.vimrc
ln -s ~/.config/myconf/tmux.config ~/.tmux.config

# install stuff for vim
# this is based on stuff from https://valloric.github.io/YouCompleteMe/
# and the readme at https://github.com/VundleVim/Vundle.vim
YCM_TAR_PREFIX=clang+llvm-3.8.0-x86_64-linux-gnu-ubuntu-16.04
cd ~
ln -s /d/linux-install/.vimrc .
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
ln -s /d/linux-install/$YCM_TAR_PREFIX.tar.xz $YCM_TAR_PREFIX.tar.xz
tar -xf $YCM_TAR_PREFIX.tar.xz
rm $YCM_TAR_PREFIX.tar.xz
cd ~/$YCM_TAR_PREFIX
sudo cp -r * /usr/local
cd ~
rm -rf $YCM_TAR_PREFIX
mkdir ycm_build
cd ~/ycm_build
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=/usr/local . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core
cd ~/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/tern_runtime
sudo npm install --production
cd ~

# config git
git config --global user.name "Simon Knapp"
git config --global user.email "sleepingwell@gmail.com"

# other things to do
# - Generate key and place on github and bitbucket
# - setup dropbox
# - setup .tmux.conf
# - modify /etc/fstab for d drive (set uid and gid on /d)

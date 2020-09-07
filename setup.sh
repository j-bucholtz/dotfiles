#!/bin/bash

# Setup Development directory and install neovim
echo "Setting up Development directory and installing neovim..."
mkdir -p ~/Development/temp
cd ~/Development/temp && curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod 775 nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim
rm -rf ~/Development/temp/*

# Install fish
echo "Installing fish..."
sudo apt install fish

# Install pip3 and python3-venv
echo "Installing pip3 and python3-venv..."
sudo apt install python3-pip
sudo apt-get install python3-venv

# Install packages for Python CoC
echo "Installing dependencies for Python CoC..."
pip3 install jedi
pip3 install neovim
sudo apt-get install pylint

# Install node for vim CoC
if [ -f /usr/local/bin/node ]; then
    echo "Node already installed."
else
    echo "Installing node for vim CoC..."
    curl -sL install-node.now.sh/lts | bash
fi

# Install Vim Plug
# https://github.com/junegunn/vim-plug
# NOTE: This is specific to nvim
if [ -f "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]; then
    echo "Vim Plug already installed."
else
    echo "Installing Vim Plug..."
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# Clone dotfiles from git and move files to proper location
if [ -d ~/Development/dotfiles ]; then
    echo "Dotfiles already cloned."
else
    echo "Cloning dotfiles..."
    git clone https://github.com/j-bucholtz/dotfiles.git ~/Development/dotfiles
fi

nvim_config_dir=~/.config/nvim/
echo "Moving init.nvim..."
mkdir -p $nvim_config_dir
cp ~/Development/dotfiles/.config/nvim/init.vim $nvim_config_dir || :

fish_config_dir=~/.config/fish/
echo "Moving fish.config..."
mkdir -p $fish_config_dir
cp ~/Development/dotfiles/.config/fish/fish.config $fish_config_dir || :

echo "Moving .bashrc..."
cp ~/Development/dotfiles/.bashrc ~/.bashrc || :

echo "Moving .vimrc..."
cp ~/Development/dotfiles/.vimrc ~/.vimrc || :

# Run PlugInstall
nvim -es -u ~/.config/nvim/init.vim -i NONE -c "PlugInstall" -c "qa"

echo "SETUP COMPLETE!"

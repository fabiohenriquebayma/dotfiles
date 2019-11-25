#!/usr/bin/env bash

set -ex

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

case "$(uname)" in
  Linux)
    ############################################################################
    # Disable prompts
    ############################################################################
    export DEBIAN_FRONTEND=noninteractive

    ############################################################################
    # Update / upgrade
    ############################################################################
    sudo apt update
    sudo apt dist-upgrade -y

    ############################################################################
    # Purge
    ############################################################################
    sudo apt purge -y \
      apport \
      chromium-* \
      cmdtest \
      laptop-mode-tools \
      ubuntu-web-launchers

    ############################################################################
    # Privacy
    ############################################################################
    ubuntu-report -f send no

    ############################################################################
    # Basic packages
    ############################################################################
    sudo apt install -y \
      apt-transport-https \
      curl \
      git \
      snapd \
      software-properties-common \
      tmux \
      ubuntu-restricted-extras \
      wget \
      xsel \
      zsh

    ############################################################################
    # Enable universe repository
    ############################################################################
    sudo add-apt-repository universe
    sudo apt update

    ############################################################################
    # Enable exFat
    ############################################################################
    sudo apt install -y \
      exfat-fuse \
      exfat-utils

    ############################################################################
    # 7Zip
    ############################################################################
    sudo apt install -y \
      p7zip-full \
      p7zip-rar

    ############################################################################
    # Rar
    ############################################################################
    sudo apt install -y \
      unrar \
      rar

    ############################################################################
    # Zip
    ############################################################################
    sudo apt install -y \
      unzip \
      zip

    ############################################################################
    # Docker
    ############################################################################
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install -y \
      docker-ce
    sudo usermod -a -G docker "$USER"

    ############################################################################
    # Node.js / Yarn
    ############################################################################
    # Node.js
    curl -fsSL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    sudo apt update
    sudo apt install -y \
      nodejs

    # Yarn
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo -e "deb [arch=amd64] https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update
    sudo apt install -y \
      yarn

    ############################################################################
    # Python / Pip
    ############################################################################
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt-get update
    sudo apt install -y \
      python3-pip \
      python3.8

    ############################################################################
    # Ruby
    ############################################################################
    sudo apt install -y \
      ruby-full

    ############################################################################
    # Erlang / Elixir
    ############################################################################
    curl -fsSL https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -
    sudo add-apt-repository -y "deb [arch=amd64] https://packages.erlang-solutions.com/ubuntu $(lsb_release -cs) contrib"
    sudo apt update
    sudo apt install -y \
      elixir \
      erlang

    ############################################################################
    # Spotify
    ############################################################################
    curl -fsSL https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
    echo -e "deb [arch=amd64] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update
    sudo apt install -y \
      spotify-client

    ############################################################################
    # Chrome
    ############################################################################
    curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    echo -e "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
    sudo apt update
    sudo apt install -y \
      google-chrome-stable

    ############################################################################
    # Firefox
    ############################################################################
    sudo apt install -y \
      firefox

    ############################################################################
    # Thunderbird
    ############################################################################
    sudo apt install -y \
      thunderbird

    ############################################################################
    # Skype
    ############################################################################
    sudo snap install skype --classic

    ############################################################################
    # VirtualBox
    ############################################################################
    curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -
    curl -fsSL https://www.virtualbox.org/download/oracle_vbox.asc | sudo apt-key add -
    sudo add-apt-repository -y "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
    sudo apt update
    sudo apt install -y \
      virtualbox-6.0
    sudo adduser "$USER" vboxusers

    ############################################################################
    # Vagrant
    ############################################################################
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key AD319E0F7CFFA38B4D9F6E55CE3F3DE92099F7A4
    echo -e "deb [arch=amd64] https://vagrant-deb.linestarve.com/ any main" | sudo tee /etc/apt/sources.list.d/vagrant.list
    sudo apt update
    sudo apt install -y \
      vagrant

    ############################################################################
    # DBeaver
    ############################################################################
    sudo add-apt-repository -y ppa:serge-rider/dbeaver-ce
    sudo apt update
    sudo apt install -y \
      dbeaver-ce

    ############################################################################
    # MySQL Workbench
    ############################################################################
    sudo apt install -y \
      mysql-workbench

    ############################################################################
    # Robo 3T
    ############################################################################
    sudo snap install robo3t-snap

    ############################################################################
    # Vim / gVim
    ############################################################################
    sudo add-apt-repository -y ppa:jonathonf/vim
    sudo apt update
    sudo apt install -y \
      vim \
      vim-gnome

    ############################################################################
    # Neovim
    ############################################################################
    sudo add-apt-repository -y ppa:neovim-ppa/stable
    sudo apt update
    sudo apt install -y \
      python-dev \
      python-pip \
      python3-dev \
      python3-pip \
      neovim

    ############################################################################
    # YouCompleteMe
    ############################################################################
    sudo apt install -y \
      build-essential \
      cmake \
      python3-dev

    ############################################################################
    # Ripgrep
    ############################################################################
    sudo add-apt-repository -y ppa:x4121/ripgrep
    sudo apt update
    sudo apt install \
      ripgrep

    ############################################################################
    # Universal ctags
    ############################################################################
    sudo add-apt-repository -y ppa:hnakamur/universal-ctags
    sudo apt update
    sudo apt install \
      universal-ctags

    ############################################################################
    # Sublime Text 3
    ############################################################################
    curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    echo "deb [arch=amd64] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get install -y \
      sublime-text

    ################################################################################
    # Visual Studio Code
    ################################################################################
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    echo -e "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
    sudo apt update
    sudo apt install -y \
      code

    ############################################################################
    # Terraform
    ############################################################################
    curl -fsSL https://tjend.github.io/repo_terraform/repo_terraform.key | sudo apt-key add -
    echo -e "deb [arch=amd64] https://tjend.github.io/repo_terraform stable main" | sudo tee /etc/apt/sources.list.d/terraform.list
    sudo apt update
    sudo apt install -y \
      terraform

    ############################################################################
    # Postman
    ############################################################################
    sudo snap install postman

    ############################################################################
    # Gnome
    ############################################################################
    sudo apt install -y \
      gnome-screensaver \
      gnome-shell-extensions \
      gnome-sushi \
      gnome-tweak-tool \
      network-manager-openvpn

    ############################################################################
    # VeraCrypt
    ############################################################################
    sudo add-apt-repository -y ppa:unit193/encryption
    sudo apt update
    sudo apt install -y \
      veracrypt

    ############################################################################
    # GPG
    ############################################################################
    sudo apt install -y \
      gpg \
      gnupg-agent

    ############################################################################
    # Neomutt
    ############################################################################
    sudo apt install -y \
      neomutt

    ############################################################################
    # Lynx
    ############################################################################
    sudo apt install -y \
      lynx

    ############################################################################
    # Shellcheck
    ############################################################################
    sudo apt install -y \
      shellcheck

    ############################################################################
    # Dropbox
    ############################################################################
    sudo apt install -y \
      nautilus-dropbox

    ############################################################################
    # Hack Nerd Font
    ############################################################################
    sudo apt install -y \
      fonts-hack-ttf

    curl -fLo \
      "$HOME/.local/share/fonts/Hack Regular Nerd Font Complete.ttf" \
      --create-dirs https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
    sudo fc-cache -fv

    ############################################################################
    # Tilix
    ############################################################################
    sudo apt install -y \
      tilix

    # Gruvbox
    curl -fLo \
      "$HOME/.config/tilix/schemes/gruvbox-dark-hard.json" \
      --create-dirs https://raw.githubusercontent.com/MichaelThessel/tilix-gruvbox/master/gruvbox-dark-hard.json
    curl -fLo \
      "$HOME/.config/tilix/schemes/gruvbox-dark-medium.json" \
      --create-dirs https://raw.githubusercontent.com/MichaelThessel/tilix-gruvbox/master/gruvbox-dark-medium.json
    curl -fLo \
      "$HOME/.config/tilix/schemes/gruvbox-dark-soft.json" \
      --create-dirs https://raw.githubusercontent.com/MichaelThessel/tilix-gruvbox/master/gruvbox-dark-soft.json
    curl -fLo \
      "$HOME/.config/tilix/schemes/gruvbox-dark.json" \
      --create-dirs https://raw.githubusercontent.com/MichaelThessel/tilix-gruvbox/master/gruvbox-dark.json
    curl -fLo \
      "$HOME/.config/tilix/schemes/gruvbox-light-hard.json" \
      --create-dirs https://raw.githubusercontent.com/MichaelThessel/tilix-gruvbox/master/gruvbox-light-hard.json
    curl -fLo \
      "$HOME/.config/tilix/schemes/gruvbox-light-medium.json" \
      --create-dirs https://raw.githubusercontent.com/MichaelThessel/tilix-gruvbox/master/gruvbox-light-medium.json
    curl -fLo \
      "$HOME/.config/tilix/schemes/gruvbox-light-soft.json" \
      --create-dirs https://raw.githubusercontent.com/MichaelThessel/tilix-gruvbox/master/gruvbox-light-soft.json

    ############################################################################
    # Conky
    ############################################################################
    sudo apt install -y \
      conky-all

    ############################################################################
    # VLC
    ############################################################################
    sudo apt install -y \
      vlc

    ############################################################################
    # Transmission
    ############################################################################
    sudo apt install -y \
      transmission

    ############################################################################
    # Steam
    ############################################################################
    sudo apt install -y \
      steam

    ############################################################################
    # Asciinema
    ############################################################################
    sudo apt install -y \
      asciinema

    ############################################################################
    # Preload
    ############################################################################
    sudo apt install -y \
      preload

    ############################################################################
    # Neofetch
    ############################################################################
    sudo apt install -y \
      neofetch

    ############################################################################
    # TLP
    ############################################################################
    sudo add-apt-repository -y ppa:linrunner/tlp
    sudo apt update
    sudo apt install -y \
      tlp

    ############################################################################
    # Gimp
    ############################################################################
    sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp
    sudo apt update
    sudo apt install -y \
      gimp \
      gimp-data \
      gimp-data-extras \
      gimp-gmic \
      gimp-plugin-registry \
      gmic

    ############################################################################
    # Inkscape
    ############################################################################
    sudo add-apt-repository -y ppa:inkscape.dev/stable
    sudo apt update
    sudo apt install -y \
      inkscape

    ############################################################################
    # Krita
    ############################################################################
    sudo add-apt-repository -y ppa:kritalime/ppa
    sudo apt update
    sudo apt install -y \
      krita \
      krita-l10n \
      krita-nautilus-thumbnailer

    ############################################################################
    # Shotcut
    ############################################################################
    sudo add-apt-repository -y ppa:haraldhv/shotcut
    sudo apt update
    sudo apt install -y \
      shotcut

    ############################################################################
    # Blender
    ############################################################################
    sudo add-apt-repository -y ppa:thomas-schiex/blender
    sudo apt update
    sudo apt install -y \
      blender \
      nvidia-modprobe
    sudo adduser "$USER" video

    ############################################################################
    # My Weather Indicator
    ############################################################################
    sudo add-apt-repository -y ppa:atareao/atareao
    sudo apt update
    sudo apt install -y \
      my-weather-indicator

    ############################################################################
    # Caffeine
    ############################################################################
    sudo apt install -y \
      caffeine

    ############################################################################
    # Stacer
    ############################################################################
    sudo add-apt-repository -y ppa:oguzhaninan/stacer
    sudo apt update
    sudo apt install -y \
      stacer

    ############################################################################
    # Handbrake
    ############################################################################
    sudo add-apt-repository -y ppa:stebbins/handbrake-releases
    sudo apt update
    sudo apt install -y \
      handbrake-cli \
      handbrake-gtk

    ############################################################################
    # Brasero
    ############################################################################
    sudo apt install -y \
      brasero

    ############################################################################
    # Okular
    ############################################################################
    sudo apt install -y \
      okular

    ############################################################################
    # uGet
    ############################################################################
    sudo add-apt-repository -y ppa:plushuang-tw/uget-stable
    sudo apt update
    sudo apt install -y \
      uget

    ############################################################################
    # Shutter
    ############################################################################
    sudo apt install -y \
      shutter

    ############################################################################
    # Peek
    ############################################################################
    sudo add-apt-repository -y ppa:peek-developers/stable
    sudo apt update
    sudo apt install -y \
      peek

    ############################################################################
    # Diodon
    ############################################################################
    sudo add-apt-repository -y ppa:diodon-team/stable
    sudo apt update
    sudo apt install -y \
      diodon

    ############################################################################
    # Retro games and emulators
    ############################################################################
    sudo add-apt-repository -y ppa:samoilov-lex/gamemode
    sudo add-apt-repository -y ppa:samoilov-lex/retrogames
    sudo apt update
    sudo apt install -y \
      citra \
      gamemode \
      ioquake3 \
      mgba-sdl \
      ppsspp \
      reicast \
      reicast-joyconfig \
      residualvm \
      retroarch \
      scummvm \
      snes9x

    ############################################################################
    # QCMA
    ############################################################################
    curl -fsSL https://download.opensuse.org/repositories/home:codestation/xUbuntu_18.04/Release.key | sudo apt-key add -
    echo -e "deb [arch=amd64] http://download.opensuse.org/repositories/home:/codestation/xUbuntu_18.04/ /" | sudo tee /etc/apt/sources.list.d/qcma.list
    sudo apt update
    sudo apt install -y \
      qcma

    ############################################################################
    # Keybase
    ############################################################################
    curl -fLo \
      "/tmp/keybase.deb" \
      --create-dirs https://prerelease.keybase.io/keybase_amd64.deb
    sudo apt install -y \
      /tmp/keybase.deb

    ############################################################################
    # Etcher
    ############################################################################
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key 379CE192D401AB61
    echo -e "deb [arch=amd64] https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
    sudo apt update
    sudo apt install -y \
      balena-etcher-electron

    ############################################################################
    # Drivers
    ############################################################################
    sudo add-apt-repository -y ppa:oibaf/graphics-drivers
    sudo add-apt-repository -y ppa:graphics-drivers/ppa
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y \
      mesa-vulkan-drivers \
      vulkan-utils

    ############################################################################
    # Routines
    ############################################################################
    # fstrim
    echo -e "#\!/bin/sh\n" | sudo tee /etc/cron.daily/fstrim
    echo -e "/sbin/fstrim --all || exit 1" | sudo tee -a /etc/cron.daily/fstrim
    sudo chmod +x /etc/cron.daily/fstrim

    # apt
    echo -e "#\!/bin/sh\n" | sudo tee /etc/cron.hourly/apt
    echo -e "apt update" | sudo tee -a /etc/cron.hourly/apt
    echo -e "apt dist-upgrade -y" | sudo tee -a /etc/cron.hourly/apt
    echo -e "apt autoremove -y" | sudo tee -a /etc/cron.hourly/apt
    echo -e "apt clean all -y" | sudo tee -a /etc/cron.hourly/apt
    sudo chmod +x /etc/cron.hourly/apt

    ;;
  Darwin)
    ############################################################################
    # xCode
    ############################################################################
    xcode-select -p || exit 1
    sudo xcodebuild -license accept
    sudo xcode-select --install

    ############################################################################
    # Homebrew
    ############################################################################
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    ############################################################################
    # Taps
    ############################################################################
    brew tap buo/cask-upgrade
    brew tap caskroom/cask
    brew tap caskroom/drivers
    brew tap caskroom/fonts
    brew tap neomutt/homebrew-neomutt
    brew tap universal-ctags/universal-ctags
    brew tap weaveworks/tap

    ############################################################################
    # Bottles
    ############################################################################
    brew install \
      asciinema \
      cmake \
      coreutils \
      curl \
      elixir \
      erlang \
      findutils \
      git \
      gpg \
      htop \
      kubernetes-cli \
      lynx \
      mas \
      moreutils \
      neofetch \
      neovim \
      nodejs \
      openssl \
      python3 \
      readline \
      reattach-to-user-namespace \
      ripgrep \
      ruby \
      shellcheck \
      terraform \
      tmux \
      urlview \
      vim \
      wget \
      yarn \
      zlib \
      zsh

    brew install --HEAD universal-ctags

    ############################################################################
    # Casks
    ############################################################################
    brew cask install \
      authy \
      balenaetcher \
      bartender \
      cheatsheet \
      cloudapp \
      coconutbattery \
      dbeaver-community \
      docker \
      dropbox \
      evernote \
      firefox \
      flixtools \
      folx \
      font-hack-nerd-font \
      google-chrome \
      intel-power-gadget \
      istat-menus \
      itau \
      iterm2 \
      java \
      keka \
      keybase \
      lastpass \
      mactracker \
      macvim \
      mysqlworkbench \
      openoffice \
      plex-media-server \
      robo-3t \
      sizeup \
      skype \
      slack \
      soda-player \
      spotify \
      steam \
      sublime-text \
      telegram-desktop \
      transmission \
      vagrant \
      virtualbox \
      virtualbox-extension-pack \
      visual-studio-code \
      vlc \
      whatsapp

    ############################################################################
    # iTerm 2
    ############################################################################
    curl -fLo \
      "/tmp/gruvbox-dark.itermcolors" \
      --create-dirs https://raw.githubusercontent.com/morhetz/gruvbox-contrib/master/iterm2/gruvbox-dark.itermcolors
    open "/tmp/gruvbox-dark.itermcolors"

    ############################################################################
    # App Store
    ############################################################################
    # Amphetamine
    mas install 937984704

    # Clean My Drive 2
    mas install 523620159

    # Todoist
    mas install 585829637

    # Twitter
    mas install 409789998

    ############################################################################
    # Hostname
    ############################################################################
    sudo scutil --set HostName macbook
    sudo scutil --set LocalHostName macbook
    sudo scutil --set ComputerName macbook

    ;;
  *)
    echo -e "Invalid system."
    exit 1

    ;;
esac

################################################################################
# Install dotfiles
################################################################################
if [ -d ~/.dotfiles ] || [ -h ~/.dotfiles ]; then
  mv ~/.dotfiles /tmp/dotfiles-old
fi
git clone --recursive https://github.com/gufranco/dotfiles.git ~/.dotfiles --depth=1
cd ~/.dotfiles || exit 1
git remote set-url origin git@github.com:gufranco/dotfiles.git

################################################################################
# Sublime Text 3 packages
################################################################################
if [[ "$(uname)" == "Linux" ]]; then
  curl -fLo \
    "$HOME/.config/sublime-text-3/Installed\ Packages\ Package\ Control.sublime-package" \
    --create-dirs https://packagecontrol.io/Package%20Control.sublime-package
elif [[ "$(uname)" == "Darwin" ]]; then
  curl -fLo \
    "$HOME/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages\ Package\ Control.sublime-package" \
    --create-dirs https://packagecontrol.io/Package%20Control.sublime-package
fi

################################################################################
# Node.js config / packages
################################################################################
sudo yarn global add \
  create-react-app \
  eslint \
  tslint \
  fkill-cli \
  neovim \
  ngrok \
  prettier @prettier/plugin-php @prettier/plugin-ruby \
  typescript \
  vtop \
  --ignore-optional

################################################################################
# Python config / packages
################################################################################
pip3 install --upgrade --user \
  awscli \
  black \
  pipenv \
  vim-vint

################################################################################
# Ruby config / packages
################################################################################
# Gem
if [ -f ~/.gemrc ] || [ -h ~/.gemrc ]; then
  mv ~/.gemrc /tmp/gemrc-old
fi
ln -s ~/.dotfiles/ruby/.gemrc ~/.gemrc

# Packages
sudo gem install \
  bundler \
  neovim \
  rails

# Bundler
if [[ "$(uname)" == "Linux" ]]; then
  bundle config --global jobs $(($(grep -c processor < /proc/cpuinfo) - 1))
elif [[ "$(uname)" == "Darwin" ]]; then
  bundle config --global jobs $(($(sysctl -n hw.ncpu) - 1))
fi

################################################################################
# Zsh config
################################################################################
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
  mv ~/.zshrc /tmp/zshrc-old
fi
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc

git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

command -v zsh | sudo tee -a /etc/shells
if [[ "$(uname)" == "Linux" ]]; then
  sudo sed -i -- 's/auth       required   pam_shells.so/# auth       required   pam_shells.so/g' /etc/pam.d/chsh
  sudo chsh "$USER" -s "$(command -v zsh)"
elif [[ "$(uname)" == "Darwin" ]]; then
  chsh -s "$(command -v zsh)"
fi

################################################################################
# Git config
################################################################################
if [ -f ~/.gitconfig ] || [ -h ~/.gitconfig ]; then
  mv ~/.gitconfig /tmp/gitconfig-old
fi
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig

################################################################################
# Vim / Neovim config
################################################################################
if [ -d ~/.vim ] || [ -h ~/.vim ]; then
  mv ~/.vim /tmp/vim-old
fi
ln -s ~/.dotfiles/vim ~/.vim

if [ -d ~/.config/nvim ] || [ -h ~/.config/nvim ]; then
  mv ~/.config/nvim /tmp/nvim-old
fi
mkdir ~/.config
ln -s ~/.dotfiles/vim ~/.config/nvim

if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
  mv ~/.vimrc /tmp/vimrc-old
fi
ln -s ~/.dotfiles/vim/init.vim ~/.vimrc

################################################################################
# GPG config
################################################################################
if [ -d ~/.gnupg ] || [ -h ~/.gnupg ]; then
  mv ~/.gnupg /tmp/gnupg-old
fi
ln -s ~/.dotfiles/gnupg ~/.gnupg

if [[ "$(uname)" == "Linux" ]]; then
  echo "pinentry-program /usr/bin/pinentry-curses" > ~/.gnupg/gpg-agent.conf
elif [[ "$(uname)" == "Darwin" ]]; then
  echo "pinentry-program /usr/local/bin/pinentry-curses" > ~/.gnupg/gpg-agent.conf
fi

chmod 700 ~/.gnupg
chmod 400 ~/.gnupg/keys/*
# gpg --import ~/.gnupg/keys/personal.public
# gpg --import ~/.gnupg/keys/personal.private

################################################################################
# SSH config
################################################################################
if [ -d ~/.ssh ] || [ -h ~/.ssh ]; then
  mv ~/.ssh /tmp/ssh-old
fi
ln -s ~/.dotfiles/ssh ~/.ssh

chmod 400 ~/.ssh/id_rsa

################################################################################
# Neomutt config
################################################################################
if [ -f ~/.muttrc ] || [ -h ~/.muttrc ]; then
  mv ~/.muttrc /tmp/muttrc-old
fi
ln -s ~/.dotfiles/mutt/.muttrc ~/.muttrc

if [ -d ~/.mutt ] || [ -h ~/.mutt ]; then
  mv ~/.mutt /tmp/mutt-old
fi
ln -s ~/.dotfiles/mutt ~/.mutt

if [ -f ~/.mailcap ] || [ -h ~/.mailcap ]; then
  mv ~/.mailcap /tmp/mailcap-old
fi
ln -s ~/.dotfiles/mutt/.mailcap ~/.mailcap

################################################################################
# Tmux config
################################################################################
if [ -f ~/.tmux.conf ] || [ -h ~/.tmux.conf ]; then
  mv ~/.tmux.conf /tmp/tmux.conf-old
fi
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

if [ -d ~/.tmux ] || [ -h ~/.tmux ]; then
  mv ~/.tmux /tmp/tmux-old
fi
ln -s ~/.dotfiles/tmux ~/.tmux

################################################################################
# Curl config
################################################################################
if [ -f ~/.curlrc ] || [ -h ~/.curlrc ]; then
  mv ~/.curlrc /tmp/curlrc-old
fi
ln -s ~/.dotfiles/.curlrc ~/.curlrc

################################################################################
# Wget config
################################################################################
if [ -f ~/.wgetrc ] || [ -h ~/.wgetrc ]; then
  mv ~/.wgetrc /tmp/wgetrc-old
fi
ln -s ~/.dotfiles/.wgetrc ~/.wgetrc

################################################################################
# Readline config
################################################################################
if [ -f ~/.inputrc ] || [ -h ~/.inputrc ]; then
  mv ~/.inputrc /tmp/inputrc-old
fi
ln -s ~/.dotfiles/.inputrc ~/.inputrc

################################################################################
# Conky config
################################################################################
if [[ "$(uname)" == "Linux" ]]; then
  if [ -f ~/.conkyrc ] || [ -h ~/.conkyrc ]; then
    mv ~/.conkyrc /tmp/conkyrc-old
  fi
  ln -s ~/.dotfiles/.conkyrc ~/.conkyrc
fi

################################################################################
# Finish
################################################################################
case "$(uname)" in
  Linux)
    # Clean the mess
    sudo apt autoremove -y
    sudo apt clean all -y

    # Reboot
    sudo shutdown -r now

  ;;
  Darwin)
    # Clean the mess
    brew cleanup -s
    brew prune

    # Enable TRIM and reboot
    sudo trimforce enable

  ;;
esac

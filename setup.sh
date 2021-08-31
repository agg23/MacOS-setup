#!/bin/bash
. config/appStore.sh
. config/brew.sh
. config/dock.sh
. config/nonAppStore.sh
. config/user.sh

# install homebrew apps repositories manager
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install non-AppStore apps
echo "Installing non-App Store apps"
brew cask install ${nonAppStoreApps[@]}

# Install AppStore CLI installer
brew install mas

# Install AppStore apps
echo "Installing App Store apps"
mas install ${appStoreApps[@]}

#Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Copy SF Mono font (available only in Xcode and Terminal.app) to the system
cp -R /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts/. /Library/Fonts/

# install brew packages
echo "Installing brew packages"
brew install ${brewPackages[@]}

# Configure git
git config --global user.email $gitEmail
git config --global user.name $gitName

# Update installed apps and clear caches
echo "Cleaning up"
brew update
brew upgrade
brew cask upgrade
brew cleanup
rm -rf ~/Library/Caches/Homebrew

# As we installed homebrew before xcode, we need to switch to Xcode Command Line Tools
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

. config/assets.sh

. config/system.sh
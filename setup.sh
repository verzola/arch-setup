#!/bin/bash
set -e

# color vars
RED='\033[00;31m'
GREEN='\033[00;32m'
BLUE='\033[00;34m'
YELLOW='\033[00;33m'
RESET='\033[0m'

exists() {
  command -v "$1" >/dev/null 2>&1
}

step() {
  echo -en "${BLUE}> $1...${RESET}\n"
}

check() {
  echo -en "${GREEN}> ✅${RESET}\n"
}

warning() {
  echo -en "${YELLOW}>⚠️  $1 ${RESET}"
}

install_packages() {
  step 'Installing packages'
  sudo pacman -S - < packages.txt
  check
}

install_yay() {
  step 'Installing yay'
  sudo pacman -S git go
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  check

}

install_yay_packages() {
  step 'Installing yay packages'
  yay -S - < yay_packages.txt
  check
}

update_system() {
  step 'Updating packages'
  sudo pacman -Syyu
  check
}

configure_git() {
  step "Configuring Git"
  git config --global user.name "Gustavo Verzola"
  git config --global user.email "verzola@gmail.com"
  git config --global tag.sort -version:refname
  git config --global pull.rebase false
  git config --global push.default current
  git config --global pull.default current
  check
}

setup() {
  install_packages
  update_system
  install_yay
  install_yay_packages
  configure_git
}

setup


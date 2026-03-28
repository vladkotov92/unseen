#!/bin/bash

# ============================================================
#  unseen — Linux Installer
#  Supports: Debian/Ubuntu, Fedora/RHEL, Arch Linux
# ============================================================

RESET="\033[0m"
BOLD="\033[1m"
GREEN="\033[92m"
YELLOW="\033[93m"
RED="\033[91m"

printf "${GREEN}${BOLD}"
cat << "EOF"

  _    _ _   _  _____ ______ ______ _   _ 
 | |  | | \ | |/ ____|  ____|  ____| \ | |
 | |  | |  \| | (___ | |__  | |__  |  \| |
 | |  | | . ` |\___ \|  __| |  __| | . ` |
 | |__| | |\  |____) | |____| |____| |\  |
  \____/|_| \_|_____/|______|______|_| \_|

                           Linux Installer

EOF
printf "${RESET}"

# Check Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    printf "${RED}[!] This installer is for Linux only.${RESET}\n"
    printf "${YELLOW}    For macOS use: bash install.sh${RESET}\n"
    exit 1
fi

# Check root
if [ "$EUID" -ne 0 ]; then
    printf "${RED}[!] Please run as root: sudo bash install-linux.sh${RESET}\n"
    exit 1
fi

# Detect package manager
if command -v apt >/dev/null 2>&1; then
    PKG_MANAGER="apt"
    INSTALL_CMD="apt install -y"
    UPDATE_CMD="apt update -y"
elif command -v dnf >/dev/null 2>&1; then
    PKG_MANAGER="dnf"
    INSTALL_CMD="dnf install -y"
    UPDATE_CMD="dnf update -y"
elif command -v yum >/dev/null 2>&1; then
    PKG_MANAGER="yum"
    INSTALL_CMD="yum install -y"
    UPDATE_CMD="yum update -y"
elif command -v pacman >/dev/null 2>&1; then
    PKG_MANAGER="pacman"
    INSTALL_CMD="pacman -S --noconfirm"
    UPDATE_CMD="pacman -Syu --noconfirm"
else
    printf "${RED}[!] Unsupported distro. Install tor, jq, curl manually.${RESET}\n"
    exit 1
fi

printf "${GREEN}[+] Detected package manager: ${PKG_MANAGER}${RESET}\n"
printf "${YELLOW}[+] Updating package list...${RESET}\n"
$UPDATE_CMD

# Install tor
if ! command -v tor >/dev/null 2>&1; then
    printf "${YELLOW}[+] Installing Tor...${RESET}\n"
    $INSTALL_CMD tor
    printf "${GREEN}[+] Tor installed.${RESET}\n"
else
    printf "${GREEN}[+] Tor already installed.${RESET}\n"
fi

# Install jq
if ! command -v jq >/dev/null 2>&1; then
    printf "${YELLOW}[+] Installing jq...${RESET}\n"
    $INSTALL_CMD jq
    printf "${GREEN}[+] jq installed.${RESET}\n"
else
    printf "${GREEN}[+] jq already installed.${RESET}\n"
fi

# Install curl
if ! command -v curl >/dev/null 2>&1; then
    printf "${YELLOW}[+] Installing curl...${RESET}\n"
    $INSTALL_CMD curl
    printf "${GREEN}[+] curl installed.${RESET}\n"
else
    printf "${GREEN}[+] curl already installed.${RESET}\n"
fi

# Make script executable
if [ -f "unseen-linux.sh" ]; then
    chmod +x unseen-linux.sh
    printf "${GREEN}[+] unseen-linux.sh is now executable.${RESET}\n"
fi

printf "\n${GREEN}${BOLD}All dependencies installed!${RESET}\n"
printf "${YELLOW}Run the VPN with: sudo bash unseen-linux.sh${RESET}\n\n"
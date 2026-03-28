#!/bin/bash

# ============================================================
#  unseen — Installer
#  Installs all dependencies required by unseen.sh
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

                                 Installer

EOF
printf "${RESET}"

# Check macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    printf "${RED}[!] This script is for macOS only.${RESET}\n"
    exit 1
fi

# Check / install Homebrew
if ! command -v brew >/dev/null 2>&1; then
    printf "${YELLOW}[+] Installing Homebrew...${RESET}\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if ! command -v brew >/dev/null 2>&1; then
        printf "${RED}[!] Homebrew installation failed. Install manually: https://brew.sh${RESET}\n"
        exit 1
    fi
    printf "${GREEN}[+] Homebrew installed.${RESET}\n"
else
    printf "${GREEN}[+] Homebrew already installed.${RESET}\n"
fi

# Check / install Tor
if ! command -v tor >/dev/null 2>&1; then
    printf "${YELLOW}[+] Installing Tor...${RESET}\n"
    brew install tor
    printf "${GREEN}[+] Tor installed.${RESET}\n"
else
    printf "${GREEN}[+] Tor already installed.${RESET}\n"
fi

# Check / install jq
if ! command -v jq >/dev/null 2>&1; then
    printf "${YELLOW}[+] Installing jq...${RESET}\n"
    brew install jq
    printf "${GREEN}[+] jq installed.${RESET}\n"
else
    printf "${GREEN}[+] jq already installed.${RESET}\n"
fi

# Check / install curl (usually pre-installed on macOS)
if ! command -v curl >/dev/null 2>&1; then
    printf "${YELLOW}[+] Installing curl...${RESET}\n"
    brew install curl
    printf "${GREEN}[+] curl installed.${RESET}\n"
else
    printf "${GREEN}[+] curl already installed.${RESET}\n"
fi

# Make unseen.sh executable
if [ -f "unseen.sh" ]; then
    chmod +x unseen.sh
    printf "${GREEN}[+] unseen.sh is now executable.${RESET}\n"
fi

printf "\n${GREEN}${BOLD}All dependencies installed!${RESET}\n"
printf "${YELLOW}Run the VPN with: sudo bash unseen.sh${RESET}\n\n"

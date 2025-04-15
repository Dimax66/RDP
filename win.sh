#!/bin/bash

# Auto Reinstall Script - Custom RDP Installer
# Tested on most KVM-based VPS or dedicated servers

set -e

# === Function: Show Menu ===
function show_menu() {
  echo "Pilih versi Windows Server yang ingin diinstall:"
  echo "1) Windows Server 2012 R2"
  echo "2) Windows Server 2016"
  echo "3) Windows Server 2019"
  echo "4) Windows Server 2022"
  read -p "Masukkan pilihan [1-4]: " choice

  case $choice in
    1)
      IMAGE_NAME='Windows Server 2012 R2 SERVERSTANDARD'
      ISO_URL='https://go.microsoft.com/fwlink/p/?LinkID=2195443&clcid=0x409&culture=en-us&country=US'
      ;;
    2)
      IMAGE_NAME='Windows Server 2016 SERVERSTANDARD'
      ISO_URL='https://software-download.microsoft.com/download/pr/Windows_Server_2016_English.ISO'
      ;;
    3)
      IMAGE_NAME='Windows Server 2019 SERVERSTANDARD'
      ISO_URL='https://software-download.microsoft.com/download/pr/Windows_Server_2019_English.ISO'
      ;;
    4)
      IMAGE_NAME='Windows Server 2022 SERVERSTANDARD'
      ISO_URL='https://software-download.microsoft.com/download/pr/Windows_Server_2022_English.ISO'
      ;;
    *)
      echo "Pilihan tidak valid. Keluar."
      exit 1
      ;;
  esac
}

# === Function: Run Installer ===
function run_installer() {
  echo "\n***** INSTALLER DIMULAI *****"
  echo "Image Name : $IMAGE_NAME"
  echo "ISO URL    : $ISO_URL"

  # Install wget dan curl jika belum ada
  apt update -y && apt install -y wget curl

  # Download script original installer
  wget -O reinstall.sh https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh

  # Jalankan dengan parameter yang dipilih
  bash reinstall.sh windows \
    --image-name "$IMAGE_NAME" \
    --iso "$ISO_URL"
}

# === MAIN ===
show_menu
run_installer

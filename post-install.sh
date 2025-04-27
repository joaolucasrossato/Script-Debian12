#!/bin/bash

echo "Atualizando o Sistema..."
apt update && apt upgrade -y
apt install linux-image-amd64 linux-headers-amd64 -t bookworm-backports -y

while true; do
clear
echo "---------- Script de instalação do Debian 12 ----------"
echo "Escolha as opções abaixo: "
echo "1 - Desinstalar Jogos Gnome, LibreOffice e Firefox-ESR."
echo "2 - Configurar Sources List."
echo "3 - Drivers Nvidia."
echo "4 - Ajustar a swappiness para melhorar o desempenho."
echo "5 - Adicionar usuário ao grupo SUDO."
echo "6 - Configurar Flatpak."
echo "7 - Instalar Fontes Microsoft."
echo "8 - Firewall."
echo "9 - Ferramentas úteis."
echo "10 - Instalar e configurar Git."
echo "11 - Instalar ferramentas de desenvolvimento (build-essential, etc)."
echo "12 - Instalar ferramentas de Rede."
echo "13 - Instalar Docker e Vagrant."
echo "14 - Instalar aplicativos (Navegadores, OnlyOffice, Discord, VsCode, Virtual Manager, Flameshot)."
echo "15 - Instalar tema de ícones Papirus."
echo "98 - Reiniciar Sistema."
echo "99 - Sair"
echo ""

read -p "Digite o número da opção:" NUMERO

case $NUMERO in
  1)
    apt remove pidgin gnome-games --purge -y && apt autoremove -y
    apt remove libreoffice* firefox-esr* -y
    apt autoremove -y
    echo "Concluído!"
    ;;
  
  2)
    cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
EOF
    apt update ; apt dist-upgrade
    echo "Concluído!"
    ;;
  
  3)
    apt install nvidia-driver nvidia-opencl-icd firmware-misc-nonfree nvidia-cuda-dev nvidia-cuda-toolkit libcuda1 libglu1-mesa libnvidia-encode1 libnvoptix1
    echo "Concluído!"
    ;;

  4) 
    echo "vm.swappiness=10" >> /etc/sysctl.conf && sysctl -p
    echo "Concluído!"
    ;;
  
  5)
    apt install sudo -y
    read -p "Digite o nome do seu usuário para adicionar ao grupo sudo: " USUARIO
    adduser "$USUARIO" sudo
    echo "Configuração concluída. Será necessário reiniciar a máquina para habilitat o SUDO."
    ;;

  6) 
    apt install flatpak gnome-software-plugin-flatpak -y
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    echo "Será necessário reiniciar o aplicativo da loja para finalizar completamente."
    ;;

  7)
    apt install ttf-mscorefonts-installer -y && fc-cache -f -v
    echo "Concluído!"
    ;;
  
  8) 
    apt install ufw gufw -y
    ufw enable
    echo "Concluído!"
    ;;

  9) 
    apt install arc arj cabextract lhasa p7zip p7zip-full p7zip-rar rar unrar unace unzip xz-utils zip -y
    apt install gdebi -y
    apt install synaptic -y
    apt install gparted -y
    apt install tilix -y
    echo "Concluído!"
    ;;
  
  10)
    apt install git -y
    read -p "Digite o nome de usuário para o Git: " GIT_USER
    read -p "Digite o e-mail para o Git: " GIT_EMAIL
    git config --global user.name "$GIT_USER"
    git config --global user.email "$GIT_EMAIL"
    echo "Gerando chave SSH..."
    ssh-keygen -t ed25519 -C "$GIT_EMAIL"
    cat ~/.ssh/id_ed25519.pub
    echo "\nAdicione esta chave ao seu GitHub"
    ;;
  
  11)
    echo "Instalando pacotes para desenvolvimento..."
    apt install build-essential -y
    apt install gcc g++ clang llvm make cmake autoconf automake libtool pkg-config -y
    apt install gdb valgrind strace ltrace binutils-dev libc6-dev -y
    apt install libssl-dev zlib1g-dev libreadline-dev libffi-dev -y
    apt install libsqlite3-dev libbz2-dev libncurses5-dev libgdbm-dev -y
    apt install liblzma-dev libxml2-dev libxslt1-dev -y
    apt install openjdk-17-jdk openjdk-17-jre -y
    echo 'JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"' >> /etc/environment && source /etc/environment
    apt install ruby-full -y
    apt install nodejs npm -y

    echo "--------------------------------------------------"
    echo "Ferramentas de desenvolvimento instaladas!"
    echo "Versões:"
    echo "GCC: $(gcc --version | head -n1)"
    echo "Java: $(java --version)"
    echo "Ruby: $(ruby --version)"
    echo "NodeJs $(node --version)"
    echo "--------------------------------------------------"
    ;;
  
  12) 
    echo "Instalando ferramentas de Rede..."
    apt install -y net-tools nmap tcpdump mtr traceroute wireshark ethtool iperf3 hping3
    apt install -y htop iftop iotop nethogs speedtest-cli whois
    echo "--------------------------------------------------"
    echo "Ferramentas de rede instaladas com sucesso!"
    echo "--------------------------------------------------"
    ;;
  
  13)
    echo "Instalando o Vagrant..."
    wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
    apt update && apt install vagrant -y

    echo "Instalando Docker..."
    apt-get update
    apt-get install ca-certificates curl -y
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

    apt install docker-compose -y 

    read -p "Nome do usuário para adicionar ao grupo: " USER
    usermod -aG docker "$USER"
    echo "Usuário adicionado ao grupo Docker. Faça logout/login ou execute 'newgrp docker' para aplicar a mudança sem reiniciar."

    echo "--------------------------------------------------"
    echo "Vagrant: $(vagrant --version)"
    echo "Docker: $(docker --version)"
    echo "--------------------------------------------------"
    ;;
    
  14)
    flatpak install flathub com.google.Chrome com.microsoft.Edge org.mozilla.firefox -y
    flatpak install flathub org.onlyoffice.desktopeditors -y
    flatpak install flathub com.discordapp.Discord -y
    flatpak install flathub com.visualstudio.code -y
    flatpak install flathub org.flameshot.Flameshot -y
    flatpak install flathub org.virt_manager.virt-manager -y
    echo "Instalações finalizadas com sucesso."
    ;;
  
  15)
    apt install papirus-icon-theme -y
    echo "Configure em: Ajustes > Aparência > Tema > ícones"
    ;;
  
  98) 
    echo "Reiniciando o sistema para aplicar todas as alterações."
    reboot

  99)
    echo "Saindo do script. Até mais!"
    break
    ;;

  *)
    echo "Opção Inválida."
    ;;
esac
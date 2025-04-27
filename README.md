# Script de Instalação Automática - Debian 12

Este script automatiza a instalação e configuração de várias ferramentas e pacotes no Debian 12, incluindo drivers, ferramentas de desenvolvimento, Docker, Vagrant e aplicativos populares. Ele foi projetado para simplificar o processo de configuração do ambiente.

## Funcionalidades

O script oferece as seguintes opções de instalação:

1. **Desinstalar Jogos Gnome, LibreOffice e Firefox-ESR.**
2. **Configurar a lista de fontes APT (sources.list).**
3. **Instalar drivers Nvidia.**
4. **Ajustar a configuração de swappiness para melhorar o desempenho.**
5. **Adicionar usuário ao grupo SUDO.**
6. **Configurar Flatpak.**
7. **Instalar fontes Microsoft.**
8. **Configurar Firewall (UFW).**
9. **Instalar ferramentas úteis (arquivos, compactação, etc).**
10. **Instalar e configurar o Git.**
11. **Instalar ferramentas de desenvolvimento (build-essential, etc).**
12. **Instalar ferramentas de Rede (nmap, tcpdump, wireshark, etc).**
13. **Instalar Docker e Vagrant.**
14. **Instalar aplicativos populares (Chrome, VSCode, Discord, etc).**
15. **Instalar tema de ícones Papirus.**

## Requisitos

Este script foi desenvolvido para o Debian 12, mas pode ser adaptado para outras distribuições baseadas no Debian com algumas modificações.

### Requisitos básicos:
- Acesso de superusuário (root) ou SUDO.
- Conexão com a internet.
- Um sistema Debian 12 (Bookworm).

## Como usar

1. Clone o repositório:
    ```bash
    git clone https://github.com/joaolucasrossato/Script-Debian12.git
    ```

2. Torne o script executável:
    ```bash
    chmod +x post-install.sh
    ```

3. Execute o script:
    ```bash
    sudo ./post-install.sh
    ```

4. Siga as instruções no menu para escolher as opções que deseja instalar.

> **Nota:** Algumas opções exigem que o sistema seja reiniciado para que as mudanças sejam aplicadas.

## Personalizações

- O script está configurado para um sistema padrão Debian 12. Caso deseje personalizá-lo para outra distribuição ou versão, ajuste as fontes de repositório e pacotes conforme necessário.
- O script suporta a instalação de ferramentas de desenvolvimento, redes, segurança e outros aplicativos úteis de maneira simples.

#!/bin/bash

# 1. Conexão com a instância EC2
# Configura o endereço da instância e o caminho para a chave privada.
# Substitua "seu_endereco_publico" e "caminho_da_sua_chave_privada.pem"
EC2_ADDRESS="seu_endereco_publico"
PEM_KEY_PATH="caminho_da_sua_chave_privada.pem"

echo "Conectando na instância EC2..."
ssh -i $PEM_KEY_PATH ec2-user@$EC2_ADDRESS << 'EOF'

# Comandos executados diretamente na instância EC2

# 2. Formatar e montar o volume EBS
echo "Formatando o volume..."
sudo mkfs -t ext4 /dev/xvdf

echo "Criando diretório para montagem do volume..."
sudo mkdir -p /mnt/banda_miguel

echo "Montando o volume no diretório criado..."
sudo mount /dev/xvdf /mnt/banda_miguel

# 3. Criação de arquivo no volume montado
echo "Criando um arquivo de texto no volume montado..."
echo "Este é o arquivo de documentos da Banda de Miguel." | sudo tee /mnt/banda_miguel/documento.txt > /dev/null

# 4. Verificação do volume e conteúdo do arquivo
echo "Verificando o volume montado e o espaço em disco disponível..."
ls /mnt/banda_miguel
df -h

echo "Verificando o conteúdo do arquivo criado..."
cat /mnt/banda_miguel/documento.txt

EOF

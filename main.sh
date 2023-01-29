#! /bin/bash
cd ~/.ssh
read -p "ip adress serverab" ipb
read -p "ip adress serverac" ipc
ssh-keygen
ssh-copy-id -i serverb.pub serverb@$ipb
ssh-keygen
ssh-copy-id -i serverc.pub serverc@$ipc
cd
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
cd
mkdir ansible
cd ~/ansible
touch hosts.txt
echo "[serverb]" >> hosts.txt
echo "serverb ansible_host=$ipb ansible_user=serverb ansible_ssh_private_key_file=/home/servera/.ssh/serverb" >> hosts.txt
echo "[serverc]" >> hosts.txt
echo "serverb ansible_host=$ipc ansible_user=serverb ansible_ssh_private_key_file=/home/servera/.ssh/serverc" >> hosts.txt
cd
cd ~/ansible
mkdir files
cd /home/servera/ansible/files
touch sudoer_DevOps
echo "DevOps ALL=(ALL) NOPASSWD: ALL" >> sudoer_DevOps
cp -p playbook1.yml ~/ansible/playbook.yml
ansible-playbook -i hosts.txt ~/ansible/playbook.yml -kK

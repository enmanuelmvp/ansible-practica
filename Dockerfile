# 🐧 Imagen base de Ubuntu
FROM ubuntu:22.04

# 💡 Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    openssh-server sudo vim net-tools iproute2 python3 \
    && mkdir /var/run/sshd

# 👤 Crear usuario 'ansible' con contraseña 'ansible'
RUN useradd -m -s /bin/bash ansible \
    && echo "ansible:ansible" | chpasswd \
    && usermod -aG sudo ansible \
    && echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 🔓 Permitir acceso SSH con contraseña
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

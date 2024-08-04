# 使用Ubuntu基础镜像  
FROM ubuntu:20.04

LABEL Organization="qsnctf" Author="M0x1n <lqn@sierting.com>"

# 设置环境变量（非安全方式，仅用于示例）  
ENV ROOT_PASSWD qsnctf  

COPY files /tmp/

# 替换主软件源
RUN sed -i 's/http:\/\/archive\.ubuntu\.com\/ubuntu\//http:\/\/mirrors.ustc.edu.cn\/ubuntu\//g' /etc/apt/sources.list  

# 检查并替换安全软件源
RUN sed -i 's/http:\/\/security\.ubuntu\.com\/ubuntu\//http:\/\/mirrors.ustc.edu.cn\/ubuntu\//g' /etc/apt/sources.list

# 安装必要的工具  
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    passwd \
    && rm -rf /var/lib/apt/lists/*  
  
# 设置root密码  
RUN echo "root:${ROOT_PASSWD}" | chpasswd  

# 配置动态FLAG
RUN mv /tmp/flag.sh /flag.sh \
    && mv /tmp/docker-entrypoint /usr/local/bin/docker-entrypoint \
    && chmod +x /usr/local/bin/docker-entrypoint \
    && rm -rf /tmp/*

# 配置SSH服务
RUN mkdir -p /run/sshd && chown root:root /run/sshd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config  
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config  
RUN echo 'LogLevel VERBOSE' >> /etc/ssh/sshd_config

# 暴露SSH端口  
EXPOSE 22

# 初始化脚本
CMD ["/bin/sh", "-c", "docker-entrypoint"]
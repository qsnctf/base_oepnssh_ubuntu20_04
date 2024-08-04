# 说明
## 环境
Linux环境：Ubuntu 20.04

## 如何使用
1. Git Clone 本仓库
2. 在`files`目录中的`docker-entrypoint`放入自己自动化代码。
3. 检查`Dockerfile`是否需要额外配置，如修改权限等。
4. 检查是否需要修改`flag.sh`，比如需要在题目中替换某个文本为FLAG？**（默认是将FLAG写入/flag）**
5. 构建项目
6. 测试

## 如何构建

### 使用Docker Build
```bash
docker build -t name/challenges_name:version_tag .
```

### 使用Docker Compose
**需要编写好`docker-compose.yml`**
```bash
docker-compose build
```

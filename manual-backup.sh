#!/bin/bash
# 手动备份并上传 - 一键执行

echo "🚀 开始手动备份..."

cd /e/blog-docs.bbroot.com

# 1. 运行备份脚本
./backup.sh

# 2. 检查备份是否成功
if [ $? -eq 0 ]; then
    echo "✅ 备份完成，开始上传到 GitHub..."
    
    # 3. 添加上传到 Git
    git add .
    git commit -m "手动备份 $(date +'%Y%m%d_%H%M%S')"
    git push origin main
    
    if [ $? -eq 0 ]; then
        echo "✅ 上传成功！备份已完成"
        echo "🌐 访问 https://blog-docs.bbroot.com 查看"
    else
        echo "❌ 上传失败，请检查网络"
    fi
else
    echo "❌ 备份失败，请检查 backup.sh"
fi
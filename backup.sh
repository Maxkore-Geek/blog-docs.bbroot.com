#!/bin/bash
# 博客自动备份脚本

# 配置
BLOG_DIR="/e/MyBlog"
BACKUP_DIR="/e/blog-docs.bbroot.com/backups"
DATE=$(date +%Y%m%d_%H%M%S)

echo "🚀 开始备份 $DATE..."

# 1. 备份文章
echo "📦 备份文章中..."
tar -czf "$BACKUP_DIR/posts/posts_$DATE.tar.gz" -C "$BLOG_DIR" source/_posts/

# 2. 备份草稿
echo "📝 备份草稿中..."
tar -czf "$BACKUP_DIR/drafts/drafts_$DATE.tar.gz" -C "$BLOG_DIR" source/_drafts/ 2>/dev/null

# 3. 备份配置
echo "⚙️ 备份配置中..."
cp "$BLOG_DIR/_config.yml" "$BACKUP_DIR/config/config_$DATE.yml"
cp "$BLOG_DIR/themes/next/_config.yml" "$BACKUP_DIR/config/theme_$DATE.yml" 2>/dev/null

# 4. 备份数据库
echo "🗃️ 备份数据库中..."
cp "$BLOG_DIR/db.json" "$BACKUP_DIR/db/db_$DATE.json" 2>/dev/null

# 5. 备份图片
echo "🖼️ 备份图片中..."
tar -czf "$BACKUP_DIR/images/images_$DATE.tar.gz" -C "$BLOG_DIR/source" images/ 2>/dev/null

# 6. 提交到 Git
echo "📤 提交到 Git..."
cd /e/blog-docs.bbroot.com
git add .
git commit -m "自动备份 $DATE"
git push origin main

echo "✅ 备份完成！"
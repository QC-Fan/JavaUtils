# JavaUtils 数据转换工具

一个本地可直接运行的数据处理工具页面，面向 Java 开发、SQL 批处理和日常 Excel 数据整理场景。

## 页面文件

- `excel-tools.html`：新版 Vercel 风格工作台页面，推荐使用。
- `excel-tools原来.html`：原始版本页面，保留不覆盖。

## 主要功能

- Excel 导入与预览
- Sheet 切换
- Excel 字段选择
- SQL 生成：
  - INSERT
  - UPDATE
  - IN 查询
  - DELETE
  - 字段 / 表名包裹
  - 事务包裹
  - SQL 复制、清空、下载
  - SQL 语句数和行数统计
- 列数据转换：
  - 转成数组
  - 转成带单引号数组
  - 转成带双引号数组
  - 添加前缀
  - 去重
  - Java `List.of(...)`
  - 按选项转换
- 转换选项：
  - 分隔符
  - 包裹格式
  - 排序
  - 每行数量
  - 去首尾空格
  - 去空行
  - 去重复
  - 中英文逗号统一
  - 大小写转换
- 数字求和
- 结果自动复制到剪贴板
- 在线版本检查与下载

## 技术栈

- Vue 3 CDN
- TailwindCSS CDN
- XLSX CDN
- 原生 JavaScript
- 单文件 HTML

不需要 Vite、npm、webpack 或任何构建步骤。

## 使用方式

直接双击打开：

```text
excel-tools.html
```

也可以继续使用原始页面：

```text
excel-tools原来.html
```

页面支持本地 `file://` 方式运行，不需要启动服务器。

## 新版界面

使用 Vercel 风格的深色极简界面：

- 顶部全宽置顶 Header
- Bing 背景图
- 黑白灰低饱和视觉体系
- 细边框卡片
- 常规转换 / 选项转换 Tab
- 优化后的输入框与滚动条
- 响应式布局，支持 PC、平板和手机

## 注意事项

- Excel 导入支持 `.xlsx` 和 `.xls`。
- 使用 Excel 模式生成 SQL 时，复选框选择的是 Excel 列，字段输入框填写的是 SQL 字段名。
- Excel 模式下暂不支持 UPDATE，请使用手动输入模式。
- SQL 输出选项默认关闭，不会改变原有生成结果；需要兼容 MySQL、SQL Server 等场景时再开启字段 / 表名包裹。
- 复制功能依赖浏览器剪贴板能力，若浏览器限制，可手动复制结果区内容。

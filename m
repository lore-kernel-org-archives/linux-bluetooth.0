Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Cathy Luo <cluo@marvell.com>, Zhaoyang Liu <liuzy@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH 3/4] Bluetooth: btmrvl: add debug mask debugfs parameter
Date: Wed, 14 Oct 2015 08:34:42 -0700
Message-ID: <1444836883-14701-3-git-send-email-akarwar@marvell.com>
In-Reply-To: <1444836883-14701-1-git-send-email-akarwar@marvell.com>
References: <1444836883-14701-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Zhaoyang Liu <liuzy@marvell.com>

This patch adds support for debug mask read/write operations
via debugfs. It is useful during debugging driver logs.

Examples:

Read current debug mask:
cat /sys/kernel/debug/bluetooth/hci0/config/debug_mask

Update debug mask:
echo 0xff > /sys/kernel/debug/bluetooth/hci0/config/debug_mask

Signed-off-by: Zhaoyang Liu <liuzy@marvell.com>
Signed-off-by: Cathy Luo <cluo@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_debugfs.c | 51 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index 1828ed8..af52b03 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -196,6 +196,55 @@ static const struct file_operations btmrvl_fwdump_fops = {
 	.llseek = default_llseek,
 };
 
+/* Proc debug_mask file read handler.
+ * This function is called when the 'debug_mask' file is opened for reading
+ * This function can be used read driver debugging mask value.
+ */
+static ssize_t btmrvl_debug_mask_read(struct file *file, char __user *ubuf,
+				      size_t count, loff_t *ppos)
+{
+	struct btmrvl_private *priv = file->private_data;
+	char buf[32];
+	int ret;
+
+	ret = snprintf(buf, sizeof(buf) - 1, "debug mask=0x%08x\n",
+		       priv->adapter->debug_mask);
+
+	return simple_read_from_buffer(ubuf, count, ppos, buf, ret);
+}
+
+/* Proc debug_mask file read handler.
+ * This function is called when the 'debug_mask' file is opened for reading
+ * This function can be used read driver debugging mask value.
+ */
+static ssize_t btmrvl_debug_mask_write(struct file *file,
+				       const char __user *ubuf,
+				       size_t count, loff_t *ppos)
+{
+	struct btmrvl_private *priv = file->private_data;
+	char buf[32];
+	unsigned long dbg_mask;
+
+	memset(buf, 0, sizeof(buf));
+
+	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	if (kstrtol(buf, 0, &dbg_mask))
+		return -EINVAL;
+
+	priv->adapter->debug_mask = dbg_mask;
+
+	return count;
+}
+
+static const struct file_operations btmrvl_debug_mask_fops = {
+	.read	= btmrvl_debug_mask_read,
+	.write	= btmrvl_debug_mask_write,
+	.open	= simple_open,
+	.llseek	= default_llseek,
+};
+
 void btmrvl_debugfs_init(struct hci_dev *hdev)
 {
 	struct btmrvl_private *priv = hci_get_drvdata(hdev);
@@ -228,6 +277,8 @@ void btmrvl_debugfs_init(struct hci_dev *hdev)
 			    priv, &btmrvl_hscfgcmd_fops);
 	debugfs_create_file("fw_dump", 0200, dbg->config_dir,
 			    priv, &btmrvl_fwdump_fops);
+	debugfs_create_file("debug_mask", 0644, dbg->config_dir,
+			    priv, &btmrvl_debug_mask_fops);
 
 	dbg->status_dir = debugfs_create_dir("status", hdev->debugfs);
 	debugfs_create_u8("curpsmode", 0444, dbg->status_dir,
-- 
1.8.1.4


Return-Path: <cyrus@holtmann.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@linux.intel.com>,
	Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] bluetooth: btmrvl: use native helpers
Date: Tue, 23 Apr 2013 12:53:46 +0300
Message-Id: <1366710826-9779-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Clean up the code by using native debugfs helpers:
	debugfs_create_u8()
	debugfs_create_x16()
	debugfs_remove_recursive()

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bluetooth/btmrvl_debugfs.c | 266 +++----------------------------------
 1 file changed, 22 insertions(+), 244 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index 428dbb7..db2c3c3 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -29,20 +29,6 @@
 struct btmrvl_debugfs_data {
 	struct dentry *config_dir;
 	struct dentry *status_dir;
-
-	/* config */
-	struct dentry *psmode;
-	struct dentry *pscmd;
-	struct dentry *hsmode;
-	struct dentry *hscmd;
-	struct dentry *gpiogap;
-	struct dentry *hscfgcmd;
-
-	/* status */
-	struct dentry *curpsmode;
-	struct dentry *hsstate;
-	struct dentry *psstate;
-	struct dentry *txdnldready;
 };
 
 static ssize_t btmrvl_hscfgcmd_write(struct file *file,
@@ -91,47 +77,6 @@ static const struct file_operations btmrvl_hscfgcmd_fops = {
 	.llseek = default_llseek,
 };
 
-static ssize_t btmrvl_psmode_write(struct file *file, const char __user *ubuf,
-						size_t count, loff_t *ppos)
-{
-	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
-	long result, ret;
-
-	memset(buf, 0, sizeof(buf));
-
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
-	ret = strict_strtol(buf, 10, &result);
-	if (ret)
-		return ret;
-
-	priv->btmrvl_dev.psmode = result;
-
-	return count;
-}
-
-static ssize_t btmrvl_psmode_read(struct file *file, char __user *userbuf,
-						size_t count, loff_t *ppos)
-{
-	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
-	int ret;
-
-	ret = snprintf(buf, sizeof(buf) - 1, "%d\n",
-						priv->btmrvl_dev.psmode);
-
-	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
-}
-
-static const struct file_operations btmrvl_psmode_fops = {
-	.read	= btmrvl_psmode_read,
-	.write	= btmrvl_psmode_write,
-	.open	= simple_open,
-	.llseek = default_llseek,
-};
-
 static ssize_t btmrvl_pscmd_write(struct file *file, const char __user *ubuf,
 						size_t count, loff_t *ppos)
 {
@@ -178,47 +123,6 @@ static const struct file_operations btmrvl_pscmd_fops = {
 	.llseek = default_llseek,
 };
 
-static ssize_t btmrvl_gpiogap_write(struct file *file, const char __user *ubuf,
-						size_t count, loff_t *ppos)
-{
-	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
-	long result, ret;
-
-	memset(buf, 0, sizeof(buf));
-
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
-	ret = strict_strtol(buf, 16, &result);
-	if (ret)
-		return ret;
-
-	priv->btmrvl_dev.gpio_gap = result;
-
-	return count;
-}
-
-static ssize_t btmrvl_gpiogap_read(struct file *file, char __user *userbuf,
-						size_t count, loff_t *ppos)
-{
-	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
-	int ret;
-
-	ret = snprintf(buf, sizeof(buf) - 1, "0x%x\n",
-						priv->btmrvl_dev.gpio_gap);
-
-	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
-}
-
-static const struct file_operations btmrvl_gpiogap_fops = {
-	.read	= btmrvl_gpiogap_read,
-	.write	= btmrvl_gpiogap_write,
-	.open	= simple_open,
-	.llseek = default_llseek,
-};
-
 static ssize_t btmrvl_hscmd_write(struct file *file, const char __user *ubuf,
 						size_t count, loff_t *ppos)
 {
@@ -263,119 +167,6 @@ static const struct file_operations btmrvl_hscmd_fops = {
 	.llseek = default_llseek,
 };
 
-static ssize_t btmrvl_hsmode_write(struct file *file, const char __user *ubuf,
-						size_t count, loff_t *ppos)
-{
-	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
-	long result, ret;
-
-	memset(buf, 0, sizeof(buf));
-
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
-	ret = strict_strtol(buf, 10, &result);
-	if (ret)
-		return ret;
-
-	priv->btmrvl_dev.hsmode = result;
-
-	return count;
-}
-
-static ssize_t btmrvl_hsmode_read(struct file *file, char __user * userbuf,
-						size_t count, loff_t *ppos)
-{
-	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
-	int ret;
-
-	ret = snprintf(buf, sizeof(buf) - 1, "%d\n", priv->btmrvl_dev.hsmode);
-
-	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
-}
-
-static const struct file_operations btmrvl_hsmode_fops = {
-	.read	= btmrvl_hsmode_read,
-	.write	= btmrvl_hsmode_write,
-	.open	= simple_open,
-	.llseek = default_llseek,
-};
-
-static ssize_t btmrvl_curpsmode_read(struct file *file, char __user *userbuf,
-						size_t count, loff_t *ppos)
-{
-	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
-	int ret;
-
-	ret = snprintf(buf, sizeof(buf) - 1, "%d\n", priv->adapter->psmode);
-
-	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
-}
-
-static const struct file_operations btmrvl_curpsmode_fops = {
-	.read	= btmrvl_curpsmode_read,
-	.open	= simple_open,
-	.llseek = default_llseek,
-};
-
-static ssize_t btmrvl_psstate_read(struct file *file, char __user * userbuf,
-						size_t count, loff_t *ppos)
-{
-	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
-	int ret;
-
-	ret = snprintf(buf, sizeof(buf) - 1, "%d\n", priv->adapter->ps_state);
-
-	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
-}
-
-static const struct file_operations btmrvl_psstate_fops = {
-	.read	= btmrvl_psstate_read,
-	.open	= simple_open,
-	.llseek = default_llseek,
-};
-
-static ssize_t btmrvl_hsstate_read(struct file *file, char __user *userbuf,
-						size_t count, loff_t *ppos)
-{
-	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
-	int ret;
-
-	ret = snprintf(buf, sizeof(buf) - 1, "%d\n", priv->adapter->hs_state);
-
-	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
-}
-
-static const struct file_operations btmrvl_hsstate_fops = {
-	.read	= btmrvl_hsstate_read,
-	.open	= simple_open,
-	.llseek = default_llseek,
-};
-
-static ssize_t btmrvl_txdnldready_read(struct file *file, char __user *userbuf,
-						size_t count, loff_t *ppos)
-{
-	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
-	int ret;
-
-	ret = snprintf(buf, sizeof(buf) - 1, "%d\n",
-					priv->btmrvl_dev.tx_dnld_rdy);
-
-	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
-}
-
-static const struct file_operations btmrvl_txdnldready_fops = {
-	.read	= btmrvl_txdnldready_read,
-	.open	= simple_open,
-	.llseek = default_llseek,
-};
-
 void btmrvl_debugfs_init(struct hci_dev *hdev)
 {
 	struct btmrvl_private *priv = hci_get_drvdata(hdev);
@@ -394,30 +185,28 @@ void btmrvl_debugfs_init(struct hci_dev *hdev)
 
 	dbg->config_dir = debugfs_create_dir("config", hdev->debugfs);
 
-	dbg->psmode = debugfs_create_file("psmode", 0644, dbg->config_dir,
-					  priv, &btmrvl_psmode_fops);
-	dbg->pscmd = debugfs_create_file("pscmd", 0644, dbg->config_dir,
-					 priv, &btmrvl_pscmd_fops);
-	dbg->gpiogap = debugfs_create_file("gpiogap", 0644, dbg->config_dir,
-					   priv, &btmrvl_gpiogap_fops);
-	dbg->hsmode =  debugfs_create_file("hsmode", 0644, dbg->config_dir,
-					   priv, &btmrvl_hsmode_fops);
-	dbg->hscmd = debugfs_create_file("hscmd", 0644, dbg->config_dir,
-					 priv, &btmrvl_hscmd_fops);
-	dbg->hscfgcmd = debugfs_create_file("hscfgcmd", 0644, dbg->config_dir,
-					    priv, &btmrvl_hscfgcmd_fops);
+	debugfs_create_u8("psmode", 0644, dbg->config_dir,
+			  &priv->btmrvl_dev.psmode);
+	debugfs_create_file("pscmd", 0644, dbg->config_dir,
+			    priv, &btmrvl_pscmd_fops);
+	debugfs_create_x16("gpiogap", 0644, dbg->config_dir,
+			   &priv->btmrvl_dev.gpio_gap);
+	debugfs_create_u8("hsmode", 0644, dbg->config_dir,
+			  &priv->btmrvl_dev.hsmode);
+	debugfs_create_file("hscmd", 0644, dbg->config_dir,
+			    priv, &btmrvl_hscmd_fops);
+	debugfs_create_file("hscfgcmd", 0644, dbg->config_dir,
+			    priv, &btmrvl_hscfgcmd_fops);
 
 	dbg->status_dir = debugfs_create_dir("status", hdev->debugfs);
-	dbg->curpsmode = debugfs_create_file("curpsmode", 0444,
-					     dbg->status_dir, priv,
-					     &btmrvl_curpsmode_fops);
-	dbg->psstate = debugfs_create_file("psstate", 0444, dbg->status_dir,
-					   priv, &btmrvl_psstate_fops);
-	dbg->hsstate = debugfs_create_file("hsstate", 0444, dbg->status_dir,
-					   priv, &btmrvl_hsstate_fops);
-	dbg->txdnldready = debugfs_create_file("txdnldready", 0444,
-					       dbg->status_dir, priv,
-					       &btmrvl_txdnldready_fops);
+	debugfs_create_u8("curpsmode", 0444, dbg->status_dir,
+			  &priv->adapter->psmode);
+	debugfs_create_u8("psstate", 0444, dbg->status_dir,
+			  &priv->adapter->ps_state);
+	debugfs_create_u8("hsstate", 0444, dbg->status_dir,
+			  &priv->adapter->hs_state);
+	debugfs_create_u8("txdnldready", 0444, dbg->status_dir,
+			  &priv->btmrvl_dev.tx_dnld_rdy);
 }
 
 void btmrvl_debugfs_remove(struct hci_dev *hdev)
@@ -428,19 +217,8 @@ void btmrvl_debugfs_remove(struct hci_dev *hdev)
 	if (!dbg)
 		return;
 
-	debugfs_remove(dbg->psmode);
-	debugfs_remove(dbg->pscmd);
-	debugfs_remove(dbg->gpiogap);
-	debugfs_remove(dbg->hsmode);
-	debugfs_remove(dbg->hscmd);
-	debugfs_remove(dbg->hscfgcmd);
-	debugfs_remove(dbg->config_dir);
-
-	debugfs_remove(dbg->curpsmode);
-	debugfs_remove(dbg->psstate);
-	debugfs_remove(dbg->hsstate);
-	debugfs_remove(dbg->txdnldready);
-	debugfs_remove(dbg->status_dir);
+	debugfs_remove_recursive(dbg->config_dir);
+	debugfs_remove_recursive(dbg->status_dir);
 
 	kfree(dbg);
 }
-- 
1.8.2.rc0.22.gb3600c3


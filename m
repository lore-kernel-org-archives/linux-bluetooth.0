Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bing Zhao <bzhao@marvell.com>
Subject: [PATCH 3/4] bluetooth: Add debugfs support to bt_mrvl driver
Date: Wed, 20 May 2009 17:35:40 -0700
Message-Id: <1242866141-22325-3-git-send-email-bzhao@marvell.com>
In-Reply-To: <1242866141-22325-1-git-send-email-bzhao@marvell.com>
References: <1242866141-22325-1-git-send-email-bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

/debug/bt_mrvl/config/
/debug/bt_mrvl/status/

This patch incorporates a lot of comments given by
Nicolas Pitre <nico@marvell.com>. Many thanks to Nicolas Pitre.

Signed-off-by: Rahul Tank <rahult@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/bt_mrvl/Kconfig       |    6 +
 drivers/bluetooth/bt_mrvl/Makefile      |    4 +-
 drivers/bluetooth/bt_mrvl/btm_debugfs.c |  492 +++++++++++++++++++++++++++++++
 drivers/bluetooth/bt_mrvl/btm_drv.h     |    8 +
 drivers/bluetooth/bt_mrvl/btm_main.c    |    8 +
 5 files changed, 517 insertions(+), 1 deletions(-)
 create mode 100644 drivers/bluetooth/bt_mrvl/btm_debugfs.c

diff --git a/drivers/bluetooth/bt_mrvl/Kconfig b/drivers/bluetooth/bt_mrvl/Kconfig
index 9f7a24a..e18e6fd 100644
--- a/drivers/bluetooth/bt_mrvl/Kconfig
+++ b/drivers/bluetooth/bt_mrvl/Kconfig
@@ -23,3 +23,9 @@ config BT_MRVL_SDIO
 
 	  Say Y here to compile support for Marvell BT-over-SDIO driver
 	  into the kernel or say M to compile it as module.
+
+config BT_MRVL_DEBUG
+	bool "Enable debug in Marvell Bluetooth driver"
+	depends on BT_MRVL && DEBUG_FS
+	help
+	  Say Y here to enable debug messages
diff --git a/drivers/bluetooth/bt_mrvl/Makefile b/drivers/bluetooth/bt_mrvl/Makefile
index 8c8cb94..4ae953d 100644
--- a/drivers/bluetooth/bt_mrvl/Makefile
+++ b/drivers/bluetooth/bt_mrvl/Makefile
@@ -2,7 +2,9 @@
 # Makefile for Marvell Bluetooth driver
 #
 
-bt_mrvl-objs := btm_main.o
+bt_mrvl-y := btm_main.o
+bt_mrvl-$(CONFIG_DEBUG_FS) += btm_debugfs.o
+
 bt_mrvl_sdio-objs := btm_sdio.o
 
 obj-$(CONFIG_BT_MRVL) += bt_mrvl.o
diff --git a/drivers/bluetooth/bt_mrvl/btm_debugfs.c b/drivers/bluetooth/bt_mrvl/btm_debugfs.c
new file mode 100644
index 0000000..ef09f06
--- /dev/null
+++ b/drivers/bluetooth/bt_mrvl/btm_debugfs.c
@@ -0,0 +1,492 @@
+/**
+ * Marvell Bluetooth driver: debugfs related functions
+ *
+ * Copyright (C) 2009, Marvell International Ltd.
+ *
+ * This software file (the "File") is distributed by Marvell International
+ * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * (the "License").  You may use, redistribute and/or modify this File in
+ * accordance with the terms and conditions of the License, a copy of which
+ * is available by writing to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA or on the
+ * worldwide web at http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
+ *
+ *
+ * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
+ * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
+ * this warranty disclaimer.
+ **/
+
+#include <linux/debugfs.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btm_drv.h"
+
+struct btm_debugfs_data {
+	struct dentry *root_dir, *config_dir, *status_dir;
+
+	/* config */
+	struct dentry *drvdbg;
+	struct dentry *psmode;
+	struct dentry *pscmd;
+	struct dentry *hsmode;
+	struct dentry *hscmd;
+	struct dentry *gpiogap;
+	struct dentry *hscfgcmd;
+
+	/* status */
+	struct dentry *curpsmode;
+	struct dentry *hsstate;
+	struct dentry *psstate;
+	struct dentry *txdnldready;
+};
+
+static int btm_open_generic(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+#ifdef CONFIG_BT_MRVL_DEBUG
+static ssize_t btm_drvdbg_write(struct file *file, const char __user *ubuf,
+				size_t count, loff_t *ppos)
+{
+	long result, ret;
+	char buf[16];
+
+	memset(buf, 0, sizeof(buf));
+
+	if (copy_from_user(&buf, ubuf,
+				min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	ret = strict_strtol(buf, 16, &result);
+
+	btm_drvdbg = result;
+
+	return count;
+}
+
+static ssize_t btm_drvdbg_read(struct file *file, char __user *userbuf,
+				size_t count, loff_t *ppos)
+{
+	int ret;
+	char buf[16];
+
+	ret = snprintf(buf, sizeof(buf) - 1, "0x%x\n", btm_drvdbg);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+}
+
+static const struct file_operations btm_drvdbg_fops = {
+	.read = btm_drvdbg_read,
+	.write = btm_drvdbg_write,
+	.open = btm_open_generic,
+};
+#endif
+
+static ssize_t btm_hscfgcmd_write(struct file *file,
+					const char __user *ubuf,
+					size_t count,
+					loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+
+	long result, ret;
+	char buf[16];
+
+	memset(buf, 0, sizeof(buf));
+
+	if (copy_from_user(&buf, ubuf,
+				min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	ret = strict_strtol(buf, 10, &result);
+
+	priv->btm_dev.hscfgcmd = result;
+
+	if (priv->btm_dev.hscfgcmd) {
+		btm_prepare_command(priv);
+		wake_up_interruptible(&priv->main_thread.wait_q);
+	}
+
+	return count;
+}
+
+static ssize_t btm_hscfgcmd_read(struct file *file, char __user * userbuf,
+				    size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	int ret;
+	char buf[16];
+
+	ret = snprintf(buf, sizeof(buf) - 1, "%d\n", priv->btm_dev.hscfgcmd);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+}
+
+static const struct file_operations btm_hscfgcmd_fops = {
+	.read = btm_hscfgcmd_read,
+	.write = btm_hscfgcmd_write,
+	.open = btm_open_generic,
+};
+
+static ssize_t btm_psmode_write(struct file *file, const char __user *ubuf,
+				   size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	long result, ret;
+	char buf[16];
+
+	memset(buf, 0, sizeof(buf));
+
+	if (copy_from_user(&buf, ubuf,
+				min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	ret = strict_strtol(buf, 10, &result);
+
+	priv->btm_dev.psmode = result;
+
+	return count;
+}
+
+static ssize_t btm_psmode_read(struct file *file, char __user * userbuf,
+				  size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	int ret;
+	char buf[16];
+
+	ret = snprintf(buf, sizeof(buf) - 1, "%d\n", priv->btm_dev.psmode);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+}
+
+static const struct file_operations btm_psmode_fops = {
+	.read = btm_psmode_read,
+	.write = btm_psmode_write,
+	.open = btm_open_generic,
+};
+
+static ssize_t btm_pscmd_write(struct file *file, const char __user *ubuf,
+				  size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	long result, ret;
+	char buf[16];
+
+	memset(buf, 0, sizeof(buf));
+
+	if (copy_from_user(&buf, ubuf,
+				min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	ret = strict_strtol(buf, 10, &result);
+
+	priv->btm_dev.pscmd = result;
+
+	if (priv->btm_dev.pscmd) {
+		btm_prepare_command(priv);
+		wake_up_interruptible(&priv->main_thread.wait_q);
+	}
+
+	return count;
+
+}
+
+static ssize_t btm_pscmd_read(struct file *file, char __user * userbuf,
+				 size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	int ret;
+	char buf[16];
+
+	ret = snprintf(buf, sizeof(buf) - 1, "%d\n", priv->btm_dev.pscmd);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+}
+
+static const struct file_operations btm_pscmd_fops = {
+	.read = btm_pscmd_read,
+	.write = btm_pscmd_write,
+	.open = btm_open_generic,
+};
+
+static ssize_t btm_gpiogap_write(struct file *file, const char __user *ubuf,
+				    size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	long result, ret;
+	char buf[16];
+
+	memset(buf, 0, sizeof(buf));
+
+	if (copy_from_user(&buf, ubuf,
+				min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	ret = strict_strtol(buf, 16, &result);
+
+	priv->btm_dev.gpio_gap = result;
+
+	return count;
+}
+
+static ssize_t btm_gpiogap_read(struct file *file, char __user * userbuf,
+				   size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	int ret;
+	char buf[16];
+
+	ret = snprintf(buf, sizeof(buf) - 1, "0x%x\n", priv->btm_dev.gpio_gap);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+}
+
+static const struct file_operations btm_gpiogap_fops = {
+	.read = btm_gpiogap_read,
+	.write = btm_gpiogap_write,
+	.open = btm_open_generic,
+};
+
+static ssize_t btm_hscmd_write(struct file *file, const char __user *ubuf,
+				  size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	long result, ret;
+	char buf[16];
+
+	memset(buf, 0, sizeof(buf));
+
+	if (copy_from_user(&buf, ubuf,
+				min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	ret = strict_strtol(buf, 10, &result);
+
+	priv->btm_dev.hscmd = result;
+	if (priv->btm_dev.hscmd) {
+		btm_prepare_command(priv);
+		wake_up_interruptible(&priv->main_thread.wait_q);
+	}
+
+	return count;
+}
+
+static ssize_t btm_hscmd_read(struct file *file, char __user * userbuf,
+				 size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	int ret;
+	char buf[16];
+
+	ret = snprintf(buf, sizeof(buf) - 1, "%d\n", priv->btm_dev.hscmd);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+}
+
+static const struct file_operations btm_hscmd_fops = {
+	.read = btm_hscmd_read,
+	.write = btm_hscmd_write,
+	.open = btm_open_generic,
+};
+
+static ssize_t btm_hsmode_write(struct file *file, const char __user *ubuf,
+				   size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	long result, ret;
+	char buf[16];
+
+	memset(buf, 0, sizeof(buf));
+
+	if (copy_from_user(&buf, ubuf,
+				min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	ret = strict_strtol(buf, 10, &result);
+
+	priv->btm_dev.hsmode = result;
+
+	return count;
+}
+
+static ssize_t btm_hsmode_read(struct file *file, char __user * userbuf,
+				  size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	int ret;
+	char buf[16];
+
+	ret = snprintf(buf, sizeof(buf) - 1, "%d\n", priv->btm_dev.hsmode);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+}
+
+static const struct file_operations btm_hsmode_fops = {
+	.read = btm_hsmode_read,
+	.write = btm_hsmode_write,
+	.open = btm_open_generic,
+};
+
+static ssize_t btm_curpsmode_read(struct file *file, char __user * userbuf,
+				     size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	int ret;
+	char buf[16];
+
+	ret = snprintf(buf, sizeof(buf) - 1, "%d\n", priv->adapter->psmode);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+}
+
+static const struct file_operations btm_curpsmode_fops = {
+	.read = btm_curpsmode_read,
+	.open = btm_open_generic,
+};
+
+static ssize_t btm_psstate_read(struct file *file, char __user * userbuf,
+				   size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	int ret;
+	char buf[16];
+
+	ret = snprintf(buf, sizeof(buf) - 1, "%d\n", priv->adapter->ps_state);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+}
+
+static const struct file_operations btm_psstate_fops = {
+	.read = btm_psstate_read,
+	.open = btm_open_generic,
+};
+
+static ssize_t btm_hsstate_read(struct file *file, char __user * userbuf,
+				   size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	int ret;
+	char buf[16];
+
+	ret = snprintf(buf, sizeof(buf) - 1, "%d\n", priv->adapter->hs_state);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+}
+
+static const struct file_operations btm_hsstate_fops = {
+	.read = btm_hsstate_read,
+	.open = btm_open_generic,
+};
+
+static ssize_t btm_txdnldready_read(struct file *file, char __user * userbuf,
+				       size_t count, loff_t *ppos)
+{
+	struct btm_private *priv = (struct btm_private *) file->private_data;
+	int ret;
+	char buf[16];
+
+	ret = snprintf(buf, sizeof(buf) - 1, "%d\n",
+			priv->btm_dev.tx_dnld_rdy);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
+}
+
+static const struct file_operations btm_txdnldready_fops = {
+	.read = btm_txdnldready_read,
+	.open = btm_open_generic,
+};
+
+void btm_debugfs_init(struct hci_dev *hdev)
+{
+	struct btm_private *priv = (struct btm_private *) hdev->driver_data;
+	struct btm_debugfs_data *dbg;
+
+	dbg = kzalloc(sizeof(*dbg), GFP_KERNEL);
+	priv->debugfs_data = dbg;
+
+	if (!dbg) {
+		PRINTM(ERROR, "Can not allocate memory "
+				"for btm_debugfs_data\n");
+		return;
+	}
+
+	dbg->root_dir = debugfs_create_dir("bt_mrvl", NULL);
+
+	dbg->config_dir = debugfs_create_dir("config", dbg->root_dir);
+
+#ifdef CONFIG_BT_MRVL_DEBUG
+	dbg->drvdbg = debugfs_create_file("drvdbg", 0644, dbg->config_dir,
+						hdev, &btm_drvdbg_fops);
+#endif
+
+	dbg->psmode = debugfs_create_file("psmode", 0644, dbg->config_dir,
+					  hdev->driver_data,
+					  &btm_psmode_fops);
+	dbg->pscmd =
+	    debugfs_create_file("pscmd", 0644, dbg->config_dir,
+				hdev->driver_data, &btm_pscmd_fops);
+	dbg->gpiogap =
+	    debugfs_create_file("gpiogap", 0644, dbg->config_dir,
+				hdev->driver_data, &btm_gpiogap_fops);
+	dbg->hsmode =
+	    debugfs_create_file("hsmode", 0644, dbg->config_dir,
+				hdev->driver_data, &btm_hsmode_fops);
+	dbg->hscmd =
+	    debugfs_create_file("hscmd", 0644, dbg->config_dir,
+				hdev->driver_data, &btm_hscmd_fops);
+	dbg->hscfgcmd =
+	    debugfs_create_file("hscfgcmd", 0644, dbg->config_dir,
+				hdev->driver_data, &btm_hscfgcmd_fops);
+
+	dbg->status_dir = debugfs_create_dir("status", dbg->root_dir);
+	dbg->curpsmode = debugfs_create_file("curpsmode", 0444,
+						dbg->status_dir,
+						hdev->driver_data,
+						&btm_curpsmode_fops);
+	dbg->psstate =
+	    debugfs_create_file("psstate", 0444, dbg->status_dir,
+				hdev->driver_data, &btm_psstate_fops);
+	dbg->hsstate =
+	    debugfs_create_file("hsstate", 0444, dbg->status_dir,
+				hdev->driver_data, &btm_hsstate_fops);
+	dbg->txdnldready =
+	    debugfs_create_file("txdnldready", 0444, dbg->status_dir,
+				hdev->driver_data, &btm_txdnldready_fops);
+}
+
+void btm_debugfs_remove(struct hci_dev *hdev)
+{
+	struct btm_private *priv = (struct btm_private *) hdev->driver_data;
+	struct btm_debugfs_data *dbg = priv->debugfs_data;
+
+	if (!dbg)
+		return;
+
+#ifdef CONFIG_BT_MRVL_DEBUG
+	debugfs_remove(dbg->drvdbg);
+#endif
+	debugfs_remove(dbg->psmode);
+	debugfs_remove(dbg->pscmd);
+	debugfs_remove(dbg->gpiogap);
+	debugfs_remove(dbg->hsmode);
+	debugfs_remove(dbg->hscmd);
+	debugfs_remove(dbg->hscfgcmd);
+	debugfs_remove(dbg->config_dir);
+
+	debugfs_remove(dbg->curpsmode);
+	debugfs_remove(dbg->psstate);
+	debugfs_remove(dbg->hsstate);
+	debugfs_remove(dbg->txdnldready);
+	debugfs_remove(dbg->status_dir);
+
+	debugfs_remove(dbg->root_dir);
+
+	kfree(dbg);
+}
diff --git a/drivers/bluetooth/bt_mrvl/btm_drv.h b/drivers/bluetooth/bt_mrvl/btm_drv.h
index 68a74cc..ed019d2 100644
--- a/drivers/bluetooth/bt_mrvl/btm_drv.h
+++ b/drivers/bluetooth/bt_mrvl/btm_drv.h
@@ -164,6 +164,9 @@ struct btm_private {
 				u8 *payload, u16 nb);
 	int (*hw_wakeup_firmware) (struct btm_private *priv);
 	spinlock_t driver_lock;		/* spinlock used by driver */
+#ifdef CONFIG_DEBUG_FS
+	void *debugfs_data;
+#endif
 };
 
 #define MRVL_VENDOR_PKT			0xFE
@@ -220,4 +223,9 @@ int btm_process_event(struct btm_private *priv, struct sk_buff *skb);
 int btm_send_module_cfg_cmd(struct btm_private *priv, int subcmd);
 int btm_prepare_command(struct btm_private *priv);
 
+#ifdef CONFIG_DEBUG_FS
+void btm_debugfs_init(struct hci_dev *hdev);
+void btm_debugfs_remove(struct hci_dev *hdev);
+#endif
+
 #endif /* _BTM_DRV_H_ */
diff --git a/drivers/bluetooth/bt_mrvl/btm_main.c b/drivers/bluetooth/bt_mrvl/btm_main.c
index 0bdd297..354fed8 100644
--- a/drivers/bluetooth/bt_mrvl/btm_main.c
+++ b/drivers/bluetooth/bt_mrvl/btm_main.c
@@ -672,6 +672,10 @@ struct btm_private *btm_add_card(void *card)
 		goto err_hci_register_dev;
 	}
 
+#ifdef CONFIG_DEBUG_FS
+	btm_debugfs_init(hdev);
+#endif
+
 	LEAVE();
 	return priv;
 
@@ -706,6 +710,10 @@ int btm_remove_card(struct btm_private *priv)
 
 	kthread_stop(priv->main_thread.task);
 
+#ifdef CONFIG_DEBUG_FS
+	btm_debugfs_remove(hdev);
+#endif
+
 	hci_unregister_dev(hdev);
 
 	hci_free_dev(hdev);
-- 
1.5.3.6


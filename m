Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] Revert "Bluetooth: btmrvl: support sysfs initiated firmware coredump"
Date: Tue, 27 Mar 2018 23:03:40 +0200
Message-Id: <1522184620-1695-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reverts commit 118c193d9699ffc1c897c38a1d314f38543c8e1c. A discussion
about the driver callback ended with the idea to change the return type of
the callback to void. That change would lead to build error in linux-next
so let's remove this change and resubmit later according the new callback
definition.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
Hi Marcel,

Still noticed the patch in bt-next/master so decided to sent this formal
revert patch.

Regards,
Arend
---
 drivers/bluetooth/btmrvl_debugfs.c | 31 +++++++++++++++++++++++++++++++
 drivers/bluetooth/btmrvl_drv.h     |  2 ++
 drivers/bluetooth/btmrvl_main.c    |  6 ++++++
 drivers/bluetooth/btmrvl_sdio.c    | 18 ++++++------------
 4 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index 023d35e..1828ed8 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -167,6 +167,35 @@ static ssize_t btmrvl_hscmd_read(struct file *file, char __user *userbuf,
 	.llseek = default_llseek,
 };
 
+static ssize_t btmrvl_fwdump_write(struct file *file, const char __user *ubuf,
+				   size_t count, loff_t *ppos)
+{
+	struct btmrvl_private *priv = file->private_data;
+	char buf[16];
+	bool result;
+
+	memset(buf, 0, sizeof(buf));
+
+	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	if (strtobool(buf, &result))
+		return -EINVAL;
+
+	if (!result)
+		return -EINVAL;
+
+	btmrvl_firmware_dump(priv);
+
+	return count;
+}
+
+static const struct file_operations btmrvl_fwdump_fops = {
+	.write	= btmrvl_fwdump_write,
+	.open	= simple_open,
+	.llseek = default_llseek,
+};
+
 void btmrvl_debugfs_init(struct hci_dev *hdev)
 {
 	struct btmrvl_private *priv = hci_get_drvdata(hdev);
@@ -197,6 +226,8 @@ void btmrvl_debugfs_init(struct hci_dev *hdev)
 			    priv, &btmrvl_hscmd_fops);
 	debugfs_create_file("hscfgcmd", 0644, dbg->config_dir,
 			    priv, &btmrvl_hscfgcmd_fops);
+	debugfs_create_file("fw_dump", 0200, dbg->config_dir,
+			    priv, &btmrvl_fwdump_fops);
 
 	dbg->status_dir = debugfs_create_dir("status", hdev->debugfs);
 	debugfs_create_u8("curpsmode", 0444, dbg->status_dir,
diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index f045454..fc3caf4 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -110,6 +110,7 @@ struct btmrvl_private {
 				u8 *payload, u16 nb);
 	int (*hw_wakeup_firmware)(struct btmrvl_private *priv);
 	int (*hw_process_int_status)(struct btmrvl_private *priv);
+	void (*firmware_dump)(struct btmrvl_private *priv);
 	spinlock_t driver_lock;		/* spinlock used by driver */
 #ifdef CONFIG_DEBUG_FS
 	void *debugfs_data;
@@ -182,6 +183,7 @@ struct btmrvl_event {
 int btmrvl_enable_ps(struct btmrvl_private *priv);
 int btmrvl_prepare_command(struct btmrvl_private *priv);
 int btmrvl_enable_hs(struct btmrvl_private *priv);
+void btmrvl_firmware_dump(struct btmrvl_private *priv);
 
 #ifdef CONFIG_DEBUG_FS
 void btmrvl_debugfs_init(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 708ad216..f6c694a 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -358,6 +358,12 @@ int btmrvl_prepare_command(struct btmrvl_private *priv)
 	return ret;
 }
 
+void btmrvl_firmware_dump(struct btmrvl_private *priv)
+{
+	if (priv->firmware_dump)
+		priv->firmware_dump(priv);
+}
+
 static int btmrvl_tx_pkt(struct btmrvl_private *priv, struct sk_buff *skb)
 {
 	int ret = 0;
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 8588fdd..6f99b9f 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1311,11 +1311,9 @@ rdwr_status btmrvl_sdio_rdwr_firmware(struct btmrvl_private *priv,
 }
 
 /* This function dump sdio register and memory data */
-static int btmrvl_sdio_coredump(struct device *dev)
+static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
 {
-	struct sdio_func *func = dev_to_sdio_func(dev);
-	struct btmrvl_sdio_card *card;
-	struct btmrvl_private *priv;
+	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
 	int ret = 0;
 	unsigned int reg, reg_start, reg_end;
 	enum rdwr_status stat;
@@ -1323,15 +1321,12 @@ static int btmrvl_sdio_coredump(struct device *dev)
 	u8 dump_num = 0, idx, i, read_reg, doneflag = 0;
 	u32 memory_size, fw_dump_len = 0;
 
-	card = sdio_get_drvdata(func);
-	priv = card->priv;
-
 	/* dump sdio register first */
 	btmrvl_sdio_dump_regs(priv);
 
 	if (!card->supports_fw_dump) {
 		BT_ERR("Firmware dump not supported for this card!");
-		return -ENODATA;
+		return;
 	}
 
 	for (idx = 0; idx < ARRAY_SIZE(mem_type_mapping_tbl); idx++) {
@@ -1450,12 +1445,12 @@ static int btmrvl_sdio_coredump(struct device *dev)
 	sdio_release_host(card->func);
 
 	if (fw_dump_len == 0)
-		return -ENODATA;
+		return;
 
 	fw_dump_data = vzalloc(fw_dump_len+1);
 	if (!fw_dump_data) {
 		BT_ERR("Vzalloc fw_dump_data fail!");
-		return -ENOMEM;
+		return;
 	}
 	fw_dump_ptr = fw_dump_data;
 
@@ -1492,7 +1487,6 @@ static int btmrvl_sdio_coredump(struct device *dev)
 	 */
 	dev_coredumpv(&card->func->dev, fw_dump_data, fw_dump_len, GFP_KERNEL);
 	BT_INFO("== btmrvl firmware dump to /sys/class/devcoredump end");
-	return 0;
 }
 
 static int btmrvl_sdio_probe(struct sdio_func *func,
@@ -1553,6 +1547,7 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 	priv->hw_host_to_card = btmrvl_sdio_host_to_card;
 	priv->hw_wakeup_firmware = btmrvl_sdio_wakeup_fw;
 	priv->hw_process_int_status = btmrvl_sdio_process_int_status;
+	priv->firmware_dump = btmrvl_sdio_dump_firmware;
 
 	if (btmrvl_register_hdev(priv)) {
 		BT_ERR("Register hdev failed!");
@@ -1722,7 +1717,6 @@ static int btmrvl_sdio_resume(struct device *dev)
 	.remove		= btmrvl_sdio_remove,
 	.drv = {
 		.owner = THIS_MODULE,
-		.coredump = btmrvl_sdio_coredump,
 		.pm = &btmrvl_sdio_pm_ops,
 	}
 };
-- 
1.9.1


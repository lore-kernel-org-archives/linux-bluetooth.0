Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH] Bluetooth: btmrvl: add manufacturing mode support
Date: Thu, 7 May 2015 08:36:03 -0700
Message-ID: <1431012963-2754-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Default firmware is chosen when driver is loaded. This patch
adds provision to download manufacturing firmware which is
used for RF tests in the factory through sysfs configuration.

Procedure
1) Switch from normal mode to manufacturing mode.
    echo 1 > /sys/class/bluetooth/hci0/mfg_mode.
    echo "mrvl/sdio8897_mfg.bin" > /sys/class/bluetooth/hci0/mfg_firmware
    Trigger chip reset from wlan driver.

2) Switch from manufacturing mode to normal mode.
   echo 0 > /sys/class/bluetooth/hci0/mfg_mode
   Trigger chip reset from wlan driver.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/Makefile       |   1 +
 drivers/bluetooth/btmrvl_drv.h   |   7 +++
 drivers/bluetooth/btmrvl_main.c  |   3 ++
 drivers/bluetooth/btmrvl_sdio.c  |  16 +++++-
 drivers/bluetooth/btmrvl_sysfs.c | 103 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 128 insertions(+), 2 deletions(-)
 create mode 100644 drivers/bluetooth/btmrvl_sysfs.c

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index dd0d9c4..11042ac 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_BT_WILINK)		+= btwilink.o
 obj-$(CONFIG_BT_BCM)		+= btbcm.o
 
 btmrvl-y			:= btmrvl_main.o
+btmrvl-y			+= btmrvl_sysfs.o
 btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
 
 hci_uart-y				:= hci_ldisc.o
diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 086f0ec..71dc407 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -89,6 +89,7 @@ struct btmrvl_adapter {
 	wait_queue_head_t event_hs_wait_q;
 	u8 cmd_complete;
 	bool is_suspended;
+	bool mfg_mode;
 };
 
 struct btmrvl_private {
@@ -155,6 +156,9 @@ struct btmrvl_event {
 	u8 data[4];
 } __packed;
 
+extern bool mfg_mode;
+extern char mfg_firmware[32];
+
 /* Prototype of global function */
 
 int btmrvl_register_hdev(struct btmrvl_private *priv);
@@ -174,6 +178,9 @@ int btmrvl_prepare_command(struct btmrvl_private *priv);
 int btmrvl_enable_hs(struct btmrvl_private *priv);
 void btmrvl_firmware_dump(struct btmrvl_private *priv);
 
+int btmrvl_sysfs_register(struct hci_dev *hdev);
+void btmrvl_sysfs_unregister(struct hci_dev *hdev);
+
 #ifdef CONFIG_DEBUG_FS
 void btmrvl_debugfs_init(struct hci_dev *hdev);
 void btmrvl_debugfs_remove(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index de05deb..1a76bdd 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -432,6 +432,7 @@ static void btmrvl_init_adapter(struct btmrvl_private *priv)
 
 	init_waitqueue_head(&priv->adapter->cmd_wait_q);
 	init_waitqueue_head(&priv->adapter->event_hs_wait_q);
+	priv->adapter->mfg_mode = mfg_mode;
 }
 
 static void btmrvl_free_adapter(struct btmrvl_private *priv)
@@ -716,6 +717,7 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 #ifdef CONFIG_DEBUG_FS
 	btmrvl_debugfs_init(hdev);
 #endif
+	btmrvl_sysfs_register(hdev);
 
 	return 0;
 
@@ -791,6 +793,7 @@ int btmrvl_remove_card(struct btmrvl_private *priv)
 #ifdef CONFIG_DEBUG_FS
 	btmrvl_debugfs_remove(hdev);
 #endif
+	btmrvl_sysfs_unregister(hdev);
 
 	hci_unregister_dev(hdev);
 
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 01d6da5..82268717 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -452,8 +452,20 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 	u16 len, blksz_dl = card->sd_blksz_fw_dl;
 	int txlen = 0, tx_blocks = 0, count = 0;
 
-	ret = request_firmware(&fw_firmware, card->firmware,
-							&card->func->dev);
+	if (mfg_mode && !strlen(mfg_firmware)) {
+		mfg_mode = 0;
+		BT_ERR("mfg firmware missing. Ignoring manufacturing mode");
+	}
+
+	/* override default firmware name with new one if provided by user */
+	if (mfg_mode) {
+		ret = request_firmware(&fw_firmware, mfg_firmware,
+				       &card->func->dev);
+	} else {
+		ret = request_firmware(&fw_firmware, card->firmware,
+				       &card->func->dev);
+	}
+
 	if ((ret < 0) || !fw_firmware) {
 		BT_ERR("request_firmware(firmware) failed, error code = %d",
 									ret);
diff --git a/drivers/bluetooth/btmrvl_sysfs.c b/drivers/bluetooth/btmrvl_sysfs.c
new file mode 100644
index 0000000..b39938e
--- /dev/null
+++ b/drivers/bluetooth/btmrvl_sysfs.c
@@ -0,0 +1,103 @@
+/* Marvell Bluetooth driver: sysfs related functions
+ *
+ * Copyright (C) 2015, Marvell International Ltd.
+ *
+ * This software file (the "File") is distributed by Marvell International
+ * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * (the "License").  You may use, redistribute and/or modify this File in
+ * accordance with the terms and conditions of the License, a copy of which
+ * is available on the worldwide web at
+ * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
+ *
+ * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
+ * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
+ * this warranty disclaimer.
+ */
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include "btmrvl_drv.h"
+
+bool mfg_mode;
+EXPORT_SYMBOL_GPL(mfg_mode);
+char mfg_firmware[32];
+EXPORT_SYMBOL_GPL(mfg_firmware);
+
+static ssize_t
+btmrvl_sysfs_get_mfg_mode(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct btmrvl_private *priv = hci_get_drvdata(to_hci_dev(dev));
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", priv->adapter->mfg_mode);
+}
+
+static ssize_t
+btmrvl_sysfs_set_mfg_mode(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	bool res;
+
+	if (strtobool(buf, &res))
+		return -EINVAL;
+
+	mfg_mode = res;
+
+	return count;
+}
+
+static DEVICE_ATTR(mfg_mode, S_IRUGO | S_IWUSR,
+		   btmrvl_sysfs_get_mfg_mode,
+		   btmrvl_sysfs_set_mfg_mode);
+
+static ssize_t btmrvl_sysfs_show_mfg_firmware(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", mfg_firmware);
+}
+
+static ssize_t btmrvl_sysfs_store_mfg_firmware(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	int len;
+
+	len = strlen(buf);
+	if (len > sizeof(mfg_firmware))
+		return -EINVAL;
+
+	strcpy(mfg_firmware, buf);
+	mfg_firmware[len - 1] = '\0';
+
+	return count;
+}
+static DEVICE_ATTR(mfg_firmware, S_IRUGO | S_IWUSR,
+		   btmrvl_sysfs_show_mfg_firmware,
+		   btmrvl_sysfs_store_mfg_firmware);
+
+int btmrvl_sysfs_register(struct hci_dev *hdev)
+{
+	int ret;
+
+	/* Create sysfs file to control manufacturing mode feature*/
+	ret = device_create_file(&hdev->dev, &dev_attr_mfg_mode);
+	if (ret)
+		BT_ERR("%s failed to create sysfs file mfg_mode", hdev->name);
+
+	/* Create sysfs file to store manufacturing firmware name */
+	ret = device_create_file(&hdev->dev, &dev_attr_mfg_firmware);
+	if (ret)
+		BT_ERR("%s failed to create sysfs file mfg_firmware",
+		       hdev->name);
+
+	return ret;
+}
+
+void btmrvl_sysfs_unregister(struct hci_dev *hdev)
+{
+	device_remove_file(&hdev->dev, &dev_attr_mfg_mode);
+	device_remove_file(&hdev->dev, &dev_attr_mfg_firmware);
+}
+
-- 
1.8.1.4

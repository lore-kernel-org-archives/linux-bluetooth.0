Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Cathy Luo <cluo@marvell.com>, Xinming Hu <huxm@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH] Bluetooth: btmrvl: add sysfs commands gpiogap and hscfgcmd
Date: Thu, 26 Nov 2015 02:37:18 -0800
Message-ID: <1448534238-5508-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Xinming Hu <huxm@marvell.com>

This patch adds support for driver's internal host sleep
configuration via sysfs. gpiogap and hscfgcmd sysfs commands
are added for this purpose.

Examples.
1. Get current gpiogap
   cat /sys/class/bluetooth/hci0/gpiogap
2. Set gpio as 13 and gap as 100msecs
   echo "0x0d64" > /sys/class/bluetooth/hci0/gpiogap
3. Download host sleep configuration to firmware.
   echo "1" > /sys/class/bluetooth/hci0/hscfgcmd

Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/Makefile       |   1 +
 drivers/bluetooth/btmrvl_drv.h   |   3 +
 drivers/bluetooth/btmrvl_main.c  |   2 +
 drivers/bluetooth/btmrvl_sysfs.c | 121 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100644 drivers/bluetooth/btmrvl_sysfs.c

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 07c9cf3..d0fd0b1 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_BT_QCA)		+= btqca.o
 
 btmrvl-y			:= btmrvl_main.o
 btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
+btmrvl-y           += btmrvl_sysfs.o
 
 hci_uart-y				:= hci_ldisc.o
 hci_uart-$(CONFIG_BT_HCIUART_H4)	+= hci_h4.o
diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 27a9aac..0fc0e7d 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -174,6 +174,9 @@ int btmrvl_prepare_command(struct btmrvl_private *priv);
 int btmrvl_enable_hs(struct btmrvl_private *priv);
 void btmrvl_firmware_dump(struct btmrvl_private *priv);
 
+int btmrvl_sysfs_register(struct btmrvl_private *priv);
+void btmrvl_sysfs_unregister(struct btmrvl_private *priv);
+
 #ifdef CONFIG_DEBUG_FS
 void btmrvl_debugfs_init(struct hci_dev *hdev);
 void btmrvl_debugfs_remove(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index f2b38c8..6a8faa2 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -693,6 +693,7 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 #ifdef CONFIG_DEBUG_FS
 	btmrvl_debugfs_init(hdev);
 #endif
+	btmrvl_sysfs_register(priv);
 
 	return 0;
 
@@ -768,6 +769,7 @@ int btmrvl_remove_card(struct btmrvl_private *priv)
 #ifdef CONFIG_DEBUG_FS
 	btmrvl_debugfs_remove(hdev);
 #endif
+	btmrvl_sysfs_unregister(priv);
 
 	hci_unregister_dev(hdev);
 
diff --git a/drivers/bluetooth/btmrvl_sysfs.c b/drivers/bluetooth/btmrvl_sysfs.c
new file mode 100644
index 0000000..5fe6fd7
--- /dev/null
+++ b/drivers/bluetooth/btmrvl_sysfs.c
@@ -0,0 +1,121 @@
+/**
+ * Marvell Bluetooth driver: sysfs related functions
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
+#include <linux/slab.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btmrvl_drv.h"
+
+static ssize_t
+btmrvl_sysfs_show_hscfgcmd(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
+	struct btmrvl_private *priv = hci_get_drvdata(hdev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", priv->btmrvl_dev.hscfgcmd);
+}
+
+static ssize_t
+btmrvl_sysfs_store_hscfgcmd(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	long ret;
+	u8 result;
+	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
+	struct btmrvl_private *priv = hci_get_drvdata(hdev);
+
+	ret = kstrtou8(buf, 10, &result);
+	if (ret)
+		return ret;
+
+	if (!priv)
+		return -EINVAL;
+
+	priv->btmrvl_dev.hscfgcmd = result;
+	if (priv->btmrvl_dev.hscfgcmd) {
+		btmrvl_prepare_command(priv);
+		wake_up_interruptible(&priv->main_thread.wait_q);
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(hscfgcmd, S_IRUGO | S_IWUSR,
+		   btmrvl_sysfs_show_hscfgcmd,
+		   btmrvl_sysfs_store_hscfgcmd);
+
+static ssize_t
+btmrvl_sysfs_show_gpiogap(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
+	struct btmrvl_private *priv = hci_get_drvdata(hdev);
+
+	return snprintf(buf, PAGE_SIZE, "0x%x\n", priv->btmrvl_dev.gpio_gap);
+}
+
+static ssize_t
+btmrvl_sysfs_store_gpiogap(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	long ret;
+	u16 result;
+	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
+	struct btmrvl_private *priv = hci_get_drvdata(hdev);
+
+	ret = kstrtou16(buf, 10, &result);
+	if (ret)
+		return ret;
+
+	priv->btmrvl_dev.gpio_gap = result;
+	return count;
+}
+
+static DEVICE_ATTR(gpiogap, S_IRUGO | S_IWUSR,
+		   btmrvl_sysfs_show_gpiogap,
+		   btmrvl_sysfs_store_gpiogap);
+
+static struct attribute *btmrvl_dev_attrs[] = {
+	&dev_attr_hscfgcmd.attr,
+	&dev_attr_gpiogap.attr,
+	NULL,
+};
+
+static struct attribute_group btmrvl_dev_attr_group = {
+	.attrs = btmrvl_dev_attrs,
+};
+
+static const struct attribute_group *btmrvl_dev_attr_groups[] = {
+	&btmrvl_dev_attr_group,
+	NULL,
+};
+
+int btmrvl_sysfs_register(struct btmrvl_private *priv)
+{
+	return sysfs_create_groups(&priv->btmrvl_dev.hcidev->dev.kobj,
+				   btmrvl_dev_attr_groups);
+}
+
+void btmrvl_sysfs_unregister(struct btmrvl_private *priv)
+{
+	sysfs_remove_groups(&priv->btmrvl_dev.hcidev->dev.kobj,
+			    btmrvl_dev_attr_groups);
+}
-- 
1.8.1.4


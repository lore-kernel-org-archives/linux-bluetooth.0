Return-Path: <root@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, Cathy Luo <cluo@marvell.com>,
        Nishant Sarmukadam
	<nishants@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Amitkumar Karwar
	<akarwar@marvell.com>
Subject: [PATCH 1/2] bluetooth: btmrvl: register platform specific driver
Date: Tue, 2 Feb 2016 20:03:25 -0800
Message-ID: <1454472206-25716-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Xinming Hu <huxm@marvell.com>

Platform device and driver provide easy way to
interact with device-tree-enabled system.

This patch registers platform driver and reorganise
existing device tree specific code.

Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 Documentation/devicetree/bindings/btmrvl.txt |  8 ++--
 drivers/bluetooth/Makefile                   |  1 +
 drivers/bluetooth/btmrvl_drv.h               | 16 ++++++++
 drivers/bluetooth/btmrvl_main.c              |  7 +++-
 drivers/bluetooth/btmrvl_platform.c          | 60 ++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 5 deletions(-)
 create mode 100644 drivers/bluetooth/btmrvl_platform.c

diff --git a/Documentation/devicetree/bindings/btmrvl.txt b/Documentation/devicetree/bindings/btmrvl.txt
index 58f964b..25b804b 100644
--- a/Documentation/devicetree/bindings/btmrvl.txt
+++ b/Documentation/devicetree/bindings/btmrvl.txt
@@ -3,7 +3,7 @@ btmrvl
 
 Required properties:
 
-  - compatible : must be "btmrvl,cfgdata"
+  - compatible : must be "marvell,btmrvl"
 
 Optional properties:
 
@@ -15,11 +15,11 @@ Optional properties:
 
 Example:
 
-GPIO pin 13 is configured as a wakeup source and GAP is set to 100 msecs
-in below example.
+GPIO pin 13 and gap 100ms are configured for host wakeup, calibration
+data is also available in below example.
 
 btmrvl {
-	compatible = "btmrvl,cfgdata";
+	compatible = "marvell,btmrvl";
 
 	btmrvl,cal-data = /bits/ 8 <
 		0x37 0x01 0x1c 0x00 0xff 0xff 0xff 0xff 0x01 0x7f 0x04 0x02
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 07c9cf3..9bc3828 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_BT_RTL)		+= btrtl.o
 obj-$(CONFIG_BT_QCA)		+= btqca.o
 
 btmrvl-y			:= btmrvl_main.o
+btmrvl-y			+= btmrvl_platform.o
 btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
 
 hci_uart-y				:= hci_ldisc.o
diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 0590473..de6309b 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -22,8 +22,22 @@
 #include <linux/kthread.h>
 #include <linux/bitops.h>
 #include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/gfp.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <net/bluetooth/bluetooth.h>
 
+extern struct platform_device *btmrvl_plt_dev;
+
 #define BTM_HEADER_LEN			4
 #define BTM_UPLD_SIZE			2312
 
@@ -174,6 +188,8 @@ int btmrvl_enable_ps(struct btmrvl_private *priv);
 int btmrvl_prepare_command(struct btmrvl_private *priv);
 int btmrvl_enable_hs(struct btmrvl_private *priv);
 void btmrvl_firmware_dump(struct btmrvl_private *priv);
+int btmrvl_platform_drv_init(void);
+void btmrvl_platform_drv_exit(void);
 
 #ifdef CONFIG_DEBUG_FS
 void btmrvl_debugfs_init(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index f25a825..3604894 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -514,7 +514,8 @@ static int btmrvl_check_device_tree(struct btmrvl_private *priv)
 	int ret;
 	u32 val;
 
-	for_each_compatible_node(dt_node, NULL, "btmrvl,cfgdata") {
+	dt_node = btmrvl_plt_dev->dev.of_node;
+	if (dt_node) {
 		ret = of_property_read_u32(dt_node, "btmrvl,gpio-gap", &val);
 		if (!ret)
 			priv->btmrvl_dev.gpio_gap = val;
@@ -733,6 +734,8 @@ struct btmrvl_private *btmrvl_add_card(void *card)
 		goto err_adapter;
 	}
 
+	btmrvl_platform_drv_init();
+
 	btmrvl_init_adapter(priv);
 
 	BT_DBG("Starting kthread...");
@@ -776,6 +779,8 @@ int btmrvl_remove_card(struct btmrvl_private *priv)
 	btmrvl_debugfs_remove(hdev);
 #endif
 
+	btmrvl_platform_drv_exit();
+
 	hci_unregister_dev(hdev);
 
 	hci_free_dev(hdev);
diff --git a/drivers/bluetooth/btmrvl_platform.c b/drivers/bluetooth/btmrvl_platform.c
new file mode 100644
index 0000000..4e91d27
--- /dev/null
+++ b/drivers/bluetooth/btmrvl_platform.c
@@ -0,0 +1,60 @@
+/* Marvell Bluetooth driver: platform specific driver
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
+#include "btmrvl_drv.h"
+
+struct platform_device *btmrvl_plt_dev;
+
+static int btmrvl_plt_probe(struct platform_device *pdev)
+{
+	btmrvl_plt_dev = pdev;
+	return 0;
+}
+
+static int btmrvl_plt_remove(struct platform_device *pdev)
+{
+	btmrvl_plt_dev = NULL;
+	return 0;
+}
+
+static const struct of_device_id btmrvl_dt_match[] = {
+	{
+		.compatible = "marvell,btmrvl",
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, btmrvl_dt_match);
+
+static struct platform_driver btmrvl_platform_driver = {
+	.probe		= btmrvl_plt_probe,
+	.remove		= btmrvl_plt_remove,
+	.driver = {
+		.name	= "btmrvl_plt",
+		.of_match_table = btmrvl_dt_match,
+	}
+};
+
+int btmrvl_platform_drv_init(void)
+{
+	return platform_driver_register(&btmrvl_platform_driver);
+}
+
+void btmrvl_platform_drv_exit(void)
+{
+	platform_driver_unregister(&btmrvl_platform_driver);
+}
-- 
1.8.1.4

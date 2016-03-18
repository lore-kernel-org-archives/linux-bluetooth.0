Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Cathy Luo <cluo@marvell.com>, <linux-kernel@vger.kernel.org>,
	Nishant Sarmukadam <nishants@marvell.com>,
	<devicetree@vger.kernel.org>,
	Wei-Ning Huang <wnhuang@chromium.org>,
	Xinming Hu <huxm@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH 2/2] btmrvl: add platform specific wakeup interrupt support
Date: Fri, 18 Mar 2016 04:04:44 -0700
Message-ID: <1458299084-31976-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1458299084-31976-1-git-send-email-akarwar@marvell.com>
References: <1458299084-31976-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Xinming Hu <huxm@marvell.com>

On some arm-based platforms, we need to configure platform specific
parameters by device tree node and we need define our node as a child
node of parent SDIO host controller.
This patch parses these parameters from device tree. It includes
calibration data download to firmware, wakeup pin configured to firmware,
and soc specific wakeup interrupt pin.

Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_drv.h  | 11 ++++++
 drivers/bluetooth/btmrvl_main.c | 20 +++++------
 drivers/bluetooth/btmrvl_sdio.c | 79 +++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmrvl_sdio.h |  6 ++++
 4 files changed, 105 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 0590473..f742384 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -23,6 +23,17 @@
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <net/bluetooth/bluetooth.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/gfp.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of_gpio.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/of_irq.h>
 
 #define BTM_HEADER_LEN			4
 #define BTM_UPLD_SIZE			2312
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index f25a825..b7c32f4 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -510,34 +510,32 @@ static int btmrvl_download_cal_data(struct btmrvl_private *priv,
 static int btmrvl_check_device_tree(struct btmrvl_private *priv)
 {
 	struct device_node *dt_node;
+	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
 	u8 cal_data[BT_CAL_HDR_LEN + BT_CAL_DATA_SIZE];
-	int ret;
+	int ret = 0;
 	u32 val;
 
-	for_each_compatible_node(dt_node, NULL, "btmrvl,cfgdata") {
-		ret = of_property_read_u32(dt_node, "btmrvl,gpio-gap", &val);
+	if (card->plt_of_node) {
+		dt_node = card->plt_of_node;
+		ret = of_property_read_u32(dt_node, "btmrvl,wakeuppin-gap",
+					   &val);
 		if (!ret)
 			priv->btmrvl_dev.gpio_gap = val;
 
 		ret = of_property_read_u8_array(dt_node, "btmrvl,cal-data",
 						cal_data + BT_CAL_HDR_LEN,
 						BT_CAL_DATA_SIZE);
-		if (ret) {
-			of_node_put(dt_node);
+		if (ret)
 			return ret;
-		}
 
 		BT_DBG("Use cal data from device tree");
 		ret = btmrvl_download_cal_data(priv, cal_data,
 					       BT_CAL_DATA_SIZE);
-		if (ret) {
+		if (ret)
 			BT_ERR("Fail to download calibrate data");
-			of_node_put(dt_node);
-			return ret;
-		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static int btmrvl_setup(struct hci_dev *hdev)
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 6ed8acf..845ef28 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -52,6 +52,68 @@ static struct memory_type_mapping mem_type_mapping_tbl[] = {
 	{"EXTLAST", NULL, 0, 0xFE},
 };
 
+static const struct of_device_id btmrvl_sdio_of_match_table[] = {
+	{ .compatible = "marvell,bt-sd8897" },
+	{ .compatible = "marvell,bt-sd8997" },
+	{ }
+};
+
+static irqreturn_t btmrvl_wake_irq_bt(int irq, void *priv)
+{
+	struct btmrvl_plt_wake_cfg *cfg = priv;
+
+	if (cfg->irq_bt >= 0) {
+		pr_info("%s: wake by bt", __func__);
+		cfg->wake_by_bt = true;
+		disable_irq_nosync(irq);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* This function parse device tree node using mmc subnode devicetree API.
+ * The device node is saved in card->plt_of_node.
+ * if the device tree node exist and include interrupts attributes, this
+ * function will also request platform specific wakeup interrupt.
+ */
+static int btmrvl_sdio_probe_of(struct device *dev,
+				struct btmrvl_sdio_card *card)
+{
+	struct btmrvl_plt_wake_cfg *cfg;
+	int ret;
+
+	if (!dev->of_node ||
+	    !of_match_node(btmrvl_sdio_of_match_table, dev->of_node)) {
+		pr_err("sdio platform data not available");
+		return -1;
+	}
+
+	card->plt_of_node = dev->of_node;
+
+	card->plt_wake_cfg = devm_kzalloc(dev, sizeof(*card->plt_wake_cfg),
+					  GFP_KERNEL);
+	cfg = card->plt_wake_cfg;
+	if (cfg && card->plt_of_node) {
+		cfg->irq_bt = irq_of_parse_and_map(card->plt_of_node, 0);
+		if (!cfg->irq_bt) {
+			dev_err(dev, "fail to parse irq_bt from device tree");
+		} else {
+			ret = devm_request_irq(dev, cfg->irq_bt,
+					       btmrvl_wake_irq_bt,
+					       IRQF_TRIGGER_LOW,
+					       "bt_wake", cfg);
+			if (ret) {
+				dev_err(dev,
+					"Failed to request irq_bt %d (%d)\n",
+					cfg->irq_bt, ret);
+			}
+			disable_irq(cfg->irq_bt);
+		}
+	}
+
+	return 0;
+}
+
 /* The btmrvl_sdio_remove() callback function is called
  * when user removes this module from kernel space or ejects
  * the card from the slot. The driver handles these 2 cases
@@ -1464,6 +1526,9 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 
 	btmrvl_sdio_enable_host_int(card);
 
+	/* device tree node parsing and platform specific configuration*/
+	btmrvl_sdio_probe_of(&func->dev, card);
+
 	priv = btmrvl_add_card(card);
 	if (!priv) {
 		BT_ERR("Initializing card failed!");
@@ -1544,6 +1609,13 @@ static int btmrvl_sdio_suspend(struct device *dev)
 		return 0;
 	}
 
+	/* Enable platform specific wakeup interrupt */
+	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0) {
+		card->plt_wake_cfg->wake_by_bt = false;
+		enable_irq(card->plt_wake_cfg->irq_bt);
+		enable_irq_wake(card->plt_wake_cfg->irq_bt);
+	}
+
 	priv = card->priv;
 	priv->adapter->is_suspending = true;
 	hcidev = priv->btmrvl_dev.hcidev;
@@ -1606,6 +1678,13 @@ static int btmrvl_sdio_resume(struct device *dev)
 	BT_DBG("%s: SDIO resume", hcidev->name);
 	hci_resume_dev(hcidev);
 
+	/* Disable platform specific wakeup interrupt */
+	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0) {
+		disable_irq_wake(card->plt_wake_cfg->irq_bt);
+		if (!card->plt_wake_cfg->wake_by_bt)
+			disable_irq(card->plt_wake_cfg->irq_bt);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/bluetooth/btmrvl_sdio.h b/drivers/bluetooth/btmrvl_sdio.h
index 1a3bd06..3a522d2 100644
--- a/drivers/bluetooth/btmrvl_sdio.h
+++ b/drivers/bluetooth/btmrvl_sdio.h
@@ -62,6 +62,10 @@
 
 #define FIRMWARE_READY				0xfedc
 
+struct btmrvl_plt_wake_cfg {
+	int irq_bt;
+	bool wake_by_bt;
+};
 
 struct btmrvl_sdio_card_reg {
 	u8 cfg;
@@ -97,6 +101,8 @@ struct btmrvl_sdio_card {
 	u16 sd_blksz_fw_dl;
 	u8 rx_unit;
 	struct btmrvl_private *priv;
+	struct device_node *plt_of_node;
+	struct btmrvl_plt_wake_cfg *plt_wake_cfg;
 };
 
 struct btmrvl_sdio_device {
-- 
1.8.1.4


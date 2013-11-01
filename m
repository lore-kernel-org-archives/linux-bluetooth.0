Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan
	<gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mike
 Frysinger <vapier@chromium.org>,
        Amitkumar Karwar <akarwar@marvell.com>, Bing
 Zhao <bzhao@marvell.com>
Subject: [PATCH v2 1/2] Bluetooth: btmrvl: use cal-data from device-tree instead of conf file
Date: Fri, 1 Nov 2013 15:28:24 -0700
Message-ID: <1383344905-3525-1-git-send-email-bzhao@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Some ARM versions of Chromebook need to download a new calibration
data from host driver to firmware. They do have EEPROM but still
need a piece of new calibration data in test mode.

The cal-data is platform dependent. It's simpler and more feasible
to use device tree based cal-data instead of configuration file
based cal-data.

This patch remove configuration file based cal-data downloading
and replace it using cal-data from device tree.

When CONFIG_OF is not selected, or the specific property is not
present in the device tree, the calibration downloading will not
happen.

Cc: Mike Frysinger <vapier@chromium.org>
Cc: Amitkumar Karwar <akarwar@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
Signed-off-by: Hyuckjoo Lee <hyuckjoo.lee@samsung.com>
---
v2: add verbose commit messages (Marcel Holtmann)

 drivers/bluetooth/btmrvl_drv.h  |  4 --
 drivers/bluetooth/btmrvl_main.c | 92 ++++++++---------------------------------
 drivers/bluetooth/btmrvl_sdio.c |  9 +---
 drivers/bluetooth/btmrvl_sdio.h |  2 -
 4 files changed, 18 insertions(+), 89 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index f9d1833..be76851 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -23,8 +23,6 @@
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <net/bluetooth/bluetooth.h>
-#include <linux/ctype.h>
-#include <linux/firmware.h>
 
 #define BTM_HEADER_LEN			4
 #define BTM_UPLD_SIZE			2312
@@ -43,8 +41,6 @@ struct btmrvl_thread {
 struct btmrvl_device {
 	void *card;
 	struct hci_dev *hcidev;
-	struct device *dev;
-	const char *cal_data;
 
 	u8 dev_type;
 
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 5cf31c4..a17812d 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -19,7 +19,7 @@
  **/
 
 #include <linux/module.h>
-
+#include <linux/of.h>
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
@@ -417,52 +417,8 @@ static int btmrvl_open(struct hci_dev *hdev)
 	return 0;
 }
 
-/*
- * This function parses provided calibration data input. It should contain
- * hex bytes separated by space or new line character. Here is an example.
- * 00 1C 01 37 FF FF FF FF 02 04 7F 01
- * CE BA 00 00 00 2D C6 C0 00 00 00 00
- * 00 F0 00 00
- */
-static int btmrvl_parse_cal_cfg(const u8 *src, u32 len, u8 *dst, u32 dst_size)
-{
-	const u8 *s = src;
-	u8 *d = dst;
-	int ret;
-	u8 tmp[3];
-
-	tmp[2] = '\0';
-	while ((s - src) <= len - 2) {
-		if (isspace(*s)) {
-			s++;
-			continue;
-		}
-
-		if (isxdigit(*s)) {
-			if ((d - dst) >= dst_size) {
-				BT_ERR("calibration data file too big!!!");
-				return -EINVAL;
-			}
-
-			memcpy(tmp, s, 2);
-
-			ret = kstrtou8(tmp, 16, d++);
-			if (ret < 0)
-				return ret;
-
-			s += 2;
-		} else {
-			return -EINVAL;
-		}
-	}
-	if (d == dst)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int btmrvl_load_cal_data(struct btmrvl_private *priv,
-				u8 *config_data)
+static int btmrvl_download_cal_data(struct btmrvl_private *priv,
+				    u8 *config_data)
 {
 	int i, ret;
 	u8 data[BT_CMD_DATA_SIZE];
@@ -490,54 +446,40 @@ static int btmrvl_load_cal_data(struct btmrvl_private *priv,
 	return 0;
 }
 
-static int
-btmrvl_process_cal_cfg(struct btmrvl_private *priv, u8 *data, u32 size)
+static int btmrvl_cal_data_dt(struct btmrvl_private *priv)
 {
+	struct device_node *dt_node;
 	u8 cal_data[BT_CAL_DATA_SIZE];
+	const char name[] = "btmrvl_caldata";
+	const char property[] = "btmrvl,caldata";
 	int ret;
 
-	ret = btmrvl_parse_cal_cfg(data, size, cal_data, sizeof(cal_data));
+	dt_node = of_find_node_by_name(NULL, name);
+	if (!dt_node)
+		return -ENODEV;
+
+	ret = of_property_read_u8_array(dt_node, property, cal_data,
+					sizeof(cal_data));
 	if (ret)
 		return ret;
 
-	ret = btmrvl_load_cal_data(priv, cal_data);
+	BT_DBG("Use cal data from device tree");
+	ret = btmrvl_download_cal_data(priv, cal_data);
 	if (ret) {
-		BT_ERR("Fail to load calibrate data");
+		BT_ERR("Fail to download calibrate data");
 		return ret;
 	}
 
 	return 0;
 }
 
-static int btmrvl_cal_data_config(struct btmrvl_private *priv)
-{
-	const struct firmware *cfg;
-	int ret;
-	const char *cal_data = priv->btmrvl_dev.cal_data;
-
-	if (!cal_data)
-		return 0;
-
-	ret = request_firmware(&cfg, cal_data, priv->btmrvl_dev.dev);
-	if (ret < 0) {
-		BT_DBG("Failed to get %s file, skipping cal data download",
-		       cal_data);
-		return 0;
-	}
-
-	ret = btmrvl_process_cal_cfg(priv, (u8 *)cfg->data, cfg->size);
-	release_firmware(cfg);
-	return ret;
-}
-
 static int btmrvl_setup(struct hci_dev *hdev)
 {
 	struct btmrvl_private *priv = hci_get_drvdata(hdev);
 
 	btmrvl_send_module_cfg_cmd(priv, MODULE_BRINGUP_REQ);
 
-	if (btmrvl_cal_data_config(priv))
-		BT_ERR("Set cal data failed");
+	btmrvl_cal_data_dt(priv);
 
 	priv->btmrvl_dev.psmode = 1;
 	btmrvl_enable_ps(priv);
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index fabcf5b..1b52c9f 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -18,6 +18,7 @@
  * this warranty disclaimer.
  **/
 
+#include <linux/firmware.h>
 #include <linux/slab.h>
 
 #include <linux/mmc/sdio_ids.h>
@@ -101,7 +102,6 @@ static const struct btmrvl_sdio_card_reg btmrvl_reg_88xx = {
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8688 = {
 	.helper		= "mrvl/sd8688_helper.bin",
 	.firmware	= "mrvl/sd8688.bin",
-	.cal_data	= NULL,
 	.reg		= &btmrvl_reg_8688,
 	.sd_blksz_fw_dl	= 64,
 };
@@ -109,7 +109,6 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8688 = {
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8787 = {
 	.helper		= NULL,
 	.firmware	= "mrvl/sd8787_uapsta.bin",
-	.cal_data	= NULL,
 	.reg		= &btmrvl_reg_87xx,
 	.sd_blksz_fw_dl	= 256,
 };
@@ -117,7 +116,6 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8787 = {
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8797 = {
 	.helper		= NULL,
 	.firmware	= "mrvl/sd8797_uapsta.bin",
-	.cal_data	= "mrvl/sd8797_caldata.conf",
 	.reg		= &btmrvl_reg_87xx,
 	.sd_blksz_fw_dl	= 256,
 };
@@ -125,7 +123,6 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8797 = {
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8897 = {
 	.helper		= NULL,
 	.firmware	= "mrvl/sd8897_uapsta.bin",
-	.cal_data	= NULL,
 	.reg		= &btmrvl_reg_88xx,
 	.sd_blksz_fw_dl	= 256,
 };
@@ -1007,7 +1004,6 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 		struct btmrvl_sdio_device *data = (void *) id->driver_data;
 		card->helper = data->helper;
 		card->firmware = data->firmware;
-		card->cal_data = data->cal_data;
 		card->reg = data->reg;
 		card->sd_blksz_fw_dl = data->sd_blksz_fw_dl;
 	}
@@ -1036,8 +1032,6 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 	}
 
 	card->priv = priv;
-	priv->btmrvl_dev.dev = &card->func->dev;
-	priv->btmrvl_dev.cal_data = card->cal_data;
 
 	/* Initialize the interface specific function pointers */
 	priv->hw_host_to_card = btmrvl_sdio_host_to_card;
@@ -1220,5 +1214,4 @@ MODULE_FIRMWARE("mrvl/sd8688_helper.bin");
 MODULE_FIRMWARE("mrvl/sd8688.bin");
 MODULE_FIRMWARE("mrvl/sd8787_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8797_uapsta.bin");
-MODULE_FIRMWARE("mrvl/sd8797_caldata.conf");
 MODULE_FIRMWARE("mrvl/sd8897_uapsta.bin");
diff --git a/drivers/bluetooth/btmrvl_sdio.h b/drivers/bluetooth/btmrvl_sdio.h
index 6872d9e..43d35a6 100644
--- a/drivers/bluetooth/btmrvl_sdio.h
+++ b/drivers/bluetooth/btmrvl_sdio.h
@@ -85,7 +85,6 @@ struct btmrvl_sdio_card {
 	u32 ioport;
 	const char *helper;
 	const char *firmware;
-	const char *cal_data;
 	const struct btmrvl_sdio_card_reg *reg;
 	u16 sd_blksz_fw_dl;
 	u8 rx_unit;
@@ -95,7 +94,6 @@ struct btmrvl_sdio_card {
 struct btmrvl_sdio_device {
 	const char *helper;
 	const char *firmware;
-	const char *cal_data;
 	const struct btmrvl_sdio_card_reg *reg;
 	u16 sd_blksz_fw_dl;
 };
-- 
1.8.0

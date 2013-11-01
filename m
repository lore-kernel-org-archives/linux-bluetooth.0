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
Subject: [PATCH v2 2/2] Bluetooth: btmrvl: remove cal-data byte swapping and redundant mem copy
Date: Fri, 1 Nov 2013 15:28:25 -0700
Message-ID: <1383344905-3525-2-git-send-email-bzhao@marvell.com>
In-Reply-To: <1383344905-3525-1-git-send-email-bzhao@marvell.com>
References: <1383344905-3525-1-git-send-email-bzhao@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

The device tree property can define the cal-data in proper order.
There is no need to swap the bytes in driver.
Also remove the redundant cal-data memory copy after removing the
byte swapping.

Cc: Mike Frysinger <vapier@chromium.org>
Cc: Amitkumar Karwar <akarwar@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
Signed-off-by: Hyuckjoo Lee <hyuckjoo.lee@samsung.com>
---
v2: no change from v1

 drivers/bluetooth/btmrvl_drv.h  |  2 +-
 drivers/bluetooth/btmrvl_main.c | 27 ++++++++++-----------------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index be76851..ffac0e4 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -117,7 +117,7 @@ struct btmrvl_private {
 #define PS_SLEEP			0x01
 #define PS_AWAKE			0x00
 
-#define BT_CMD_DATA_SIZE		32
+#define BT_CAL_HDR_LEN			4
 #define BT_CAL_DATA_SIZE		28
 
 struct btmrvl_event {
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index a17812d..f13bef8 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -418,28 +418,20 @@ static int btmrvl_open(struct hci_dev *hdev)
 }
 
 static int btmrvl_download_cal_data(struct btmrvl_private *priv,
-				    u8 *config_data)
+				    u8 *data, int len)
 {
-	int i, ret;
-	u8 data[BT_CMD_DATA_SIZE];
+	int ret;
 
 	data[0] = 0x00;
 	data[1] = 0x00;
 	data[2] = 0x00;
-	data[3] = BT_CMD_DATA_SIZE - 4;
-
-	/* Swap cal-data bytes. Each four bytes are swapped. Considering 4
-	 * byte SDIO header offset, mapping of input and output bytes will be
-	 * {3, 2, 1, 0} -> {0+4, 1+4, 2+4, 3+4},
-	 * {7, 6, 5, 4} -> {4+4, 5+4, 6+4, 7+4} */
-	for (i = 4; i < BT_CMD_DATA_SIZE; i++)
-		data[i] = config_data[(i / 4) * 8 - 1 - i];
+	data[3] = len;
 
 	print_hex_dump_bytes("Calibration data: ",
-			     DUMP_PREFIX_OFFSET, data, BT_CMD_DATA_SIZE);
+			     DUMP_PREFIX_OFFSET, data, BT_CAL_HDR_LEN + len);
 
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_LOAD_CONFIG_DATA, data,
-				   BT_CMD_DATA_SIZE);
+				   BT_CAL_HDR_LEN + len);
 	if (ret)
 		BT_ERR("Failed to download caibration data\n");
 
@@ -449,7 +441,7 @@ static int btmrvl_download_cal_data(struct btmrvl_private *priv,
 static int btmrvl_cal_data_dt(struct btmrvl_private *priv)
 {
 	struct device_node *dt_node;
-	u8 cal_data[BT_CAL_DATA_SIZE];
+	u8 cal_data[BT_CAL_HDR_LEN + BT_CAL_DATA_SIZE];
 	const char name[] = "btmrvl_caldata";
 	const char property[] = "btmrvl,caldata";
 	int ret;
@@ -458,13 +450,14 @@ static int btmrvl_cal_data_dt(struct btmrvl_private *priv)
 	if (!dt_node)
 		return -ENODEV;
 
-	ret = of_property_read_u8_array(dt_node, property, cal_data,
-					sizeof(cal_data));
+	ret = of_property_read_u8_array(dt_node, property,
+					cal_data + BT_CAL_HDR_LEN,
+					BT_CAL_DATA_SIZE);
 	if (ret)
 		return ret;
 
 	BT_DBG("Use cal data from device tree");
-	ret = btmrvl_download_cal_data(priv, cal_data);
+	ret = btmrvl_download_cal_data(priv, cal_data, BT_CAL_DATA_SIZE);
 	if (ret) {
 		BT_ERR("Fail to download calibrate data");
 		return ret;
-- 
1.8.0

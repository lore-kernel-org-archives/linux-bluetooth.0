Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, Amitkumar Karwar <akarwar@marvell.com>,
        Cathy Luo
	<cluo@marvell.com>, Avinash Patil <patila@marvell.com>
Subject: [PATCH 2/3] Bluetooth: btmrvl: add DT-bindings for gpio-gap
Date: Wed, 19 Nov 2014 01:28:33 -0800
Message-ID: <1416389314-6327-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1416389314-6327-1-git-send-email-akarwar@marvell.com>
References: <1416389314-6327-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This can be used to have GPIO host wakeup method suitable for the
platform and configurable GAP for host sleep handshake.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
Signed-off-by: Cathy Luo <cluo@marvell.com>
Signed-off-by: Avinash Patil <patila@marvell.com>
---
 Documentation/devicetree/bindings/btmrvl.txt |  7 +++++++
 drivers/bluetooth/btmrvl_main.c              | 12 +++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/btmrvl.txt b/Documentation/devicetree/bindings/btmrvl.txt
index cdd5768..58f964b 100644
--- a/Documentation/devicetree/bindings/btmrvl.txt
+++ b/Documentation/devicetree/bindings/btmrvl.txt
@@ -10,8 +10,14 @@ Optional properties:
   - btmrvl,cal-data : Calibration data downloaded to the device during
 		      initialization. This is an array of 28 values(u8).
 
+  - btmrvl,gpio-gap : gpio and gap (in msecs) combination to be
+		      configured.
+
 Example:
 
+GPIO pin 13 is configured as a wakeup source and GAP is set to 100 msecs
+in below example.
+
 btmrvl {
 	compatible = "btmrvl,cfgdata";
 
@@ -19,4 +25,5 @@ btmrvl {
 		0x37 0x01 0x1c 0x00 0xff 0xff 0xff 0xff 0x01 0x7f 0x04 0x02
 		0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00 0x00 0x00
 		0x00 0x00 0xf0 0x00>;
+	btmrvl,gpio-gap = <0x0d64>;
 };
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 2909bca..e43c495 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -492,13 +492,18 @@ static int btmrvl_download_cal_data(struct btmrvl_private *priv,
 	return 0;
 }
 
-static int btmrvl_cal_data_dt(struct btmrvl_private *priv)
+static int btmrvl_check_device_tree(struct btmrvl_private *priv)
 {
 	struct device_node *dt_node;
 	u8 cal_data[BT_CAL_HDR_LEN + BT_CAL_DATA_SIZE];
 	int ret;
+	u32 val;
 
 	for_each_compatible_node(dt_node, NULL, "btmrvl,cfgdata") {
+		ret = of_property_read_u32(dt_node, "btmrvl,gpio-gap", &val);
+		if (!ret)
+			priv->btmrvl_dev.gpio_gap = val;
+
 		ret = of_property_read_u8_array(dt_node, "btmrvl,cal-data",
 						cal_data + BT_CAL_HDR_LEN,
 						BT_CAL_DATA_SIZE);
@@ -523,14 +528,15 @@ static int btmrvl_setup(struct hci_dev *hdev)
 
 	btmrvl_send_module_cfg_cmd(priv, MODULE_BRINGUP_REQ);
 
-	btmrvl_cal_data_dt(priv);
+	priv->btmrvl_dev.gpio_gap = 0xffff;
+
+	btmrvl_check_device_tree(priv);
 
 	btmrvl_pscan_window_reporting(priv, 0x01);
 
 	priv->btmrvl_dev.psmode = 1;
 	btmrvl_enable_ps(priv);
 
-	priv->btmrvl_dev.gpio_gap = 0xffff;
 	btmrvl_send_hscfg_cmd(priv);
 
 	return 0;
-- 
1.8.1.4

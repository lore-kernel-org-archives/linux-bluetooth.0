Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, Amitkumar Karwar <akarwar@marvell.com>,
        Cathy Luo
	<cluo@marvell.com>, Avinash Patil <patila@marvell.com>
Subject: [PATCH 1/3] Bluetooth: btmrvl: add DT bindings documentation
Date: Wed, 19 Nov 2014 01:28:32 -0800
Message-ID: <1416389314-6327-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Calibration data can be downloaded through device tree method. This
patch adds the documentation. Also, instead of searching device tree
node by name using of_find_node_by_name() API, let's use
for_each_compatible_node().

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
Signed-off-by: Cathy Luo <cluo@marvell.com>
Signed-off-by: Avinash Patil <patila@marvell.com>
---
 Documentation/devicetree/bindings/btmrvl.txt | 22 ++++++++++++++++++++
 drivers/bluetooth/btmrvl_main.c              | 31 +++++++++++++---------------
 2 files changed, 36 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/btmrvl.txt

diff --git a/Documentation/devicetree/bindings/btmrvl.txt b/Documentation/devicetree/bindings/btmrvl.txt
new file mode 100644
index 0000000..cdd5768
--- /dev/null
+++ b/Documentation/devicetree/bindings/btmrvl.txt
@@ -0,0 +1,22 @@
+btmrvl
+------
+
+Required properties:
+
+  - compatible : must be "btmrvl,cfgdata"
+
+Optional properties:
+
+  - btmrvl,cal-data : Calibration data downloaded to the device during
+		      initialization. This is an array of 28 values(u8).
+
+Example:
+
+btmrvl {
+	compatible = "btmrvl,cfgdata";
+
+	btmrvl,cal-data = /bits/ 8 <
+		0x37 0x01 0x1c 0x00 0xff 0xff 0xff 0xff 0x01 0x7f 0x04 0x02
+		0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00 0x00 0x00
+		0x00 0x00 0xf0 0x00>;
+};
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 1d7db20..2909bca 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -496,25 +496,22 @@ static int btmrvl_cal_data_dt(struct btmrvl_private *priv)
 {
 	struct device_node *dt_node;
 	u8 cal_data[BT_CAL_HDR_LEN + BT_CAL_DATA_SIZE];
-	const char name[] = "btmrvl_caldata";
-	const char property[] = "btmrvl,caldata";
 	int ret;
 
-	dt_node = of_find_node_by_name(NULL, name);
-	if (!dt_node)
-		return -ENODEV;
-
-	ret = of_property_read_u8_array(dt_node, property,
-					cal_data + BT_CAL_HDR_LEN,
-					BT_CAL_DATA_SIZE);
-	if (ret)
-		return ret;
-
-	BT_DBG("Use cal data from device tree");
-	ret = btmrvl_download_cal_data(priv, cal_data, BT_CAL_DATA_SIZE);
-	if (ret) {
-		BT_ERR("Fail to download calibrate data");
-		return ret;
+	for_each_compatible_node(dt_node, NULL, "btmrvl,cfgdata") {
+		ret = of_property_read_u8_array(dt_node, "btmrvl,cal-data",
+						cal_data + BT_CAL_HDR_LEN,
+						BT_CAL_DATA_SIZE);
+		if (ret)
+			return ret;
+
+		BT_DBG("Use cal data from device tree");
+		ret = btmrvl_download_cal_data(priv, cal_data,
+					       BT_CAL_DATA_SIZE);
+		if (ret) {
+			BT_ERR("Fail to download calibrate data");
+			return ret;
+		}
 	}
 
 	return 0;
-- 
1.8.1.4

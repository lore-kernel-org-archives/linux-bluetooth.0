Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	robh@kernel.org,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 06/13] Bluetooth: btrtl: load the config blob from devicetree when available
Date: Sun, 27 May 2018 21:04:50 +0200
Message-Id: <20180527190457.2632-7-hdegoede@redhat.com>
In-Reply-To: <20180527190457.2632-1-hdegoede@redhat.com>
References: <20180527190457.2632-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Some Realtek bluetooth devices need a "config" blob. The btrtl driver
currently only allows loading this config blob via the request_firmware
mechanism.

The UART Bluetooth chips use this config blob to specify the baudrate,
whether flow control is used and some other unknown bits. This means
that the config blob is board-specific - thus loading it via
request_firmware means that the rootfs is tied to a specific board.

The UART Bluetooth chips are implemented through serdev. This means
there is also a devicetree node which describes the Bluetooth chip.
Thus we can also load the blob from the devicetree node to keep the
filesystem independent of any board configuration data. In the future
this could be extended to support ACPI as well (in case that's needed).

Parse the devicetree node if it exists and obtain the config blob from
there. Otherwise fall back to using the "old" request_firmware
mechanism.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btrtl.c | 43 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 134eac0c8fe7..4962a7a2d9c1 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <asm/unaligned.h>
+#include <linux/of.h>
 #include <linux/usb.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -509,6 +510,41 @@ void btrtl_free(struct btrtl_device_info *btrtl_dev)
 }
 EXPORT_SYMBOL_GPL(btrtl_free);
 
+static int rtl_load_config_from_dt(struct hci_dev *hdev,
+				   struct btrtl_device_info *btrtl_dev)
+{
+	struct device_node *np = hdev->dev.parent->of_node;
+	int ret, config_len;
+
+	if (!of_device_is_available(np))
+		return -ENOENT;
+
+	if (!of_find_property(np, "realtek,config-data", NULL))
+		return -ENOENT;
+
+	config_len = of_property_count_u8_elems(np, "realtek,config-data");
+	if (config_len <= 0)
+		return -ENOENT;
+
+	btrtl_dev->cfg_data = kzalloc(config_len, GFP_KERNEL);
+	if (!btrtl_dev->cfg_data)
+		return -ENOMEM;
+
+	ret = of_property_read_u8_array(np, "realtek,config-data",
+					btrtl_dev->cfg_data, config_len);
+	if (ret) {
+		kfree(btrtl_dev->cfg_data);
+		return ret;
+	}
+
+	btrtl_dev->cfg_len = config_len;
+
+	bt_dev_dbg(hdev, "rtl: using config data with len %d from DT",
+		   config_len);
+
+	return 0;
+}
+
 struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev)
 {
 	struct btrtl_device_info *btrtl_dev;
@@ -567,13 +603,16 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev)
 		goto err_free;
 	}
 
-	if (btrtl_dev->ic_info->cfg_name) {
+	/* try loading the config blob from device-tree first: */
+	ret = rtl_load_config_from_dt(hdev, btrtl_dev);
+	/* fall back to loading the config via request_firmware: */
+	if (ret && btrtl_dev->ic_info->cfg_name) {
 		btrtl_dev->cfg_len = rtl_load_file(hdev,
 						   btrtl_dev->ic_info->cfg_name,
 						   &btrtl_dev->cfg_data);
 		if (btrtl_dev->ic_info->config_needed && btrtl_dev->cfg_len <= 0) {
 			bt_dev_err(hdev,
-				   "mandatory config file %s not found\n",
+				   "mandatory config blob not found in %s or DT\n",
 				   btrtl_dev->ic_info->cfg_name);
 			ret = btrtl_dev->cfg_len;
 			goto err_free;
-- 
2.17.0

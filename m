Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Dec 2014 15:24:54 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, "An, Tedd" <tedd.an@intel.com>,
 Marcel Holtmann <marcel@holtmann.org>
Subject: [RFC v2 3/4] Bluetooth: Set file extension to SFI file for
 bootloader mode
Message-ID: <20141208152454.2985e44d@tedd-test>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch sets extension for firmware file to SFI if the device mode
is bootloader.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b3ce85f..0c6eb333 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1336,6 +1336,7 @@ struct intel_version {
 
 enum {
 	INTEL_FW_MODE_OP,
+	INTEL_FW_MODE_BL,
 };
 
 static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
@@ -1397,6 +1398,17 @@ static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
 			return NULL;
 		}
 		strncpy(ext, "bseq", 4);
+	} else if (fw_mode == INTEL_FW_MODE_BL) {
+		/* If fw_variant is 0x23, the device is already running in
+		 * operational mode, so no need to download the firmware
+		 */
+		if (ver->fw_variant == 0x23) {
+			BT_INFO("%s: Intel device is running in operation mode",
+				hdev->name);
+			btusb_check_bdaddr_intel(hdev);
+			return NULL;
+		}
+		strncpy(ext, "sfi", 3);
 	} else {
 		BT_ERR("%s: Invalid Intel firmware type: %d",
 		       hdev->name, fw_mode);
-- 
1.9.1

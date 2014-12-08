Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Dec 2014 15:24:48 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	"An, Tedd" <tedd.an@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [RFC v2 2/4] Bluetooth: Set the firmware file extension based on
 firmware type
Message-ID: <20141208152448.594b9659@tedd-test>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch sets the extension of Intel Bluetooth firmware file based on
firmware type.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9ab396b..b3ce85f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1334,12 +1334,18 @@ struct intel_version {
 	u8 fw_patch_num;
 } __packed;
 
-static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev)
+enum {
+	INTEL_FW_MODE_OP,
+};
+
+static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
+						       int fw_mode)
 {
 	const struct firmware *fw;
 	struct sk_buff *skb;
 	struct intel_version *ver;
 	char fwname[64];
+	char ext[6] = {0};
 	int ret;
 
 	BT_DBG("%s", hdev->name);
@@ -1377,23 +1383,32 @@ static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev)
 		ver->fw_build_num, ver->fw_build_ww, ver->fw_build_yy,
 		ver->fw_patch_num);
 
-	/* fw_patch_num indicates the version of patch the device currently
-	 * have. If there is no patch data in the device, it is always 0x00.
-	 * So, if it is other than 0x00, no need to patch the device again.
-	 */
-	if (ver->fw_patch_num) {
-		BT_INFO("%s: Intel device is already patched. patch num: %02x",
-			hdev->name, ver->fw_patch_num);
-		btusb_check_bdaddr_intel(hdev);
+	/* set the extension of firmware file based on firmware type */
+	if (fw_mode == INTEL_FW_MODE_OP) {
+		/* fw_patch_num indicates the version of patch the device
+		 * currently have. If there is no patch data in the device,
+		 * it is always 0x00. So, if it is other than 0x00, no need
+		 * to patch the device again.
+		 */
+		if (ver->fw_patch_num) {
+			BT_INFO("%s: Intel device is already patched",
+				hdev->name);
+			btusb_check_bdaddr_intel(hdev);
+			return NULL;
+		}
+		strncpy(ext, "bseq", 4);
+	} else {
+		BT_ERR("%s: Invalid Intel firmware type: %d",
+		       hdev->name, fw_mode);
 		return NULL;
 	}
 
 	/* Open the firwmare file if it exists */
 	snprintf(fwname, sizeof(fwname),
-		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
+		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.%s",
 		 ver->hw_platform, ver->hw_variant, ver->hw_revision,
 		 ver->fw_variant,  ver->fw_revision, ver->fw_build_num,
-		 ver->fw_build_ww, ver->fw_build_yy);
+		 ver->fw_build_ww, ver->fw_build_yy, ext);
 
 	ret = request_firmware(&fw, fwname, &hdev->dev);
 	if (ret < 0) {
@@ -1409,8 +1424,8 @@ static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev)
 		/* If the correct firmware patch file is not found, use the
 		 * default firmware patch file instead
 		 */
-		snprintf(fwname, sizeof(fwname), "intel/ibt-hw-%x.%x.bseq",
-			 ver->hw_platform, ver->hw_variant);
+		snprintf(fwname, sizeof(fwname), "intel/ibt-hw-%x.%x.%s",
+			 ver->hw_platform, ver->hw_variant, ext);
 		if (request_firmware(&fw, fwname, &hdev->dev) < 0) {
 			BT_ERR("%s failed to open default Intel fw file: %s",
 			       hdev->name, fwname);
@@ -1574,7 +1589,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * If no patch file is found, allow the device to operate without
 	 * a patch.
 	 */
-	fw = btusb_setup_intel_get_fw(hdev);
+	fw = btusb_setup_intel_get_fw(hdev, INTEL_FW_MODE_OP);
 	if (!fw) {
 		btusb_check_bdaddr_intel(hdev);
 		return 0;
-- 
1.9.1


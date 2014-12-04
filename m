Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Dec 2014 17:09:31 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "An, Tedd" <tedd.an@intel.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [RFC 2/3] Bluetooth: Add parameter to specify the firmware file
 extension
Message-ID: <20141203170931.7ba80d6b@tedd-test>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch add a parameter to specify the extension of firmware file,
so differnt format of firmware file can be opened.
---
 drivers/bluetooth/btusb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d88faab..0fa1c13 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1290,17 +1290,17 @@ struct intel_version {
 } __packed;
 
 static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
-						       struct intel_version *ver)
+					struct intel_version *ver, char *ext)
 {
 	const struct firmware *fw;
 	char fwname[64];
 	int ret;
 
 	snprintf(fwname, sizeof(fwname),
-		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
+		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.%s",
 		 ver->hw_platform, ver->hw_variant, ver->hw_revision,
 		 ver->fw_variant,  ver->fw_revision, ver->fw_build_num,
-		 ver->fw_build_ww, ver->fw_build_yy);
+		 ver->fw_build_ww, ver->fw_build_yy, ext);
 
 	ret = request_firmware(&fw, fwname, &hdev->dev);
 	if (ret < 0) {
@@ -1316,8 +1316,8 @@ static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
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
@@ -1583,7 +1583,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * If no patch file is found, allow the device to operate without
 	 * a patch.
 	 */
-	fw = btusb_setup_intel_get_fw(hdev, &ver);
+	fw = btusb_setup_intel_get_fw(hdev, &ver, "bseq");
 	if (!fw) {
 		btusb_check_bdaddr_intel(hdev);
 		return 0;
-- 
1.9.1


Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: btusb: Move Intel command structs into its own header
Date: Mon,  6 Apr 2015 00:52:13 -0700
Message-Id: <1428306734-14210-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the Intel Bluetooth support has its own header, it makes sense
to move all command structs into it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btintel.h | 33 +++++++++++++++++++++++++++++++++
 drivers/bluetooth/btusb.c   | 33 ---------------------------------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 20be247d2ff6..d1581150679a 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -21,6 +21,39 @@
  *
  */
 
+struct intel_version {
+	u8 status;
+	u8 hw_platform;
+	u8 hw_variant;
+	u8 hw_revision;
+	u8 fw_variant;
+	u8 fw_revision;
+	u8 fw_build_num;
+	u8 fw_build_ww;
+	u8 fw_build_yy;
+	u8 fw_patch_num;
+} __packed;
+
+struct intel_boot_params {
+	__u8     status;
+	__u8     otp_format;
+	__u8     otp_content;
+	__u8     otp_patch;
+	__le16   dev_revid;
+	__u8     secure_boot;
+	__u8     key_from_hdr;
+	__u8     key_type;
+	__u8     otp_lock;
+	__u8     api_lock;
+	__u8     debug_lock;
+	bdaddr_t otp_bdaddr;
+	__u8     min_fw_build_nn;
+	__u8     min_fw_build_cw;
+	__u8     min_fw_build_yy;
+	__u8     limited_cce;
+	__u8     unlocked_state;
+} __packed;
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5798aec44824..c06ceec13dbb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1345,39 +1345,6 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 	return ret;
 }
 
-struct intel_version {
-	u8 status;
-	u8 hw_platform;
-	u8 hw_variant;
-	u8 hw_revision;
-	u8 fw_variant;
-	u8 fw_revision;
-	u8 fw_build_num;
-	u8 fw_build_ww;
-	u8 fw_build_yy;
-	u8 fw_patch_num;
-} __packed;
-
-struct intel_boot_params {
-	__u8     status;
-	__u8     otp_format;
-	__u8     otp_content;
-	__u8     otp_patch;
-	__le16   dev_revid;
-	__u8     secure_boot;
-	__u8     key_from_hdr;
-	__u8     key_type;
-	__u8     otp_lock;
-	__u8     api_lock;
-	__u8     debug_lock;
-	bdaddr_t otp_bdaddr;
-	__u8     min_fw_build_nn;
-	__u8     min_fw_build_cw;
-	__u8     min_fw_build_yy;
-	__u8     limited_cce;
-	__u8     unlocked_state;
-} __packed;
-
 static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
 						       struct intel_version *ver)
 {
-- 
2.1.0


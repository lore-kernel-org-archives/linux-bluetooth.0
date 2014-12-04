Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Dec 2014 17:09:28 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, tedd.an@intel.com
Subject: [RFC 1/3] Bluetooth: Refactor Intel read version command
Message-ID: <20141203170928.5f55df90@tedd-test>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch refactors the routine that read the device firmware version
with Intel_Read_Version command.
This command and event are common to all Intel Bluetooth device.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c | 68
+++++++++++++++++++++++++++-------------------- 1 file changed, 39
insertions(+), 29 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 31dd24a..d88faab 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1490,13 +1490,40 @@ static int btusb_check_bdaddr_intel(struct
hci_dev *hdev) return 0;
 }
 
+static int btusb_setup_intel_read_fw_ver(struct hci_dev *hdev,
+					 struct intel_version *ver)
+{
+	struct sk_buff *skb;
+
+	BT_DBG("%s", hdev->name);
+
+	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s reading Intel fw version command failed
(%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*ver)) {
+		BT_ERR("%s Intel version event length mismatch",
hdev->name);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	memcpy(ver, skb->data, sizeof(*ver));
+	kfree_skb(skb);
+
+	return 0;
+}
+
 static int btusb_setup_intel(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	const struct firmware *fw;
 	const u8 *fw_ptr;
 	int disable_patch;
-	struct intel_version *ver;
+	struct intel_version ver;
+	int err;
 
 	const u8 mfg_enable[] = { 0x01, 0x00 };
 	const u8 mfg_disable[] = { 0x00, 0x00 };
@@ -1527,41 +1554,25 @@ static int btusb_setup_intel(struct hci_dev
*hdev)
 	 * The returned information are hardware variant and revision
plus
 	 * firmware variant, revision and build number.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s reading Intel fw version command failed
(%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	if (skb->len != sizeof(*ver)) {
-		BT_ERR("%s Intel version event length mismatch",
hdev->name);
-		kfree_skb(skb);
-		return -EIO;
-	}
-
-	ver = (struct intel_version *)skb->data;
-	if (ver->status) {
-		BT_ERR("%s Intel fw version event failed (%02x)",
hdev->name,
-		       ver->status);
-		kfree_skb(skb);
-		return -bt_to_errno(ver->status);
+	err = btusb_setup_intel_read_fw_ver(hdev, &ver);
+	if (err < 0) {
+		BT_ERR("%s: failed to read fw version (%d)",
hdev->name, err);
+		return err;
 	}
 
 	BT_INFO("%s: read Intel version:
%02x%02x%02x%02x%02x%02x%02x%02x%02x",
-		hdev->name, ver->hw_platform, ver->hw_variant,
-		ver->hw_revision, ver->fw_variant,  ver->fw_revision,
-		ver->fw_build_num, ver->fw_build_ww, ver->fw_build_yy,
-		ver->fw_patch_num);
+		hdev->name, ver.hw_platform, ver.hw_variant,
+		ver.hw_revision, ver.fw_variant,  ver.fw_revision,
+		ver.fw_build_num, ver.fw_build_ww, ver.fw_build_yy,
+		ver.fw_patch_num);
 
 	/* fw_patch_num indicates the version of patch the device
currently
 	 * have. If there is no patch data in the device, it is always
0x00.
 	 * So, if it is other than 0x00, no need to patch the deivce
again. */
-	if (ver->fw_patch_num) {
+	if (ver.fw_patch_num) {
 		BT_INFO("%s: Intel device is already patched. patch
num: %02x",
-			hdev->name, ver->fw_patch_num);
-		kfree_skb(skb);
+			hdev->name, ver.fw_patch_num);
 		btusb_check_bdaddr_intel(hdev);
 		return 0;
 	}
@@ -1572,9 +1583,8 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * If no patch file is found, allow the device to operate
without
 	 * a patch.
 	 */
-	fw = btusb_setup_intel_get_fw(hdev, ver);
+	fw = btusb_setup_intel_get_fw(hdev, &ver);
 	if (!fw) {
-		kfree_skb(skb);
 		btusb_check_bdaddr_intel(hdev);
 		return 0;
 	}
-- 
1.9.1

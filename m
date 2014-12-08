Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Dec 2014 15:24:39 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "An, Tedd" <tedd.an@intel.com>, Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Subject: [RFC v2 1/4] Bluetooth: Refactor Intel_read_version and opens
 firmware patch file
Message-ID: <20141208152439.5acd87da@tedd-test>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch refactors the routines that read the device version and opens
firmware patch file.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c | 191 +++++++++++++++++++++++-----------------------
 1 file changed, 96 insertions(+), 95 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 31dd24a..9ab396b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1276,6 +1276,51 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 	return ret;
 }
 
+#define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
+
+static int btusb_check_bdaddr_intel(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct hci_rp_read_bd_addr *rp;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s reading Intel device address failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*rp)) {
+		BT_ERR("%s Intel device address length mismatch", hdev->name);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	rp = (struct hci_rp_read_bd_addr *)skb->data;
+	if (rp->status) {
+		BT_ERR("%s Intel device address result failed (%02x)",
+		       hdev->name, rp->status);
+		kfree_skb(skb);
+		return -bt_to_errno(rp->status);
+	}
+
+	/* For some Intel based controllers, the default Bluetooth device
+	 * address 00:03:19:9E:8B:00 can be found. These controllers are
+	 * fully operational, but have the danger of duplicate addresses
+	 * and that in turn can cause problems with Bluetooth operation.
+	 */
+	if (!bacmp(&rp->bdaddr, BDADDR_INTEL)) {
+		BT_ERR("%s found Intel default device address (%pMR)",
+		       hdev->name, &rp->bdaddr);
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
 struct intel_version {
 	u8 status;
 	u8 hw_platform;
@@ -1289,13 +1334,61 @@ struct intel_version {
 	u8 fw_patch_num;
 } __packed;
 
-static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
-						       struct intel_version *ver)
+static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev)
 {
 	const struct firmware *fw;
+	struct sk_buff *skb;
+	struct intel_version *ver;
 	char fwname[64];
 	int ret;
 
+	BT_DBG("%s", hdev->name);
+
+	/* Read Intel specific controller version first to allow selection of
+	 * which firmware file to load.
+	 *
+	 * The returned information are hardware variant and revision plus
+	 * firmware variant, revision and build number.
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s reading Intel fw version command failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return NULL;
+	}
+
+	if (skb->len != sizeof(*ver)) {
+		BT_ERR("%s Intel version event length mismatch", hdev->name);
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	ver = (struct intel_version *)skb->data;
+	if (ver->status) {
+		BT_ERR("%s Intel fw version event failed (%02x)", hdev->name,
+		       ver->status);
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	BT_INFO("%s: read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
+		hdev->name, ver->hw_platform, ver->hw_variant,
+		ver->hw_revision, ver->fw_variant,  ver->fw_revision,
+		ver->fw_build_num, ver->fw_build_ww, ver->fw_build_yy,
+		ver->fw_patch_num);
+
+	/* fw_patch_num indicates the version of patch the device currently
+	 * have. If there is no patch data in the device, it is always 0x00.
+	 * So, if it is other than 0x00, no need to patch the device again.
+	 */
+	if (ver->fw_patch_num) {
+		BT_INFO("%s: Intel device is already patched. patch num: %02x",
+			hdev->name, ver->fw_patch_num);
+		btusb_check_bdaddr_intel(hdev);
+		return NULL;
+	}
+
+	/* Open the firwmare file if it exists */
 	snprintf(fwname, sizeof(fwname),
 		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
 		 ver->hw_platform, ver->hw_variant, ver->hw_revision,
@@ -1445,58 +1538,12 @@ static int btusb_setup_intel_patching(struct hci_dev *hdev,
 	return 0;
 }
 
-#define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
-
-static int btusb_check_bdaddr_intel(struct hci_dev *hdev)
-{
-	struct sk_buff *skb;
-	struct hci_rp_read_bd_addr *rp;
-
-	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
-			     HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s reading Intel device address failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	if (skb->len != sizeof(*rp)) {
-		BT_ERR("%s Intel device address length mismatch", hdev->name);
-		kfree_skb(skb);
-		return -EIO;
-	}
-
-	rp = (struct hci_rp_read_bd_addr *)skb->data;
-	if (rp->status) {
-		BT_ERR("%s Intel device address result failed (%02x)",
-		       hdev->name, rp->status);
-		kfree_skb(skb);
-		return -bt_to_errno(rp->status);
-	}
-
-	/* For some Intel based controllers, the default Bluetooth device
-	 * address 00:03:19:9E:8B:00 can be found. These controllers are
-	 * fully operational, but have the danger of duplicate addresses
-	 * and that in turn can cause problems with Bluetooth operation.
-	 */
-	if (!bacmp(&rp->bdaddr, BDADDR_INTEL)) {
-		BT_ERR("%s found Intel default device address (%pMR)",
-		       hdev->name, &rp->bdaddr);
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-	}
-
-	kfree_skb(skb);
-
-	return 0;
-}
-
 static int btusb_setup_intel(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	const struct firmware *fw;
 	const u8 *fw_ptr;
 	int disable_patch;
-	struct intel_version *ver;
 
 	const u8 mfg_enable[] = { 0x01, 0x00 };
 	const u8 mfg_disable[] = { 0x00, 0x00 };
@@ -1521,60 +1568,14 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	}
 	kfree_skb(skb);
 
-	/* Read Intel specific controller version first to allow selection of
-	 * which firmware file to load.
-	 *
-	 * The returned information are hardware variant and revision plus
-	 * firmware variant, revision and build number.
-	 */
-	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s reading Intel fw version command failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	if (skb->len != sizeof(*ver)) {
-		BT_ERR("%s Intel version event length mismatch", hdev->name);
-		kfree_skb(skb);
-		return -EIO;
-	}
-
-	ver = (struct intel_version *)skb->data;
-	if (ver->status) {
-		BT_ERR("%s Intel fw version event failed (%02x)", hdev->name,
-		       ver->status);
-		kfree_skb(skb);
-		return -bt_to_errno(ver->status);
-	}
-
-	BT_INFO("%s: read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
-		hdev->name, ver->hw_platform, ver->hw_variant,
-		ver->hw_revision, ver->fw_variant,  ver->fw_revision,
-		ver->fw_build_num, ver->fw_build_ww, ver->fw_build_yy,
-		ver->fw_patch_num);
-
-	/* fw_patch_num indicates the version of patch the device currently
-	 * have. If there is no patch data in the device, it is always 0x00.
-	 * So, if it is other than 0x00, no need to patch the deivce again.
-	 */
-	if (ver->fw_patch_num) {
-		BT_INFO("%s: Intel device is already patched. patch num: %02x",
-			hdev->name, ver->fw_patch_num);
-		kfree_skb(skb);
-		btusb_check_bdaddr_intel(hdev);
-		return 0;
-	}
-
 	/* Opens the firmware patch file based on the firmware version read
 	 * from the controller. If it fails to open the matching firmware
 	 * patch file, it tries to open the default firmware patch file.
 	 * If no patch file is found, allow the device to operate without
 	 * a patch.
 	 */
-	fw = btusb_setup_intel_get_fw(hdev, ver);
+	fw = btusb_setup_intel_get_fw(hdev);
 	if (!fw) {
-		kfree_skb(skb);
 		btusb_check_bdaddr_intel(hdev);
 		return 0;
 	}
-- 
1.9.1

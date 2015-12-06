Return-Path: <loic.poulain@intel.com>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: Create common Intel Version Read function
Date: Sun,  6 Dec 2015 16:18:34 +0100
Message-Id: <1449415114-30029-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The Intel Version Read command is used to retrieve information
about hardware and firmware version/revision of Intel Bluetooth
controllers. This is an Intel generic command used in USB and
UART drivers.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: Fix typo in inline declaration

 drivers/bluetooth/btintel.c   | 25 ++++++++++++++
 drivers/bluetooth/btintel.h   |  7 ++++
 drivers/bluetooth/btusb.c     | 80 +++++++++++++------------------------------
 drivers/bluetooth/hci_intel.c | 46 ++++++-------------------
 4 files changed, 66 insertions(+), 92 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5441047..fce1548 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -349,6 +349,31 @@ int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
 }
 EXPORT_SYMBOL_GPL(btintel_set_event_mask_mfg);
 
+int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*ver)) {
+		bt_dev_err(hdev, "Intel version event size mismatch");
+		kfree_skb(skb);
+		return -EILSEQ;
+	}
+
+	memcpy(ver, skb->data, sizeof(*ver));
+
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_read_version);
+
 /* ------- REGMAP IBT SUPPORT ------- */
 
 #define IBT_REG_MODE_8BIT  0x00
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index fa72eae..1e8955a 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -85,6 +85,7 @@ int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name);
 int btintel_set_event_mask(struct hci_dev *hdev, bool debug);
 int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug);
+int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver);
 
 struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
 				   u16 opcode_write);
@@ -152,6 +153,12 @@ static inline int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_read_version(struct hci_dev *hdev,
+				       struct intel_version *ver)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct regmap *btintel_regmap_init(struct hci_dev *hdev,
 						 u16 opcode_read,
 						 u16 opcode_write)
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6e141cd..a191e31 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1647,7 +1647,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	const struct firmware *fw;
 	const u8 *fw_ptr;
 	int disable_patch, err;
-	struct intel_version *ver;
+	struct intel_version ver;
 
 	BT_DBG("%s", hdev->name);
 
@@ -1673,35 +1673,22 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * The returned information are hardware variant and revision plus
 	 * firmware variant, revision and build number.
 	 */
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
+	err = btintel_read_version(hdev, &ver);
+	if (err)
+		return err;
 
 	BT_INFO("%s: read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
-		hdev->name, ver->hw_platform, ver->hw_variant,
-		ver->hw_revision, ver->fw_variant,  ver->fw_revision,
-		ver->fw_build_num, ver->fw_build_ww, ver->fw_build_yy,
-		ver->fw_patch_num);
+		hdev->name, ver.hw_platform, ver.hw_variant, ver.hw_revision,
+		ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
+		ver.fw_build_ww, ver.fw_build_yy, ver.fw_patch_num);
 
 	/* fw_patch_num indicates the version of patch the device currently
 	 * have. If there is no patch data in the device, it is always 0x00.
 	 * So, if it is other than 0x00, no need to patch the device again.
 	 */
-	if (ver->fw_patch_num) {
+	if (ver.fw_patch_num) {
 		BT_INFO("%s: Intel device is already patched. patch num: %02x",
-			hdev->name, ver->fw_patch_num);
-		kfree_skb(skb);
+			hdev->name, ver.fw_patch_num);
 		goto complete;
 	}
 
@@ -1711,15 +1698,11 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * If no patch file is found, allow the device to operate without
 	 * a patch.
 	 */
-	fw = btusb_setup_intel_get_fw(hdev, ver);
-	if (!fw) {
-		kfree_skb(skb);
+	fw = btusb_setup_intel_get_fw(hdev, &ver);
+	if (!fw)
 		goto complete;
-	}
 	fw_ptr = fw->data;
 
-	kfree_skb(skb);
-
 	/* Enable the manufacturer mode of the controller.
 	 * Only while this mode is enabled, the driver can download the
 	 * firmware patch data and configuration parameters.
@@ -1983,7 +1966,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 					  0x00, 0x08, 0x04, 0x00 };
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct sk_buff *skb;
-	struct intel_version *ver;
+	struct intel_version ver;
 	struct intel_boot_params *params;
 	const struct firmware *fw;
 	const u8 *fw_ptr;
@@ -2001,28 +1984,16 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		BT_ERR("%s: Reading Intel version information failed (%ld)",
-		       hdev->name, PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	if (skb->len != sizeof(*ver)) {
-		BT_ERR("%s: Intel version event size mismatch", hdev->name);
-		kfree_skb(skb);
-		return -EILSEQ;
-	}
-
-	ver = (struct intel_version *)skb->data;
+	err = btintel_read_version(hdev, &ver);
+	if (err)
+		return err;
 
 	/* The hardware platform number has a fixed value of 0x37 and
 	 * for now only accept this single value.
 	 */
-	if (ver->hw_platform != 0x37) {
+	if (ver.hw_platform != 0x37) {
 		BT_ERR("%s: Unsupported Intel hardware platform (%u)",
-		       hdev->name, ver->hw_platform);
-		kfree_skb(skb);
+		       hdev->name, ver.hw_platform);
 		return -EINVAL;
 	}
 
@@ -2031,14 +2002,13 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * put in place to ensure correct forward compatibility options
 	 * when newer hardware variants come along.
 	 */
-	if (ver->hw_variant != 0x0b) {
+	if (ver.hw_variant != 0x0b) {
 		BT_ERR("%s: Unsupported Intel hardware variant (%u)",
-		       hdev->name, ver->hw_variant);
-		kfree_skb(skb);
+		       hdev->name, ver.hw_variant);
 		return -EINVAL;
 	}
 
-	btintel_version_info(hdev, ver);
+	btintel_version_info(hdev, &ver);
 
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
@@ -2053,8 +2023,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * It is not possible to use the Secure Boot Parameters in this
 	 * case since that command is only available in bootloader mode.
 	 */
-	if (ver->fw_variant == 0x23) {
-		kfree_skb(skb);
+	if (ver.fw_variant == 0x23) {
 		clear_bit(BTUSB_BOOTLOADER, &data->flags);
 		btintel_check_bdaddr(hdev);
 		return 0;
@@ -2063,15 +2032,12 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	/* If the device is not in bootloader mode, then the only possible
 	 * choice is to return an error and abort the device initialization.
 	 */
-	if (ver->fw_variant != 0x06) {
+	if (ver.fw_variant != 0x06) {
 		BT_ERR("%s: Unsupported Intel firmware variant (%u)",
-		       hdev->name, ver->fw_variant);
-		kfree_skb(skb);
+		       hdev->name, ver.fw_variant);
 		return -ENODEV;
 	}
 
-	kfree_skb(skb);
-
 	/* Read the secure boot parameters to identify the operating
 	 * details of the bootloader.
 	 */
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 3c28c4a..3d63ea3 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -542,7 +542,7 @@ static int intel_setup(struct hci_uart *hu)
 	struct intel_device *idev = NULL;
 	struct hci_dev *hdev = hu->hdev;
 	struct sk_buff *skb;
-	struct intel_version *ver;
+	struct intel_version ver;
 	struct intel_boot_params *params;
 	struct list_head *p;
 	const struct firmware *fw;
@@ -590,35 +590,16 @@ static int intel_setup(struct hci_uart *hu)
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
-			   PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	if (skb->len != sizeof(*ver)) {
-		bt_dev_err(hdev, "Intel version event size mismatch");
-		kfree_skb(skb);
-		return -EILSEQ;
-	}
-
-	ver = (struct intel_version *)skb->data;
-	if (ver->status) {
-		bt_dev_err(hdev, "Intel version command failure (%02x)",
-			   ver->status);
-		err = -bt_to_errno(ver->status);
-		kfree_skb(skb);
+	 err = btintel_read_version(hdev, &ver);
+	 if (err)
 		return err;
-	}
 
 	/* The hardware platform number has a fixed value of 0x37 and
 	 * for now only accept this single value.
 	 */
-	if (ver->hw_platform != 0x37) {
+	if (ver.hw_platform != 0x37) {
 		bt_dev_err(hdev, "Unsupported Intel hardware platform (%u)",
-			   ver->hw_platform);
-		kfree_skb(skb);
+			   ver.hw_platform);
 		return -EINVAL;
 	}
 
@@ -627,14 +608,13 @@ static int intel_setup(struct hci_uart *hu)
 	 * put in place to ensure correct forward compatibility options
 	 * when newer hardware variants come along.
 	 */
-	if (ver->hw_variant != 0x0b) {
+	if (ver.hw_variant != 0x0b) {
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
-			   ver->hw_variant);
-		kfree_skb(skb);
+			   ver.hw_variant);
 		return -EINVAL;
 	}
 
-	btintel_version_info(hdev, ver);
+	btintel_version_info(hdev, &ver);
 
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
@@ -649,8 +629,7 @@ static int intel_setup(struct hci_uart *hu)
 	 * It is not possible to use the Secure Boot Parameters in this
 	 * case since that command is only available in bootloader mode.
 	 */
-	if (ver->fw_variant == 0x23) {
-		kfree_skb(skb);
+	if (ver.fw_variant == 0x23) {
 		clear_bit(STATE_BOOTLOADER, &intel->flags);
 		btintel_check_bdaddr(hdev);
 		return 0;
@@ -659,15 +638,12 @@ static int intel_setup(struct hci_uart *hu)
 	/* If the device is not in bootloader mode, then the only possible
 	 * choice is to return an error and abort the device initialization.
 	 */
-	if (ver->fw_variant != 0x06) {
+	if (ver.fw_variant != 0x06) {
 		bt_dev_err(hdev, "Unsupported Intel firmware variant (%u)",
-			   ver->fw_variant);
-		kfree_skb(skb);
+			   ver.fw_variant);
 		return -ENODEV;
 	}
 
-	kfree_skb(skb);
-
 	/* Read the secure boot parameters to identify the operating
 	 * details of the bootloader.
 	 */
-- 
1.9.1

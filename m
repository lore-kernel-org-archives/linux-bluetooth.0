Return-Path: <kai.heng.feng@canonical.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/2] Bluetooth: btusb: ath3k: Decide firmware name before checking update status
Date: Thu, 24 Aug 2017 17:06:28 +0800
Message-Id: <20170824090629.13381-1-kai.heng.feng@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Decide firmware name before checking patch update status. Firmware name is
required for caching.

Also, version information in btusb_setup_qca() is being calculated twice,
reduce it to one.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/ath3k.c | 10 +++----
 drivers/bluetooth/btusb.c | 72 +++++++++++++++++++++++------------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index b793853ff05f..280849dba51e 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -409,11 +409,6 @@ static int ath3k_load_patch(struct usb_device *udev)
 		return ret;
 	}
 
-	if (fw_state & ATH3K_PATCH_UPDATE) {
-		BT_DBG("Patch was already downloaded");
-		return 0;
-	}
-
 	ret = ath3k_get_version(udev, &fw_version);
 	if (ret < 0) {
 		BT_ERR("Can't get version to change to load ram patch err");
@@ -423,6 +418,11 @@ static int ath3k_load_patch(struct usb_device *udev)
 	snprintf(filename, ATH3K_NAME_LEN, "ar3k/AthrBT_0x%08x.dfu",
 		 le32_to_cpu(fw_version.rom_version));
 
+	if (fw_state & ATH3K_PATCH_UPDATE) {
+		BT_DBG("Patch was already downloaded");
+		return 0;
+	}
+
 	ret = request_firmware(&firmware, filename, &udev->dev);
 	if (ret < 0) {
 		BT_ERR("Patch file not found %s", filename);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fa24d693af24..732fe6c3e789 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1518,18 +1518,12 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 }
 
 static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
-						       struct intel_version *ver)
+						       const char *fwname,
+						       const char *default_fwname)
 {
 	const struct firmware *fw;
-	char fwname[64];
 	int ret;
 
-	snprintf(fwname, sizeof(fwname),
-		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
-		 ver->hw_platform, ver->hw_variant, ver->hw_revision,
-		 ver->fw_variant,  ver->fw_revision, ver->fw_build_num,
-		 ver->fw_build_ww, ver->fw_build_yy);
-
 	ret = request_firmware(&fw, fwname, &hdev->dev);
 	if (ret < 0) {
 		if (ret == -EINVAL) {
@@ -1544,11 +1538,9 @@ static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
 		/* If the correct firmware patch file is not found, use the
 		 * default firmware patch file instead
 		 */
-		snprintf(fwname, sizeof(fwname), "intel/ibt-hw-%x.%x.bseq",
-			 ver->hw_platform, ver->hw_variant);
-		if (request_firmware(&fw, fwname, &hdev->dev) < 0) {
+		if (request_firmware(&fw, default_fwname, &hdev->dev) < 0) {
 			BT_ERR("%s failed to open default Intel fw file: %s",
-			       hdev->name, fwname);
+			       hdev->name, default_fwname);
 			return NULL;
 		}
 	}
@@ -1676,6 +1668,8 @@ static int btusb_setup_intel_patching(struct hci_dev *hdev,
 static int btusb_setup_intel(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
+	char fwname[64];
+	char default_fwname[64];
 	const struct firmware *fw;
 	const u8 *fw_ptr;
 	int disable_patch, err;
@@ -1714,6 +1708,15 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 		ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
 		ver.fw_build_ww, ver.fw_build_yy, ver.fw_patch_num);
 
+	snprintf(fwname, sizeof(fwname),
+		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
+		 ver.hw_platform, ver.hw_variant, ver.hw_revision,
+		 ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
+		 ver.fw_build_ww, ver.fw_build_yy);
+
+	snprintf(default_fwname, sizeof(default_fwname),
+		"intel/ibt-hw-%x.%x.bseq", ver.hw_platform, ver.hw_variant);
+
 	/* fw_patch_num indicates the version of patch the device currently
 	 * have. If there is no patch data in the device, it is always 0x00.
 	 * So, if it is other than 0x00, no need to patch the device again.
@@ -1730,7 +1733,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * If no patch file is found, allow the device to operate without
 	 * a patch.
 	 */
-	fw = btusb_setup_intel_get_fw(hdev, &ver);
+	fw = btusb_setup_intel_get_fw(hdev, fwname, default_fwname);
 	if (!fw)
 		goto complete;
 	fw_ptr = fw->data;
@@ -2592,21 +2595,15 @@ static int btusb_setup_qca_download_fw(struct hci_dev *hdev,
 }
 
 static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
-					 struct qca_version *ver,
+					 const char *fwname,
+					 const struct qca_version *ver,
 					 const struct qca_device_info *info)
 {
 	struct qca_rampatch_version *rver;
 	const struct firmware *fw;
-	u32 ver_rom, ver_patch;
 	u16 rver_rom, rver_patch;
-	char fwname[64];
 	int err;
 
-	ver_rom = le32_to_cpu(ver->rom_version);
-	ver_patch = le32_to_cpu(ver->patch_version);
-
-	snprintf(fwname, sizeof(fwname), "qca/rampatch_usb_%08x.bin", ver_rom);
-
 	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err) {
 		BT_ERR("%s: failed to request rampatch file: %s (%d)",
@@ -2620,11 +2617,11 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 	rver_rom = le16_to_cpu(rver->rom_version);
 	rver_patch = le16_to_cpu(rver->patch_version);
 
-	BT_INFO("%s: QCA: patch rome 0x%x build 0x%x, firmware rome 0x%x "
-		"build 0x%x", hdev->name, rver_rom, rver_patch, ver_rom,
-		ver_patch);
+	BT_INFO("%s: QCA: patch rome 0x%x build 0x%x, firmware rome 0x%x build 0x%x",
+		hdev->name, rver_rom, rver_patch,
+		ver->rom_version, ver->patch_version);
 
-	if (rver_rom != ver_rom || rver_patch <= ver_patch) {
+	if (rver_rom != ver->rom_version || rver_patch <= ver->patch_version) {
 		BT_ERR("%s: rampatch file version did not match with firmware",
 		       hdev->name);
 		err = -EINVAL;
@@ -2640,16 +2637,12 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 }
 
 static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
-				    struct qca_version *ver,
+				    const char *fwname,
 				    const struct qca_device_info *info)
 {
 	const struct firmware *fw;
-	char fwname[64];
 	int err;
 
-	snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
-		 le32_to_cpu(ver->rom_version));
-
 	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err) {
 		BT_ERR("%s: failed to request NVM file: %s (%d)",
@@ -2670,7 +2663,7 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 {
 	const struct qca_device_info *info = NULL;
 	struct qca_version ver;
-	u32 ver_rom;
+	char fwname[64];
 	u8 status;
 	int i, err;
 
@@ -2679,14 +2672,15 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
-	ver_rom = le32_to_cpu(ver.rom_version);
+	ver.rom_version = le32_to_cpu(ver.rom_version);
+	ver.patch_version = le32_to_cpu(ver.patch_version);
 	for (i = 0; i < ARRAY_SIZE(qca_devices_table); i++) {
-		if (ver_rom == qca_devices_table[i].rom_version)
+		if (ver.rom_version == qca_devices_table[i].rom_version)
 			info = &qca_devices_table[i];
 	}
 	if (!info) {
 		BT_ERR("%s: don't support firmware rome 0x%x", hdev->name,
-		       ver_rom);
+		       ver.rom_version);
 		return -ENODEV;
 	}
 
@@ -2695,14 +2689,20 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
+	snprintf(fwname, sizeof(fwname), "qca/rampatch_usb_%08x.bin",
+		 ver.rom_version);
+
 	if (!(status & QCA_PATCH_UPDATED)) {
-		err = btusb_setup_qca_load_rampatch(hdev, &ver, info);
+		err = btusb_setup_qca_load_rampatch(hdev, fwname, &ver, info);
 		if (err < 0)
 			return err;
 	}
 
+	snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
+		 ver.rom_version);
+
 	if (!(status & QCA_SYSCFG_UPDATED)) {
-		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
+		err = btusb_setup_qca_load_nvm(hdev, fwname, info);
 		if (err < 0)
 			return err;
 	}
-- 
2.14.1

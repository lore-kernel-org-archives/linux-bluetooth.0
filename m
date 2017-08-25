Return-Path: <kai.heng.feng@canonical.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 3/4] Bluetooth: btusb: Cache firmware for QCA Bluetooth
Date: Fri, 25 Aug 2017 15:18:28 +0800
Message-Id: <20170825071829.1829-3-kai.heng.feng@canonical.com>
In-Reply-To: <20170825071829.1829-1-kai.heng.feng@canonical.com>
References: <20170825071829.1829-1-kai.heng.feng@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

For QCA Bluetooth that downloads firmware based on patched status, it
should still call request_firmware() once if download is not needed.

Also, version information was converted twice, reduce it to one.

Verified on DW1810 wireless module (0cf3:e009).

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2: Split patches for different vendors.

 drivers/bluetooth/btusb.c | 49 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4cb206ecfa7d..ec246302d7e6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2662,21 +2662,15 @@ static int btusb_setup_qca_download_fw(struct hci_dev *hdev,
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
@@ -2690,11 +2684,11 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
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
@@ -2710,16 +2704,12 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
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
@@ -2740,7 +2730,7 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 {
 	const struct qca_device_info *info = NULL;
 	struct qca_version ver;
-	u32 ver_rom;
+	char fwname[64];
 	u8 status;
 	int i, err;
 
@@ -2749,14 +2739,15 @@ static int btusb_setup_qca(struct hci_dev *hdev)
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
 
@@ -2765,17 +2756,25 @@ static int btusb_setup_qca(struct hci_dev *hdev)
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
-	}
+	} else
+		btusb_request_firmware_async(hdev, fwname);
+
+	snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
+		 ver.rom_version);
 
 	if (!(status & QCA_SYSCFG_UPDATED)) {
-		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
+		err = btusb_setup_qca_load_nvm(hdev, fwname, info);
 		if (err < 0)
 			return err;
-	}
+	} else
+		btusb_request_firmware_async(hdev, fwname);
 
 	return 0;
 }
-- 
2.14.1

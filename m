Return-Path: <cyrus@holtmann.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth:btusb:fix incorrect type in qca_device_info
Date: Tue, 10 Mar 2015 23:34:58 +0000
Message-ID: <5aa0581dcf9f4432a9080cdb18c9106a@nalasexr02e.na.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While qca_device_info is not coming from outside communication,
no reason to use specific endian type inside and fix the wrong
version comparison on big-endian platform.

Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0833054..c34a875 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2667,10 +2667,10 @@ struct qca_rampatch_version {
 } __packed;
 
 struct qca_device_info {
-	__le32	rom_version;
-	__u8	rampatch_hdr;	/* length of header in rampatch */
-	__u8	nvm_hdr;	/* length of header in NVM */
-	__u8	ver_offset;	/* offset of version structure in rampatch */
+	u32	rom_version;
+	u8	rampatch_hdr;	/* length of header in rampatch */
+	u8	nvm_hdr;	/* length of header in NVM */
+	u8	ver_offset;	/* offset of version structure in rampatch */
 };
 
 static const struct qca_device_info qca_devices_table[] = {
@@ -2782,11 +2782,15 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 {
 	struct qca_rampatch_version *rver;
 	const struct firmware *fw;
+	u32 ver_rom, ver_patch;
+	u16 rver_rom, rver_patch;
 	char fwname[64];
 	int err;
 
-	snprintf(fwname, sizeof(fwname), "qca/rampatch_usb_%08x.bin",
-		 le32_to_cpu(ver->rom_version));
+	ver_rom = le32_to_cpu(ver->rom_version);
+	ver_patch = le32_to_cpu(ver->patch_version);
+
+	snprintf(fwname, sizeof(fwname), "qca/rampatch_usb_%08x.bin", ver_rom);
 
 	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err) {
@@ -2796,14 +2800,16 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 	}
 
 	BT_INFO("%s: using rampatch file: %s", hdev->name, fwname);
+
 	rver = (struct qca_rampatch_version *)(fw->data + info->ver_offset);
+	rver_rom = le16_to_cpu(rver->rom_version);
+	rver_patch = le16_to_cpu(rver->patch_version);
+
 	BT_INFO("%s: QCA: patch rome 0x%x build 0x%x, firmware rome 0x%x "
-		"build 0x%x", hdev->name, le16_to_cpu(rver->rom_version),
-		le16_to_cpu(rver->patch_version), le32_to_cpu(ver->rom_version),
-		le32_to_cpu(ver->patch_version));
+		"build 0x%x", hdev->name, rver_rom, rver_patch, ver_rom,
+		ver_patch);
 
-	if (rver->rom_version != ver->rom_version ||
-	    rver->patch_version <= ver->patch_version) {
+	if (rver_rom != ver_rom || rver_patch <= ver_patch) {
 		BT_ERR("%s: rampatch file version did not match with firmware",
 		       hdev->name);
 		err = -EINVAL;
@@ -2849,6 +2855,7 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 {
 	const struct qca_device_info *info = NULL;
 	struct qca_version ver;
+	u32 ver_rom;
 	u8 status;
 	int i, err;
 
@@ -2857,13 +2864,14 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
+	ver_rom = le32_to_cpu(ver.rom_version);
 	for (i = 0; i < ARRAY_SIZE(qca_devices_table); i++) {
-		if (ver.rom_version == qca_devices_table[i].rom_version)
+		if (ver_rom == qca_devices_table[i].rom_version)
 			info = &qca_devices_table[i];
 	}
 	if (!info) {
 		BT_ERR("%s: don't support firmware rome 0x%x", hdev->name,
-		       le32_to_cpu(ver.rom_version));
+		       ver_rom);
 		return -ENODEV;
 	}
 
-- 
1.8.1.5


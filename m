Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix endian and alignment issue with ath3k version handling
Date: Sun, 20 Jul 2014 17:29:59 +0200
Message-Id: <1405870199-32499-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The ath3k driver is treating the version information badly when it
comes to loading the right firmware version and comparing that it
actually matches with the hardware.

Initially this showed up as this:

  CHECK   drivers/bluetooth/ath3k.c
drivers/bluetooth/ath3k.c:373:17: warning: cast to restricted __le32
drivers/bluetooth/ath3k.c:435:17: warning: cast to restricted __le32

However when fixing this by actually using __packed and __le32 for
the ath3_version structure, more issues came up:

  CHECK   drivers/bluetooth/ath3k.c
drivers/bluetooth/ath3k.c:381:32: warning: incorrect type in assignment (different base types)
drivers/bluetooth/ath3k.c:381:32:    expected restricted __le32 [usertype] rom_version
drivers/bluetooth/ath3k.c:381:32:    got int [signed] <noident>
drivers/bluetooth/ath3k.c:382:34: warning: incorrect type in assignment (different base types)
drivers/bluetooth/ath3k.c:382:34:    expected restricted __le32 [usertype] build_version
drivers/bluetooth/ath3k.c:382:34:    got int [signed] <noident>
drivers/bluetooth/ath3k.c:386:28: warning: restricted __le32 degrades to integer
drivers/bluetooth/ath3k.c:386:56: warning: restricted __le32 degrades to integer

This patch fixes every instance of the firmware version handling and
makes sure it is endian safe and uses proper unaligned access.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/ath3k.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 230c552daf91..a0d7355ef127 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -27,6 +27,7 @@
 #include <linux/device.h>
 #include <linux/firmware.h>
 #include <linux/usb.h>
+#include <asm/unaligned.h>
 #include <net/bluetooth/bluetooth.h>
 
 #define VERSION "1.0"
@@ -50,12 +51,12 @@
 #define ATH3K_NAME_LEN				0xFF
 
 struct ath3k_version {
-	unsigned int	rom_version;
-	unsigned int	build_version;
-	unsigned int	ram_version;
-	unsigned char	ref_clock;
-	unsigned char	reserved[0x07];
-};
+	__le32	rom_version;
+	__le32	build_version;
+	__le32	ram_version;
+	__u8	ref_clock;
+	__u8	reserved[7];
+} __packed;
 
 static const struct usb_device_id ath3k_table[] = {
 	/* Atheros AR3011 */
@@ -349,7 +350,8 @@ static int ath3k_load_patch(struct usb_device *udev)
 	unsigned char fw_state;
 	char filename[ATH3K_NAME_LEN] = {0};
 	const struct firmware *firmware;
-	struct ath3k_version fw_version, pt_version;
+	struct ath3k_version fw_version;
+	__u32 pt_rom_version, pt_build_version;
 	int ret;
 
 	ret = ath3k_get_state(udev, &fw_state);
@@ -370,7 +372,7 @@ static int ath3k_load_patch(struct usb_device *udev)
 	}
 
 	snprintf(filename, ATH3K_NAME_LEN, "ar3k/AthrBT_0x%08x.dfu",
-		le32_to_cpu(fw_version.rom_version));
+		 le32_to_cpu(fw_version.rom_version));
 
 	ret = request_firmware(&firmware, filename, &udev->dev);
 	if (ret < 0) {
@@ -378,12 +380,13 @@ static int ath3k_load_patch(struct usb_device *udev)
 		return ret;
 	}
 
-	pt_version.rom_version = *(int *)(firmware->data + firmware->size - 8);
-	pt_version.build_version = *(int *)
-		(firmware->data + firmware->size - 4);
+	pt_rom_version = get_unaligned_le32(firmware->data +
+					    firmware->size - 8);
+	pt_build_version = get_unaligned_le32(firmware->data +
+					      firmware->size - 4);
 
-	if ((pt_version.rom_version != fw_version.rom_version) ||
-		(pt_version.build_version <= fw_version.build_version)) {
+	if (pt_rom_version != le32_to_cpu(fw_version.rom_version) ||
+	    pt_build_version <= le32_to_cpu(fw_version.build_version)) {
 		BT_ERR("Patch file version did not match with firmware");
 		release_firmware(firmware);
 		return -EINVAL;
-- 
1.9.3


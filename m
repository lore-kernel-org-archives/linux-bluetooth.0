Return-Path: <cyrus@holtmann.org>
From: Peng Chen <pengchen@qca.qualcomm.com>
To: <gustavo@padovan.org>
CC: <linux-bluetooth@vger.kernel.org>, <marcel@holtmann.org>, Peng Chen
	<pengchen@qca.qualcomm.com>
Subject: [PATCH] Fix endian safe issue, make driver work on both little and big endian cpu.
Date: Thu, 6 Sep 2012 19:30:43 +0800
Message-ID: <1346931043-11541-1-git-send-email-pengchen@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: Peng Chen <pengchen@qca.qualcomm.com>
---
 drivers/bluetooth/ath3k.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 10308cd..e63aee1 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -299,7 +299,7 @@ static int ath3k_load_patch(struct usb_device *udev)
 	}
 
 	snprintf(filename, ATH3K_NAME_LEN, "ar3k/AthrBT_0x%08x.dfu",
-		fw_version.rom_version);
+		le32_to_cpu(fw_version.rom_version));
 
 	ret = request_firmware(&firmware, filename, &udev->dev);
 	if (ret < 0) {
@@ -361,7 +361,7 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 	}
 
 	snprintf(filename, ATH3K_NAME_LEN, "ar3k/ramps_0x%08x_%d%s",
-		fw_version.rom_version, clk_value, ".dfu");
+		le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");
 
 	ret = request_firmware(&firmware, filename, &udev->dev);
 	if (ret < 0) {
-- 
1.7.9.5

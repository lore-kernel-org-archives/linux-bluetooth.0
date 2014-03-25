Return-Path: <cyrus@holtmann.org>
From: Surendra Patil <surendra.tux@gmail.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	surendra.tux@gmail.com
Subject: [PATCH] drivers:bluetooth:ath3k.c: Fixed sparse warning for cast to restricted __le32
Date: Tue, 25 Mar 2014 01:25:50 -0700
Message-Id: <1395735950-17968-1-git-send-email-surendra.tux@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes below Sparse warnings -
drivers/bluetooth/ath3k.c:370:17: warning: cast to restricted __le32
drivers/bluetooth/ath3k.c:432:17: warning: cast to restricted __le32

Signed-off-by: Surendra Patil <surendra.tux@gmail.com>
---
 drivers/bluetooth/ath3k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index be571fe..badacbc 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -367,7 +367,7 @@ static int ath3k_load_patch(struct usb_device *udev)
 	}
 
 	snprintf(filename, ATH3K_NAME_LEN, "ar3k/AthrBT_0x%08x.dfu",
-		le32_to_cpu(fw_version.rom_version));
+		fw_version.rom_version);
 
 	ret = request_firmware(&firmware, filename, &udev->dev);
 	if (ret < 0) {
@@ -429,7 +429,7 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 	}
 
 	snprintf(filename, ATH3K_NAME_LEN, "ar3k/ramps_0x%08x_%d%s",
-		le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");
+		 fw_version.rom_version, clk_value, ".dfu");
 
 	ret = request_firmware(&firmware, filename, &udev->dev);
 	if (ret < 0) {
-- 
1.8.3.2

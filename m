Return-Path: <s.christ@phytec.de>
From: Stefan Christ <s.christ@phytec.de>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH] bluetooth: btmrvl: print filename of firmware in error msg
Date: Thu, 17 Mar 2016 15:32:46 +0100
Message-Id: <1458225166-14738-1-git-send-email-s.christ@phytec.de>
List-ID: <linux-bluetooth.vger.kernel.org>

When the firmware file cannot be loaded, print the filename in the error
message. So the user has a clue which file is missing.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
---
 drivers/bluetooth/btmrvl_sdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 6ed8acf..a88f031 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -490,8 +490,8 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 	ret = request_firmware(&fw_firmware, card->firmware,
 							&card->func->dev);
 	if ((ret < 0) || !fw_firmware) {
-		BT_ERR("request_firmware(firmware) failed, error code = %d",
-									ret);
+		BT_ERR("Requesting firmware %s failed, error code = %d",
+							card->firmware, ret);
 		ret = -ENOENT;
 		goto done;
 	}
-- 
1.9.1

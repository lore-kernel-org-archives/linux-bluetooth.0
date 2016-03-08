Return-Path: <wnhuang@chromium.org>
From: Wei-Ning Huang <wnhuang@chromium.org>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	snanda@chromium.org,
	djkurtz@chromium.org,
	akarwar@marvell.com,
	Wei-Ning Huang <wnhuang@chromium.org>,
	Wei-Ning Huang <wnhuang@google.com>,
	marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Subject: [PATCH] Bluetooth: btmrvl_sdio: fix firmware activation failure
Date: Tue,  8 Mar 2016 11:40:06 +0800
Message-Id: <1457408407-39841-1-git-send-email-wnhuang@google.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wei-Ning Huang <wnhuang@chromium.org>

In some case, the btmrvl_sdio firmware would fail to active within the
polling time. Increase the polling interval to 100 msec to fix the
issue.

Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 6ed8acf..c6ef248 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -371,7 +371,7 @@ static int btmrvl_sdio_verify_fw_download(struct btmrvl_sdio_card *card,
 		if (firmwarestat == FIRMWARE_READY)
 			return 0;
 
-		msleep(10);
+		msleep(100);
 	}
 
 	return -ETIMEDOUT;
-- 
2.7.0.rc3.207.g0ac5344

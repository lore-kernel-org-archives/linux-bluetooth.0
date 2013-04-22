Return-Path: <cyrus@holtmann.org>
From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	andrei.emeltchenko@intel.com,
	akarwar@marvell.com,
	bzhao@marvell.com,
	zonque@gmail.com,
	Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH v3 1/2] Bluetooth: btmrvl: release lock while waiting for fw download complete.
Date: Mon, 22 Apr 2013 11:10:22 +0200
Message-Id: <1366621823-10411-2-git-send-email-andreas.fenkart@streamunlimited.com>
In-Reply-To: <1366621823-10411-1-git-send-email-andreas.fenkart@streamunlimited.com>
References: <1366621823-10411-1-git-send-email-andreas.fenkart@streamunlimited.com>
List-ID: <linux-bluetooth.vger.kernel.org>

If not winner, driver must release the sdio host lock, so the fw
download can progress. While holding the lock fw download is stalled
and the following error is produced:

[  235.746015] Bluetooth: FW failed to be active in time!
[  235.752799] Bluetooth: Downloading firmware failed!

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 drivers/bluetooth/btmrvl_sdio.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 9959d4c..c7ec727 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -234,7 +234,10 @@ static int btmrvl_sdio_verify_fw_download(struct btmrvl_sdio_card *card,
 
 	 /* Wait for firmware to become ready */
 	for (tries = 0; tries < pollnum; tries++) {
-		if (btmrvl_sdio_read_fw_status(card, &firmwarestat) < 0)
+		sdio_claim_host(card->func);
+		ret = btmrvl_sdio_read_fw_status(card, &firmwarestat);
+		sdio_release_host(card->func);
+		if (ret < 0)
 			continue;
 
 		if (firmwarestat == FIRMWARE_READY) {
@@ -882,13 +885,14 @@ static int btmrvl_sdio_download_fw(struct btmrvl_sdio_card *card)
 		BT_ERR("card or function is NULL!");
 		return -EINVAL;
 	}
-	sdio_claim_host(card->func);
 
 	if (!btmrvl_sdio_verify_fw_download(card, 1)) {
 		BT_DBG("Firmware already downloaded!");
-		goto done;
+		return 0;
 	}
 
+	sdio_claim_host(card->func);
+
 	/* Check if other function driver is downloading the firmware */
 	fws0 = sdio_readb(card->func, card->reg->card_fw_status0, &ret);
 	if (ret) {
@@ -918,15 +922,17 @@ static int btmrvl_sdio_download_fw(struct btmrvl_sdio_card *card)
 		}
 	}
 
+	sdio_release_host(card->func);
+
 	if (btmrvl_sdio_verify_fw_download(card, pollnum)) {
 		BT_ERR("FW failed to be active in time!");
-		ret = -ETIMEDOUT;
-		goto done;
+		return -ETIMEDOUT;
 	}
 
+	return 0;
+
 done:
 	sdio_release_host(card->func);
-
 	return ret;
 }
 
-- 
1.7.10.4

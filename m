Return-Path: <cyrus@holtmann.org>
From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	andrei.emeltchenko@intel.com,
	akarwar@marvell.com,
	bzhao@marvell.com,
	Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH 2/2] Bluetooth: btmrvl: report error if verify_fw_download times out.
Date: Thu, 18 Apr 2013 18:18:09 +0200
Message-Id: <1366301890-14100-3-git-send-email-andreas.fenkart@streamunlimited.com>
In-Reply-To: <1366301890-14100-1-git-send-email-andreas.fenkart@streamunlimited.com>
References: <1366301890-14100-1-git-send-email-andreas.fenkart@streamunlimited.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Fw does the synchronization of the different modules during init.
It will report different modules, that it is ready at different times.
The download 'winner' will be reported 'fw ready' first. Without this
patch, btmrvl is continuing before the fw tells it to. Probably on behalf
of the 'winner' which then never sees the fw as ready and times out.

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 drivers/bluetooth/btmrvl_sdio.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 6b6abb2..2ec0841 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -245,6 +245,7 @@ static int btmrvl_sdio_verify_fw_download(struct btmrvl_sdio_card *card,
 			break;
 		} else {
 			msleep(10);
+			ret = -1;
 		}
 	}
 
@@ -924,6 +925,10 @@ static int btmrvl_sdio_download_fw(struct btmrvl_sdio_card *card)
 
 	sdio_release_host(card->func);
 
+	/*
+	 * winner or not, with this test the FW synchronizes when the
+	 * module can continue its initialization
+	 */
 	if (btmrvl_sdio_verify_fw_download(card, pollnum)) {
 		BT_ERR("FW failed to be active in time!");
 		return -ETIMEDOUT;
-- 
1.7.10.4

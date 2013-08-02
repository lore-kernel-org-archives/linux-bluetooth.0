Return-Path: <cyrus@holtmann.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] btmrvl_sdio: use DIV_ROUND_UP in suitable places
Date: Fri,  2 Aug 2013 14:10:12 +0300
Message-Id: <1375441812-13852-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are two places where DIV_ROUND_UP may be used. It makes code a bit
clearer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 75c2626..00da6df 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -486,7 +486,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 			if (firmwarelen - offset < txlen)
 				txlen = firmwarelen - offset;
 
-			tx_blocks = (txlen + blksz_dl - 1) / blksz_dl;
+			tx_blocks = DIV_ROUND_UP(txlen, blksz_dl);
 
 			memcpy(fwbuf, &firmware[offset], txlen);
 		}
@@ -873,7 +873,7 @@ static int btmrvl_sdio_host_to_card(struct btmrvl_private *priv,
 	}
 
 	blksz = SDIO_BLOCK_SIZE;
-	buf_block_len = (nb + blksz - 1) / blksz;
+	buf_block_len = DIV_ROUND_UP(nb, blksz);
 
 	sdio_claim_host(card->func);
 
-- 
1.8.4.rc0


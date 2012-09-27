Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/3] Bluetooth: btmrvl: Use DIV_ROUND_UP macro
Date: Thu, 27 Sep 2012 10:51:47 +0300
Message-Id: <1348732308-29348-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1348732308-29348-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1348732308-29348-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The kernel.h macro DIV_ROUND_UP performs the computation
(((n) + (d) - 1) / (d))

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 drivers/bluetooth/btmrvl_sdio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 25dc53b..1457f25 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -516,7 +516,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	BT_DBG("%s buf_len %zu", hdev->name, buf_len);
 
 	blksz = SDIO_BLOCK_SIZE;
-	num_blocks = (buf_len + blksz - 1) / blksz;
+	num_blocks = DIV_ROUND_UP(buf_len, blksz);
 
 	if (buf_len <= SDIO_HEADER_LEN
 	    || (num_blocks * blksz) > ALLOC_BUF_SIZE) {
-- 
1.7.9.5


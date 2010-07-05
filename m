Return-Path: <cyrus@holtmann.org>
From: Kulikov Vasiliy <segooon@gmail.com>
To: Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Bing Zhao <bzhao@marvell.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	=?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>,
	Julia Lawall <julia@diku.dk>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: btmrvl_sdio: silence warning
Date: Mon,  5 Jul 2010 12:01:22 +0400
Message-Id: <1278316883-29784-1-git-send-email-segooon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Clone checking of ret to simplify the code.

This patch silences a compiler warning:
drivers/bluetooth/btmrvl_sdio.c: In function ‘btmrvl_sdio_verify_fw_download’:
drivers/bluetooth/btmrvl_sdio.c:80: warning: ‘fws1’ may be used uninitialized in this function
drivers/bluetooth/btmrvl_sdio.c:80: note: ‘fws1’ was declared here

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 drivers/bluetooth/btmrvl_sdio.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index df0773e..47f0f91 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -83,10 +83,10 @@ static int btmrvl_sdio_read_fw_status(struct btmrvl_sdio_card *card, u16 *dat)
 	*dat = 0;
 
 	fws0 = sdio_readb(card->func, CARD_FW_STATUS0_REG, &ret);
+	if (ret)
+		return -EIO;
 
-	if (!ret)
-		fws1 = sdio_readb(card->func, CARD_FW_STATUS1_REG, &ret);
-
+	fws1 = sdio_readb(card->func, CARD_FW_STATUS1_REG, &ret);
 	if (ret)
 		return -EIO;
 
-- 
1.7.0.4

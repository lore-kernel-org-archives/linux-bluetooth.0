Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] bluetooth/btmrl_sdio.c: Fix compile warning
From: Javier Martinez Canillas <martinez.javier@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, Bing Zhao <bzhao@marvell.com>,  Rahul Tank <rahult@marvell.com>, Julia Lawall <julia@diku.dk>, linux-bluetooth@vger.kernel.org,  kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 31 Oct 2009 02:48:44 -0300
Message-Id: <1256968124.29147.4.camel@laptop>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

In linux-next 20091030 I got this compile warning:

drivers/bluetooth/btmrvl_sdio.c: In function ‘btmrvl_sdio_verify_fw_download’:
drivers/bluetooth/btmrvl_sdio.c:79: warning: ‘fws1’ may be used uninitialized in this function
drivers/bluetooth/btmrvl_sdio.c:79: note: ‘fws1’ was declared here

This patch solves the issue.

Signed-off-by: Javier Martinez Canillas <martinez.javier@gmail.com>
---
 drivers/bluetooth/btmrvl_sdio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 5b33b85..41d64fd 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -76,7 +76,7 @@ static int btmrvl_sdio_get_rx_unit(struct btmrvl_sdio_card *card)
 
 static int btmrvl_sdio_read_fw_status(struct btmrvl_sdio_card *card, u16 *dat)
 {
-	u8 fws0, fws1;
+	u8 fws0, fws1 = 0;
 	int ret;
 
 	*dat = 0;
-- 
1.6.0.4

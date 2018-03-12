Return-Path: <elfring@users.sourceforge.net>
Subject: [PATCH 1/5] Bluetooth: btmrvl: Use common error handling code in
 btmrvl_sdio_register_dev()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Message-ID: <5c3361c6-ef1d-b919-8817-05c2c98fb2ef@users.sourceforge.net>
Date: Mon, 12 Mar 2018 12:31:44 +0100
MIME-Version: 1.0
In-Reply-To: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 10:15:17 +0100

Adjust a jump target so that a bit of exception handling can be better
reused at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/bluetooth/btmrvl_sdio.c | 50 ++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 0f020254fd39..df2a04bd8428 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -949,31 +949,24 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 	ret = sdio_set_block_size(card->func, SDIO_BLOCK_SIZE);
 	if (ret) {
 		BT_ERR("cannot set SDIO block size");
-		ret = -EIO;
-		goto release_irq;
+		goto release_with_eio;
 	}
 
 	reg = sdio_readb(func, card->reg->io_port_0, &ret);
-	if (ret < 0) {
-		ret = -EIO;
-		goto release_irq;
-	}
+	if (ret < 0)
+		goto release_with_eio;
 
 	card->ioport = reg;
 
 	reg = sdio_readb(func, card->reg->io_port_1, &ret);
-	if (ret < 0) {
-		ret = -EIO;
-		goto release_irq;
-	}
+	if (ret < 0)
+		goto release_with_eio;
 
 	card->ioport |= (reg << 8);
 
 	reg = sdio_readb(func, card->reg->io_port_2, &ret);
-	if (ret < 0) {
-		ret = -EIO;
-		goto release_irq;
-	}
+	if (ret < 0)
+		goto release_with_eio;
 
 	card->ioport |= (reg << 16);
 
@@ -981,26 +974,20 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 
 	if (card->reg->int_read_to_clear) {
 		reg = sdio_readb(func, card->reg->host_int_rsr, &ret);
-		if (ret < 0) {
-			ret = -EIO;
-			goto release_irq;
-		}
+		if (ret < 0)
+			goto release_with_eio;
+
 		sdio_writeb(func, reg | 0x3f, card->reg->host_int_rsr, &ret);
-		if (ret < 0) {
-			ret = -EIO;
-			goto release_irq;
-		}
+		if (ret < 0)
+			goto release_with_eio;
 
 		reg = sdio_readb(func, card->reg->card_misc_cfg, &ret);
-		if (ret < 0) {
-			ret = -EIO;
-			goto release_irq;
-		}
+		if (ret < 0)
+			goto release_with_eio;
+
 		sdio_writeb(func, reg | 0x10, card->reg->card_misc_cfg, &ret);
-		if (ret < 0) {
-			ret = -EIO;
-			goto release_irq;
-		}
+		if (ret < 0)
+			goto release_with_eio;
 	}
 
 	sdio_set_drvdata(func, card);
@@ -1009,7 +996,8 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 
 	return 0;
 
-release_irq:
+release_with_eio:
+	ret = -EIO;
 	sdio_release_irq(func);
 
 disable_func:
-- 
2.16.2

Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan
	<gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Amitkumar
 Karwar <akarwar@marvell.com>, Bing Zhao <bzhao@marvell.com>
Subject: [PATCH 1/2] Bluetooth: btmrvl: separate write-to-clear function from interrupt handler
Date: Thu, 27 Mar 2014 21:30:42 -0700
Message-ID: <1395981043-2541-1-git-send-email-bzhao@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patch improves readability and makes future changes easier.

Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 53 +++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 1b52c9f..7883793 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -667,6 +667,36 @@ static int btmrvl_sdio_process_int_status(struct btmrvl_private *priv)
 	return 0;
 }
 
+static int btmrvl_sdio_write_to_clear(struct btmrvl_sdio_card *card, u8 *ireg)
+{
+	int ret;
+
+	*ireg = sdio_readb(card->func, card->reg->host_intstatus, &ret);
+	if (ret) {
+		BT_ERR("sdio_readb: read int status failed: %d", ret);
+		return ret;
+	}
+
+	if (*ireg) {
+		/*
+		 * DN_LD_HOST_INT_STATUS and/or UP_LD_HOST_INT_STATUS
+		 * Clear the interrupt status register and re-enable the
+		 * interrupt.
+		 */
+		BT_DBG("int_status = 0x%x", *ireg);
+
+		sdio_writeb(card->func, ~(*ireg) & (DN_LD_HOST_INT_STATUS |
+						    UP_LD_HOST_INT_STATUS),
+			    card->reg->host_intstatus, &ret);
+		if (ret) {
+			BT_ERR("sdio_writeb: clear int status failed: %d", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static void btmrvl_sdio_interrupt(struct sdio_func *func)
 {
 	struct btmrvl_private *priv;
@@ -684,28 +714,9 @@ static void btmrvl_sdio_interrupt(struct sdio_func *func)
 
 	priv = card->priv;
 
-	ireg = sdio_readb(card->func, card->reg->host_intstatus, &ret);
-	if (ret) {
-		BT_ERR("sdio_readb: read int status register failed");
+	ret = btmrvl_sdio_write_to_clear(card, &ireg);
+	if (ret)
 		return;
-	}
-
-	if (ireg != 0) {
-		/*
-		 * DN_LD_HOST_INT_STATUS and/or UP_LD_HOST_INT_STATUS
-		 * Clear the interrupt status register and re-enable the
-		 * interrupt.
-		 */
-		BT_DBG("ireg = 0x%x", ireg);
-
-		sdio_writeb(card->func, ~(ireg) & (DN_LD_HOST_INT_STATUS |
-					UP_LD_HOST_INT_STATUS),
-				card->reg->host_intstatus, &ret);
-		if (ret) {
-			BT_ERR("sdio_writeb: clear int status register failed");
-			return;
-		}
-	}
 
 	spin_lock_irqsave(&priv->driver_lock, flags);
 	sdio_ireg |= ireg;
-- 
1.8.0

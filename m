Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bing Zhao <bzhao@marvell.com>
Subject: [PATCH] Bluetooth: Fix incorrect alignment in Marvell BT-over-SDIO driver
Date: Wed,  8 Jul 2009 11:44:14 -0700
Message-Id: <1247078654-8666-1-git-send-email-bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The driver uses "u32" for alignment check and calculation which
works only on 32-bit system. It will crash the 64-bit system.
Replace "u32" with "unsigned long" to fix this issue.

Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
This patch is for bluetooth-mrvl-2.6.git tree.
It has been tested on both 32-bit and 64-bit x86 laptops.

 drivers/bluetooth/btmrvl_sdio.c |   12 +++++++-----
 drivers/bluetooth/btmrvl_sdio.h |    3 ++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 224af53..1cfa8b4 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -481,12 +481,14 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 		goto exit;
 	}
 
-	if ((u32) skb->data & (BTSDIO_DMA_ALIGN - 1)) {
-		skb_put(skb, (u32) skb->data & (BTSDIO_DMA_ALIGN - 1));
-		skb_pull(skb, (u32) skb->data & (BTSDIO_DMA_ALIGN - 1));
+	if ((unsigned long) skb->data & (BTSDIO_DMA_ALIGN - 1)) {
+		skb_put(skb, (unsigned long) skb->data &
+					(BTSDIO_DMA_ALIGN - 1));
+		skb_pull(skb, (unsigned long) skb->data &
+					(BTSDIO_DMA_ALIGN - 1));
 	}
 
-	payload = skb->tail;
+	payload = skb->data;
 
 	ret = sdio_readsb(card->func, payload, card->ioport,
 			  buf_block_len * blksz);
@@ -773,7 +775,7 @@ static int btmrvl_sdio_host_to_card(struct btmrvl_private *priv,
 	}
 
 	buf = payload;
-	if ((u32) payload & (BTSDIO_DMA_ALIGN - 1)) {
+	if ((unsigned long) payload & (BTSDIO_DMA_ALIGN - 1)) {
 		tmpbufsz = ALIGN_SZ(nb, BTSDIO_DMA_ALIGN);
 		tmpbuf = kmalloc(tmpbufsz, GFP_KERNEL);
 		memset(tmpbuf, 0, tmpbufsz);
diff --git a/drivers/bluetooth/btmrvl_sdio.h b/drivers/bluetooth/btmrvl_sdio.h
index 2dd284e..27329f1 100644
--- a/drivers/bluetooth/btmrvl_sdio.h
+++ b/drivers/bluetooth/btmrvl_sdio.h
@@ -104,4 +104,5 @@ struct btmrvl_sdio_device {
 
 /* Macros for Data Alignment : address */
 #define ALIGN_ADDR(p, a)	\
-	((((u32)(p)) + (((u32)(a)) - 1)) & ~(((u32)(a)) - 1))
+	((((unsigned long)(p)) + (((unsigned long)(a)) - 1)) & \
+					~(((unsigned long)(a)) - 1))
-- 
1.5.3.6


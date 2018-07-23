Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: btmrvl_sdio: Replace GFP_ATOMIC with GFP_KERNEL in btmrvl_sdio_card_to_host()
Date: Mon, 23 Jul 2018 11:30:03 +0800
Message-Id: <20180723033003.7957-1-baijiaju1990@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

btmrvl_sdio_card_to_host() is never called in atomic context.
It calls bt_skb_alloc() with GFP_ATOMIC, which is not necessary. 
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 6f99b9f3d57f..af36ed6376ad 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -718,7 +718,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	}
 
 	/* Allocate buffer */
-	skb = bt_skb_alloc(num_blocks * blksz + BTSDIO_DMA_ALIGN, GFP_ATOMIC);
+	skb = bt_skb_alloc(num_blocks * blksz + BTSDIO_DMA_ALIGN, GFP_KERNEL);
 	if (!skb) {
 		BT_ERR("No free skb");
 		ret = -ENOMEM;
-- 
2.17.0

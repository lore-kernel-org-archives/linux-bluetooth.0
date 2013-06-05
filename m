Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 5 Jun 2013 10:16:55 +0800
Message-ID: <CAPgLHd_+jJEOiO9x=gw1eW0LrrRj-rkKhb7mDqhg1ALaMzjKwQ@mail.gmail.com>
Subject: [PATCH] Bluetooth: btmrvl: fix error return code in btmrvl_sdio_card_to_host()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: yongjun_wei@trendmicro.com.cn, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -ENOMEM in the skb alloc error handling case
instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/bluetooth/btmrvl_sdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 13693b7..75c2626 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -554,6 +554,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	skb = bt_skb_alloc(num_blocks * blksz + BTSDIO_DMA_ALIGN, GFP_ATOMIC);
 	if (skb == NULL) {
 		BT_ERR("No free skb");
+		ret = -ENOMEM;
 		goto exit;
 	}
 

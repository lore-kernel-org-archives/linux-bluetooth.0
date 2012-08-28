Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 28 Aug 2012 21:12:48 +0800
Message-ID: <CAPgLHd-R2t_9aDOQ8Q-Q0nz6k4KZEBPVEO4SMea7T=ANbTOLnQ@mail.gmail.com>
Subject: [PATCH] Bluetooth: btmrvl: remove pointless conditional before kfree_skb()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: yongjun_wei@trendmicro.com.cn, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove pointless conditional before kfree_skb().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/bluetooth/btmrvl_sdio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 6a9e971..48ae86f 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -600,8 +600,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 exit:
 	if (ret) {
 		hdev->stat.err_rx++;
-		if (skb)
-			kfree_skb(skb);
+		kfree_skb(skb);
 	}
 
 	return ret;

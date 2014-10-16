Return-Path: <cyrus@holtmann.org>
From: roy.qing.li@gmail.com
To: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Subject: [PATCH] Bluetooth: 6lowpan: remove unnecessary codes in give_skb_to_upper
Date: Thu, 16 Oct 2014 10:21:55 +0800
Message-Id: <1413426115-17077-1-git-send-email-roy.qing.li@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Li RongQing <roy.qing.li@gmail.com>

netif_rx() only returns NET_RX_DROP and NET_RX_SUCCESS, not returns
negative value

Signed-off-by: Li RongQing <roy.qing.li@gmail.com>
---
 net/bluetooth/6lowpan.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index c2e0d14..9b5c89b 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -249,19 +249,12 @@ static struct lowpan_dev *lookup_dev(struct l2cap_conn *conn)
 static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
 {
 	struct sk_buff *skb_cp;
-	int ret;
 
 	skb_cp = skb_copy(skb, GFP_ATOMIC);
 	if (!skb_cp)
 		return -ENOMEM;
 
-	ret = netif_rx(skb_cp);
-	if (ret < 0) {
-		BT_DBG("receive skb %d", ret);
-		return NET_RX_DROP;
-	}
-
-	return ret;
+	return netif_rx(skb_cp);
 }
 
 static int process_data(struct sk_buff *skb, struct net_device *netdev,
-- 
1.7.10.4

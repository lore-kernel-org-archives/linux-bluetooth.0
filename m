Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: 6lowpan: Do not free skb when packet is dropped
Date: Wed, 10 Dec 2014 14:19:53 +0200
Message-Id: <1418213993-24884-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we need to drop the message because of some error in the
compression etc, then do not free the skb as that is done
automatically in other part of networking stack.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index bdcaefd..ca5b4ec 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -390,7 +390,6 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 
 drop:
 	dev->stats.rx_dropped++;
-	kfree_skb(skb);
 	return NET_RX_DROP;
 }
 
-- 
1.8.3.1


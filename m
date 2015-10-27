Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>
Subject: [PATCH bluetooth-next] bluetooth: 6lowpan: fix NOHZ: local_softirq_pending
Date: Tue, 27 Oct 2015 08:35:24 +0100
Message-Id: <1445931324-1524-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Jukka reported about the following warning:

"NOHZ: local_softirq_pending 08"

I remember this warning and we had a similar issue when using workqueues
and calling netif_rx. See commit 5ff3fec ("mac802154: fix NOHZ
local_softirq_pending 08 warning").

This warning occurs when calling "netif_rx" inside the wrong context
(non softirq context). The net core api offers "netif_rx_ni" to call
netif_rx inside the correct softirq context.

Reported-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/bluetooth/6lowpan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index d85af23..9e9cca3 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -263,7 +263,7 @@ static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
 	if (!skb_cp)
 		return NET_RX_DROP;
 
-	return netif_rx(skb_cp);
+	return netif_rx_ni(skb_cp);
 }
 
 static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
-- 
2.6.1


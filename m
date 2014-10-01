Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: 6lowpan: Avoid memory leak if memory allocation fails
Date: Wed,  1 Oct 2014 11:30:57 +0300
Message-Id: <1412152257-22316-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If skb_unshare() returns NULL, then we leak the original skb.
Solution is to use temp variable to hold the new skb.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index add2b58..44eaad7 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -589,13 +589,17 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
 	int err = 0;
 	bdaddr_t addr;
 	u8 addr_type;
+	struct sk_buff *tmpskb;
 
 	/* We must take a copy of the skb before we modify/replace the ipv6
 	 * header as the header could be used elsewhere
 	 */
-	skb = skb_unshare(skb, GFP_ATOMIC);
-	if (!skb)
+	tmpskb = skb_unshare(skb, GFP_ATOMIC);
+	if (!tmpskb) {
+		kfree_skb(skb);
 		return NET_XMIT_DROP;
+	}
+	skb = tmpskb;
 
 	/* Return values from setup_header()
 	 *  <0 - error, packet is dropped
-- 
1.8.3.1


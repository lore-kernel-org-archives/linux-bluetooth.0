Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: jukka.rissanen@linux.intel.com,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] bluetooth: 6lowpan: fix skb_unshare behaviour
Date: Wed,  8 Oct 2014 10:24:53 +0200
Message-Id: <1412756693-19410-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch reverts commit:

a7807d73 ("Bluetooth: 6lowpan: Avoid memory leak if memory allocation
fails")

which was wrong suggested by Alexander Aring. The function skb_unshare
run also kfree_skb on failure.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
compile tested only.

 net/bluetooth/6lowpan.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index c2e0d14..cfbb39e 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -591,17 +591,13 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
 	int err = 0;
 	bdaddr_t addr;
 	u8 addr_type;
-	struct sk_buff *tmpskb;
 
 	/* We must take a copy of the skb before we modify/replace the ipv6
 	 * header as the header could be used elsewhere
 	 */
-	tmpskb = skb_unshare(skb, GFP_ATOMIC);
-	if (!tmpskb) {
-		kfree_skb(skb);
+	skb = skb_unshare(skb, GFP_ATOMIC);
+	if (!skb)
 		return NET_XMIT_DROP;
-	}
-	skb = tmpskb;
 
 	/* Return values from setup_header()
 	 *  <0 - error, packet is dropped
-- 
2.1.2


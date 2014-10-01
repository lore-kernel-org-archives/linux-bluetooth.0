Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: 6lowpan: Check transmit errors for multicast packets
Date: Wed,  1 Oct 2014 15:59:15 +0300
Message-Id: <1412168355-27127-3-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1412168355-27127-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1412168355-27127-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We did not return error if multicast packet transmit failed.
This might not be desired so return error also in this case.
If there are multiple 6lowpan devices where the multicast packet
is sent, then return error even if sending to only one of them fails.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index fcfaa70..c2e0d14 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -546,11 +546,12 @@ static int send_pkt(struct l2cap_chan *chan, struct sk_buff *skb,
 	return err;
 }
 
-static void send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
+static int send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct sk_buff *local_skb;
 	struct lowpan_dev *entry, *tmp;
 	unsigned long flags;
+	int err = 0;
 
 	read_lock_irqsave(&devices_lock, flags);
 
@@ -564,19 +565,25 @@ static void send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 		dev = lowpan_dev(entry->netdev);
 
 		list_for_each_entry_safe(pentry, ptmp, &dev->peers, list) {
+			int ret;
+
 			local_skb = skb_clone(skb, GFP_ATOMIC);
 
 			BT_DBG("xmit %s to %pMR type %d IP %pI6c chan %p",
 			       netdev->name,
 			       &pentry->chan->dst, pentry->chan->dst_type,
 			       &pentry->peer_addr, pentry->chan);
-			send_pkt(pentry->chan, local_skb, netdev);
+			ret = send_pkt(pentry->chan, local_skb, netdev);
+			if (ret < 0)
+				err = ret;
 
 			kfree_skb(local_skb);
 		}
 	}
 
 	read_unlock_irqrestore(&devices_lock, flags);
+
+	return err;
 }
 
 static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
@@ -620,7 +627,7 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
 		/* We need to send the packet to every device behind this
 		 * interface.
 		 */
-		send_mcast_pkt(skb, netdev);
+		err = send_mcast_pkt(skb, netdev);
 	}
 
 	dev_kfree_skb(skb);
-- 
1.8.3.1


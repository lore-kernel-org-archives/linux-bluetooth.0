Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: 6lowpan: Return EAGAIN error also for multicast packets
Date: Wed,  1 Oct 2014 15:59:14 +0300
Message-Id: <1412168355-27127-2-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1412168355-27127-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1412168355-27127-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure that we are able to return EAGAIN from l2cap_chan_send()
even for multicast packets. The error code was ignored unncessarily.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 44eaad7..fcfaa70 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -509,21 +509,16 @@ static int header_create(struct sk_buff *skb, struct net_device *netdev,
 
 /* Packet to BT LE device */
 static int send_pkt(struct l2cap_chan *chan, struct sk_buff *skb,
-		    struct net_device *netdev, bool is_mcast)
+		    struct net_device *netdev)
 {
 	struct msghdr msg;
 	struct kvec iv;
 	int err;
 
 	/* Remember the skb so that we can send EAGAIN to the caller if
-	 * we run out of credits. This is not done for multicast packets
-	 * because we generate mcast packet in this module and are not
-	 * really able to remember the skb after this packet is sent.
+	 * we run out of credits.
 	 */
-	if (is_mcast)
-		chan->data = NULL;
-	else
-		chan->data = skb;
+	chan->data = skb;
 
 	memset(&msg, 0, sizeof(msg));
 	msg.msg_iov = (struct iovec *) &iv;
@@ -575,7 +570,7 @@ static void send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 			       netdev->name,
 			       &pentry->chan->dst, pentry->chan->dst_type,
 			       &pentry->peer_addr, pentry->chan);
-			send_pkt(pentry->chan, local_skb, netdev, true);
+			send_pkt(pentry->chan, local_skb, netdev);
 
 			kfree_skb(local_skb);
 		}
@@ -617,8 +612,7 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
 			BT_DBG("xmit %s to %pMR type %d IP %pI6c chan %p",
 			       netdev->name, &addr, addr_type,
 			       &lowpan_cb(skb)->addr, lowpan_cb(skb)->chan);
-			err = send_pkt(lowpan_cb(skb)->chan, skb, netdev,
-				       false);
+			err = send_pkt(lowpan_cb(skb)->chan, skb, netdev);
 		} else {
 			err = -ENOENT;
 		}
-- 
1.8.3.1


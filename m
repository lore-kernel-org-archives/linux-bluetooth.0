Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>
Subject: [RFC bluetooth-next 2/2] bluetooth: 6lowpan: rework receive handling
Date: Sat, 24 Oct 2015 16:50:56 +0200
Message-Id: <1445698256-10407-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1445698256-10407-1-git-send-email-alex.aring@gmail.com>
References: <1445698256-10407-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch reworks the receive handling of bluetooth 6lowpan. I
introduce the same mechanism like we do in 802.15.4 6LoWPAN. Small
change is that I changed RX_QUEUED to RX_QUEUE, because it's not queued,
returning RX_QUEUE means the skb will be queued.

About the TODOs:

I added several TODOs which I am not sure how to handle it right now.
E.g. "skb->dev = dev", if this is really necessary, the current
implementation does it in IPHC and not in IPv6 dispatch value.

About memory management here:

This is currently wrong somehow, you can see that at the first call of
"skb_share_check", if this fails then the skb will be freed by
kfree_skb. But the previous error checks doesn't kfree_skb the skb. This
is a different handling for the same thing.

Jukka, please look how the ".recv" callback of "l2cap_ops" is working.
Who will free the skb? The ".recv" callback of "l2cap_ops" if returning
errno, or the callback itself need to do that. If it's when returning
errno, then you can't use skb_share_check/skb_unshare here.

I assume the callback itself need to do that.

Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/bluetooth/6lowpan.c | 157 +++++++++++++++++++++++++++++-------------------
 1 file changed, 95 insertions(+), 62 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index d936e7d..72ccbbf 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -29,6 +29,11 @@
 
 #define VERSION "0.1"
 
+typedef unsigned __bitwise__ lowpan_rx_result;
+#define RX_CONTINUE		((__force lowpan_rx_result) 0u)
+#define RX_DROP_UNUSABLE	((__force lowpan_rx_result) 1u)
+#define RX_QUEUE		((__force lowpan_rx_result) 3u)
+
 static struct dentry *lowpan_enable_debugfs;
 static struct dentry *lowpan_control_debugfs;
 
@@ -257,13 +262,38 @@ static struct lowpan_dev *lookup_dev(struct l2cap_conn *conn)
 
 static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
 {
-	struct sk_buff *skb_cp;
+	skb->protocol = htons(ETH_P_IPV6);
+	skb->pkt_type = PACKET_HOST;
+
+	dev->stats.rx_bytes += skb->len;
+	dev->stats.rx_packets++;
+
+	return netif_rx(skb);
+}
 
-	skb_cp = skb_copy(skb, GFP_ATOMIC);
-	if (!skb_cp)
+static int lowpan_rx_handlers_result(struct sk_buff *skb,
+				     struct net_device *dev,
+				     lowpan_rx_result res)
+{
+	switch (res) {
+	case RX_CONTINUE:
+		/* nobody cared about this packet */
+		net_warn_ratelimited("%s: received unknown dispatch\n",
+				     __func__);
+
+		/* fall-through */
+	case RX_DROP_UNUSABLE:
+		kfree_skb(skb);
 		return NET_RX_DROP;
+	case RX_QUEUE:
+		return give_skb_to_upper(skb, dev);
+	default:
+		/* should never occur */
+		WARN_ON_ONCE(1);
+		break;
+	}
 
-	return netif_rx(skb_cp);
+	return NET_RX_DROP;
 }
 
 static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
@@ -287,82 +317,85 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
 	return lowpan_header_decompress(skb, netdev, daddr, saddr);
 }
 
-static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
-		    struct l2cap_chan *chan)
+static lowpan_rx_result lowpan_rx_h_iphc(struct sk_buff *skb,
+					 struct net_device *dev,
+					 struct l2cap_chan *chan)
 {
-	struct sk_buff *local_skb;
 	int ret;
 
-	if (!netif_running(dev))
-		goto drop;
-
-	if (dev->type != ARPHRD_6LOWPAN || !skb->len)
-		goto drop;
-
-	skb_reset_network_header(skb);
+	if (!lowpan_is_iphc(*skb_network_header(skb)))
+		return RX_CONTINUE;
 
-	skb = skb_share_check(skb, GFP_ATOMIC);
-	if (!skb)
-		goto drop;
-
-	/* check that it's our buffer */
-	if (lowpan_is_ipv6(*skb_network_header(skb))) {
-		/* Copy the packet so that the IPv6 header is
-		 * properly aligned.
-		 */
-		local_skb = skb_copy_expand(skb, NET_SKB_PAD - 1,
-					    skb_tailroom(skb), GFP_ATOMIC);
-		if (!local_skb)
-			goto drop;
+	ret = iphc_decompress(skb, dev, chan);
+	if (ret < 0)
+		return RX_DROP_UNUSABLE;
 
-		local_skb->protocol = htons(ETH_P_IPV6);
-		local_skb->pkt_type = PACKET_HOST;
+	return RX_QUEUE;
+}
 
-		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
+static lowpan_rx_result lowpan_rx_h_ipv6(struct sk_buff *skb,
+					 struct net_device *dev,
+					 struct l2cap_chan *chan)
+{
+	if (!lowpan_is_ipv6(*skb_network_header(skb)))
+		return RX_CONTINUE;
 
-		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
-			kfree_skb(local_skb);
-			goto drop;
-		}
+	/* Pull off the 1-byte of 6lowpan header. */
+	skb_pull(skb, 1);
+	return RX_QUEUE;
+}
 
-		dev->stats.rx_bytes += skb->len;
-		dev->stats.rx_packets++;
+static int lowpan_invoke_rx_handlers(struct sk_buff *skb,
+				     struct net_device *dev,
+				     struct l2cap_chan *chan)
+{
+	lowpan_rx_result res;
 
-		consume_skb(local_skb);
-		consume_skb(skb);
-	} else if (lowpan_is_iphc(*skb_network_header(skb))) {
-		local_skb = skb_clone(skb, GFP_ATOMIC);
-		if (!local_skb)
-			goto drop;
+#define CALL_RXH(rxh)			\
+	do {				\
+		res = rxh(skb, dev, chan); \
+		if (res != RX_CONTINUE)	\
+			goto rxh_next;	\
+	} while (0)
 
-		ret = iphc_decompress(local_skb, dev, chan);
-		if (ret < 0) {
-			kfree_skb(local_skb);
-			goto drop;
-		}
+	/* likely at first */
+	CALL_RXH(lowpan_rx_h_iphc);
+	CALL_RXH(lowpan_rx_h_ipv6);
 
-		local_skb->protocol = htons(ETH_P_IPV6);
-		local_skb->pkt_type = PACKET_HOST;
-		local_skb->dev = dev;
+rxh_next:
+	return lowpan_rx_handlers_result(skb, dev, res);
+}
 
-		if (give_skb_to_upper(local_skb, dev)
-				!= NET_RX_SUCCESS) {
-			kfree_skb(local_skb);
-			goto drop;
-		}
+static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
+		    struct l2cap_chan *chan)
+{
+	/* TODO check for reserved, nalp dispatch here? */
+	if (!netif_running(dev) ||
+	    dev->type != ARPHRD_6LOWPAN || !skb->len)
+		goto drop;
 
-		dev->stats.rx_bytes += skb->len;
-		dev->stats.rx_packets++;
+	/* we will manipulate the skb struct */
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		goto out;
 
-		consume_skb(local_skb);
-		consume_skb(skb);
-	} else {
-		goto drop;
+	/* TODO is this done by bluetooth callback, before? */
+	skb_reset_network_header(skb);
+	/* TODO really necessary? Previous did that in one branch only */
+	skb->dev = dev;
+
+	/* iphc will manipulate the skb buffer, unshare it */
+	if (lowpan_is_iphc(*skb_network_header(skb))) {
+		skb = skb_unshare(skb, GFP_ATOMIC);
+		if (!skb)
+			goto out;
 	}
 
-	return NET_RX_SUCCESS;
+	return lowpan_invoke_rx_handlers(skb, dev, chan);
 
 drop:
+	kfree_skb(skb);
+out:
 	dev->stats.rx_dropped++;
 	return NET_RX_DROP;
 }
-- 
2.6.1


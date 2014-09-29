Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: alex.aring@gmail.com
Subject: [PATCH 1/2] Bluetooth: 6lowpan: Ensure header compression does not corrupt IPv6 header
Date: Mon, 29 Sep 2014 16:37:25 +0300
Message-Id: <1411997846-23949-2-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1411997846-23949-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1411997846-23949-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If skb is going to multiple destinations, then make sure that we
do not overwrite the common IPv6 headers. So before compressing
the IPv6 headers, we copy the skb and that is then sent to 6LoWPAN
Bluetooth devices.

This is a similar patch as what was done for IEEE 802.154 6LoWPAN
in commit f19f4f9525cf3 ("ieee802154: 6lowpan: ensure header compression
does not corrupt ipv6 header")

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 137 +++++++++++++++++++++++++++++-------------------
 1 file changed, 84 insertions(+), 53 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 5d3e620..2ec7c84 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -426,38 +426,33 @@ static void convert_dest_bdaddr(struct in6_addr *ip6_daddr,
 	*addr_type = get_addr_type_from_eui64(addr->b[5]);
 }
 
-static int header_create(struct sk_buff *skb, struct net_device *netdev,
-		         unsigned short type, const void *_daddr,
-		         const void *_saddr, unsigned int len)
+static int setup_header(struct sk_buff *skb, struct net_device *netdev,
+			bdaddr_t *peer_addr, u8 *peer_addr_type)
 {
-	struct ipv6hdr *hdr;
+	struct in6_addr ipv6_daddr;
 	struct lowpan_dev *dev;
 	struct lowpan_peer *peer;
 	bdaddr_t addr, *any = BDADDR_ANY;
-	u8 *saddr, *daddr = any->b;
-	u8 addr_type;
-
-	if (type != ETH_P_IPV6)
-		return -EINVAL;
-
-	hdr = ipv6_hdr(skb);
+	u8 *daddr = any->b;
+	int err, status = 0;
 
 	dev = lowpan_dev(netdev);
 
-	if (ipv6_addr_is_multicast(&hdr->daddr)) {
-		memcpy(&lowpan_cb(skb)->addr, &hdr->daddr,
-		       sizeof(struct in6_addr));
+	memcpy(&ipv6_daddr, &lowpan_cb(skb)->addr, sizeof(ipv6_daddr));
+
+	if (ipv6_addr_is_multicast(&ipv6_daddr)) {
 		lowpan_cb(skb)->chan = NULL;
 	} else {
 		unsigned long flags;
+		u8 addr_type;
 
 		/* Get destination BT device from skb.
 		 * If there is no such peer then discard the packet.
 		 */
-		convert_dest_bdaddr(&hdr->daddr, &addr, &addr_type);
+		convert_dest_bdaddr(&ipv6_daddr, &addr, &addr_type);
 
 		BT_DBG("dest addr %pMR type %d IP %pI6c", &addr,
-		       addr_type, &hdr->daddr);
+		       addr_type, &ipv6_daddr);
 
 		read_lock_irqsave(&devices_lock, flags);
 		peer = peer_lookup_ba(dev, &addr, addr_type);
@@ -470,7 +465,7 @@ static int header_create(struct sk_buff *skb, struct net_device *netdev,
 			 * the destination address.
 			 */
 			read_lock_irqsave(&devices_lock, flags);
-			peer = peer_lookup_dst(dev, &hdr->daddr, skb);
+			peer = peer_lookup_dst(dev, &ipv6_daddr, skb);
 			read_unlock_irqrestore(&devices_lock, flags);
 			if (!peer) {
 				BT_DBG("no such peer %pMR found", &addr);
@@ -479,29 +474,56 @@ static int header_create(struct sk_buff *skb, struct net_device *netdev,
 		}
 
 		daddr = peer->eui64_addr;
-
-		memcpy(&lowpan_cb(skb)->addr, &hdr->daddr,
-		       sizeof(struct in6_addr));
+		*peer_addr = addr;
+		*peer_addr_type = addr_type;
 		lowpan_cb(skb)->chan = peer->chan;
+
+		status = 1;
 	}
 
-	saddr = dev->netdev->dev_addr;
+	lowpan_header_compress(skb, netdev, ETH_P_IPV6, daddr,
+			       dev->netdev->dev_addr, skb->len);
 
-	return lowpan_header_compress(skb, netdev, type, daddr, saddr, len);
+	err = dev_hard_header(skb, netdev, ETH_P_IPV6, NULL, NULL, 0);
+	if (err < 0)
+		return err;
+
+	return status;
+}
+
+static int header_create(struct sk_buff *skb, struct net_device *netdev,
+			 unsigned short type, const void *_daddr,
+			 const void *_saddr, unsigned int len)
+{
+	struct ipv6hdr *hdr;
+
+	if (type != ETH_P_IPV6)
+		return -EINVAL;
+
+	hdr = ipv6_hdr(skb);
+
+	memcpy(&lowpan_cb(skb)->addr, &hdr->daddr, sizeof(struct in6_addr));
+
+	return 0;
 }
 
 /* Packet to BT LE device */
 static int send_pkt(struct l2cap_chan *chan, struct sk_buff *skb,
-		    struct net_device *netdev)
+		    struct net_device *netdev, bool is_mcast)
 {
 	struct msghdr msg;
 	struct kvec iv;
 	int err;
 
 	/* Remember the skb so that we can send EAGAIN to the caller if
-	 * we run out of credits.
+	 * we run out of credits. This is not done for multicast packets
+	 * because we generate mcast packet in this module and are not
+	 * really able to remember the skb after this packet is sent.
 	 */
-	chan->data = skb;
+	if (is_mcast)
+		chan->data = NULL;
+	else
+		chan->data = skb;
 
 	memset(&msg, 0, sizeof(msg));
 	msg.msg_iov = (struct iovec *) &iv;
@@ -549,7 +571,11 @@ static void send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 		list_for_each_entry_safe(pentry, ptmp, &dev->peers, list) {
 			local_skb = skb_clone(skb, GFP_ATOMIC);
 
-			send_pkt(pentry->chan, local_skb, netdev);
+			BT_DBG("xmit %s to %pMR type %d IP %pI6c chan %p",
+			       netdev->name,
+			       &pentry->chan->dst, pentry->chan->dst_type,
+			       &pentry->peer_addr, pentry->chan);
+			send_pkt(pentry->chan, local_skb, netdev, true);
 
 			kfree_skb(local_skb);
 		}
@@ -561,43 +587,48 @@ static void send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	int err = 0;
-	struct lowpan_dev *dev;
-	struct lowpan_peer *peer;
 	bdaddr_t addr;
 	u8 addr_type;
 
-	if (ipv6_addr_is_multicast(&lowpan_cb(skb)->addr)) {
-		/* We need to send the packet to every device
-		 * behind this interface.
+	/* We must take a copy of the skb before we modify/replace the ipv6
+	 * header as the header could be used elsewhere
+	 */
+	skb = skb_unshare(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_XMIT_DROP;
+
+	/* Return values from setup_header()
+	 *  <0 - error, packet is dropped
+	 *   0 - this is a multicast packet
+	 *   1 - this is unicast packet
+	 */
+	err = setup_header(skb, netdev, &addr, &addr_type);
+	if (err < 0) {
+		kfree_skb(skb);
+		return NET_XMIT_DROP;
+	}
+
+	if (err) {
+		if (lowpan_cb(skb)->chan) {
+			BT_DBG("xmit %s to %pMR type %d IP %pI6c chan %p",
+			       netdev->name, &addr, addr_type,
+			       &lowpan_cb(skb)->addr, lowpan_cb(skb)->chan);
+			err = send_pkt(lowpan_cb(skb)->chan, skb, netdev,
+				       false);
+		} else {
+			err = -ENOENT;
+		}
+	} else {
+		/* We need to send the packet to every device behind this
+		 * interface.
 		 */
 		send_mcast_pkt(skb, netdev);
-	} else {
-		unsigned long flags;
-
-		convert_dest_bdaddr(&lowpan_cb(skb)->addr, &addr, &addr_type);
-		dev = lowpan_dev(netdev);
-
-		read_lock_irqsave(&devices_lock, flags);
-		peer = peer_lookup_ba(dev, &addr, addr_type);
-		if (!peer)
-			peer = peer_lookup_dst(dev, &lowpan_cb(skb)->addr, skb);
-		read_unlock_irqrestore(&devices_lock, flags);
-
-		BT_DBG("xmit %s to %pMR type %d IP %pI6c peer %p",
-		       netdev->name, &addr, addr_type,
-		       &lowpan_cb(skb)->addr, peer);
-
-		if (peer && peer->chan)
-			err = send_pkt(peer->chan, skb, netdev);
-		else
-			err = -ENOENT;
 	}
-	dev_kfree_skb(skb);
 
 	if (err)
 		BT_DBG("ERROR: xmit failed (%d)", err);
 
-	return (err < 0) ? NET_XMIT_DROP : err;
+	return err < 0 ? NET_XMIT_DROP : err;
 }
 
 static const struct net_device_ops netdev_ops = {
-- 
1.8.3.1


Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/8] Bluetooth: 6lowpan: Fix MAC address universal/local bit handling
Date: Fri, 23 May 2014 12:27:26 +0300
Message-Id: <1400837248-12179-7-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The universal/local bit handling was incorrectly done in the code.

So when setting EUI address from BD address we do this:
- If BD address type is PUBLIC, then we clear the universal bit
  in EUI address. If the address type is RANDOM, then the universal
  bit is set (BT 6lowpan draft chapter 3.2.2)
- After this we invert the universal/local bit according to RFC 2464

When figuring out BD address we do the reverse:
- Take EUI address from stateless IPv6 address, invert the
  universal/local bit according to RFC 2464
- If universal bit is 1 in this modified EUI address, then address
  type is set to RANDOM, otherwise it is PUBLIC

Note that 6lowpan_iphc.[ch] does the final toggling of U/L bit
before sending or receiving the network packet.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 65 ++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 3390b7b..46cc298 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -337,12 +337,18 @@ static int bt_6lowpan_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	return err;
 }
 
-static void get_dest_bdaddr(struct in6_addr *ip6_daddr,
-			    bdaddr_t *addr, u8 *addr_type)
+static u8 get_addr_type_from_eui64(u8 byte)
 {
-	u8 *eui64;
+	/* Is universal(0) or local(1) bit,  */
+	if (byte & 0x02)
+		return BDADDR_LE_RANDOM;
 
-	eui64 = ip6_daddr->s6_addr + 8;
+	return BDADDR_LE_PUBLIC;
+}
+
+static void copy_to_bdaddr(struct in6_addr *ip6_daddr, bdaddr_t *addr)
+{
+	u8 *eui64 = ip6_daddr->s6_addr + 8;
 
 	addr->b[0] = eui64[7];
 	addr->b[1] = eui64[6];
@@ -350,16 +356,19 @@ static void get_dest_bdaddr(struct in6_addr *ip6_daddr,
 	addr->b[3] = eui64[2];
 	addr->b[4] = eui64[1];
 	addr->b[5] = eui64[0];
+}
 
-	addr->b[5] ^= 2;
+static void convert_dest_bdaddr(struct in6_addr *ip6_daddr,
+				bdaddr_t *addr, u8 *addr_type)
+{
+	copy_to_bdaddr(ip6_daddr, addr);
 
-	/* Set universal/local bit to 0 */
-	if (addr->b[5] & 1) {
-		addr->b[5] &= ~1;
-		*addr_type = ADDR_LE_DEV_PUBLIC;
-	} else {
-		*addr_type = ADDR_LE_DEV_RANDOM;
-	}
+	/* We need to toggle the U/L bit that we got from IPv6 address
+	 * so that we get the proper address and type of the BD address.
+	 */
+	addr->b[5] ^= 0x02;
+
+	*addr_type = get_addr_type_from_eui64(addr->b[5]);
 }
 
 static int header_create(struct sk_buff *skb, struct net_device *netdev,
@@ -390,9 +399,11 @@ static int header_create(struct sk_buff *skb, struct net_device *netdev,
 		/* Get destination BT device from skb.
 		 * If there is no such peer then discard the packet.
 		 */
-		get_dest_bdaddr(&hdr->daddr, &addr, &addr_type);
+		convert_dest_bdaddr(&hdr->daddr, &addr, &addr_type);
 
-		BT_DBG("dest addr %pMR type %d", &addr, addr_type);
+		BT_DBG("dest addr %pMR type %s(%d) IP %pI6c", &addr,
+		       addr_type == BDADDR_LE_PUBLIC ? "PUBLIC" : "RANDOM",
+		       addr_type, &hdr->daddr);
 
 		read_lock_irqsave(&devices_lock, flags);
 		peer = peer_lookup_ba(dev, &addr, addr_type);
@@ -489,15 +500,17 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
 	} else {
 		unsigned long flags;
 
-		get_dest_bdaddr(&lowpan_cb(skb)->addr, &addr, &addr_type);
+		convert_dest_bdaddr(&lowpan_cb(skb)->addr, &addr, &addr_type);
 		dev = lowpan_dev(netdev);
 
 		read_lock_irqsave(&devices_lock, flags);
 		peer = peer_lookup_ba(dev, &addr, addr_type);
 		read_unlock_irqrestore(&devices_lock, flags);
 
-		BT_DBG("xmit from %s to %pMR (%pI6c) peer %p", netdev->name,
-		       &addr, &lowpan_cb(skb)->addr, peer);
+		BT_DBG("xmit %s to %pMR type %s(%d) IP %pI6c peer %p",
+		       netdev->name, &addr,
+		       addr_type == BDADDR_LE_PUBLIC ? "PUBLIC" : "RANDOM",
+		       addr_type, &lowpan_cb(skb)->addr, peer);
 
 		if (peer && peer->chan)
 			err = send_pkt(peer->chan, skb, netdev);
@@ -553,13 +566,11 @@ static void set_addr(u8 *eui, u8 *addr, u8 addr_type)
 	eui[6] = addr[1];
 	eui[7] = addr[0];
 
-	eui[0] ^= 2;
-
-	/* Universal/local bit set, RFC 4291 */
-	if (addr_type == ADDR_LE_DEV_PUBLIC)
-		eui[0] |= 1;
+	/* Universal/local bit set, BT 6lowpan draft ch. 3.2.1 */
+	if (addr_type == BDADDR_LE_PUBLIC)
+		eui[0] &= ~2;
 	else
-		eui[0] &= ~1;
+		eui[0] |= 2;
 }
 
 static void set_dev_addr(struct net_device *netdev, bdaddr_t *addr,
@@ -567,7 +578,6 @@ static void set_dev_addr(struct net_device *netdev, bdaddr_t *addr,
 {
 	netdev->addr_assign_type = NET_ADDR_PERM;
 	set_addr(netdev->dev_addr, addr->b, addr_type);
-	netdev->dev_addr[0] ^= 2;
 }
 
 static void ifup(struct net_device *netdev)
@@ -637,13 +647,6 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
 
 	memcpy(&peer->eui64_addr, (u8 *)&peer->peer_addr.s6_addr + 8,
 	       EUI64_ADDR_LEN);
-	peer->eui64_addr[0] ^= 2; /* second bit-flip (Universe/Local)
-				   * is done according RFC2464
-				   */
-
-	raw_dump_inline(__func__, "peer IPv6 address",
-			(unsigned char *)&peer->peer_addr, 16);
-	raw_dump_inline(__func__, "peer EUI64 address", peer->eui64_addr, 8);
 
 	write_lock_irqsave(&devices_lock, flags);
 	INIT_LIST_HEAD(&peer->list);
-- 
1.8.3.1


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de
Subject: [PATCH 5/5] 6lowpan: Use netdev addr_len to determine lladdr len
Date: Thu,  9 Feb 2017 16:55:51 +0200
Message-Id: <20170209145551.12747-6-luiz.dentz@gmail.com>
In-Reply-To: <20170209145551.12747-1-luiz.dentz@gmail.com>
References: <20170209145551.12747-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This allow technologies such as Bluetooth to use its native lladdr which
is eui48 instead of eui64 which was expected by functions like
lowpan_header_decompress and lowpan_header_compress.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/6lowpan/iphc.c      | 17 +++++++++++++++--
 net/bluetooth/6lowpan.c | 43 ++++++++++---------------------------------
 2 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index fb5f6fa..ee88feb 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -827,8 +827,21 @@ static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct net_device *dev,
 		}
 		break;
 	default:
-		/* check for SAM/DAM = 11 */
-		memcpy(&tmp.s6_addr[8], lladdr, EUI64_ADDR_LEN);
+		switch (dev->addr_len) {
+		case ETH_ALEN:
+			memcpy(&tmp.s6_addr[8], lladdr, 3);
+			tmp.s6_addr[11] = 0xFF;
+			tmp.s6_addr[12] = 0xFE;
+			memcpy(&tmp.s6_addr[13], lladdr + 3, 3);
+			break;
+		case EUI64_ADDR_LEN:
+			memcpy(&tmp.s6_addr[8], lladdr, EUI64_ADDR_LEN);
+			break;
+		default:
+			dam = LOWPAN_IPHC_DAM_11;
+			goto out;
+		}
+
 		/* second bit-flip (Universe/Local) is done according RFC2464 */
 		tmp.s6_addr[8] ^= 0x02;
 		/* context information are always used */
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 1456b01..d2a1aa5 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -64,7 +64,7 @@ struct lowpan_peer {
 	struct l2cap_chan *chan;
 
 	/* peer addresses in various formats */
-	unsigned char eui64_addr[EUI64_ADDR_LEN];
+	unsigned char lladdr[ETH_ALEN];
 	struct in6_addr peer_addr;
 };
 
@@ -80,8 +80,6 @@ struct lowpan_btle_dev {
 	struct delayed_work notify_peers;
 };
 
-static void set_addr(u8 *eui, u8 *addr, u8 addr_type);
-
 static inline struct lowpan_btle_dev *
 lowpan_btle_dev(const struct net_device *netdev)
 {
@@ -277,7 +275,6 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
 	const u8 *saddr;
 	struct lowpan_btle_dev *dev;
 	struct lowpan_peer *peer;
-	unsigned char eui64_daddr[EUI64_ADDR_LEN];
 
 	dev = lowpan_btle_dev(netdev);
 
@@ -287,10 +284,9 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
 	if (!peer)
 		return -EINVAL;
 
-	saddr = peer->eui64_addr;
-	set_addr(&eui64_daddr[0], chan->src.b, chan->src_type);
+	saddr = peer->lladdr;
 
-	return lowpan_header_decompress(skb, netdev, &eui64_daddr, saddr);
+	return lowpan_header_decompress(skb, netdev, netdev->dev_addr, saddr);
 }
 
 static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
@@ -477,7 +473,7 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 			}
 		}
 
-		daddr = peer->eui64_addr;
+		daddr = peer->lladdr;
 		*peer_addr = addr;
 		*peer_addr_type = addr_type;
 		lowpan_cb(skb)->chan = peer->chan;
@@ -663,27 +659,6 @@ static struct device_type bt_type = {
 	.name	= "bluetooth",
 };
 
-static void set_addr(u8 *eui, u8 *addr, u8 addr_type)
-{
-	/* addr is the BT address in little-endian format */
-	eui[0] = addr[5];
-	eui[1] = addr[4];
-	eui[2] = addr[3];
-	eui[3] = 0xFF;
-	eui[4] = 0xFE;
-	eui[5] = addr[2];
-	eui[6] = addr[1];
-	eui[7] = addr[0];
-
-	/* Universal/local bit set, BT 6lowpan draft ch. 3.2.1 */
-	if (addr_type == BDADDR_LE_PUBLIC)
-		eui[0] &= ~0x02;
-	else
-		eui[0] |= 0x02;
-
-	BT_DBG("type %d addr %*phC", addr_type, 8, eui);
-}
-
 static void ifup(struct net_device *netdev)
 {
 	int err;
@@ -762,14 +737,16 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
 	peer->chan = chan;
 	memset(&peer->peer_addr, 0, sizeof(struct in6_addr));
 
+	baswap((void *)peer->lladdr, &chan->dst);
+
 	/* RFC 2464 ch. 5 */
 	peer->peer_addr.s6_addr[0] = 0xFE;
 	peer->peer_addr.s6_addr[1] = 0x80;
-	set_addr((u8 *)&peer->peer_addr.s6_addr + 8, chan->dst.b,
-		 chan->dst_type);
 
-	memcpy(&peer->eui64_addr, (u8 *)&peer->peer_addr.s6_addr + 8,
-	       EUI64_ADDR_LEN);
+	memcpy(&peer->peer_addr.s6_addr[8], peer->lladdr, 3);
+	peer->peer_addr.s6_addr[11] = 0xFF;
+	peer->peer_addr.s6_addr[12] = 0xFE;
+	memcpy(&peer->peer_addr.s6_addr[13], peer->lladdr + 3, 3);
 
 	/* IPv6 address needs to have the U/L bit set properly so toggle
 	 * it back here.
-- 
2.9.3


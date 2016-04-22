Return-Path: <glennrubenbakke@nordicsemi.no>
From: Glenn Ruben Bakke <glennrubenbakke@nordicsemi.no>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <jukka.rissanen@linux.intel.com>, Glenn
 Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
Subject: [PATCH] Bluetooth: 6lowpan: Fix memory corruption of ipv6 destination address
Date: Fri, 22 Apr 2016 18:06:11 +0200
Message-ID: <1461341171-2951-1-git-send-email-glennrubenbakke@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

The memcpy of ipv6 header destination address to the skb control block
(sbk->cb) in header_create() results in currupted memory when bt_xmit()
is issued. The skb->cb is "released" in the return of header_create()
making room for lower layer to minipulate the skb->cb.

The value retrieved in bt_xmit is not persistent across header creation
and sending, and the lower layer will overwrite portions of skb->cb,
making the copied destination address wrong.

The memory corruption will lead to non-working multicast as the first 4
bytes of the copied destination address is replaced by a value that
resolves into a non-multicast prefix.

The issue has also been observed in kernel 4.5.

This fix removes the dependency on the skb control block between header
creation and send, by moving the destination address memcpy to the send
function path (setup_create, which is called from bt_xmit).

Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
---
 net/bluetooth/6lowpan.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 38e82dd..780089d 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -434,15 +434,18 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 			bdaddr_t *peer_addr, u8 *peer_addr_type)
 {
 	struct in6_addr ipv6_daddr;
+	struct ipv6hdr *hdr;
 	struct lowpan_btle_dev *dev;
 	struct lowpan_peer *peer;
 	bdaddr_t addr, *any = BDADDR_ANY;
 	u8 *daddr = any->b;
 	int err, status = 0;
 
+	hdr = ipv6_hdr(skb);
+
 	dev = lowpan_btle_dev(netdev);
 
-	memcpy(&ipv6_daddr, &lowpan_cb(skb)->addr, sizeof(ipv6_daddr));
+	memcpy(&ipv6_daddr, &hdr->daddr, sizeof(ipv6_daddr));
 
 	if (ipv6_addr_is_multicast(&ipv6_daddr)) {
 		lowpan_cb(skb)->chan = NULL;
@@ -492,15 +495,9 @@ static int header_create(struct sk_buff *skb, struct net_device *netdev,
 			 unsigned short type, const void *_daddr,
 			 const void *_saddr, unsigned int len)
 {
-	struct ipv6hdr *hdr;
-
 	if (type != ETH_P_IPV6)
 		return -EINVAL;
 
-	hdr = ipv6_hdr(skb);
-
-	memcpy(&lowpan_cb(skb)->addr, &hdr->daddr, sizeof(struct in6_addr));
-
 	return 0;
 }
 
-- 
2.5.0

Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Cc: alex.aring@gmail.com
Subject: [PATCH 2/5] 6lowpan: iphc: Fix issues with alignment matching open parenthesis
Date: Wed, 30 Jul 2014 03:48:41 +0200
Message-Id: <1406684924-40906-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes all the issues with alignment matching of open
parenthesis found by checkpatch.pl and makes them follow the
network coding style now.

CHECK: Alignment should match open parenthesis
+static int uncompress_addr(struct sk_buff *skb,
+				struct in6_addr *ipaddr, const u8 address_mode,

CHECK: Alignment should match open parenthesis
+static int uncompress_context_based_src_addr(struct sk_buff *skb,
+						struct in6_addr *ipaddr,

CHECK: Alignment should match open parenthesis
+static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
+		struct net_device *dev, skb_delivery_cb deliver_skb)

CHECK: Alignment should match open parenthesis
+	new = skb_copy_expand(skb, sizeof(struct ipv6hdr), skb_tailroom(skb),
+								GFP_ATOMIC);

CHECK: Alignment should match open parenthesis
+	raw_dump_table(__func__, "raw skb data dump before receiving",
+			new->data, new->len);

CHECK: Alignment should match open parenthesis
+lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
+		struct in6_addr *ipaddr,

CHECK: Alignment should match open parenthesis
+	raw_dump_inline(NULL, "Reconstructed ipv6 multicast addr is",
+				ipaddr->s6_addr, 16);

CHECK: Alignment should match open parenthesis
+int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
+		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,

CHECK: Alignment should match open parenthesis
+	raw_dump_table(__func__, "raw skb data dump uncompressed",
+				skb->data, skb->len);

CHECK: Alignment should match open parenthesis
+		err = uncompress_addr(skb, &hdr.saddr, tmp, saddr,
+					saddr_type, saddr_len);

CHECK: Alignment should match open parenthesis
+		err = uncompress_addr(skb, &hdr.daddr, tmp, daddr,
+					daddr_type, daddr_len);

CHECK: Alignment should match open parenthesis
+		pr_debug("dest: stateless compression mode %d dest %pI6c\n",
+			tmp, &hdr.daddr);

CHECK: Alignment should match open parenthesis
+		raw_dump_table(__func__, "raw UDP header dump",
+				      (u8 *)&uh, sizeof(uh));

CHECK: Alignment should match open parenthesis
+	raw_dump_table(__func__, "raw header dump", (u8 *)&hdr,
+							sizeof(hdr));

CHECK: Alignment should match open parenthesis
+int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
+			unsigned short type, const void *_daddr,

CHECK: Alignment should match open parenthesis
+	raw_dump_table(__func__, "raw skb network header dump",
+		skb_network_header(skb), sizeof(struct ipv6hdr));

CHECK: Alignment should match open parenthesis
+	raw_dump_table(__func__,
+			"sending raw skb network uncompressed packet",

CHECK: Alignment should match open parenthesis
+	if (((hdr->flow_lbl[0] & 0x0F) == 0) &&
+	     (hdr->flow_lbl[1] == 0) && (hdr->flow_lbl[2] == 0)) {

WARNING: quoted string split across lines
+			pr_debug("dest address unicast link-local %pI6c "
+				"iphc1 0x%02x\n", &hdr->daddr, iphc1);

CHECK: Alignment should match open parenthesis
+	raw_dump_table(__func__, "raw skb data dump compressed",
+				skb->data, skb->len);

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/6lowpan/iphc.c | 74 ++++++++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 39 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 3069eb615ace..c718253a4e07 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -63,9 +63,9 @@
  * address_mode is sam value or dam value.
  */
 static int uncompress_addr(struct sk_buff *skb,
-				struct in6_addr *ipaddr, const u8 address_mode,
-				const u8 *lladdr, const u8 addr_type,
-				const u8 addr_len)
+			   struct in6_addr *ipaddr, const u8 address_mode,
+			   const u8 *lladdr, const u8 addr_type,
+			   const u8 addr_len)
 {
 	bool fail;
 
@@ -142,8 +142,8 @@ static int uncompress_addr(struct sk_buff *skb,
  * based address(non-multicast).
  */
 static int uncompress_context_based_src_addr(struct sk_buff *skb,
-						struct in6_addr *ipaddr,
-						const u8 sam)
+					     struct in6_addr *ipaddr,
+					     const u8 sam)
 {
 	switch (sam) {
 	case LOWPAN_IPHC_ADDR_00:
@@ -172,13 +172,13 @@ static int uncompress_context_based_src_addr(struct sk_buff *skb,
 }
 
 static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
-		struct net_device *dev, skb_delivery_cb deliver_skb)
+		       struct net_device *dev, skb_delivery_cb deliver_skb)
 {
 	struct sk_buff *new;
 	int stat;
 
 	new = skb_copy_expand(skb, sizeof(struct ipv6hdr), skb_tailroom(skb),
-								GFP_ATOMIC);
+			      GFP_ATOMIC);
 	kfree_skb(skb);
 
 	if (!new)
@@ -193,7 +193,7 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
 	new->dev = dev;
 
 	raw_dump_table(__func__, "raw skb data dump before receiving",
-			new->data, new->len);
+		       new->data, new->len);
 
 	stat = deliver_skb(new, dev);
 
@@ -205,10 +205,9 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
 /* Uncompress function for multicast destination address,
  * when M bit is set.
  */
-static int
-lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
-		struct in6_addr *ipaddr,
-		const u8 dam)
+static int lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
+					     struct in6_addr *ipaddr,
+					     const u8 dam)
 {
 	bool fail;
 
@@ -254,13 +253,12 @@ lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
 	}
 
 	raw_dump_inline(NULL, "Reconstructed ipv6 multicast addr is",
-				ipaddr->s6_addr, 16);
+			ipaddr->s6_addr, 16);
 
 	return 0;
 }
 
-static int
-uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
+static int uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
 {
 	bool fail;
 	u8 tmp = 0, val = 0;
@@ -336,16 +334,16 @@ err:
 static const u8 lowpan_ttl_values[] = { 0, 1, 64, 255 };
 
 int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
-		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
-		const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
-		u8 iphc0, u8 iphc1, skb_delivery_cb deliver_skb)
+			const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
+			const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
+			u8 iphc0, u8 iphc1, skb_delivery_cb deliver_skb)
 {
 	struct ipv6hdr hdr = {};
 	u8 tmp, num_context = 0;
 	int err;
 
 	raw_dump_table(__func__, "raw skb data dump uncompressed",
-				skb->data, skb->len);
+		       skb->data, skb->len);
 
 	/* another if the CID flag is set */
 	if (iphc1 & LOWPAN_IPHC_CID) {
@@ -424,13 +422,12 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	if (iphc1 & LOWPAN_IPHC_SAC) {
 		/* Source address context based uncompression */
 		pr_debug("SAC bit is set. Handle context based source address.\n");
-		err = uncompress_context_based_src_addr(
-				skb, &hdr.saddr, tmp);
+		err = uncompress_context_based_src_addr(skb, &hdr.saddr, tmp);
 	} else {
 		/* Source address uncompression */
 		pr_debug("source address stateless compression\n");
 		err = uncompress_addr(skb, &hdr.saddr, tmp, saddr,
-					saddr_type, saddr_len);
+				      saddr_type, saddr_len);
 	}
 
 	/* Check on error of previous branch */
@@ -446,16 +443,17 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 			pr_debug("dest: context-based mcast compression\n");
 			/* TODO: implement this */
 		} else {
-			err = lowpan_uncompress_multicast_daddr(
-						skb, &hdr.daddr, tmp);
+			err = lowpan_uncompress_multicast_daddr(skb, &hdr.daddr,
+								tmp);
+
 			if (err)
 				goto drop;
 		}
 	} else {
 		err = uncompress_addr(skb, &hdr.daddr, tmp, daddr,
-					daddr_type, daddr_len);
+				      daddr_type, daddr_len);
 		pr_debug("dest: stateless compression mode %d dest %pI6c\n",
-			tmp, &hdr.daddr);
+			 tmp, &hdr.daddr);
 		if (err)
 			goto drop;
 	}
@@ -484,7 +482,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		skb_copy_to_linear_data(skb, &uh, sizeof(struct udphdr));
 
 		raw_dump_table(__func__, "raw UDP header dump",
-				      (u8 *)&uh, sizeof(uh));
+			       (u8 *)&uh, sizeof(uh));
 
 		hdr.nexthdr = UIP_PROTO_UDP;
 	}
@@ -499,8 +497,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		hdr.version, ntohs(hdr.payload_len), hdr.nexthdr,
 		hdr.hop_limit, &hdr.daddr);
 
-	raw_dump_table(__func__, "raw header dump", (u8 *)&hdr,
-							sizeof(hdr));
+	raw_dump_table(__func__, "raw header dump", (u8 *)&hdr, sizeof(hdr));
 
 	return skb_deliver(skb, &hdr, dev, deliver_skb);
 
@@ -594,8 +591,8 @@ static void compress_udp_header(u8 **hc_ptr, struct sk_buff *skb)
 }
 
 int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
-			unsigned short type, const void *_daddr,
-			const void *_saddr, unsigned int len)
+			   unsigned short type, const void *_daddr,
+			   const void *_saddr, unsigned int len)
 {
 	u8 tmp, iphc0, iphc1, *hc_ptr;
 	struct ipv6hdr *hdr;
@@ -610,11 +607,11 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 
 	pr_debug("IPv6 header dump:\n\tversion = %d\n\tlength  = %d\n"
 		 "\tnexthdr = 0x%02x\n\thop_lim = %d\n\tdest    = %pI6c\n",
-		hdr->version, ntohs(hdr->payload_len), hdr->nexthdr,
-		hdr->hop_limit, &hdr->daddr);
+		 hdr->version, ntohs(hdr->payload_len), hdr->nexthdr,
+		 hdr->hop_limit, &hdr->daddr);
 
 	raw_dump_table(__func__, "raw skb network header dump",
-		skb_network_header(skb), sizeof(struct ipv6hdr));
+		       skb_network_header(skb), sizeof(struct ipv6hdr));
 
 	/* As we copy some bit-length fields, in the IPHC encoding bytes,
 	 * we sometimes use |=
@@ -631,9 +628,8 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 	raw_dump_inline(__func__, "daddr",
 			(unsigned char *)_daddr, IEEE802154_ADDR_LEN);
 
-	raw_dump_table(__func__,
-			"sending raw skb network uncompressed packet",
-			skb->data, skb->len);
+	raw_dump_table(__func__, "sending raw skb network uncompressed packet",
+		       skb->data, skb->len);
 
 	/* Traffic class, flow label
 	 * If flow label is 0, compress it. If traffic class is 0, compress it
@@ -763,7 +759,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			iphc1 |= lowpan_compress_addr_64(&hc_ptr,
 				LOWPAN_IPHC_DAM_BIT, &hdr->daddr, _daddr);
 			pr_debug("dest address unicast link-local %pI6c "
-				"iphc1 0x%02x\n", &hdr->daddr, iphc1);
+				 "iphc1 0x%02x\n", &hdr->daddr, iphc1);
 		} else {
 			pr_debug("dest address unicast %pI6c\n", &hdr->daddr);
 			lowpan_push_hc_data(&hc_ptr, hdr->daddr.s6_addr, 16);
@@ -785,7 +781,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 	pr_debug("header len %d skb %u\n", (int)(hc_ptr - head), skb->len);
 
 	raw_dump_table(__func__, "raw skb data dump compressed",
-				skb->data, skb->len);
+		       skb->data, skb->len);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(lowpan_header_compress);
-- 
1.9.3


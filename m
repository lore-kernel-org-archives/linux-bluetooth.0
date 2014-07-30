Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Cc: alex.aring@gmail.com
Subject: [PATCH 1/5] 6lowpan: iphc: Fix block comments to match networking style
Date: Wed, 30 Jul 2014 03:48:40 +0200
Message-Id: <1406684924-40906-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes all the block comment issues found by checkpatch.pl and
makes them match the network style now.

WARNING: networking block comments don't use an empty /* line, use /* Comment...
+/*
+ * Based on patches from Jon Smirl <jonsmirl@gmail.com>

WARNING: networking block comments don't use an empty /* line, use /* Comment...
+/*
+ * Uncompress address function for source and

WARNING: networking block comments don't use an empty /* line, use /* Comment...
+/*
+ * Uncompress address function for source context

WARNING: networking block comments don't use an empty /* line, use /* Comment...
+		/*
+		 * UDP lenght needs to be infered from the lower layers

WARNING: networking block comments don't use an empty /* line, use /* Comment...
+	/*
+	 * Traffic Class and FLow Label carried in-line

WARNING: networking block comments don't use an empty /* line, use /* Comment...
+	/*
+	 * Traffic class carried in-line

WARNING: networking block comments don't use an empty /* line, use /* Comment...
+	/*
+	 * Flow Label carried in-line

WARNING: networking block comments don't use an empty /* line, use /* Comment...
+		/*
+		 * replace the compressed UDP head by the uncompressed UDP

WARNING: networking block comments don't use an empty /* line, use /* Comment...
+	/*
+	 * As we copy some bit-length fields, in the IPHC encoding bytes,

WARNING: networking block comments don't use an empty /* line, use /* Comment...
+	/*
+	 * Traffic class, flow label

WARNING: networking block comments don't use an empty /* line, use /* Comment...
+	/*
+	 * Hop limit

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/6lowpan/iphc.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index de78deb49959..3069eb615ace 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -3,8 +3,7 @@
  * written by Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
  */
 
-/*
- * Based on patches from Jon Smirl <jonsmirl@gmail.com>
+/* Based on patches from Jon Smirl <jonsmirl@gmail.com>
  * Copyright (c) 2011 Jon Smirl <jonsmirl@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -58,8 +57,7 @@
 #include <net/ipv6.h>
 #include <net/af_ieee802154.h>
 
-/*
- * Uncompress address function for source and
+/* Uncompress address function for source and
  * destination address(non-multicast).
  *
  * address_mode is sam value or dam value.
@@ -140,8 +138,7 @@ static int uncompress_addr(struct sk_buff *skb,
 	return 0;
 }
 
-/*
- * Uncompress address function for source context
+/* Uncompress address function for source context
  * based address(non-multicast).
  */
 static int uncompress_context_based_src_addr(struct sk_buff *skb,
@@ -316,8 +313,7 @@ uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
 						 sizeof(uh->check));
 		}
 
-		/*
-		 * UDP lenght needs to be infered from the lower layers
+		/* UDP length needs to be infered from the lower layers
 		 * here, we obtain the hint from the remaining size of the
 		 * frame
 		 */
@@ -362,8 +358,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 
 	/* Traffic Class and Flow Label */
 	switch ((iphc0 & LOWPAN_IPHC_TF) >> 3) {
-	/*
-	 * Traffic Class and FLow Label carried in-line
+	/* Traffic Class and FLow Label carried in-line
 	 * ECN + DSCP + 4-bit Pad + Flow Label (4 bytes)
 	 */
 	case 0: /* 00b */
@@ -376,8 +371,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		hdr.flow_lbl[0] = ((tmp >> 2) & 0x30) | (tmp << 6) |
 					(hdr.flow_lbl[0] & 0x0f);
 		break;
-	/*
-	 * Traffic class carried in-line
+	/* Traffic class carried in-line
 	 * ECN + DSCP (1 byte), Flow Label is elided
 	 */
 	case 2: /* 10b */
@@ -387,8 +381,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		hdr.priority = ((tmp >> 2) & 0x0f);
 		hdr.flow_lbl[0] = ((tmp << 6) & 0xC0) | ((tmp >> 2) & 0x30);
 		break;
-	/*
-	 * Flow Label carried in-line
+	/* Flow Label carried in-line
 	 * ECN + 2-bit Pad + Flow Label (3 bytes), DSCP is elided
 	 */
 	case 1: /* 01b */
@@ -474,8 +467,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		if (uncompress_udp_header(skb, &uh))
 			goto drop;
 
-		/*
-		 * replace the compressed UDP head by the uncompressed UDP
+		/* replace the compressed UDP head by the uncompressed UDP
 		 * header
 		 */
 		new = skb_copy_expand(skb, sizeof(struct udphdr),
@@ -624,8 +616,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 	raw_dump_table(__func__, "raw skb network header dump",
 		skb_network_header(skb), sizeof(struct ipv6hdr));
 
-	/*
-	 * As we copy some bit-length fields, in the IPHC encoding bytes,
+	/* As we copy some bit-length fields, in the IPHC encoding bytes,
 	 * we sometimes use |=
 	 * If the field is 0, and the current bit value in memory is 1,
 	 * this does not work. We therefore reset the IPHC encoding here
@@ -644,8 +635,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			"sending raw skb network uncompressed packet",
 			skb->data, skb->len);
 
-	/*
-	 * Traffic class, flow label
+	/* Traffic class, flow label
 	 * If flow label is 0, compress it. If traffic class is 0, compress it
 	 * We have to process both in the same time as the offset of traffic
 	 * class depends on the presence of version and flow label
@@ -696,8 +686,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 		lowpan_push_hc_data(&hc_ptr, &hdr->nexthdr,
 				    sizeof(hdr->nexthdr));
 
-	/*
-	 * Hop limit
+	/* Hop limit
 	 * if 1:   compress, encoding is 01
 	 * if 64:  compress, encoding is 10
 	 * if 255: compress, encoding is 11
-- 
1.9.3


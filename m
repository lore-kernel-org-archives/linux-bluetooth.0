Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: marcel@holtmann.org
Cc: jukka.rissanen@linux.intel.com,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/7] 6lowpan: iphc: rename hc06_ptr pointer to hc_ptr
Date: Tue, 29 Jul 2014 23:46:58 +0200
Message-Id: <1406670424-15596-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
References: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The hc06_ptr pointer variable stands for header compression draft-06. We
are mostly rfc complaint. This patch rename the variable to normal hc_ptr.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/iphc.c | 112 ++++++++++++++++++++++++++---------------------------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 211b568..a13eae5 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -515,9 +515,9 @@ drop:
 }
 EXPORT_SYMBOL_GPL(lowpan_process_data);
 
-static u8 lowpan_compress_addr_64(u8 **hc06_ptr, u8 shift,
-				const struct in6_addr *ipaddr,
-				const unsigned char *lladdr)
+static u8 lowpan_compress_addr_64(u8 **hc_ptr, u8 shift,
+				  const struct in6_addr *ipaddr,
+				  const unsigned char *lladdr)
 {
 	u8 val = 0;
 
@@ -526,24 +526,24 @@ static u8 lowpan_compress_addr_64(u8 **hc06_ptr, u8 shift,
 		pr_debug("address compression 0 bits\n");
 	} else if (lowpan_is_iid_16_bit_compressable(ipaddr)) {
 		/* compress IID to 16 bits xxxx::XXXX */
-		memcpy(*hc06_ptr, &ipaddr->s6_addr16[7], 2);
-		*hc06_ptr += 2;
+		memcpy(*hc_ptr, &ipaddr->s6_addr16[7], 2);
+		*hc_ptr += 2;
 		val = 2; /* 16-bits */
 		raw_dump_inline(NULL, "Compressed ipv6 addr is (16 bits)",
-			*hc06_ptr - 2, 2);
+				*hc_ptr - 2, 2);
 	} else {
 		/* do not compress IID => xxxx::IID */
-		memcpy(*hc06_ptr, &ipaddr->s6_addr16[4], 8);
-		*hc06_ptr += 8;
+		memcpy(*hc_ptr, &ipaddr->s6_addr16[4], 8);
+		*hc_ptr += 8;
 		val = 1; /* 64-bits */
 		raw_dump_inline(NULL, "Compressed ipv6 addr is (64 bits)",
-			*hc06_ptr - 8, 8);
+				*hc_ptr - 8, 8);
 	}
 
 	return rol8(val, shift);
 }
 
-static void compress_udp_header(u8 **hc06_ptr, struct sk_buff *skb)
+static void compress_udp_header(u8 **hc_ptr, struct sk_buff *skb)
 {
 	struct udphdr *uh = udp_hdr(skb);
 	u8 tmp;
@@ -555,46 +555,46 @@ static void compress_udp_header(u8 **hc06_ptr, struct sk_buff *skb)
 		pr_debug("UDP header: both ports compression to 4 bits\n");
 		/* compression value */
 		tmp = LOWPAN_NHC_UDP_CS_P_11;
-		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
 		/* source and destination port */
 		tmp = ntohs(uh->dest) - LOWPAN_NHC_UDP_4BIT_PORT +
 		      ((ntohs(uh->source) - LOWPAN_NHC_UDP_4BIT_PORT) << 4);
-		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
 	} else if ((ntohs(uh->dest) & LOWPAN_NHC_UDP_8BIT_MASK) ==
 			LOWPAN_NHC_UDP_8BIT_PORT) {
 		pr_debug("UDP header: remove 8 bits of dest\n");
 		/* compression value */
 		tmp = LOWPAN_NHC_UDP_CS_P_01;
-		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
 		/* source port */
-		lowpan_push_hc_data(hc06_ptr, &uh->source, sizeof(uh->source));
+		lowpan_push_hc_data(hc_ptr, &uh->source, sizeof(uh->source));
 		/* destination port */
 		tmp = ntohs(uh->dest) - LOWPAN_NHC_UDP_8BIT_PORT;
-		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
 	} else if ((ntohs(uh->source) & LOWPAN_NHC_UDP_8BIT_MASK) ==
 			LOWPAN_NHC_UDP_8BIT_PORT) {
 		pr_debug("UDP header: remove 8 bits of source\n");
 		/* compression value */
 		tmp = LOWPAN_NHC_UDP_CS_P_10;
-		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
 		/* source port */
 		tmp = ntohs(uh->source) - LOWPAN_NHC_UDP_8BIT_PORT;
-		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
 		/* destination port */
-		lowpan_push_hc_data(hc06_ptr, &uh->dest, sizeof(uh->dest));
+		lowpan_push_hc_data(hc_ptr, &uh->dest, sizeof(uh->dest));
 	} else {
 		pr_debug("UDP header: can't compress\n");
 		/* compression value */
 		tmp = LOWPAN_NHC_UDP_CS_P_00;
-		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
 		/* source port */
-		lowpan_push_hc_data(hc06_ptr, &uh->source, sizeof(uh->source));
+		lowpan_push_hc_data(hc_ptr, &uh->source, sizeof(uh->source));
 		/* destination port */
-		lowpan_push_hc_data(hc06_ptr, &uh->dest, sizeof(uh->dest));
+		lowpan_push_hc_data(hc_ptr, &uh->dest, sizeof(uh->dest));
 	}
 
 	/* checksum is always inline */
-	lowpan_push_hc_data(hc06_ptr, &uh->check, sizeof(uh->check));
+	lowpan_push_hc_data(hc_ptr, &uh->check, sizeof(uh->check));
 
 	/* skip the UDP header */
 	skb_pull(skb, sizeof(struct udphdr));
@@ -604,7 +604,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			unsigned short type, const void *_daddr,
 			const void *_saddr, unsigned int len)
 {
-	u8 tmp, iphc0, iphc1, *hc06_ptr;
+	u8 tmp, iphc0, iphc1, *hc_ptr;
 	struct ipv6hdr *hdr;
 	u8 head[100] = {};
 
@@ -612,7 +612,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 		return -EINVAL;
 
 	hdr = ipv6_hdr(skb);
-	hc06_ptr = head + 2;
+	hc_ptr = head + 2;
 
 	pr_debug("IPv6 header dump:\n\tversion = %d\n\tlength  = %d\n"
 		 "\tnexthdr = 0x%02x\n\thop_lim = %d\n\tdest    = %pI6c\n",
@@ -649,7 +649,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 	 * class depends on the presence of version and flow label
 	 */
 
-	/* hc06 format of TC is ECN | DSCP , original one is DSCP | ECN */
+	/* hc format of TC is ECN | DSCP , original one is DSCP | ECN */
 	tmp = (hdr->priority << 4) | (hdr->flow_lbl[0] >> 4);
 	tmp = ((tmp & 0x03) << 6) | (tmp >> 2);
 
@@ -663,8 +663,8 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			iphc0 |= LOWPAN_IPHC_TC_C;
 		} else {
 			/* compress only the flow label */
-			*hc06_ptr = tmp;
-			hc06_ptr += 1;
+			*hc_ptr = tmp;
+			hc_ptr += 1;
 		}
 	} else {
 		/* Flow label cannot be compressed */
@@ -672,15 +672,15 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 		   ((hdr->flow_lbl[0] & 0xF0) == 0)) {
 			/* compress only traffic class */
 			iphc0 |= LOWPAN_IPHC_TC_C;
-			*hc06_ptr = (tmp & 0xc0) | (hdr->flow_lbl[0] & 0x0F);
-			memcpy(hc06_ptr + 1, &hdr->flow_lbl[1], 2);
-			hc06_ptr += 3;
+			*hc_ptr = (tmp & 0xc0) | (hdr->flow_lbl[0] & 0x0F);
+			memcpy(hc_ptr + 1, &hdr->flow_lbl[1], 2);
+			hc_ptr += 3;
 		} else {
 			/* compress nothing */
-			memcpy(hc06_ptr, hdr, 4);
+			memcpy(hc_ptr, hdr, 4);
 			/* replace the top byte with new ECN | DSCP format */
-			*hc06_ptr = tmp;
-			hc06_ptr += 4;
+			*hc_ptr = tmp;
+			hc_ptr += 4;
 		}
 	}
 
@@ -691,8 +691,8 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 		iphc0 |= LOWPAN_IPHC_NH_C;
 
 	if ((iphc0 & LOWPAN_IPHC_NH_C) == 0) {
-		*hc06_ptr = hdr->nexthdr;
-		hc06_ptr += 1;
+		*hc_ptr = hdr->nexthdr;
+		hc_ptr += 1;
 	}
 
 	/*
@@ -713,8 +713,8 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 		iphc0 |= LOWPAN_IPHC_TTL_255;
 		break;
 	default:
-		*hc06_ptr = hdr->hop_limit;
-		hc06_ptr += 1;
+		*hc_ptr = hdr->hop_limit;
+		hc_ptr += 1;
 		break;
 	}
 
@@ -724,14 +724,14 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 		iphc1 |= LOWPAN_IPHC_SAC;
 	/* TODO: context lookup */
 	} else if (is_addr_link_local(&hdr->saddr)) {
-		iphc1 |= lowpan_compress_addr_64(&hc06_ptr,
+		iphc1 |= lowpan_compress_addr_64(&hc_ptr,
 				LOWPAN_IPHC_SAM_BIT, &hdr->saddr, _saddr);
 		pr_debug("source address unicast link-local %pI6c "
 			"iphc1 0x%02x\n", &hdr->saddr, iphc1);
 	} else {
 		pr_debug("send the full source address\n");
-		memcpy(hc06_ptr, &hdr->saddr.s6_addr16[0], 16);
-		hc06_ptr += 16;
+		memcpy(hc_ptr, &hdr->saddr.s6_addr16[0], 16);
+		hc_ptr += 16;
 	}
 
 	/* destination address compression */
@@ -742,55 +742,55 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			pr_debug("compressed to 1 octet\n");
 			iphc1 |= LOWPAN_IPHC_DAM_11;
 			/* use last byte */
-			*hc06_ptr = hdr->daddr.s6_addr[15];
-			hc06_ptr += 1;
+			*hc_ptr = hdr->daddr.s6_addr[15];
+			hc_ptr += 1;
 		} else if (lowpan_is_mcast_addr_compressable32(&hdr->daddr)) {
 			pr_debug("compressed to 4 octets\n");
 			iphc1 |= LOWPAN_IPHC_DAM_10;
 			/* second byte + the last three */
-			*hc06_ptr = hdr->daddr.s6_addr[1];
-			memcpy(hc06_ptr + 1, &hdr->daddr.s6_addr[13], 3);
-			hc06_ptr += 4;
+			*hc_ptr = hdr->daddr.s6_addr[1];
+			memcpy(hc_ptr + 1, &hdr->daddr.s6_addr[13], 3);
+			hc_ptr += 4;
 		} else if (lowpan_is_mcast_addr_compressable48(&hdr->daddr)) {
 			pr_debug("compressed to 6 octets\n");
 			iphc1 |= LOWPAN_IPHC_DAM_01;
 			/* second byte + the last five */
-			*hc06_ptr = hdr->daddr.s6_addr[1];
-			memcpy(hc06_ptr + 1, &hdr->daddr.s6_addr[11], 5);
-			hc06_ptr += 6;
+			*hc_ptr = hdr->daddr.s6_addr[1];
+			memcpy(hc_ptr + 1, &hdr->daddr.s6_addr[11], 5);
+			hc_ptr += 6;
 		} else {
 			pr_debug("using full address\n");
 			iphc1 |= LOWPAN_IPHC_DAM_00;
-			memcpy(hc06_ptr, &hdr->daddr.s6_addr[0], 16);
-			hc06_ptr += 16;
+			memcpy(hc_ptr, &hdr->daddr.s6_addr[0], 16);
+			hc_ptr += 16;
 		}
 	} else {
 		/* TODO: context lookup */
 		if (is_addr_link_local(&hdr->daddr)) {
-			iphc1 |= lowpan_compress_addr_64(&hc06_ptr,
+			iphc1 |= lowpan_compress_addr_64(&hc_ptr,
 				LOWPAN_IPHC_DAM_BIT, &hdr->daddr, _daddr);
 			pr_debug("dest address unicast link-local %pI6c "
 				"iphc1 0x%02x\n", &hdr->daddr, iphc1);
 		} else {
 			pr_debug("dest address unicast %pI6c\n", &hdr->daddr);
-			memcpy(hc06_ptr, &hdr->daddr.s6_addr16[0], 16);
-			hc06_ptr += 16;
+			memcpy(hc_ptr, &hdr->daddr.s6_addr16[0], 16);
+			hc_ptr += 16;
 		}
 	}
 
 	/* UDP header compression */
 	if (hdr->nexthdr == UIP_PROTO_UDP)
-		compress_udp_header(&hc06_ptr, skb);
+		compress_udp_header(&hc_ptr, skb);
 
 	head[0] = iphc0;
 	head[1] = iphc1;
 
 	skb_pull(skb, sizeof(struct ipv6hdr));
 	skb_reset_transport_header(skb);
-	memcpy(skb_push(skb, hc06_ptr - head), head, hc06_ptr - head);
+	memcpy(skb_push(skb, hc_ptr - head), head, hc_ptr - head);
 	skb_reset_network_header(skb);
 
-	pr_debug("header len %d skb %u\n", (int)(hc06_ptr - head), skb->len);
+	pr_debug("header len %d skb %u\n", (int)(hc_ptr - head), skb->len);
 
 	raw_dump_table(__func__, "raw skb data dump compressed",
 				skb->data, skb->len);
-- 
2.0.3

Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: marcel@holtmann.org
Cc: jukka.rissanen@linux.intel.com,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/7] 6lowpan: iphc: cleanup use of lowpan_push_hc_data
Date: Tue, 29 Jul 2014 23:47:01 +0200
Message-Id: <1406670424-15596-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
References: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch uses the lowpan_push_hc_data functions in several places
where we can use it. The lowpan_push_hc_data was introduced in some
previous patches.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/iphc.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 0376684..636edd0 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -532,15 +532,13 @@ static u8 lowpan_compress_addr_64(u8 **hc_ptr, u8 shift,
 		pr_debug("address compression 0 bits\n");
 	} else if (lowpan_is_iid_16_bit_compressable(ipaddr)) {
 		/* compress IID to 16 bits xxxx::XXXX */
-		memcpy(*hc_ptr, &ipaddr->s6_addr16[7], 2);
-		*hc_ptr += 2;
+		lowpan_push_hc_data(hc_ptr, &ipaddr->s6_addr16[7], 2);
 		val = 2; /* 16-bits */
 		raw_dump_inline(NULL, "Compressed ipv6 addr is (16 bits)",
 				*hc_ptr - 2, 2);
 	} else {
 		/* do not compress IID => xxxx::IID */
-		memcpy(*hc_ptr, &ipaddr->s6_addr16[4], 8);
-		*hc_ptr += 8;
+		lowpan_push_hc_data(hc_ptr, &ipaddr->s6_addr16[4], 8);
 		val = 1; /* 64-bits */
 		raw_dump_inline(NULL, "Compressed ipv6 addr is (64 bits)",
 				*hc_ptr - 8, 8);
@@ -696,10 +694,9 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 	if (hdr->nexthdr == UIP_PROTO_UDP)
 		iphc0 |= LOWPAN_IPHC_NH_C;
 
-	if ((iphc0 & LOWPAN_IPHC_NH_C) == 0) {
-		*hc_ptr = hdr->nexthdr;
-		hc_ptr += 1;
-	}
+	if ((iphc0 & LOWPAN_IPHC_NH_C) == 0)
+		lowpan_push_hc_data(&hc_ptr, &hdr->nexthdr,
+				    sizeof(hdr->nexthdr));
 
 	/*
 	 * Hop limit
@@ -719,9 +716,8 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 		iphc0 |= LOWPAN_IPHC_TTL_255;
 		break;
 	default:
-		*hc_ptr = hdr->hop_limit;
-		hc_ptr += 1;
-		break;
+		lowpan_push_hc_data(&hc_ptr, &hdr->hop_limit,
+				    sizeof(hdr->hop_limit));
 	}
 
 	/* source address compression */
@@ -736,8 +732,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			"iphc1 0x%02x\n", &hdr->saddr, iphc1);
 	} else {
 		pr_debug("send the full source address\n");
-		memcpy(hc_ptr, &hdr->saddr.s6_addr16[0], 16);
-		hc_ptr += 16;
+		lowpan_push_hc_data(&hc_ptr, &hdr->saddr.s6_addr[0], 16);
 	}
 
 	/* destination address compression */
@@ -748,27 +743,28 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			pr_debug("compressed to 1 octet\n");
 			iphc1 |= LOWPAN_IPHC_DAM_11;
 			/* use last byte */
-			*hc_ptr = hdr->daddr.s6_addr[15];
-			hc_ptr += 1;
+			lowpan_push_hc_data(&hc_ptr,
+					    &hdr->daddr.s6_addr[15], 1);
 		} else if (lowpan_is_mcast_addr_compressable32(&hdr->daddr)) {
 			pr_debug("compressed to 4 octets\n");
 			iphc1 |= LOWPAN_IPHC_DAM_10;
 			/* second byte + the last three */
-			*hc_ptr = hdr->daddr.s6_addr[1];
-			memcpy(hc_ptr + 1, &hdr->daddr.s6_addr[13], 3);
-			hc_ptr += 4;
+			lowpan_push_hc_data(&hc_ptr,
+					    &hdr->daddr.s6_addr[1], 1);
+			lowpan_push_hc_data(&hc_ptr,
+					    &hdr->daddr.s6_addr[13], 3);
 		} else if (lowpan_is_mcast_addr_compressable48(&hdr->daddr)) {
 			pr_debug("compressed to 6 octets\n");
 			iphc1 |= LOWPAN_IPHC_DAM_01;
 			/* second byte + the last five */
-			*hc_ptr = hdr->daddr.s6_addr[1];
-			memcpy(hc_ptr + 1, &hdr->daddr.s6_addr[11], 5);
-			hc_ptr += 6;
+			lowpan_push_hc_data(&hc_ptr,
+					    &hdr->daddr.s6_addr[1], 1);
+			lowpan_push_hc_data(&hc_ptr,
+					    &hdr->daddr.s6_addr[11], 5);
 		} else {
 			pr_debug("using full address\n");
 			iphc1 |= LOWPAN_IPHC_DAM_00;
-			memcpy(hc_ptr, &hdr->daddr.s6_addr[0], 16);
-			hc_ptr += 16;
+			lowpan_push_hc_data(&hc_ptr, hdr->daddr.s6_addr, 16);
 		}
 	} else {
 		/* TODO: context lookup */
@@ -779,8 +775,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 				"iphc1 0x%02x\n", &hdr->daddr, iphc1);
 		} else {
 			pr_debug("dest address unicast %pI6c\n", &hdr->daddr);
-			memcpy(hc_ptr, &hdr->daddr.s6_addr16[0], 16);
-			hc_ptr += 16;
+			lowpan_push_hc_data(&hc_ptr, hdr->daddr.s6_addr, 16);
 		}
 	}
 
-- 
2.0.3

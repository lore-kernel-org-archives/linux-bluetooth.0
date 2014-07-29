Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: marcel@holtmann.org
Cc: jukka.rissanen@linux.intel.com,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/7] 6lowpan: iphc: cleanup use of lowpan_fetch_skb
Date: Tue, 29 Jul 2014 23:47:00 +0200
Message-Id: <1406670424-15596-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
References: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We introduced the lowpan_fetch_skb function in some previous patches for
6lowpan to have a generic fetch function. This patch drops the old
function and use the generic lowpan_fetch_skb one.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/iphc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index d2654d4..0376684 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -357,7 +357,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	/* another if the CID flag is set */
 	if (iphc1 & LOWPAN_IPHC_CID) {
 		pr_debug("CID flag is set, increase header with one\n");
-		if (lowpan_fetch_skb_u8(skb, &num_context))
+		if (lowpan_fetch_skb(skb, &num_context, sizeof(num_context)))
 			goto drop;
 	}
 
@@ -370,7 +370,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	 * ECN + DSCP + 4-bit Pad + Flow Label (4 bytes)
 	 */
 	case 0: /* 00b */
-		if (lowpan_fetch_skb_u8(skb, &tmp))
+		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
 			goto drop;
 
 		memcpy(&hdr.flow_lbl, &skb->data[0], 3);
@@ -384,7 +384,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	 * ECN + DSCP (1 byte), Flow Label is elided
 	 */
 	case 2: /* 10b */
-		if (lowpan_fetch_skb_u8(skb, &tmp))
+		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
 			goto drop;
 
 		hdr.priority = ((tmp >> 2) & 0x0f);
@@ -395,7 +395,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	 * ECN + 2-bit Pad + Flow Label (3 bytes), DSCP is elided
 	 */
 	case 1: /* 01b */
-		if (lowpan_fetch_skb_u8(skb, &tmp))
+		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
 			goto drop;
 
 		hdr.flow_lbl[0] = (skb->data[0] & 0x0F) | ((tmp >> 2) & 0x30);
@@ -412,7 +412,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	/* Next Header */
 	if ((iphc0 & LOWPAN_IPHC_NH_C) == 0) {
 		/* Next header is carried inline */
-		if (lowpan_fetch_skb_u8(skb, &(hdr.nexthdr)))
+		if (lowpan_fetch_skb(skb, &hdr.nexthdr, sizeof(hdr.nexthdr)))
 			goto drop;
 
 		pr_debug("NH flag is set, next header carried inline: %02x\n",
@@ -423,7 +423,8 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	if ((iphc0 & 0x03) != LOWPAN_IPHC_TTL_I)
 		hdr.hop_limit = lowpan_ttl_values[iphc0 & 0x03];
 	else {
-		if (lowpan_fetch_skb_u8(skb, &(hdr.hop_limit)))
+		if (lowpan_fetch_skb(skb, &hdr.hop_limit,
+				     sizeof(hdr.hop_limit)))
 			goto drop;
 	}
 
-- 
2.0.3

Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: werner@almesberger.net, linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH v2 bluetooth-next 3/7] 6lowpan: fix udp byte ordering
Date: Tue, 17 Dec 2013 11:32:49 +0100
Message-Id: <1387276373-23882-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
References: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The incoming udp header in lowpan_compress_udp_header function is
already in network byte order.

Everytime we read this values for source and destination port we need
to convert this value to host byte order.

In the outcoming header we need to set this value in network byte order
which the upcoming process assumes.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_iphc.c | 45 +++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/net/ieee802154/6lowpan_iphc.c b/net/ieee802154/6lowpan_iphc.c
index 0537b33..a7ae340 100644
--- a/net/ieee802154/6lowpan_iphc.c
+++ b/net/ieee802154/6lowpan_iphc.c
@@ -283,20 +283,21 @@ uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
 			break;
 		case LOWPAN_NHC_UDP_CS_P_01:
 			memcpy(&uh->source, &skb->data[0], 2);
-			uh->dest =
-			   skb->data[2] + LOWPAN_NHC_UDP_8BIT_PORT;
+			uh->dest = htons(skb->data[2] +
+					 LOWPAN_NHC_UDP_8BIT_PORT);
 			skb_pull(skb, 3);
 			break;
 		case LOWPAN_NHC_UDP_CS_P_10:
-			uh->source = skb->data[0] + LOWPAN_NHC_UDP_8BIT_PORT;
+			uh->source = htons(skb->data[0] +
+					   LOWPAN_NHC_UDP_8BIT_PORT);
 			memcpy(&uh->dest, &skb->data[1], 2);
 			skb_pull(skb, 3);
 			break;
 		case LOWPAN_NHC_UDP_CS_P_11:
-			uh->source =
-			   LOWPAN_NHC_UDP_4BIT_PORT + (skb->data[0] >> 4);
-			uh->dest =
-			   LOWPAN_NHC_UDP_4BIT_PORT + (skb->data[0] & 0x0f);
+			uh->source = htons(LOWPAN_NHC_UDP_4BIT_PORT +
+					   (skb->data[0] >> 4));
+			uh->dest = htons(LOWPAN_NHC_UDP_4BIT_PORT +
+					 (skb->data[0] & 0x0f));
 			skb_pull(skb, 1);
 			break;
 		default:
@@ -306,7 +307,7 @@ uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
 		}
 
 		pr_debug("uncompressed UDP ports: src = %d, dst = %d\n",
-			 uh->source, uh->dest);
+			 ntohs(uh->source), ntohs(uh->dest));
 
 		/* copy checksum */
 		memcpy(&uh->check, &skb->data[0], 2);
@@ -318,7 +319,7 @@ uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
 		 * frame
 		 */
 		uh->len = htons(skb->len + sizeof(struct udphdr));
-		pr_debug("uncompressed UDP length: src = %d", uh->len);
+		pr_debug("uncompressed UDP length: src = %d", ntohs(uh->len));
 	} else {
 		pr_debug("ERROR: unsupported NH format\n");
 		goto err;
@@ -542,28 +543,30 @@ static void compress_udp_header(u8 **hc06_ptr, struct sk_buff *skb)
 {
 	struct udphdr *uh = udp_hdr(skb);
 
-	if (((uh->source & LOWPAN_NHC_UDP_4BIT_MASK) ==
-				LOWPAN_NHC_UDP_4BIT_PORT) &&
-	    ((uh->dest & LOWPAN_NHC_UDP_4BIT_MASK) ==
-				LOWPAN_NHC_UDP_4BIT_PORT)) {
+	if (((ntohs(uh->source) & LOWPAN_NHC_UDP_4BIT_MASK) ==
+	     LOWPAN_NHC_UDP_4BIT_PORT) &&
+	    ((ntohs(uh->dest) & LOWPAN_NHC_UDP_4BIT_MASK) ==
+	     LOWPAN_NHC_UDP_4BIT_PORT)) {
 		pr_debug("UDP header: both ports compression to 4 bits\n");
 		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_11;
 		*(*hc06_ptr + 1) = /* subtraction is faster */
-		   (u8)((uh->dest - LOWPAN_NHC_UDP_4BIT_PORT) +
-		       ((uh->source & LOWPAN_NHC_UDP_4BIT_PORT) << 4));
+		   (u8)((ntohs(uh->dest) - LOWPAN_NHC_UDP_4BIT_PORT) +
+		       ((ntohs(uh->source) & LOWPAN_NHC_UDP_4BIT_PORT) << 4));
 		*hc06_ptr += 2;
-	} else if ((uh->dest & LOWPAN_NHC_UDP_8BIT_MASK) ==
-			LOWPAN_NHC_UDP_8BIT_PORT) {
+	} else if ((ntohs(uh->dest) & LOWPAN_NHC_UDP_8BIT_MASK) ==
+		   LOWPAN_NHC_UDP_8BIT_PORT) {
 		pr_debug("UDP header: remove 8 bits of dest\n");
 		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_01;
 		memcpy(*hc06_ptr + 1, &uh->source, 2);
-		*(*hc06_ptr + 3) = (u8)(uh->dest - LOWPAN_NHC_UDP_8BIT_PORT);
+		*(*hc06_ptr + 3) = (u8)(ntohs(uh->dest) -
+					LOWPAN_NHC_UDP_8BIT_PORT);
 		*hc06_ptr += 4;
-	} else if ((uh->source & LOWPAN_NHC_UDP_8BIT_MASK) ==
-			LOWPAN_NHC_UDP_8BIT_PORT) {
+	} else if ((ntohs(uh->source) & LOWPAN_NHC_UDP_8BIT_MASK) ==
+		   LOWPAN_NHC_UDP_8BIT_PORT) {
 		pr_debug("UDP header: remove 8 bits of source\n");
 		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_10;
-		*(*hc06_ptr + 1) = (u8)(uh->source - LOWPAN_NHC_UDP_8BIT_PORT);
+		*(*hc06_ptr + 1) = (u8)(ntohs(uh->source) -
+					LOWPAN_NHC_UDP_8BIT_PORT);
 		memcpy(*hc06_ptr + 2, &uh->dest, 2);
 		*hc06_ptr += 4;
 	} else {
-- 
1.8.5.1


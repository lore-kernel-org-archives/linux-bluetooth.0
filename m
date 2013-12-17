Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: werner@almesberger.net, linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH v2 bluetooth-next 5/7] 6lowpan: udp use lowpan_fetch_skb function
Date: Tue, 17 Dec 2013 11:32:51 +0100
Message-Id: <1387276373-23882-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
References: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Cleanup the lowpan_uncompress_udp_header function to use the
lowpan_fetch_skb function.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_iphc.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/net/ieee802154/6lowpan_iphc.c b/net/ieee802154/6lowpan_iphc.c
index 8303c93..ee6891f 100644
--- a/net/ieee802154/6lowpan_iphc.c
+++ b/net/ieee802154/6lowpan_iphc.c
@@ -265,40 +265,37 @@ lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
 static int
 uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
 {
-	u8 tmp;
+	bool fail;
+	u8 tmp = 0, val = 0;
 
 	if (!uh)
 		goto err;
 
-	if (lowpan_fetch_skb_u8(skb, &tmp))
-		goto err;
+	fail = lowpan_fetch_skb(skb, &tmp, 1);
 
 	if ((tmp & LOWPAN_NHC_UDP_MASK) == LOWPAN_NHC_UDP_ID) {
 		pr_debug("UDP header uncompression\n");
 		switch (tmp & LOWPAN_NHC_UDP_CS_P_11) {
 		case LOWPAN_NHC_UDP_CS_P_00:
-			memcpy(&uh->source, &skb->data[0], 2);
-			memcpy(&uh->dest, &skb->data[2], 2);
-			skb_pull(skb, 4);
+			fail |= lowpan_fetch_skb(skb, &uh->source, 2);
+			fail |= lowpan_fetch_skb(skb, &uh->dest, 2);
 			break;
 		case LOWPAN_NHC_UDP_CS_P_01:
-			memcpy(&uh->source, &skb->data[0], 2);
-			uh->dest = htons(skb->data[2] +
-					 LOWPAN_NHC_UDP_8BIT_PORT);
-			skb_pull(skb, 3);
+			fail |= lowpan_fetch_skb(skb, &uh->source, 2);
+			fail |= lowpan_fetch_skb(skb, &val, 1);
+			uh->dest = htons(val + LOWPAN_NHC_UDP_8BIT_PORT);
 			break;
 		case LOWPAN_NHC_UDP_CS_P_10:
-			uh->source = htons(skb->data[0] +
-					   LOWPAN_NHC_UDP_8BIT_PORT);
-			memcpy(&uh->dest, &skb->data[1], 2);
-			skb_pull(skb, 3);
+			fail |= lowpan_fetch_skb(skb, &val, 1);
+			uh->source = htons(val + LOWPAN_NHC_UDP_8BIT_PORT);
+			fail |= lowpan_fetch_skb(skb, &uh->dest, 2);
 			break;
 		case LOWPAN_NHC_UDP_CS_P_11:
+			fail |= lowpan_fetch_skb(skb, &val, 1);
 			uh->source = htons(LOWPAN_NHC_UDP_4BIT_PORT +
-					   (skb->data[0] >> 4));
+					   (val >> 4));
 			uh->dest = htons(LOWPAN_NHC_UDP_4BIT_PORT +
-					 (skb->data[0] & 0x0f));
-			skb_pull(skb, 1);
+					 (val & 0x0f));
 			break;
 		default:
 			pr_debug("ERROR: unknown UDP format\n");
@@ -314,8 +311,7 @@ uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
 			pr_debug_ratelimited("checksum elided currently not supported");
 			goto err;
 		} else {
-			memcpy(&uh->check, &skb->data[0], 2);
-			skb_pull(skb, 2);
+			fail |= lowpan_fetch_skb(skb, &uh->check, 2);
 		}
 
 		/*
@@ -330,6 +326,9 @@ uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
 		goto err;
 	}
 
+	if (fail)
+		goto err;
+
 	return 0;
 err:
 	return -EINVAL;
-- 
1.8.5.1


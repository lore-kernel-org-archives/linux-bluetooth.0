Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: marcel@holtmann.org
Cc: jukka.rissanen@linux.intel.com,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/7] 6lowpan: iphc: use sizeof in udp uncompression
Date: Tue, 29 Jul 2014 23:46:59 +0200
Message-Id: <1406670424-15596-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
References: <1406670424-15596-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/iphc.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index a13eae5..d2654d4 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -271,27 +271,31 @@ uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
 	if (!uh)
 		goto err;
 
-	fail = lowpan_fetch_skb(skb, &tmp, 1);
+	fail = lowpan_fetch_skb(skb, &tmp, sizeof(tmp));
 
 	if ((tmp & LOWPAN_NHC_UDP_MASK) == LOWPAN_NHC_UDP_ID) {
 		pr_debug("UDP header uncompression\n");
 		switch (tmp & LOWPAN_NHC_UDP_CS_P_11) {
 		case LOWPAN_NHC_UDP_CS_P_00:
-			fail |= lowpan_fetch_skb(skb, &uh->source, 2);
-			fail |= lowpan_fetch_skb(skb, &uh->dest, 2);
+			fail |= lowpan_fetch_skb(skb, &uh->source,
+						 sizeof(uh->source));
+			fail |= lowpan_fetch_skb(skb, &uh->dest,
+						 sizeof(uh->dest));
 			break;
 		case LOWPAN_NHC_UDP_CS_P_01:
-			fail |= lowpan_fetch_skb(skb, &uh->source, 2);
-			fail |= lowpan_fetch_skb(skb, &val, 1);
+			fail |= lowpan_fetch_skb(skb, &uh->source,
+						 sizeof(uh->source));
+			fail |= lowpan_fetch_skb(skb, &val, sizeof(val));
 			uh->dest = htons(val + LOWPAN_NHC_UDP_8BIT_PORT);
 			break;
 		case LOWPAN_NHC_UDP_CS_P_10:
-			fail |= lowpan_fetch_skb(skb, &val, 1);
+			fail |= lowpan_fetch_skb(skb, &val, sizeof(val));
 			uh->source = htons(val + LOWPAN_NHC_UDP_8BIT_PORT);
-			fail |= lowpan_fetch_skb(skb, &uh->dest, 2);
+			fail |= lowpan_fetch_skb(skb, &uh->dest,
+						 sizeof(uh->dest));
 			break;
 		case LOWPAN_NHC_UDP_CS_P_11:
-			fail |= lowpan_fetch_skb(skb, &val, 1);
+			fail |= lowpan_fetch_skb(skb, &val, sizeof(val));
 			uh->source = htons(LOWPAN_NHC_UDP_4BIT_PORT +
 					   (val >> 4));
 			uh->dest = htons(LOWPAN_NHC_UDP_4BIT_PORT +
@@ -311,7 +315,8 @@ uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
 			pr_debug_ratelimited("checksum elided currently not supported\n");
 			goto err;
 		} else {
-			fail |= lowpan_fetch_skb(skb, &uh->check, 2);
+			fail |= lowpan_fetch_skb(skb, &uh->check,
+						 sizeof(uh->check));
 		}
 
 		/*
-- 
2.0.3

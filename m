Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: werner@almesberger.net, linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH v3 bluetooth-next 8/8] 6lowpan: cleanup udp compress function
Date: Tue, 17 Dec 2013 14:21:28 +0100
Message-Id: <1387286488-29382-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1387286488-29382-1-git-send-email-alex.aring@gmail.com>
References: <1387286488-29382-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch remove unnecessary casts and brackets in compress_udp_header
function.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_iphc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/ieee802154/6lowpan_iphc.c b/net/ieee802154/6lowpan_iphc.c
index b298bfc..11840f9 100644
--- a/net/ieee802154/6lowpan_iphc.c
+++ b/net/ieee802154/6lowpan_iphc.c
@@ -553,33 +553,43 @@ static void compress_udp_header(u8 **hc06_ptr, struct sk_buff *skb)
 	    ((ntohs(uh->dest) & LOWPAN_NHC_UDP_4BIT_MASK) ==
 	     LOWPAN_NHC_UDP_4BIT_PORT)) {
 		pr_debug("UDP header: both ports compression to 4 bits\n");
+		/* compression value */
 		tmp = LOWPAN_NHC_UDP_CS_P_11;
 		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
-		tmp = /* subtraction is faster */
-		   (u8)((ntohs(uh->dest) - LOWPAN_NHC_UDP_4BIT_PORT) +
-		       ((ntohs(uh->source) - LOWPAN_NHC_UDP_4BIT_PORT) << 4));
+		/* source and destination port */
+		tmp = ntohs(uh->dest) - LOWPAN_NHC_UDP_4BIT_PORT +
+		      ((ntohs(uh->source) - LOWPAN_NHC_UDP_4BIT_PORT) << 4);
 		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
 	} else if ((ntohs(uh->dest) & LOWPAN_NHC_UDP_8BIT_MASK) ==
 			LOWPAN_NHC_UDP_8BIT_PORT) {
 		pr_debug("UDP header: remove 8 bits of dest\n");
+		/* compression value */
 		tmp = LOWPAN_NHC_UDP_CS_P_01;
 		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		/* source port */
 		lowpan_push_hc_data(hc06_ptr, &uh->source, sizeof(uh->source));
-		tmp = (u8)(ntohs(uh->dest) - LOWPAN_NHC_UDP_8BIT_PORT);
+		/* destination port */
+		tmp = ntohs(uh->dest) - LOWPAN_NHC_UDP_8BIT_PORT;
 		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
 	} else if ((ntohs(uh->source) & LOWPAN_NHC_UDP_8BIT_MASK) ==
 			LOWPAN_NHC_UDP_8BIT_PORT) {
 		pr_debug("UDP header: remove 8 bits of source\n");
+		/* compression value */
 		tmp = LOWPAN_NHC_UDP_CS_P_10;
 		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
-		tmp = (u8)(ntohs(uh->source) - LOWPAN_NHC_UDP_8BIT_PORT);
+		/* source port */
+		tmp = ntohs(uh->source) - LOWPAN_NHC_UDP_8BIT_PORT;
 		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		/* destination port */
 		lowpan_push_hc_data(hc06_ptr, &uh->dest, sizeof(uh->dest));
 	} else {
 		pr_debug("UDP header: can't compress\n");
+		/* compression value */
 		tmp = LOWPAN_NHC_UDP_CS_P_00;
 		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		/* source port */
 		lowpan_push_hc_data(hc06_ptr, &uh->source, sizeof(uh->source));
+		/* destination port */
 		lowpan_push_hc_data(hc06_ptr, &uh->dest, sizeof(uh->dest));
 	}
 
-- 
1.8.5.1


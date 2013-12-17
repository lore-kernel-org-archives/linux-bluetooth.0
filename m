Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: werner@almesberger.net, linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH v2 bluetooth-next 7/7] 6lowpan: cleanup udp compress function
Date: Tue, 17 Dec 2013 11:32:53 +0100
Message-Id: <1387276373-23882-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
References: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch remove unnecessary casts and brackets in compress_udp_header
function.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_iphc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/ieee802154/6lowpan_iphc.c b/net/ieee802154/6lowpan_iphc.c
index d49cc1b..78bbb76 100644
--- a/net/ieee802154/6lowpan_iphc.c
+++ b/net/ieee802154/6lowpan_iphc.c
@@ -553,24 +553,22 @@ static void compress_udp_header(u8 **hc06_ptr, struct sk_buff *skb)
 	     LOWPAN_NHC_UDP_4BIT_PORT)) {
 		pr_debug("UDP header: both ports compression to 4 bits\n");
 		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_11;
-		*(*hc06_ptr + 1) = /* subtraction is faster */
-		   (u8)((ntohs(uh->dest) - LOWPAN_NHC_UDP_4BIT_PORT) +
-		       ((ntohs(uh->source) - LOWPAN_NHC_UDP_4BIT_PORT) << 4));
+		*(*hc06_ptr + 1) = ntohs(uh->dest) - LOWPAN_NHC_UDP_4BIT_PORT +
+				   ((ntohs(uh->source) -
+				     LOWPAN_NHC_UDP_4BIT_PORT) << 4);
 		*hc06_ptr += 2;
 	} else if ((ntohs(uh->dest) & LOWPAN_NHC_UDP_8BIT_MASK) ==
 		   LOWPAN_NHC_UDP_8BIT_PORT) {
 		pr_debug("UDP header: remove 8 bits of dest\n");
 		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_01;
 		memcpy(*hc06_ptr + 1, &uh->source, 2);
-		*(*hc06_ptr + 3) = (u8)(ntohs(uh->dest) -
-					LOWPAN_NHC_UDP_8BIT_PORT);
+		*(*hc06_ptr + 3) = ntohs(uh->dest) - LOWPAN_NHC_UDP_8BIT_PORT;
 		*hc06_ptr += 4;
 	} else if ((ntohs(uh->source) & LOWPAN_NHC_UDP_8BIT_MASK) ==
 		   LOWPAN_NHC_UDP_8BIT_PORT) {
 		pr_debug("UDP header: remove 8 bits of source\n");
 		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_10;
-		*(*hc06_ptr + 1) = (u8)(ntohs(uh->source) -
-					LOWPAN_NHC_UDP_8BIT_PORT);
+		*(*hc06_ptr + 1) = ntohs(uh->source) - LOWPAN_NHC_UDP_8BIT_PORT;
 		memcpy(*hc06_ptr + 2, &uh->dest, 2);
 		*hc06_ptr += 4;
 	} else {
-- 
1.8.5.1


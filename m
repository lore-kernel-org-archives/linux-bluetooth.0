Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: werner@almesberger.net, linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH v3 bluetooth-next 2/8] 6lowpan: udp use lowpan_push_hc_data function
Date: Tue, 17 Dec 2013 14:21:22 +0100
Message-Id: <1387286488-29382-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1387286488-29382-1-git-send-email-alex.aring@gmail.com>
References: <1387286488-29382-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch uses the lowpan_push_hc_data to generate iphc header.

The current implementation has some wrong pointer arithmetic issues and
works in a random case only.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_iphc.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/net/ieee802154/6lowpan_iphc.c b/net/ieee802154/6lowpan_iphc.c
index 88e7da5..77c0366 100644
--- a/net/ieee802154/6lowpan_iphc.c
+++ b/net/ieee802154/6lowpan_iphc.c
@@ -541,42 +541,45 @@ static u8 lowpan_compress_addr_64(u8 **hc06_ptr, u8 shift,
 static void compress_udp_header(u8 **hc06_ptr, struct sk_buff *skb)
 {
 	struct udphdr *uh = udp_hdr(skb);
+	u8 tmp;
 
 	if (((uh->source & LOWPAN_NHC_UDP_4BIT_MASK) ==
 				LOWPAN_NHC_UDP_4BIT_PORT) &&
 	    ((uh->dest & LOWPAN_NHC_UDP_4BIT_MASK) ==
 				LOWPAN_NHC_UDP_4BIT_PORT)) {
 		pr_debug("UDP header: both ports compression to 4 bits\n");
-		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_11;
-		**(hc06_ptr + 1) = /* subtraction is faster */
+		tmp = LOWPAN_NHC_UDP_CS_P_11;
+		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		tmp = /* subtraction is faster */
 		   (u8)((uh->dest - LOWPAN_NHC_UDP_4BIT_PORT) +
 		       ((uh->source & LOWPAN_NHC_UDP_4BIT_PORT) << 4));
-		*hc06_ptr += 2;
+		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
 	} else if ((uh->dest & LOWPAN_NHC_UDP_8BIT_MASK) ==
 			LOWPAN_NHC_UDP_8BIT_PORT) {
 		pr_debug("UDP header: remove 8 bits of dest\n");
-		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_01;
-		memcpy(*hc06_ptr + 1, &uh->source, 2);
-		**(hc06_ptr + 3) = (u8)(uh->dest - LOWPAN_NHC_UDP_8BIT_PORT);
-		*hc06_ptr += 4;
+		tmp = LOWPAN_NHC_UDP_CS_P_01;
+		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		lowpan_push_hc_data(hc06_ptr, &uh->source, sizeof(uh->source));
+		tmp = (u8)(uh->dest - LOWPAN_NHC_UDP_8BIT_PORT);
+		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
 	} else if ((uh->source & LOWPAN_NHC_UDP_8BIT_MASK) ==
 			LOWPAN_NHC_UDP_8BIT_PORT) {
 		pr_debug("UDP header: remove 8 bits of source\n");
-		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_10;
-		memcpy(*hc06_ptr + 1, &uh->dest, 2);
-		**(hc06_ptr + 3) = (u8)(uh->source - LOWPAN_NHC_UDP_8BIT_PORT);
-		*hc06_ptr += 4;
+		tmp = LOWPAN_NHC_UDP_CS_P_10;
+		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		lowpan_push_hc_data(hc06_ptr, &uh->dest, sizeof(uh->dest));
+		tmp = (u8)(uh->source - LOWPAN_NHC_UDP_8BIT_PORT);
+		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
 	} else {
 		pr_debug("UDP header: can't compress\n");
-		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_00;
-		memcpy(*hc06_ptr + 1, &uh->source, 2);
-		memcpy(*hc06_ptr + 3, &uh->dest, 2);
-		*hc06_ptr += 5;
+		tmp = LOWPAN_NHC_UDP_CS_P_00;
+		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		lowpan_push_hc_data(hc06_ptr, &uh->source, sizeof(uh->source));
+		lowpan_push_hc_data(hc06_ptr, &uh->dest, sizeof(uh->dest));
 	}
 
 	/* checksum is always inline */
-	memcpy(*hc06_ptr, &uh->check, 2);
-	*hc06_ptr += 2;
+	lowpan_push_hc_data(hc06_ptr, &uh->check, sizeof(uh->check));
 
 	/* skip the UDP header */
 	skb_pull(skb, sizeof(struct udphdr));
-- 
1.8.5.1


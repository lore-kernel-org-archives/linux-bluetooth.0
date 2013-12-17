Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: werner@almesberger.net, linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH v2 bluetooth-next 1/7] 6lowpan: fix udp nullpointer dereferencing
Date: Tue, 17 Dec 2013 11:32:47 +0100
Message-Id: <1387276373-23882-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
References: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sometimes a nullpointer dereferencing occurs because of using a wrong
pointer arithmetic in udp_uncompression.

This patch changes "**(hc06_ptr + 3)" to the right one "*(*hc06_ptr +
3)". Dereferencing like "**(hc06_ptr + 3)" works in a random case only.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_iphc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ieee802154/6lowpan_iphc.c b/net/ieee802154/6lowpan_iphc.c
index 88e7da5..8bbe28e 100644
--- a/net/ieee802154/6lowpan_iphc.c
+++ b/net/ieee802154/6lowpan_iphc.c
@@ -548,7 +548,7 @@ static void compress_udp_header(u8 **hc06_ptr, struct sk_buff *skb)
 				LOWPAN_NHC_UDP_4BIT_PORT)) {
 		pr_debug("UDP header: both ports compression to 4 bits\n");
 		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_11;
-		**(hc06_ptr + 1) = /* subtraction is faster */
+		*(*hc06_ptr + 1) = /* subtraction is faster */
 		   (u8)((uh->dest - LOWPAN_NHC_UDP_4BIT_PORT) +
 		       ((uh->source & LOWPAN_NHC_UDP_4BIT_PORT) << 4));
 		*hc06_ptr += 2;
@@ -557,14 +557,14 @@ static void compress_udp_header(u8 **hc06_ptr, struct sk_buff *skb)
 		pr_debug("UDP header: remove 8 bits of dest\n");
 		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_01;
 		memcpy(*hc06_ptr + 1, &uh->source, 2);
-		**(hc06_ptr + 3) = (u8)(uh->dest - LOWPAN_NHC_UDP_8BIT_PORT);
+		*(*hc06_ptr + 3) = (u8)(uh->dest - LOWPAN_NHC_UDP_8BIT_PORT);
 		*hc06_ptr += 4;
 	} else if ((uh->source & LOWPAN_NHC_UDP_8BIT_MASK) ==
 			LOWPAN_NHC_UDP_8BIT_PORT) {
 		pr_debug("UDP header: remove 8 bits of source\n");
 		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_10;
 		memcpy(*hc06_ptr + 1, &uh->dest, 2);
-		**(hc06_ptr + 3) = (u8)(uh->source - LOWPAN_NHC_UDP_8BIT_PORT);
+		*(*hc06_ptr + 3) = (u8)(uh->source - LOWPAN_NHC_UDP_8BIT_PORT);
 		*hc06_ptr += 4;
 	} else {
 		pr_debug("UDP header: can't compress\n");
-- 
1.8.5.1


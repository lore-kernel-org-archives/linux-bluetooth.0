Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: werner@almesberger.net, linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH v2 bluetooth-next 2/7] 6lowpan: fix udp compress ordering
Date: Tue, 17 Dec 2013 11:32:48 +0100
Message-Id: <1387276373-23882-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
References: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case ((ntohs(uh->source) & LOWPAN_NHC_UDP_8BIT_MASK) the order of
uncompression is wrong. It's always first source port then destination
port as second.

See:
http://tools.ietf.org/html/rfc6282#section-4.3.3

"Fields carried in-line (in part or in whole) appear in the same order
as they do in the UDP header format"

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_iphc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ieee802154/6lowpan_iphc.c b/net/ieee802154/6lowpan_iphc.c
index 8bbe28e..0537b33 100644
--- a/net/ieee802154/6lowpan_iphc.c
+++ b/net/ieee802154/6lowpan_iphc.c
@@ -563,8 +563,8 @@ static void compress_udp_header(u8 **hc06_ptr, struct sk_buff *skb)
 			LOWPAN_NHC_UDP_8BIT_PORT) {
 		pr_debug("UDP header: remove 8 bits of source\n");
 		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_10;
-		memcpy(*hc06_ptr + 1, &uh->dest, 2);
-		*(*hc06_ptr + 3) = (u8)(uh->source - LOWPAN_NHC_UDP_8BIT_PORT);
+		*(*hc06_ptr + 1) = (u8)(uh->source - LOWPAN_NHC_UDP_8BIT_PORT);
+		memcpy(*hc06_ptr + 2, &uh->dest, 2);
 		*hc06_ptr += 4;
 	} else {
 		pr_debug("UDP header: can't compress\n");
-- 
1.8.5.1


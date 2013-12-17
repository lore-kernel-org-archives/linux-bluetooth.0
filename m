Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: werner@almesberger.net, linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH v3 bluetooth-next 3/8] 6lowpan: fix udp compress ordering
Date: Tue, 17 Dec 2013 14:21:23 +0100
Message-Id: <1387286488-29382-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1387286488-29382-1-git-send-email-alex.aring@gmail.com>
References: <1387286488-29382-1-git-send-email-alex.aring@gmail.com>
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
 net/ieee802154/6lowpan_iphc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan_iphc.c b/net/ieee802154/6lowpan_iphc.c
index 77c0366..1933f5b 100644
--- a/net/ieee802154/6lowpan_iphc.c
+++ b/net/ieee802154/6lowpan_iphc.c
@@ -567,9 +567,9 @@ static void compress_udp_header(u8 **hc06_ptr, struct sk_buff *skb)
 		pr_debug("UDP header: remove 8 bits of source\n");
 		tmp = LOWPAN_NHC_UDP_CS_P_10;
 		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
-		lowpan_push_hc_data(hc06_ptr, &uh->dest, sizeof(uh->dest));
 		tmp = (u8)(uh->source - LOWPAN_NHC_UDP_8BIT_PORT);
 		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
+		lowpan_push_hc_data(hc06_ptr, &uh->dest, sizeof(uh->dest));
 	} else {
 		pr_debug("UDP header: can't compress\n");
 		tmp = LOWPAN_NHC_UDP_CS_P_00;
-- 
1.8.5.1


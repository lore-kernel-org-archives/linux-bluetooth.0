Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: werner@almesberger.net, linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH v2 bluetooth-next 6/7] 6lowpan: udp use subtraction on both conditions
Date: Tue, 17 Dec 2013 11:32:52 +0100
Message-Id: <1387276373-23882-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
References: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Cleanup code to handle both calculation in the same way.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_iphc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan_iphc.c b/net/ieee802154/6lowpan_iphc.c
index ee6891f..d49cc1b 100644
--- a/net/ieee802154/6lowpan_iphc.c
+++ b/net/ieee802154/6lowpan_iphc.c
@@ -555,7 +555,7 @@ static void compress_udp_header(u8 **hc06_ptr, struct sk_buff *skb)
 		**hc06_ptr = LOWPAN_NHC_UDP_CS_P_11;
 		*(*hc06_ptr + 1) = /* subtraction is faster */
 		   (u8)((ntohs(uh->dest) - LOWPAN_NHC_UDP_4BIT_PORT) +
-		       ((ntohs(uh->source) & LOWPAN_NHC_UDP_4BIT_PORT) << 4));
+		       ((ntohs(uh->source) - LOWPAN_NHC_UDP_4BIT_PORT) << 4));
 		*hc06_ptr += 2;
 	} else if ((ntohs(uh->dest) & LOWPAN_NHC_UDP_8BIT_MASK) ==
 		   LOWPAN_NHC_UDP_8BIT_PORT) {
-- 
1.8.5.1


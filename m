Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: werner@almesberger.net, linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH v3 bluetooth-next 7/8] 6lowpan: udp use subtraction on both conditions
Date: Tue, 17 Dec 2013 14:21:27 +0100
Message-Id: <1387286488-29382-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1387286488-29382-1-git-send-email-alex.aring@gmail.com>
References: <1387286488-29382-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Cleanup code to handle both calculation in the same way.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_iphc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan_iphc.c b/net/ieee802154/6lowpan_iphc.c
index 8857285..b298bfc 100644
--- a/net/ieee802154/6lowpan_iphc.c
+++ b/net/ieee802154/6lowpan_iphc.c
@@ -557,7 +557,7 @@ static void compress_udp_header(u8 **hc06_ptr, struct sk_buff *skb)
 		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
 		tmp = /* subtraction is faster */
 		   (u8)((ntohs(uh->dest) - LOWPAN_NHC_UDP_4BIT_PORT) +
-		       ((ntohs(uh->source) & LOWPAN_NHC_UDP_4BIT_PORT) << 4));
+		       ((ntohs(uh->source) - LOWPAN_NHC_UDP_4BIT_PORT) << 4));
 		lowpan_push_hc_data(hc06_ptr, &tmp, sizeof(tmp));
 	} else if ((ntohs(uh->dest) & LOWPAN_NHC_UDP_8BIT_MASK) ==
 			LOWPAN_NHC_UDP_8BIT_PORT) {
-- 
1.8.5.1


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Alexander Aring <aar@pengutronix.de>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de,
	Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next] 6lowpan: iphc: fix stateful multicast compression
Date: Wed, 24 Feb 2016 12:01:03 +0100
Message-Id: <1456311663-11438-1-git-send-email-aar@pengutronix.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of multicast address we need to set always the LOWPAN_IPHC_M bit
and if a destination context identifier was found for a multicast
address then we need to set the LOWPAN_IPHC_DAC as well.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/iphc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 0fe954f..06287ac 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -1118,12 +1118,13 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 	/* destination address compression */
 	if (ipv6_daddr_type & IPV6_ADDR_MULTICAST) {
 		pr_debug("destination address is multicast: ");
+		iphc1 |= LOWPAN_IPHC_M;
 		if (dci) {
 			iphc1 |= lowpan_iphc_mcast_ctx_addr_compress(&hc_ptr,
 								     &dci_entry,
 								     &hdr->daddr);
+			iphc1 |= LOWPAN_IPHC_DAC;
 		} else {
-			iphc1 |= LOWPAN_IPHC_M;
 			iphc1 |= lowpan_iphc_mcast_addr_compress(&hc_ptr,
 								 &hdr->daddr);
 		}
-- 
2.7.1


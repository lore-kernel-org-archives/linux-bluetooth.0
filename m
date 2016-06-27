Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Alexander Aring <aar@pengutronix.de>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 bluetooth-next 5/8] 6lowpan: ndisc: set invalid unicast short addr to unspec
Date: Tue, 28 Jun 2016 00:00:34 +0200
Message-Id: <20160627220037.10108-6-aar@pengutronix.de>
In-Reply-To: <20160627220037.10108-1-aar@pengutronix.de>
References: <20160627220037.10108-1-aar@pengutronix.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When receiving neighbour information with short address option field we
should check the complete range of invalid short addresses and set it to
one invalid address setting which is the unspecified address. This
address is also used when by creating at first a new neighbour entry to
indicate no short address is set.

Cc: linux-bluetooth@vger.kernel.org
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/ndisc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/6lowpan/ndisc.c b/net/6lowpan/ndisc.c
index 79c5fa9..86450b7 100644
--- a/net/6lowpan/ndisc.c
+++ b/net/6lowpan/ndisc.c
@@ -97,10 +97,13 @@ static void lowpan_ndisc_802154_update(struct neighbour *n, u32 flags,
 	}
 
 	write_lock_bh(&n->lock);
-	if (lladdr_short)
+	if (lladdr_short) {
 		ieee802154_be16_to_le16(&neigh->short_addr, lladdr_short);
-	else
+		if (!lowpan_802154_is_valid_src_short_addr(neigh->short_addr))
+			neigh->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
+	} else {
 		neigh->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
+	}
 	write_unlock_bh(&n->lock);
 }
 
-- 
2.9.0


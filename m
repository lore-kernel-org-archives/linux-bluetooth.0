Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: jukka.rissanen@linux.intel.com
Subject: [PATCH] Bluetooth: 6lowpan: Fix multi-link setup
Date: Wed, 20 Sep 2017 12:52:53 +0300
Message-Id: <20170920095253.8634-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there are more than one node connected and there isn't any route
information attempt to check if destination address matches any of the
link-local peer addresses.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/6lowpan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 4e2576fc0c59..55370c330386 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -190,7 +190,7 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 		nexthop = &lowpan_cb(skb)->gw;
 
 		if (ipv6_addr_any(nexthop))
-			return NULL;
+			nexthop = daddr;
 	} else {
 		nexthop = rt6_nexthop(rt, daddr);
 
-- 
2.13.5


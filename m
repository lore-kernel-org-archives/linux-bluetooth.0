Return-Path: <stephen@networkplumber.org>
From: Stephen Hemminger <stephen@networkplumber.org>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	pablo@netfilter.org,
	kadlec@blackhole.kfki.hu,
	fw@strlen.de
Cc: netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH net-next 6/6] 6lowpan: fix set not used warning
Date: Mon, 24 Jul 2017 10:25:23 -0700
Message-Id: <20170724172523.13135-7-sthemmin@microsoft.com>
In-Reply-To: <20170724172523.13135-1-sthemmin@microsoft.com>
References: <20170724172523.13135-1-sthemmin@microsoft.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 net/bluetooth/6lowpan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2af4f1cc0ab4..4e2576fc0c59 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -273,9 +273,6 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
 			   struct lowpan_peer *peer)
 {
 	const u8 *saddr;
-	struct lowpan_btle_dev *dev;
-
-	dev = lowpan_btle_dev(netdev);
 
 	saddr = peer->lladdr;
 
-- 
2.11.0

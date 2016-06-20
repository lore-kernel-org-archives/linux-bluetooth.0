Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org, aar@pengutronix.de,
	jukka.rissanen@linux.intel.com
Subject: [RFC 4/4] bluetooth: Do not set IFF_POINTOPOINT
Date: Mon, 20 Jun 2016 10:49:53 +0300
Message-Id: <1466408993-3808-5-git-send-email-patrik.flykt@linux.intel.com>
In-Reply-To: <1466408993-3808-1-git-send-email-patrik.flykt@linux.intel.com>
References: <1466408993-3808-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The IPv6 stack needs to send and receive Neighbor Discovery
messages. Remove the IFF_POINTOPOINT flag.

Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2dddb2b..1a70312 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -650,8 +650,7 @@ static void netdev_setup(struct net_device *dev)
 {
 	dev->hard_header_len	= 0;
 	dev->needed_tailroom	= 0;
-	dev->flags		= IFF_RUNNING | IFF_POINTOPOINT |
-				  IFF_MULTICAST;
+	dev->flags		= IFF_RUNNING | IFF_MULTICAST;
 	dev->watchdog_timeo	= 0;
 
 	dev->netdev_ops		= &netdev_ops;
-- 
2.8.1


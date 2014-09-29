Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: alex.aring@gmail.com
Subject: [PATCH 2/2] Bluetooth: 6lowpan: Enable multicast support
Date: Mon, 29 Sep 2014 16:37:26 +0300
Message-Id: <1411997846-23949-3-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1411997846-23949-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1411997846-23949-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set multicast support for 6lowpan network interface.
This is needed in every network interface that supports IPv6.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2ec7c84..f0432ae 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -648,7 +648,8 @@ static void netdev_setup(struct net_device *dev)
 	dev->needed_tailroom	= 0;
 	dev->mtu		= IPV6_MIN_MTU;
 	dev->tx_queue_len	= 0;
-	dev->flags		= IFF_RUNNING | IFF_POINTOPOINT;
+	dev->flags		= IFF_RUNNING | IFF_POINTOPOINT |
+				  IFF_MULTICAST;
 	dev->watchdog_timeo	= 0;
 
 	dev->netdev_ops		= &netdev_ops;
-- 
1.8.3.1


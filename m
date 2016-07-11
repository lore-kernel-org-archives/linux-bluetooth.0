Return-Path: <linux-wpan-owner@vger.kernel.org>
From: Alexander Aring <aar@pengutronix.de>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de,
	jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org,
	Patrik.Flykt@linux.intel.com, Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 06/20] 6lowpan: hold netdev while unregister
Date: Mon, 11 Jul 2016 21:50:30 +0200
Message-Id: <20160711195044.25343-7-aar@pengutronix.de>
In-Reply-To: <20160711195044.25343-1-aar@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I saw that unregister_netdevice will also free the netdev by running
dev_put. This may clash run debugfs exist, because it use netdevice
private data room.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 5945f7e..00ffab3 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -62,8 +62,10 @@ EXPORT_SYMBOL(lowpan_register_netdev);
 
 void lowpan_unregister_netdevice(struct net_device *dev)
 {
+	dev_hold(dev);
 	unregister_netdevice(dev);
 	lowpan_dev_debugfs_exit(dev);
+	dev_put(dev);
 }
 EXPORT_SYMBOL(lowpan_unregister_netdevice);
 
-- 
2.9.0


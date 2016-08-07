Return-Path: <linux-wpan-owner@vger.kernel.org>
From: Alexander Aring <aar@pengutronix.de>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org,
	Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 04/19] 6lowpan: hold netdev while unregister
Date: Sun,  7 Aug 2016 16:30:41 +0200
Message-Id: <20160807143056.3116-5-aar@pengutronix.de>
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de>
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
2.9.2


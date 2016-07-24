Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Alexander Aring <aar@pengutronix.de>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org,
	Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 1/2] mac802154: set phy net namespace for new ifaces
Date: Sun, 24 Jul 2016 16:12:24 +0200
Message-Id: <20160724141225.17591-1-aar@pengutronix.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch sets the net namespace when creating SoftMAC interfaces. This
is important if the namespace at phy layer was switched before.
Currently we losing interfaces in some namespace and it's not possible
to recover that.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/mac802154/iface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 7079cd3..06019db 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -663,6 +663,7 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 
 	/* TODO check this */
 	SET_NETDEV_DEV(ndev, &local->phy->dev);
+	dev_net_set(ndev, wpan_phy_net(local->hw.phy));
 	sdata = netdev_priv(ndev);
 	ndev->ieee802154_ptr = &sdata->wpan_dev;
 	memcpy(sdata->name, ndev->name, IFNAMSIZ);
-- 
2.9.0


Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: jukka.rissanen@linux.intel.com
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	kernel@pengutronix.de,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] bluetooth: 6lowpan: fix possible race
Date: Thu, 30 Jul 2015 09:40:53 +0200
Message-Id: <1438242053-15380-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix a possible race after calling register_netdev. After
calling netdev_register it could be possible that netdev_ops callbacks
use the uninitialized private data of lowpan_dev. By moving the
initialization of this data before netdev_register we can be sure that
initialized private data is be used after netdev_register.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/bluetooth/6lowpan.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2fb7b30..0ffe2e2 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -859,9 +859,22 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 	SET_NETDEV_DEV(netdev, &chan->conn->hcon->hdev->dev);
 	SET_NETDEV_DEVTYPE(netdev, &bt_type);
 
+	*dev = netdev_priv(netdev);
+	(*dev)->netdev = netdev;
+	(*dev)->hdev = chan->conn->hcon->hdev;
+	INIT_LIST_HEAD(&(*dev)->peers);
+
+	spin_lock(&devices_lock);
+	INIT_LIST_HEAD(&(*dev)->list);
+	list_add_rcu(&(*dev)->list, &bt_6lowpan_devices);
+	spin_unlock(&devices_lock);
+
 	err = register_netdev(netdev);
 	if (err < 0) {
 		BT_INFO("register_netdev failed %d", err);
+		spin_lock(&devices_lock);
+		list_del_rcu(&(*dev)->list);
+		spin_unlock(&devices_lock);
 		free_netdev(netdev);
 		goto out;
 	}
@@ -871,16 +884,6 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 	       &chan->src, chan->src_type);
 	set_bit(__LINK_STATE_PRESENT, &netdev->state);
 
-	*dev = netdev_priv(netdev);
-	(*dev)->netdev = netdev;
-	(*dev)->hdev = chan->conn->hcon->hdev;
-	INIT_LIST_HEAD(&(*dev)->peers);
-
-	spin_lock(&devices_lock);
-	INIT_LIST_HEAD(&(*dev)->list);
-	list_add_rcu(&(*dev)->list, &bt_6lowpan_devices);
-	spin_unlock(&devices_lock);
-
 	return 0;
 
 out:
-- 
2.5.0

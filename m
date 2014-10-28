Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/3] Bluetooth: 6lowpan: Fix lockdep splats
Date: Tue, 28 Oct 2014 17:16:48 +0200
Message-Id: <1414509409-11970-3-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1414509409-11970-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1414509409-11970-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a device ndo_start_xmit() calls again dev_queue_xmit(),
lockdep can complain because dev_queue_xmit() is re-entered and the
spinlocks protecting tx queues share a common lockdep class.

Same issue was fixed for ieee802154 in commit "20e7c4e80dcd"

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index a681247..7254bdd 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -662,7 +662,26 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
 	return err < 0 ? NET_XMIT_DROP : err;
 }
 
+static struct lock_class_key bt_tx_busylock;
+static struct lock_class_key bt_netdev_xmit_lock_key;
+
+static void bt_set_lockdep_class_one(struct net_device *dev,
+				     struct netdev_queue *txq,
+				     void *_unused)
+{
+	lockdep_set_class(&txq->_xmit_lock, &bt_netdev_xmit_lock_key);
+}
+
+static int bt_dev_init(struct net_device *dev)
+{
+	netdev_for_each_tx_queue(dev, bt_set_lockdep_class_one, NULL);
+	dev->qdisc_tx_busylock = &bt_tx_busylock;
+
+	return 0;
+}
+
 static const struct net_device_ops netdev_ops = {
+	.ndo_init		= bt_dev_init,
 	.ndo_start_xmit		= bt_xmit,
 };
 
-- 
1.8.3.1


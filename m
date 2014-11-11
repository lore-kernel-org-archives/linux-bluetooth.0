Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: 6lowpan: Remove unnecessary RCU callback
Date: Tue, 11 Nov 2014 14:16:29 +0200
Message-Id: <1415708189-7184-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When kfree() is all that's needed to free an object protected by RCU
there's a kfree_rcu() convenience function that can be used. This patch
updates the 6lowpan code to use this, thereby eliminating the need for
the separate peer_free() function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/6lowpan.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 3f20dce9d671..3d8ceb251d75 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -87,13 +87,6 @@ struct lowpan_dev {
 	struct delayed_work notify_peers;
 };
 
-static inline void peer_free(struct rcu_head *head)
-{
-	struct lowpan_peer *e = container_of(head, struct lowpan_peer, rcu);
-
-	kfree(e);
-}
-
 static inline struct lowpan_dev *lowpan_dev(const struct net_device *netdev)
 {
 	return netdev_priv(netdev);
@@ -108,7 +101,7 @@ static inline void peer_add(struct lowpan_dev *dev, struct lowpan_peer *peer)
 static inline bool peer_del(struct lowpan_dev *dev, struct lowpan_peer *peer)
 {
 	list_del_rcu(&peer->list);
-	call_rcu(&peer->rcu, peer_free);
+	kfree_rcu(peer, rcu);
 
 	module_put(THIS_MODULE);
 
@@ -1219,7 +1212,7 @@ static void disconnect_all_peers(void)
 		l2cap_chan_close(peer->chan, ENOENT);
 
 		list_del_rcu(&peer->list);
-		call_rcu(&peer->rcu, peer_free);
+		kfree_rcu(peer, rcu);
 
 		module_put(THIS_MODULE);
 	}
-- 
2.1.0


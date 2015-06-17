Return-Path: <cyrus@holtmann.org>
From: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
To: <marcel@holtmann.org>
CC: <jukka.rissanen@linux.intel.com>, <lukasz.duda@nordicsemi.no>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH 2/5] Bluetooth: 6lowpan: Rename ambiguous variable
Date: Wed, 17 Jun 2015 07:32:24 -0700
Message-ID: <1434551547-11210-3-git-send-email-glenn.ruben.bakke@nordicsemi.no>
In-Reply-To: <1434551547-11210-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
References: <1434551547-11210-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames the variable used to trigger scheduling of
delete_netdev. Changed to infinitiv in order to describe the action
to be done.

Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
---
 net/bluetooth/6lowpan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 3edc731..7ee591a 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -937,7 +937,7 @@ static void chan_close_cb(struct l2cap_chan *chan)
 	struct lowpan_dev *dev = NULL;
 	struct lowpan_peer *peer;
 	int err = -ENOENT;
-	bool last = false, removed = true;
+	bool last = false, remove = true;
 
 	BT_DBG("chan %p conn %p", chan, chan->conn);
 
@@ -948,7 +948,7 @@ static void chan_close_cb(struct l2cap_chan *chan)
 		/* If conn is set, then the netdev is also there and we should
 		 * not remove it.
 		 */
-		removed = false;
+		remove = false;
 	}
 
 	spin_lock(&devices_lock);
@@ -977,7 +977,7 @@ static void chan_close_cb(struct l2cap_chan *chan)
 
 		ifdown(dev->netdev);
 
-		if (removed) {
+		if (remove) {
 			INIT_WORK(&entry->delete_netdev, delete_netdev);
 			schedule_work(&entry->delete_netdev);
 		}
-- 
2.1.4

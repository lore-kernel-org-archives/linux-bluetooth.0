Return-Path: <cyrus@holtmann.org>
From: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
To: <marcel@holtmann.org>
CC: <jukka.rissanen@linux.intel.com>, <lukasz.duda@nordicsemi.no>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH 4/5] Bluetooth: 6lowpan: Fix double kfree of netdev priv
Date: Wed, 17 Jun 2015 07:32:26 -0700
Message-ID: <1434551547-11210-5-git-send-email-glenn.ruben.bakke@nordicsemi.no>
In-Reply-To: <1434551547-11210-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
References: <1434551547-11210-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the kfree of the netdev priv in device_event() upon
NETDEV_UNREGISTER event. The freeing of memory is taken care of by the
netdev destructor.

Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
---
 net/bluetooth/6lowpan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index bc105a9..071f9eb 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -928,7 +928,7 @@ static void delete_netdev(struct work_struct *work)
 
 	unregister_netdev(entry->netdev);
 
-	/* The entry pointer is deleted in device_event() */
+	/* The entry pointer is deleted by the netdev destructor. */
 }
 
 static void chan_close_cb(struct l2cap_chan *chan)
@@ -1418,7 +1418,6 @@ static int device_event(struct notifier_block *unused,
 				BT_DBG("Unregistered netdev %s %p",
 				       netdev->name, netdev);
 				list_del(&entry->list);
-				kfree(entry);
 				break;
 			}
 		}
-- 
2.1.4

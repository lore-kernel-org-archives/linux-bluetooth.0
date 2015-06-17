Return-Path: <cyrus@holtmann.org>
From: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
To: <marcel@holtmann.org>
CC: <jukka.rissanen@linux.intel.com>, <lukasz.duda@nordicsemi.no>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH 1/5] Bluetooth: 6lowpan: Enable delete_netdev to be scheduled when last peer is deleted
Date: Wed, 17 Jun 2015 07:32:23 -0700
Message-ID: <1434551547-11210-2-git-send-email-glenn.ruben.bakke@nordicsemi.no>
In-Reply-To: <1434551547-11210-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
References: <1434551547-11210-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes an issue with the netdev not being unregistered when
the last peer is deleted. Removing the logical negation operator on the
boolean solves this issue. If the last peer is removed the condition
will be true, and the delete_netdev() is scheduled.

Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
---
 net/bluetooth/6lowpan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index f3d6046..3edc731 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -977,7 +977,7 @@ static void chan_close_cb(struct l2cap_chan *chan)
 
 		ifdown(dev->netdev);
 
-		if (!removed) {
+		if (removed) {
 			INIT_WORK(&entry->delete_netdev, delete_netdev);
 			schedule_work(&entry->delete_netdev);
 		}
-- 
2.1.4

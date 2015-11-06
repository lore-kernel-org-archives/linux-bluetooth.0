Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add clarifying comment why schedule_work is used
Date: Fri,  6 Nov 2015 13:35:33 +0200
Message-Id: <1446809733-31134-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It's not obvious why schedule_work is used instead of queue_work. Add
a comment explaining why.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 85b82f7adbd2..fd6120a41138 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -178,6 +178,10 @@ static void hci_connect_le_scan_remove(struct hci_conn *conn)
 	hci_dev_hold(conn->hdev);
 	hci_conn_get(conn);
 
+	/* Even though we hold a reference to the hdev, many other
+	 * things might get cleaned up meanwhile, including the hdev's
+	 * own workqueue, so we can't use that for scheduling.
+	 */
 	schedule_work(&conn->le_scan_cleanup);
 }
 
-- 
2.5.0


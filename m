Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Fix reference counting for LE-scan based connections
Date: Fri, 16 Oct 2015 10:07:50 +0300
Message-Id: <1444979274-21622-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1444979274-21622-1-git-send-email-johan.hedberg@gmail.com>
References: <1444979274-21622-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The code should never directly call hci_conn_hash_del since many
cleanup & reference counting updates would be lost. Normally
hci_conn_del is the right thing to do, but in the case of a connection
doing LE scanning this could cause a deadlock due to doing a
cancel_delayed_work_sync() on the same work callback that we were
called from.

Connections in the LE scanning state actually need very little cleanup
- just a small subset of hci_conn_del. To solve the issue, refactor
out these essential pieces into a new hci_conn_cleanup() function and
call that from the two necessary places.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 53 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2ebcaaa6b855..4c240c1cb2cb 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -99,12 +99,41 @@ static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
 	}
 }
 
+static void hci_conn_cleanup(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+
+	if (test_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
+		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
+
+	hci_chan_list_flush(conn);
+
+	hci_conn_hash_del(hdev, conn);
+
+	if (hdev->notify)
+		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
+
+	hci_conn_del_sysfs(conn);
+
+	debugfs_remove_recursive(conn->debugfs);
+
+	hci_dev_put(hdev);
+
+	hci_conn_put(conn);
+}
+
 /* This function requires the caller holds hdev->lock */
 static void hci_connect_le_scan_remove(struct hci_conn *conn)
 {
 	hci_connect_le_scan_cleanup(conn);
 
-	hci_conn_hash_del(conn->hdev, conn);
+	/* We can't call hci_conn_del here since that would deadlock
+	 * with trying to call cancel_delayed_work_sync(&conn->disc_work).
+	 * Instead, call just hci_conn_cleanup() which contains the bare
+	 * minimum cleanup operations needed for a connection in this
+	 * state.
+	 */
+	hci_conn_cleanup(conn);
 }
 
 static void hci_acl_create_connection(struct hci_conn *conn)
@@ -582,27 +611,17 @@ int hci_conn_del(struct hci_conn *conn)
 		}
 	}
 
-	hci_chan_list_flush(conn);
-
 	if (conn->amp_mgr)
 		amp_mgr_put(conn->amp_mgr);
 
-	hci_conn_hash_del(hdev, conn);
-	if (hdev->notify)
-		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
-
 	skb_queue_purge(&conn->data_q);
 
-	hci_conn_del_sysfs(conn);
-
-	debugfs_remove_recursive(conn->debugfs);
-
-	if (test_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
-		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
-
-	hci_dev_put(hdev);
-
-	hci_conn_put(conn);
+	/* Remove the connection from the list and cleanup its remaining
+	 * state. This is a separate function since for some cases like
+	 * BT_CONNECT_SCAN we *only* want the cleanup part without the
+	 * rest of hci_conn_del.
+	 */
+	hci_conn_cleanup(conn);
 
 	return 0;
 }
-- 
2.4.3


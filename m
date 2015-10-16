Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: Fix double scan updates
Date: Fri, 16 Oct 2015 10:07:49 +0300
Message-Id: <1444979274-21622-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1444979274-21622-1-git-send-email-johan.hedberg@gmail.com>
References: <1444979274-21622-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Pawlowski <jpawlowski@google.com>

When disable/enable scan command is issued twice, some controllers
will return an error for the second request, i.e. requests with this
command will fail on some controllers, and succeed on others.

This patch makes sure that unnecessary scan disable/enable commands
are not issued.

When adding device to the auto connect whitelist when there is pending
connect attempt, there is no need to update scan.

hci_connect_le_scan_cleanup is conditionally executing
hci_conn_params_del, that is calling hci_update_background_scan. Make
the other case also update scan, and remove reduntand call from
hci_connect_le_scan_remove.

When stopping interleaved discovery the state should be set to stopped
only when both LE scanning and discovery has stopped.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c  | 7 ++++---
 net/bluetooth/hci_event.c | 7 ++++++-
 net/bluetooth/mgmt.c      | 6 +++++-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b4548c739a64..2ebcaaa6b855 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -91,10 +91,12 @@ static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
 	 * autoconnect action, remove them completely. If they are, just unmark
 	 * them as waiting for connection, by clearing explicit_connect field.
 	 */
-	if (params->auto_connect == HCI_AUTO_CONN_EXPLICIT)
+	if (params->auto_connect == HCI_AUTO_CONN_EXPLICIT) {
 		hci_conn_params_del(conn->hdev, bdaddr, bdaddr_type);
-	else
+	} else {
 		params->explicit_connect = false;
+		hci_update_background_scan(conn->hdev);
+	}
 }
 
 /* This function requires the caller holds hdev->lock */
@@ -103,7 +105,6 @@ static void hci_connect_le_scan_remove(struct hci_conn *conn)
 	hci_connect_le_scan_cleanup(conn);
 
 	hci_conn_hash_del(conn->hdev, conn);
-	hci_update_background_scan(conn->hdev);
 }
 
 static void hci_acl_create_connection(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 186041866315..509e41575633 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -55,7 +55,12 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	wake_up_bit(&hdev->flags, HCI_INQUIRY);
 
 	hci_dev_lock(hdev);
-	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+	/* Set discovery state to stopped if we're not doing LE active
+	 * scanning.
+	 */
+	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+	    hdev->le_scan_type != LE_SCAN_ACTIVE)
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	hci_dev_unlock(hdev);
 
 	hci_conn_check_pending(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ccaf5a436d8f..9a9bbc990d4f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6124,7 +6124,11 @@ static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
 	case HCI_AUTO_CONN_ALWAYS:
 		if (!is_connected(hdev, addr, addr_type)) {
 			list_add(&params->action, &hdev->pend_le_conns);
-			__hci_update_background_scan(req);
+			/* If we are in scan phase of connecting, we were
+			 * already added to pend_le_conns and scanning.
+			 */
+			if (params->auto_connect != HCI_AUTO_CONN_EXPLICIT)
+				__hci_update_background_scan(req);
 		}
 		break;
 	}
-- 
2.4.3


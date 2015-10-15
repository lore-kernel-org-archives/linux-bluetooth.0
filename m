Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] Bluetooth: fix double scan updates
Date: Thu, 15 Oct 2015 12:53:58 -0700
Message-Id: <1444938838-3225-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When disble/enable scan command is issued twice, some controllers would
return error for second request. Therefore requests including those would
fail on some controllers, and succeed on others.

This patch makes sure that unnecessary scan disable/enable is not issued.

When adding device to auto connect whitelist when there is pending connect
attempt, there is no need to update scan.

hci_connect_le_scan_cleanup is conditionally executing
hci_conn_params_del, that is calling hci_update_background_scan. Make the
other case also update scan, and remove reduntand call from
hci_connect_le_scan_remove.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/hci_conn.c | 7 ++++---
 net/bluetooth/mgmt.c     | 6 +++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b4548c73..2ebcaaa 100644
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
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ccaf5a4..af29a3d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6124,7 +6124,11 @@ static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
 	case HCI_AUTO_CONN_ALWAYS:
 		if (!is_connected(hdev, addr, addr_type)) {
 			list_add(&params->action, &hdev->pend_le_conns);
-			__hci_update_background_scan(req);
+			/* If we are connecting to device using random address,
+			 * we were already added to pend_le_conns and scanning.
+			 */
+			if (params->auto_connect != HCI_AUTO_CONN_EXPLICIT)
+				__hci_update_background_scan(req);
 		}
 		break;
 	}
-- 
2.5.0


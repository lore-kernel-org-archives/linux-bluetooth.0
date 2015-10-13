Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v2 2/2] Bluetooth: fix double scan disable
Date: Tue, 13 Oct 2015 10:22:19 -0700
Message-Id: <1444756939-28776-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1444756939-28776-1-git-send-email-jpawlowski@google.com>
References: <1444756939-28776-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hci_connect_le_scan_cleanup is conditionally executing
hci_conn_params_del, that is calling hci_update_background_scan. Make the
other case also update scan, and remove reduntand call from
hci_connect_le_scan_remove.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/hci_conn.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

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
-- 
2.6.0.rc2.230.g3dd15c0


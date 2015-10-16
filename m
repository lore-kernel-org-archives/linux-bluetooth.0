Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Fix conn_params list update in hci_connect_le_scan_cleanup
Date: Fri, 16 Oct 2015 08:41:42 +0300
Message-Id: <1444974102-32379-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1444974102-32379-1-git-send-email-johan.hedberg@gmail.com>
References: <1444974102-32379-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

After clearing the params->explicit_connect variable the parameters
may need to be either added back to the right list or potentially left
absent from both the le_reports and the le_conns lists.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d5c06eeab4a3..fe99025fb649 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -91,12 +91,27 @@ static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
 	 * autoconnect action, remove them completely. If they are, just unmark
 	 * them as waiting for connection, by clearing explicit_connect field.
 	 */
-	if (params->auto_connect == HCI_AUTO_CONN_EXPLICIT) {
+	params->explicit_connect = false;
+
+	list_del_init(&params->action);
+
+	switch (params->auto_connect) {
+	case HCI_AUTO_CONN_EXPLICIT:
 		hci_conn_params_del(conn->hdev, bdaddr, bdaddr_type);
-	} else {
-		params->explicit_connect = false;
-		hci_update_background_scan(conn->hdev);
+		/* return instead of break to avoid duplicate scan update */
+		return;
+	case HCI_AUTO_CONN_DIRECT:
+	case HCI_AUTO_CONN_ALWAYS:
+		list_add(&params->action, &conn->hdev->pend_le_conns);
+		break;
+	case HCI_AUTO_CONN_REPORT:
+		list_add(&params->action, &conn->hdev->pend_le_reports);
+		break;
+	default:
+		break;
 	}
+
+	hci_update_background_scan(conn->hdev);
 }
 
 static void hci_conn_cleanup(struct hci_conn *conn)
-- 
2.4.3


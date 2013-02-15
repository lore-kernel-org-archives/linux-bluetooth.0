Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 6/8] Bluetooth: Handle hci_conn timeout in BT_CONNECT
Date: Fri, 15 Feb 2013 20:27:06 -0300
Message-Id: <1360970828-24004-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
References: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to properly cancel an ongoing LE connection attempt (hci_conn
in BT_CONNECT state), we need to check the current le_state.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c  | 20 +++++++++++++++++++-
 net/bluetooth/hci_event.c | 11 +++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 308c87a..e259745 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -258,6 +258,24 @@ static void hci_conn_disconnect(struct hci_conn *conn)
 	}
 }
 
+static void cancel_le_connection(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+
+	BT_DBG("conn %p le state %d", conn, atomic_read(&conn->le_state));
+
+	switch (atomic_read(&conn->le_state)) {
+	case HCI_CONN_LE_SCAN:
+		hci_cancel_le_scan(hdev);
+		break;
+	case HCI_CONN_LE_INITIATE:
+		hci_le_create_connection_cancel(conn);
+		break;
+	}
+
+	hci_conn_set_le_state(conn, 0);
+}
+
 static void hci_conn_timeout(struct work_struct *work)
 {
 	struct hci_conn *conn = container_of(work, struct hci_conn,
@@ -275,7 +293,7 @@ static void hci_conn_timeout(struct work_struct *work)
 			if (conn->type == ACL_LINK)
 				hci_acl_create_connection_cancel(conn);
 			else if (conn->type == LE_LINK)
-				hci_le_create_connection_cancel(conn);
+				cancel_le_connection(conn);
 		}
 		break;
 	case BT_CONFIG:
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 84648c8..625eada 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1296,6 +1296,17 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
+		hcon = hci_conn_hash_lookup_le_state(hdev, 0);
+		if (hcon) {
+			mgmt_connect_failed(hdev, &hcon->dst, hcon->type,
+					    hcon->dst_type,
+					    HCI_ERROR_LOCAL_HOST_TERM);
+
+			hcon->state = BT_CLOSED;
+			hci_proto_connect_cfm(hcon, HCI_ERROR_LOCAL_HOST_TERM);
+			hci_conn_del(hcon);
+		}
+
 		hcon = hci_conn_hash_lookup_le_state(hdev, HCI_CONN_LE_FOUND);
 		if (hcon) {
 			hci_dev_lock(hdev);
-- 
1.8.1.2


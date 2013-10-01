Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Refactor LE Connection Complete HCI event handler
Date: Tue,  1 Oct 2013 20:03:55 -0300
Message-Id: <1380668636-30654-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does some code refactorig in LE Connection Complete HCI
event handler. It basically adds a switch statement to separate new
master connection code from new slave connection code.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   | 55 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7ede266..8c98f60 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1442,6 +1442,7 @@ struct hci_ev_num_comp_blocks {
 
 /* Low energy meta events */
 #define LE_CONN_ROLE_MASTER	0x00
+#define LE_CONN_ROLE_SLAVE	0x01
 
 #define HCI_EV_LE_CONN_COMPLETE		0x01
 struct hci_ev_le_conn_complete {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1d1ffa6..0e4a9f4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3444,8 +3444,42 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
-	if (!conn) {
+	if (ev->status) {
+		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+		if (!conn)
+			goto unlock;
+
+		mgmt_connect_failed(hdev, &conn->dst, conn->type,
+				    conn->dst_type, ev->status);
+		hci_proto_connect_cfm(conn, ev->status);
+		conn->state = BT_CLOSED;
+		hci_conn_del(conn);
+		goto unlock;
+	}
+
+	switch (ev->role) {
+	case LE_CONN_ROLE_MASTER:
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &ev->bdaddr);
+		/* If there is no hci_conn object with the given address, it
+		 * means this new connection was triggered through HCI socket
+		 * interface. For that case, we should create a new hci_conn
+		 * object.
+		 */
+		if (!conn) {
+			conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr);
+			if (!conn) {
+				BT_ERR("No memory for new connection");
+				goto unlock;
+			}
+
+			conn->out = true;
+			conn->link_mode |= HCI_LM_MASTER;
+			conn->sec_level = BT_SECURITY_LOW;
+			conn->dst_type = ev->bdaddr_type;
+		}
+		break;
+
+	case LE_CONN_ROLE_SLAVE:
 		conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr);
 		if (!conn) {
 			BT_ERR("No memory for new connection");
@@ -3453,19 +3487,11 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 
 		conn->dst_type = ev->bdaddr_type;
+		conn->sec_level = BT_SECURITY_LOW;
+		break;
 
-		if (ev->role == LE_CONN_ROLE_MASTER) {
-			conn->out = true;
-			conn->link_mode |= HCI_LM_MASTER;
-		}
-	}
-
-	if (ev->status) {
-		mgmt_connect_failed(hdev, &conn->dst, conn->type,
-				    conn->dst_type, ev->status);
-		hci_proto_connect_cfm(conn, ev->status);
-		conn->state = BT_CLOSED;
-		hci_conn_del(conn);
+	default:
+		BT_ERR("Used reserved Role parameter %d", ev->role);
 		goto unlock;
 	}
 
@@ -3473,7 +3499,6 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		mgmt_device_connected(hdev, &ev->bdaddr, conn->type,
 				      conn->dst_type, 0, NULL, 0, NULL);
 
-	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
 	conn->state = BT_CONNECTED;
 
-- 
1.8.4


Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Locking in hci_le_conn_complete_evt
Date: Tue,  1 Oct 2013 20:03:56 -0300
Message-Id: <1380668636-30654-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves hci_dev_lock and hci_dev_unlock calls to where they
are really required, reducing the critical region in hci_le_conn_
complete_evt function. hdev->lock is required only in hci_conn_del
and hci_conn_add call to protect concurrent add and remove operations
in hci_conn_hash list.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0e4a9f4..ffd5186 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3442,19 +3442,20 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
-	hci_dev_lock(hdev);
-
 	if (ev->status) {
 		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
 		if (!conn)
-			goto unlock;
+			return;
 
 		mgmt_connect_failed(hdev, &conn->dst, conn->type,
 				    conn->dst_type, ev->status);
 		hci_proto_connect_cfm(conn, ev->status);
 		conn->state = BT_CLOSED;
+
+		hci_dev_lock(hdev);
 		hci_conn_del(conn);
-		goto unlock;
+		hci_dev_unlock(hdev);
+		return;
 	}
 
 	switch (ev->role) {
@@ -3466,10 +3467,13 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		 * object.
 		 */
 		if (!conn) {
+			hci_dev_lock(hdev);
 			conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr);
+			hci_dev_unlock(hdev);
+
 			if (!conn) {
 				BT_ERR("No memory for new connection");
-				goto unlock;
+				return;
 			}
 
 			conn->out = true;
@@ -3480,10 +3484,13 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 
 	case LE_CONN_ROLE_SLAVE:
+		hci_dev_lock(hdev);
 		conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr);
+		hci_dev_unlock(hdev);
+
 		if (!conn) {
 			BT_ERR("No memory for new connection");
-			goto unlock;
+			return;
 		}
 
 		conn->dst_type = ev->bdaddr_type;
@@ -3492,7 +3499,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	default:
 		BT_ERR("Used reserved Role parameter %d", ev->role);
-		goto unlock;
+		return;
 	}
 
 	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
@@ -3505,9 +3512,6 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_conn_add_sysfs(conn);
 
 	hci_proto_connect_cfm(conn, ev->status);
-
-unlock:
-	hci_dev_unlock(hdev);
 }
 
 static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.8.4


Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Refactor in hci_le_conn_complete_evt
Date: Fri, 27 Jul 2012 15:10:16 -0300
Message-Id: <1343412616-25641-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1343412616-25641-1-git-send-email-andre.guedes@openbossa.org>
References: <1343412616-25641-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves the hci_conn check to begining of hci_le_conn_
complete_evt in order to improve code's readability and better
error handling.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 92522b4..32e21ad 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3334,19 +3334,6 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
-
-	if (ev->status) {
-		if (!conn)
-			goto unlock;
-
-		mgmt_connect_failed(hdev, &conn->dst, conn->type,
-				    conn->dst_type, ev->status);
-		hci_proto_connect_cfm(conn, ev->status);
-		conn->state = BT_CLOSED;
-		hci_conn_del(conn);
-		goto unlock;
-	}
-
 	if (!conn) {
 		conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr);
 		if (!conn) {
@@ -3362,6 +3349,15 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
+	if (ev->status) {
+		mgmt_connect_failed(hdev, &conn->dst, conn->type,
+				    conn->dst_type, ev->status);
+		hci_proto_connect_cfm(conn, ev->status);
+		conn->state = BT_CLOSED;
+		hci_conn_del(conn);
+		goto unlock;
+	}
+
 	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
 		mgmt_device_connected(hdev, &ev->bdaddr, conn->type,
 				      conn->dst_type, 0, NULL, 0, NULL);
-- 
1.7.11.2


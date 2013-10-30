Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 5/5] Bluetooth: Refactor hci_disconn_complete_evt
Date: Wed, 30 Oct 2013 19:01:44 -0300
Message-Id: <1383170504-16602-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1383170504-16602-1-git-send-email-andre.guedes@openbossa.org>
References: <1383170504-16602-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hci_disconn_complete_evt() logic is more complicated than what it
should be, making it hard to follow and add new features.

So this patch does some code refactoring by handling the error cases
in the beginning of the function and by moving the main flow into the
first level of function scope. No change is done in the event handling
logic itself.

Besides organizing this messy code, this patch makes easier to add
code for handling LE auto connection (which will be added in a further
patch).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 56 +++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9225a9c..981d858 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1782,7 +1782,9 @@ static u8 hci_to_mgmt_reason(u8 err)
 static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_disconn_complete *ev = (void *) skb->data;
+	u8 reason = hci_to_mgmt_reason(ev->reason);
 	struct hci_conn *conn;
+	u8 type;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -1792,40 +1794,38 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!conn)
 		goto unlock;
 
-	if (ev->status == 0)
-		conn->state = BT_CLOSED;
-
 	if (ev->status) {
 		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
-				conn->dst_type, ev->status);
-	} else {
-		u8 reason = hci_to_mgmt_reason(ev->reason);
-
-		mgmt_device_disconnected(hdev, &conn->dst, conn->type,
-				conn->dst_type, reason);
+				       conn->dst_type, ev->status);
+		goto unlock;
 	}
 
-	if (ev->status == 0) {
-		u8 type = conn->type;
+	conn->state = BT_CLOSED;
 
-		if (type == ACL_LINK && conn->flush_key)
-			hci_remove_link_key(hdev, &conn->dst);
-		hci_proto_disconn_cfm(conn, ev->reason);
-		hci_conn_del(conn);
+	mgmt_device_disconnected(hdev, &conn->dst, conn->type,
+				 conn->dst_type, reason);
 
-		/* Re-enable advertising if necessary, since it might
-		 * have been disabled by the connection. From the
-		 * HCI_LE_Set_Advertise_Enable command description in
-		 * the core specification (v4.0):
-		 * "The Controller shall continue advertising until the Host
-		 * issues an LE_Set_Advertise_Enable command with
-		 * Advertising_Enable set to 0x00 (Advertising is disabled)
-		 * or until a connection is created or until the Advertising
-		 * is timed out due to Directed Advertising."
-		 */
-		if (type == LE_LINK)
-			mgmt_reenable_advertising(hdev);
-	}
+
+	if (conn->type == ACL_LINK && conn->flush_key)
+		hci_remove_link_key(hdev, &conn->dst);
+
+	type = conn->type;
+
+	hci_proto_disconn_cfm(conn, ev->reason);
+	hci_conn_del(conn);
+
+	/* Re-enable advertising if necessary, since it might
+	 * have been disabled by the connection. From the
+	 * HCI_LE_Set_Advertise_Enable command description in
+	 * the core specification (v4.0):
+	 * "The Controller shall continue advertising until the Host
+	 * issues an LE_Set_Advertise_Enable command with
+	 * Advertising_Enable set to 0x00 (Advertising is disabled)
+	 * or until a connection is created or until the Advertising
+	 * is timed out due to Directed Advertising."
+	 */
+	if (type == LE_LINK)
+	   mgmt_reenable_advertising(hdev);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
1.8.4


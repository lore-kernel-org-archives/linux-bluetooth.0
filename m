Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Refactor hci_disconn_complete_evt
Date: Thu,  7 Nov 2013 17:36:10 -0300
Message-Id: <1383856570-30480-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1383856570-30480-1-git-send-email-andre.guedes@openbossa.org>
References: <1383856570-30480-1-git-send-email-andre.guedes@openbossa.org>
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
 net/bluetooth/hci_event.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index eb99a12..5fb3df6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1781,6 +1781,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	struct hci_ev_disconn_complete *ev = (void *) skb->data;
 	u8 reason = hci_to_mgmt_reason(ev->reason);
 	struct hci_conn *conn;
+	u8 type;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -1790,40 +1791,38 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!conn)
 		goto unlock;
 
-	if (ev->status == 0)
-		conn->state = BT_CLOSED;
-
 	if (ev->status) {
 		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
 				       conn->dst_type, ev->status);
 		goto unlock;
 	}
 
+	conn->state = BT_CLOSED;
+
 	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
 		mgmt_device_disconnected(hdev, &conn->dst, conn->type,
 					 conn->dst_type, reason);
 
-	if (ev->status == 0) {
-		u8 type = conn->type;
+	if (conn->type == ACL_LINK && conn->flush_key)
+		hci_remove_link_key(hdev, &conn->dst);
 
-		if (type == ACL_LINK && conn->flush_key)
-			hci_remove_link_key(hdev, &conn->dst);
-		hci_proto_disconn_cfm(conn, ev->reason);
-		hci_conn_del(conn);
+	type = conn->type;
 
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
+		mgmt_reenable_advertising(hdev);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
1.8.4


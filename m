Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Remove unneeded check in hci_disconn_complete_evt()
Date: Thu,  7 Nov 2013 17:36:09 -0300
Message-Id: <1383856570-30480-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to b644ba336 (patch that introduced HCI_CONN_MGMT_CONNECTED
flag), the HCI_CONN_MGMT_CONNECTED flag tracks when mgmt has been
notified about the connection.

That being said, there is no point in calling mgmt_disconnect_failed()
conditionally based on this flag. mgmt_disconnect_failed() removes
pending MGMT_OP_DISCONNECT commands, it doesn't matter if that
connection was notified or not.

Moreover, if the Disconnection Complete event has status then we have
nothing else to do but call mgmt_disconnect_failed() and return.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 142aa61..eb99a12 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1779,6 +1779,7 @@ static u8 hci_to_mgmt_reason(u8 err)
 static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_disconn_complete *ev = (void *) skb->data;
+	u8 reason = hci_to_mgmt_reason(ev->reason);
 	struct hci_conn *conn;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
@@ -1792,18 +1793,16 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (ev->status == 0)
 		conn->state = BT_CLOSED;
 
-	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
-		if (ev->status) {
-			mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
-					       conn->dst_type, ev->status);
-		} else {
-			u8 reason = hci_to_mgmt_reason(ev->reason);
-
-			mgmt_device_disconnected(hdev, &conn->dst, conn->type,
-						 conn->dst_type, reason);
-		}
+	if (ev->status) {
+		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
+				       conn->dst_type, ev->status);
+		goto unlock;
 	}
 
+	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+		mgmt_device_disconnected(hdev, &conn->dst, conn->type,
+					 conn->dst_type, reason);
+
 	if (ev->status == 0) {
 		u8 type = conn->type;
 
-- 
1.8.4


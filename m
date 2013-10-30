Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 4/5] Bluetooth: Remove unneeded check in hci_disconn_complete_evt()
Date: Wed, 30 Oct 2013 19:01:43 -0300
Message-Id: <1383170504-16602-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1383170504-16602-1-git-send-email-andre.guedes@openbossa.org>
References: <1383170504-16602-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to b644ba336 (patch that introduced HCI_CONN_MGMT_CONNECTED
flag), the HCI_CONN_MGMT_CONNECTED flag tracks when mgmt has been
notified about the connection.

That being said, there is no point in checking this flag in hci_
disconn_complete_evt() since neither mgmt_disconnect_failed() nor
mgmt_device_disconnected() depend on it. Below follows more details:
  * mgmt_disconnect_failed() removes pending MGMT_OP_DISCONNECT
    commands, it doesn't matter if that connection was notified or not.
  * mgmt_device_disconnected() sends the mgmt event only if the link
    type is ACL_LINK or LE_LINK. For those connection type, the flag is
    always set.

So this patch removes the HCI_CONN_MGMT_CONNECTED check.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4673cfb..9225a9c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1795,16 +1795,14 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (ev->status == 0)
 		conn->state = BT_CLOSED;
 
-	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
-		if (ev->status) {
-			mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
-					       conn->dst_type, ev->status);
-		} else {
-			u8 reason = hci_to_mgmt_reason(ev->reason);
+	if (ev->status) {
+		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
+				conn->dst_type, ev->status);
+	} else {
+		u8 reason = hci_to_mgmt_reason(ev->reason);
 
-			mgmt_device_disconnected(hdev, &conn->dst, conn->type,
-						 conn->dst_type, reason);
-		}
+		mgmt_device_disconnected(hdev, &conn->dst, conn->type,
+				conn->dst_type, reason);
 	}
 
 	if (ev->status == 0) {
-- 
1.8.4


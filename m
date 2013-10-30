Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/5] Bluetooth: Remove link type check in hci_disconn_complete_evt()
Date: Wed, 30 Oct 2013 19:01:42 -0300
Message-Id: <1383170504-16602-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1383170504-16602-1-git-send-email-andre.guedes@openbossa.org>
References: <1383170504-16602-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We can safely remove the link type check from hci_disconn_complete_
evt() since this check in not required for mgmt_disconnect_failed()
and mgmt_device_disconnected() does it internally.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5935f74..4673cfb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1795,8 +1795,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (ev->status == 0)
 		conn->state = BT_CLOSED;
 
-	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags) &&
-	    (conn->type == ACL_LINK || conn->type == LE_LINK)) {
+	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
 		if (ev->status) {
 			mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
 					       conn->dst_type, ev->status);
-- 
1.8.4


Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Remove one level of indentation from hci_encrypt_change_evt
Date: Fri, 31 Jan 2014 16:24:27 -0800
Message-Id: <1391214268-13443-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The function already has an unlock label which means the one extra level
on indentation is not useful and just makes the code more complex. So
remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 49 ++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7bb8094a3ff2..62aea2edc231 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1988,35 +1988,36 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
-	if (conn) {
-		if (!ev->status) {
-			if (ev->encrypt) {
-				/* Encryption implies authentication */
-				conn->link_mode |= HCI_LM_AUTH;
-				conn->link_mode |= HCI_LM_ENCRYPT;
-				conn->sec_level = conn->pending_sec_level;
-			} else
-				conn->link_mode &= ~HCI_LM_ENCRYPT;
-		}
-
-		clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
+	if (!conn)
+		goto unlock;
 
-		if (ev->status && conn->state == BT_CONNECTED) {
-			hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
-			hci_conn_drop(conn);
-			goto unlock;
-		}
+	if (!ev->status) {
+		if (ev->encrypt) {
+			/* Encryption implies authentication */
+			conn->link_mode |= HCI_LM_AUTH;
+			conn->link_mode |= HCI_LM_ENCRYPT;
+			conn->sec_level = conn->pending_sec_level;
+		} else
+			conn->link_mode &= ~HCI_LM_ENCRYPT;
+	}
 
-		if (conn->state == BT_CONFIG) {
-			if (!ev->status)
-				conn->state = BT_CONNECTED;
+	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
-			hci_proto_connect_cfm(conn, ev->status);
-			hci_conn_drop(conn);
-		} else
-			hci_encrypt_cfm(conn, ev->status, ev->encrypt);
+	if (ev->status && conn->state == BT_CONNECTED) {
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_conn_drop(conn);
+		goto unlock;
 	}
 
+	if (conn->state == BT_CONFIG) {
+		if (!ev->status)
+			conn->state = BT_CONNECTED;
+
+		hci_proto_connect_cfm(conn, ev->status);
+		hci_conn_drop(conn);
+	} else
+		hci_encrypt_cfm(conn, ev->status, ev->encrypt);
+
 unlock:
 	hci_dev_unlock(hdev);
 }
-- 
1.8.5.3


Return-Path: <cyrus@holtmann.org>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] bluetooth:Fix error handling in various functions in the file hci_event.c
Date: Thu, 20 Aug 2015 10:02:12 -0400
Message-Id: <1440079332-20283-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes error handling in various functions to check if their
internal call to the function hci_disconnect has failed and if so
jump to their respective label for unlocking the passed hci_dev
structure pointer before returning directly to their caller(s)
for functions in the file hci_event.c.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/hci_event.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 32363c2..0df69f7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2086,7 +2086,8 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 	if (conn->state != BT_CONNECTED)
 		goto unlock;
 
-	hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+	if (hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE))
+		goto unlock;
 	hci_conn_drop(conn);
 
 unlock:
@@ -2702,7 +2703,8 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
 	if (ev->status && conn->state == BT_CONNECTED) {
-		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		if (hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE))
+			goto unlock;
 		hci_conn_drop(conn);
 		goto unlock;
 	}
@@ -3975,7 +3977,8 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev,
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
 	if (ev->status && conn->state == BT_CONNECTED) {
-		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		if (hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE))
+			goto unlock;
 		hci_conn_drop(conn);
 		goto unlock;
 	}
-- 
2.1.4

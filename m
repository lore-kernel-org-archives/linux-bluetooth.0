Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Enforce strict Secure Connections Only mode security
Date: Wed, 19 Mar 2014 14:10:25 -0700
Message-Id: <1395263425-5744-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In Secure Connections Only mode, it is required that Secure Connections
is used for pairing and that the link key is encrypted with AES-CCM using
a P-256 authenticated combination key. If this is not the case, then new
connection shall be refused or existing connections shall be dropped.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c  | 11 +++++++++++
 net/bluetooth/hci_event.c | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b4809e473a19..d958e2dca52f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -781,6 +781,17 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 {
 	BT_DBG("hcon %p", conn);
 
+	/* In Secure Connections Only mode, it is required that Secure
+	 * Connections is used and the link is encrypted with AES-CCM
+	 * using a P-256 authenticated combination key.
+	 */
+	if (test_bit(HCI_SC_ONLY, &conn->hdev->flags)) {
+		if (!hci_conn_sc_enabled(conn) ||
+		    !test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
+		    conn->key_type != HCI_LK_AUTH_COMBINATION_P256)
+			return 0;
+	}
+
 	if (hci_conn_ssp_enabled(conn) && !(conn->link_mode & HCI_LM_ENCRYPT))
 		return 0;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e97f1905aa5c..a6a3d32553c5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2183,6 +2183,18 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		if (!ev->status)
 			conn->state = BT_CONNECTED;
 
+		/* In Secure Connections Only mode, do not allow any
+		 * connections that are not encrypted with AES-CCM
+		 * using a P-256 authenticated combination key.
+		 */
+		if (test_bit(HCI_SC_ONLY, &hdev->dev_flags) &&
+		    (!test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
+		     conn->key_type != HCI_LK_AUTH_COMBINATION_P256)) {
+			hci_proto_connect_cfm(conn, HCI_ERROR_AUTH_FAILURE);
+			hci_conn_drop(conn);
+			goto unlock;
+		}
+
 		hci_proto_connect_cfm(conn, ev->status);
 		hci_conn_drop(conn);
 	} else
-- 
1.8.5.3


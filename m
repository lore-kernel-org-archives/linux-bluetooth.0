Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] Bluetooth: Rename hci_conn variable in hci_connect_le()
Date: Thu,  3 Oct 2013 18:25:44 -0300
Message-Id: <1380835547-3640-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1380835547-3640-1-git-send-email-andre.guedes@openbossa.org>
References: <1380835547-3640-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch simply rename the hci_conn variable "le" to "conn"
since it is a better name.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 514148b..5aba520 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -549,31 +549,31 @@ EXPORT_SYMBOL(hci_get_route);
 static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				    u8 dst_type, u8 sec_level, u8 auth_type)
 {
-	struct hci_conn *le;
+	struct hci_conn *conn;
 
 	if (test_bit(HCI_LE_PERIPHERAL, &hdev->flags))
 		return ERR_PTR(-ENOTSUPP);
 
-	le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
-	if (!le) {
-		le = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
-		if (le)
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
+	if (!conn) {
+		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+		if (conn)
 			return ERR_PTR(-EBUSY);
 
-		le = hci_conn_add(hdev, LE_LINK, dst);
-		if (!le)
+		conn = hci_conn_add(hdev, LE_LINK, dst);
+		if (!conn)
 			return ERR_PTR(-ENOMEM);
 
-		le->dst_type = bdaddr_to_le(dst_type);
-		hci_le_create_connection(le);
+		conn->dst_type = bdaddr_to_le(dst_type);
+		hci_le_create_connection(conn);
 	}
 
-	le->pending_sec_level = sec_level;
-	le->auth_type = auth_type;
+	conn->pending_sec_level = sec_level;
+	conn->auth_type = auth_type;
 
-	hci_conn_hold(le);
+	hci_conn_hold(conn);
 
-	return le;
+	return conn;
 }
 
 static struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
-- 
1.8.4


Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/2] Bluetooth: Refactor hci_connect_le
Date: Tue,  8 Oct 2013 08:21:18 -0300
Message-Id: <1381231278-20534-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1381231278-20534-1-git-send-email-andre.guedes@openbossa.org>
References: <1381231278-20534-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does some code refactoring in hci_connect_le() by moving
the exception code into if statements and letting the main flow in
first level of function scope. It also adds extra comments to improve
the code readability.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 51 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1800b50..dedd1ea 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -594,32 +594,47 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	if (test_bit(HCI_ADVERTISING, &hdev->flags))
 		return ERR_PTR(-ENOTSUPP);
 
+	/* Some devices send ATT messages as soon as the physical link is
+	 * established. To be able to handle these ATT messages, the user-
+	 * space first establishes the connection and then starts the pairing
+	 * process.
+	 *
+	 * So if a hci_conn object already exists for the following connection
+	 * attempt, we simply update pending_sec_level and auth_type fields
+	 * and return the object found.
+	 */
 	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
-	if (!conn) {
-		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
-		if (conn)
-			return ERR_PTR(-EBUSY);
-
-		conn = hci_conn_add(hdev, LE_LINK, dst);
-		if (!conn)
-			return ERR_PTR(-ENOMEM);
+	if (conn) {
+		conn->pending_sec_level = sec_level;
+		conn->auth_type = auth_type;
+		goto done;
+	}
 
-		conn->dst_type = bdaddr_to_le(dst_type);
-		conn->state = BT_CONNECT;
-		conn->out = true;
-		conn->link_mode |= HCI_LM_MASTER;
-		conn->sec_level = BT_SECURITY_LOW;
+	/* Since the controller supports only one LE connection attempt at a
+	 * time, we return -EBUSY if there is any connection attempt running.
+	 */
+	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+	if (conn)
+		return ERR_PTR(-EBUSY);
 
-		err = hci_create_le_conn(conn);
-		if (err)
-			return ERR_PTR(err);
-	}
+	conn = hci_conn_add(hdev, LE_LINK, dst);
+	if (!conn)
+		return ERR_PTR(-ENOMEM);
 
+	conn->dst_type = bdaddr_to_le(dst_type);
+	conn->state = BT_CONNECT;
+	conn->out = true;
+	conn->link_mode |= HCI_LM_MASTER;
+	conn->sec_level = BT_SECURITY_LOW;
 	conn->pending_sec_level = sec_level;
 	conn->auth_type = auth_type;
 
-	hci_conn_hold(conn);
+	err = hci_create_le_conn(conn);
+	if (err)
+		return ERR_PTR(err);
 
+done:
+	hci_conn_hold(conn);
 	return conn;
 }
 
-- 
1.8.4


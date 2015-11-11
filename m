Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Remove conn_unfinished variable from hci_connect_le()
Date: Wed, 11 Nov 2015 14:44:59 +0200
Message-Id: <1447245899-30783-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447245899-30783-1-git-send-email-johan.hedberg@gmail.com>
References: <1447245899-30783-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The conn_unfinished variable makes the entire logic of
hci_connect_le() rather confusing. By restructuring and clarifying the
logic we can actually remove the conn_unfinished variable and still
keep the same behavior.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 48 ++++++++++++------------------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 08a291dd0f3a..2d334e07fd77 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -785,7 +785,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 role)
 {
 	struct hci_conn_params *params;
-	struct hci_conn *conn, *conn_unfinished;
+	struct hci_conn *conn;
 	struct smp_irk *irk;
 	struct hci_request req;
 	int err;
@@ -804,27 +804,14 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	if (hci_lookup_le_connect(hdev))
 		return ERR_PTR(-EBUSY);
 
-	/* Some devices send ATT messages as soon as the physical link is
-	 * established. To be able to handle these ATT messages, the user-
-	 * space first establishes the connection and then starts the pairing
-	 * process.
-	 *
-	 * So if a hci_conn object already exists for the following connection
-	 * attempt, we simply update pending_sec_level and auth_type fields
-	 * and return the object found.
+	/* If there's already a connection object but it's not in
+	 * scanning state it means it must already be established, in
+	 * which case we can't do anything else except report a failure
+	 * to connect.
 	 */
 	conn = hci_conn_hash_lookup_le(hdev, dst, dst_type);
-	conn_unfinished = NULL;
-	if (conn) {
-		if (conn->state == BT_CONNECT &&
-		    test_bit(HCI_CONN_SCANNING, &conn->flags)) {
-			BT_DBG("will continue unfinished conn %pMR", dst);
-			conn_unfinished = conn;
-		} else {
-			if (conn->pending_sec_level < sec_level)
-				conn->pending_sec_level = sec_level;
-			goto done;
-		}
+	if (conn && !test_bit(HCI_CONN_SCANNING, &conn->flags)) {
+		return ERR_PTR(-EBUSY);
 	}
 
 	/* When given an identity address with existing identity
@@ -842,23 +829,20 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		dst_type = ADDR_LE_DEV_RANDOM;
 	}
 
-	if (conn_unfinished) {
-		conn = conn_unfinished;
+	if (conn) {
 		bacpy(&conn->dst, dst);
 	} else {
 		conn = hci_conn_add(hdev, LE_LINK, dst, role);
+		if (!conn)
+			return ERR_PTR(-ENOMEM);
+		hci_conn_hold(conn);
+		conn->pending_sec_level = sec_level;
 	}
 
-	if (!conn)
-		return ERR_PTR(-ENOMEM);
-
 	conn->dst_type = dst_type;
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->conn_timeout = conn_timeout;
 
-	if (!conn_unfinished)
-		conn->pending_sec_level = sec_level;
-
 	hci_req_init(&req, hdev);
 
 	/* Disable advertising if we're active. For master role
@@ -922,14 +906,6 @@ create_conn:
 		return ERR_PTR(err);
 	}
 
-done:
-	/* If this is continuation of connect started by hci_connect_le_scan,
-	 * it already called hci_conn_hold and calling it again would mess the
-	 * counter.
-	 */
-	if (!conn_unfinished)
-		hci_conn_hold(conn);
-
 	return conn;
 }
 
-- 
2.5.0


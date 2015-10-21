Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/13] Bluetooth: Remove unnecessary indentation in unpair_device()
Date: Wed, 21 Oct 2015 18:03:03 +0300
Message-Id: <1445439791-2151-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
References: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Instead of doing all of the LE-specific handling in an else-branch in
unpair_device() create a 'done' label for the BR/EDR branch to jump to
and then remove the else-branch completely.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 55 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 19834f524a7b..d56845a28af1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3055,6 +3055,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct hci_cp_disconnect dc;
 	struct mgmt_pending_cmd *cmd;
 	struct hci_conn *conn;
+	u8 addr_type;
 	int err;
 
 	memset(&rp, 0, sizeof(rp));
@@ -3095,33 +3096,23 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 			conn = NULL;
 
 		err = hci_remove_link_key(hdev, &cp->addr.bdaddr);
-	} else {
-		u8 addr_type = le_addr_type(cp->addr.type);
-
-		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
-					       addr_type);
-		if (conn) {
-			/* Defer clearing up the connection parameters
-			 * until closing to give a chance of keeping
-			 * them if a repairing happens.
-			 */
-			set_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags);
-
-			/* If disconnection is not requested, then
-			 * clear the connection variable so that the
-			 * link is not terminated.
-			 */
-			if (!cp->disconnect)
-				conn = NULL;
-		} else {
-			hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
+		if (err < 0) {
+			err = mgmt_cmd_complete(sk, hdev->id,
+						MGMT_OP_UNPAIR_DEVICE,
+						MGMT_STATUS_NOT_PAIRED, &rp,
+						sizeof(rp));
+			goto unlock;
 		}
 
-		hci_remove_irk(hdev, &cp->addr.bdaddr, addr_type);
-
-		err = hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type);
+		goto done;
 	}
 
+	/* LE address type */
+	addr_type = le_addr_type(cp->addr.type);
+
+	hci_remove_irk(hdev, &cp->addr.bdaddr, addr_type);
+
+	err = hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type);
 	if (err < 0) {
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
 					MGMT_STATUS_NOT_PAIRED, &rp,
@@ -3129,6 +3120,24 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr, addr_type);
+	if (!conn) {
+		hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
+		goto done;
+	}
+
+	/* Defer clearing up the connection parameters until closing to
+	 * give a chance of keeping them if a repairing happens.
+	 */
+	set_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags);
+
+	/* If disconnection is not requested, then clear the connection
+	 * variable so that the link is not terminated.
+	 */
+	if (!cp->disconnect)
+		conn = NULL;
+
+done:
 	/* If the connection variable is set, then termination of the
 	 * link is requested.
 	 */
-- 
2.5.0


Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6] Bluetooth: Defer connection-parameter removal when unpairing
Date: Sat, 11 Oct 2014 21:44:47 +0000
Message-Id: <1413063887-25870-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Systematically removing the LE connection parameters and autoconnect
action is inconvenient for rebonding without disconnecting from
userland (i.e. unpairing followed by repairing without
disconnecting). The parameters will be lost after unparing and
userland needs to take care of book-keeping them and re-adding them.

This patch allows userland to forget about parameter management when
rebonding without disconnecting. It defers clearing the connection
parameters when unparing without disconnecting, giving a chance of
keeping the parameters if a repairing happens before the connection is
closed.

Signed-off-by: Alfonso Acosta <fons@spotify.com>

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 07ddeed62..b8685a7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -555,6 +555,7 @@ enum {
 	HCI_CONN_STK_ENCRYPT,
 	HCI_CONN_AUTH_INITIATOR,
 	HCI_CONN_DROP,
+	HCI_CONN_PARAM_REMOVAL_PEND,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b9517bd..11aac06 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -544,6 +544,9 @@ int hci_conn_del(struct hci_conn *conn)
 
 	hci_conn_del_sysfs(conn);
 
+	if (test_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
+		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
+
 	hci_dev_put(hdev);
 
 	hci_conn_put(conn);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3fd88b0..9c4daf7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2725,10 +2725,40 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (cp->addr.type == BDADDR_BREDR) {
+		/* If disconnection is requested, then look up the
+		 * connection. If the remote device is connected, it
+		 * will be later used to terminate the link.
+		 *
+		 * Setting it to NULL explicitly will cause no
+		 * termination of the link.
+		 */
+		if (cp->disconnect)
+			conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+						       &cp->addr.bdaddr);
+		else
+			conn = NULL;
+
 		err = hci_remove_link_key(hdev, &cp->addr.bdaddr);
 	} else {
 		u8 addr_type;
 
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
+					       &cp->addr.bdaddr);
+		if (conn) {
+			/* Defer clearing up the connection parameters
+			 * until closing to give a chance of keeping
+			 * them if a repairing happens.
+			 */
+			set_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags);
+
+			/* If disconnection is not requested, then
+			 * clear the connection variable so that the
+			 * link is not terminated.
+			 */
+			if (!cp->disconnect)
+				conn = NULL;
+		}
+
 		if (cp->addr.type == BDADDR_LE_PUBLIC)
 			addr_type = ADDR_LE_DEV_PUBLIC;
 		else
@@ -2736,8 +2766,6 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		hci_remove_irk(hdev, &cp->addr.bdaddr, addr_type);
 
-		hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
-
 		err = hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type);
 	}
 
@@ -2747,17 +2775,9 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	if (cp->disconnect) {
-		if (cp->addr.type == BDADDR_BREDR)
-			conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
-						       &cp->addr.bdaddr);
-		else
-			conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
-						       &cp->addr.bdaddr);
-	} else {
-		conn = NULL;
-	}
-
+	/* If the connection variable is set, then termination of the
+	 * link is requested.
+	 */
 	if (!conn) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE, 0,
 				   &rp, sizeof(rp));
@@ -3062,6 +3082,11 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 	hci_conn_put(conn);
 
 	mgmt_pending_remove(cmd);
+
+	/* The device is paired so there is no need to remove
+	 * its connection parameters anymore.
+	 */
+	clear_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags);
 }
 
 void mgmt_smp_complete(struct hci_conn *conn, bool complete)
-- 
1.9.1


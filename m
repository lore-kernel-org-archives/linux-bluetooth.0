Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH v1] Bluetooth: Override status if local user rejects pairing
Date: Thu, 05 Jul 2012 21:01:17 +0530
Message-id: <1341502277-13724-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case if pairing is failed, user cannot differentiate from the status
whether failure is caused by local rejection or remote rejection
because authentication failure is coming in both the cases.

This patch overrides the status from controller with "Rejected"
in case of local rejection.

This patch will be useful if user can take some action based on local
or remote rejection

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 include/net/bluetooth/hci_core.h |    4 +-
 net/bluetooth/hci_event.c        |    4 +-
 net/bluetooth/mgmt.c             |  173 +++++++++++++++++++-------------------
 net/bluetooth/smp.c              |    2 +-
 4 files changed, 94 insertions(+), 89 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 475b8c0..bbb295f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -312,6 +312,8 @@ struct hci_conn {
 	__u16		disc_timeout;
 	unsigned long	flags;
 
+	bool		auth_rejected;
+
 	__u8		remote_cap;
 	__u8		remote_auth;
 	bool		flush_key;
@@ -1036,7 +1038,7 @@ int mgmt_user_passkey_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 					 u8 link_type, u8 addr_type, u8 status);
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		     u8 addr_type, u8 status);
+		     u8 addr_type, u8 status, bool auth_rejected);
 int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
 int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1ba929c..d5b4655 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1948,7 +1948,7 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	} else {
 		mgmt_auth_failed(hdev, &conn->dst, conn->type, conn->dst_type,
-				 ev->status);
+				 ev->status, conn->auth_rejected);
 	}
 
 	clear_bit(HCI_CONN_AUTH_PEND, &conn->flags);
@@ -3281,7 +3281,7 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 	 * the mgmt_auth_failed event */
 	if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) && ev->status != 0)
 		mgmt_auth_failed(hdev, &conn->dst, conn->type, conn->dst_type,
-				 ev->status);
+				 ev->status, conn->auth_rejected);
 
 	hci_conn_put(conn);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e83368f..4fc3379 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1718,89 +1718,6 @@ static int send_pin_code_neg_reply(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static int pin_code_reply(struct sock *sk, struct hci_dev *hdev, void *data,
-			  u16 len)
-{
-	struct hci_conn *conn;
-	struct mgmt_cp_pin_code_reply *cp = data;
-	struct hci_cp_pin_code_reply reply;
-	struct pending_cmd *cmd;
-	int err;
-
-	BT_DBG("");
-
-	hci_dev_lock(hdev);
-
-	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
-				 MGMT_STATUS_NOT_POWERED);
-		goto failed;
-	}
-
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->addr.bdaddr);
-	if (!conn) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
-				 MGMT_STATUS_NOT_CONNECTED);
-		goto failed;
-	}
-
-	if (conn->pending_sec_level == BT_SECURITY_HIGH && cp->pin_len != 16) {
-		struct mgmt_cp_pin_code_neg_reply ncp;
-
-		memcpy(&ncp.addr, &cp->addr, sizeof(ncp.addr));
-
-		BT_ERR("PIN code is not 16 bytes long");
-
-		err = send_pin_code_neg_reply(sk, hdev, &ncp);
-		if (err >= 0)
-			err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
-					 MGMT_STATUS_INVALID_PARAMS);
-
-		goto failed;
-	}
-
-	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_REPLY, hdev, data, len);
-	if (!cmd) {
-		err = -ENOMEM;
-		goto failed;
-	}
-
-	bacpy(&reply.bdaddr, &cp->addr.bdaddr);
-	reply.pin_len = cp->pin_len;
-	memcpy(reply.pin_code, cp->pin_code, sizeof(reply.pin_code));
-
-	err = hci_send_cmd(hdev, HCI_OP_PIN_CODE_REPLY, sizeof(reply), &reply);
-	if (err < 0)
-		mgmt_pending_remove(cmd);
-
-failed:
-	hci_dev_unlock(hdev);
-	return err;
-}
-
-static int pin_code_neg_reply(struct sock *sk, struct hci_dev *hdev,
-			      void *data, u16 len)
-{
-	struct mgmt_cp_pin_code_neg_reply *cp = data;
-	int err;
-
-	BT_DBG("");
-
-	hci_dev_lock(hdev);
-
-	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_NEG_REPLY,
-				 MGMT_STATUS_NOT_POWERED);
-		goto failed;
-	}
-
-	err = send_pin_code_neg_reply(sk, hdev, cp);
-
-failed:
-	hci_dev_unlock(hdev);
-	return err;
-}
-
 static int set_io_capability(struct sock *sk, struct hci_dev *hdev, void *data,
 			     u16 len)
 {
@@ -1847,6 +1764,10 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 	bacpy(&rp.addr.bdaddr, &conn->dst);
 	rp.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 
+	/* Override status if local device rejected pairing */
+	if (conn->auth_rejected == true)
+		status = MGMT_STATUS_REJECTED;
+
 	cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE, status,
 		     &rp, sizeof(rp));
 
@@ -2045,6 +1966,11 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 		goto done;
 	}
 
+	if (hci_op == HCI_OP_USER_CONFIRM_NEG_REPLY ||
+				hci_op == HCI_OP_USER_PASSKEY_NEG_REPLY ||
+				hci_op == HCI_OP_PIN_CODE_NEG_REPLY)
+		conn->auth_rejected = true;
+
 	if (type == BDADDR_LE_PUBLIC || type == BDADDR_LE_RANDOM) {
 		/* Continue with pairing via SMP */
 		err = smp_user_confirm_reply(conn, mgmt_op, passkey);
@@ -2083,6 +2009,78 @@ done:
 	return err;
 }
 
+static int pin_code_reply(struct sock *sk, struct hci_dev *hdev, void *data,
+			  u16 len)
+{
+	struct hci_conn *conn;
+	struct mgmt_cp_pin_code_reply *cp = data;
+	struct hci_cp_pin_code_reply reply;
+	struct pending_cmd *cmd;
+	int err;
+
+	BT_DBG("");
+
+	hci_dev_lock(hdev);
+
+	if (!hdev_is_powered(hdev)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
+				 MGMT_STATUS_NOT_POWERED);
+		goto failed;
+	}
+
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->addr.bdaddr);
+	if (!conn) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
+				 MGMT_STATUS_NOT_CONNECTED);
+		goto failed;
+	}
+
+	if (conn->pending_sec_level == BT_SECURITY_HIGH && cp->pin_len != 16) {
+		struct mgmt_cp_pin_code_neg_reply ncp;
+
+		memcpy(&ncp.addr, &cp->addr, sizeof(ncp.addr));
+
+		BT_ERR("PIN code is not 16 bytes long");
+
+		err = send_pin_code_neg_reply(sk, hdev, &ncp);
+		if (err >= 0)
+			err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
+					 MGMT_STATUS_INVALID_PARAMS);
+
+		goto failed;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_REPLY, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	bacpy(&reply.bdaddr, &cp->addr.bdaddr);
+	reply.pin_len = cp->pin_len;
+	memcpy(reply.pin_code, cp->pin_code, sizeof(reply.pin_code));
+
+	err = hci_send_cmd(hdev, HCI_OP_PIN_CODE_REPLY, sizeof(reply), &reply);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+failed:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
+static int pin_code_neg_reply(struct sock *sk, struct hci_dev *hdev,
+			      void *data, u16 len)
+{
+	struct mgmt_cp_pin_code_neg_reply *cp = data;
+
+	BT_DBG("");
+
+	return user_pairing_resp(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
+				MGMT_OP_PIN_CODE_NEG_REPLY,
+				HCI_OP_PIN_CODE_NEG_REPLY, 0);
+}
+
 static int user_confirm_reply(struct sock *sk, struct hci_dev *hdev, void *data,
 			      u16 len)
 {
@@ -3271,13 +3269,18 @@ int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 }
 
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		     u8 addr_type, u8 status)
+		     u8 addr_type, u8 status, bool auth_rejected)
 {
 	struct mgmt_ev_auth_failed ev;
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
-	ev.status = mgmt_status(status);
+
+	/* Override status if local device rejected pairing */
+	if (auth_rejected == true)
+		ev.status = MGMT_STATUS_REJECTED;
+	else
+		ev.status = mgmt_status(status);
 
 	return mgmt_event(MGMT_EV_AUTH_FAILED, hdev, &ev, sizeof(ev), NULL);
 }
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 16ef0dc..3c04313 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -265,7 +265,7 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->hcon->flags);
 	mgmt_auth_failed(conn->hcon->hdev, conn->dst, hcon->type,
-			 hcon->dst_type, reason);
+			 hcon->dst_type, reason, hcon->auth_rejected);
 
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
 		cancel_delayed_work_sync(&conn->security_timer);
-- 
1.7.1


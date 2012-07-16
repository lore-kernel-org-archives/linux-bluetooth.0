Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH v5] Bluetooth: Override status if local user rejects pairing
Date: Mon, 16 Jul 2012 20:11:15 +0530
Message-id: <1342449675-2842-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case if pairing is failed, user cannot differentiate from the status
whether failure is caused by local rejection or remote rejection
because authentication failure is coming in both the cases.

This patch overrides the status from controller with "Cancelled"
in case of local rejection.

This patch will be useful if user can take some action based on local
or remote rejection

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
v5 -> 	Used STATUS_CANCELLED instead of STATUS_REJECTED
	Added a new flag in hci conn for auth cancel instead of
	a new member in struct	
	
 include/net/bluetooth/hci_core.h |    3 ++-
 net/bluetooth/hci_event.c        |   19 +++++++++++++++----
 net/bluetooth/mgmt.c             |   18 ++++++++++++++++--
 net/bluetooth/smp.c              |    3 ++-
 4 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 475b8c0..409b7ad 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -425,6 +425,7 @@ enum {
 	HCI_CONN_SSP_ENABLED,
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_REMOTE_OOB,
+	HCI_CONN_AUTH_CANCELLED,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -1036,7 +1037,7 @@ int mgmt_user_passkey_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 					 u8 link_type, u8 addr_type, u8 status);
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		     u8 addr_type, u8 status);
+		     u8 addr_type, u8 status, bool cancelled);
 int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
 int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 41ff978..08fb9d6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1948,7 +1948,8 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	} else {
 		mgmt_auth_failed(hdev, &conn->dst, conn->type, conn->dst_type,
-				 ev->status);
+				 ev->status, test_bit(HCI_CONN_AUTH_CANCELLED,
+								&conn->flags));
 	}
 
 	clear_bit(HCI_CONN_AUTH_PEND, &conn->flags);
@@ -2642,16 +2643,19 @@ static void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!conn)
 		goto unlock;
 
+	clear_bit(HCI_CONN_AUTH_CANCELLED, &conn->flags);
+
 	if (conn->state == BT_CONNECTED) {
 		hci_conn_hold(conn);
 		conn->disc_timeout = HCI_PAIRING_TIMEOUT;
 		hci_conn_put(conn);
 	}
 
-	if (!test_bit(HCI_PAIRABLE, &hdev->dev_flags))
+	if (!test_bit(HCI_PAIRABLE, &hdev->dev_flags)) {
+		set_bit(HCI_CONN_AUTH_CANCELLED, &conn->flags);
 		hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY,
 			     sizeof(ev->bdaddr), &ev->bdaddr);
-	else if (test_bit(HCI_MGMT, &hdev->dev_flags)) {
+	} else if (test_bit(HCI_MGMT, &hdev->dev_flags)) {
 		u8 secure;
 
 		if (conn->pending_sec_level == BT_SECURITY_HIGH)
@@ -2698,6 +2702,8 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (conn) {
+		clear_bit(HCI_CONN_AUTH_CANCELLED, &conn->flags);
+
 		if (key->type == HCI_LK_UNAUTH_COMBINATION &&
 		    conn->auth_type != 0xff && (conn->auth_type & 0x01)) {
 			BT_DBG("%s ignoring unauthenticated key", hdev->name);
@@ -3116,6 +3122,8 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!conn)
 		goto unlock;
 
+	clear_bit(HCI_CONN_AUTH_CANCELLED, &conn->flags);
+
 	hci_conn_hold(conn);
 
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
@@ -3147,6 +3155,8 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		bacpy(&cp.bdaddr, &ev->bdaddr);
 		cp.reason = HCI_ERROR_PAIRING_NOT_ALLOWED;
 
+		set_bit(HCI_CONN_AUTH_CANCELLED, &conn->flags);
+
 		hci_send_cmd(hdev, HCI_OP_IO_CAPABILITY_NEG_REPLY,
 			     sizeof(cp), &cp);
 	}
@@ -3281,7 +3291,8 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 	 * the mgmt_auth_failed event */
 	if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) && ev->status != 0)
 		mgmt_auth_failed(hdev, &conn->dst, conn->type, conn->dst_type,
-				 ev->status);
+				 ev->status, test_bit(HCI_CONN_AUTH_CANCELLED,
+								&conn->flags));
 
 	hci_conn_put(conn);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0475f37..6a12c87 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1824,6 +1824,10 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 	bacpy(&rp.addr.bdaddr, &conn->dst);
 	rp.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 
+	/* Override status if local device rejected pairing */
+	if (status && test_bit(HCI_CONN_AUTH_CANCELLED, &conn->flags))
+		status = MGMT_STATUS_CANCELLED;
+
 	cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE, status,
 		     &rp, sizeof(rp));
 
@@ -2022,6 +2026,11 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 		goto done;
 	}
 
+	if (hci_op == HCI_OP_USER_CONFIRM_NEG_REPLY ||
+				hci_op == HCI_OP_USER_PASSKEY_NEG_REPLY ||
+				hci_op == HCI_OP_PIN_CODE_NEG_REPLY)
+		set_bit(HCI_CONN_AUTH_CANCELLED, &conn->flags);
+
 	if (type == BDADDR_LE_PUBLIC || type == BDADDR_LE_RANDOM) {
 		/* Continue with pairing via SMP */
 		err = smp_user_confirm_reply(conn, mgmt_op, passkey);
@@ -3260,13 +3269,18 @@ int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 }
 
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		     u8 addr_type, u8 status)
+		     u8 addr_type, u8 status, bool cancelled)
 {
 	struct mgmt_ev_auth_failed ev;
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
-	ev.status = mgmt_status(status);
+
+	/* Override status if local device rejected pairing */
+	if (cancelled)
+		ev.status = MGMT_STATUS_CANCELLED;
+	else
+		ev.status = mgmt_status(status);
 
 	return mgmt_event(MGMT_EV_AUTH_FAILED, hdev, &ev, sizeof(ev), NULL);
 }
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 16ef0dc..39bda92 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -265,7 +265,8 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->hcon->flags);
 	mgmt_auth_failed(conn->hcon->hdev, conn->dst, hcon->type,
-			 hcon->dst_type, reason);
+			 hcon->dst_type, reason,
+			 test_bit(HCI_CONN_AUTH_CANCELLED, &hcon->flags));
 
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
 		cancel_delayed_work_sync(&conn->security_timer);
-- 
1.7.1


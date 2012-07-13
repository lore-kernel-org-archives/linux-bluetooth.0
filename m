Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH v4] Bluetooth: Override status if local user rejects pairing
Date: Fri, 13 Jul 2012 19:38:42 +0530
Message-id: <1342188522-27623-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case if pairing is failed, user cannot differentiate from the status
whether failure is caused by local rejection or remote rejection
because authentication failure is coming in both the cases.

This patch overrides the status from controller with "AuthRejected"
in case of local rejection.

This patch will be useful if user can take some action based on local
or remote rejection

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 include/net/bluetooth/hci_core.h |    4 +++-
 include/net/bluetooth/mgmt.h     |    1 +
 net/bluetooth/hci_event.c        |    8 ++++++--
 net/bluetooth/mgmt.c             |   18 ++++++++++++++++--
 net/bluetooth/smp.c              |    2 +-
 5 files changed, 27 insertions(+), 6 deletions(-)

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
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 4348ee8..4f20ad7 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -42,6 +42,7 @@
 #define MGMT_STATUS_NOT_POWERED		0x0f
 #define MGMT_STATUS_CANCELLED		0x10
 #define MGMT_STATUS_INVALID_INDEX	0x11
+#define MGMT_STATUS_AUTH_REJECTED	0x12
 
 struct mgmt_hdr {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 41ff978..891db5c 100644
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
@@ -2659,6 +2659,8 @@ static void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		else
 			secure = 0;
 
+		conn->auth_rejected = false;
+
 		mgmt_pin_code_request(hdev, &ev->bdaddr, secure);
 	}
 
@@ -3139,6 +3141,8 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		else
 			cp.oob_data = 0x00;
 
+		conn->auth_rejected = false;
+
 		hci_send_cmd(hdev, HCI_OP_IO_CAPABILITY_REPLY,
 			     sizeof(cp), &cp);
 	} else {
@@ -3281,7 +3285,7 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 	 * the mgmt_auth_failed event */
 	if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) && ev->status != 0)
 		mgmt_auth_failed(hdev, &conn->dst, conn->type, conn->dst_type,
-				 ev->status);
+				 ev->status, conn->auth_rejected);
 
 	hci_conn_put(conn);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0475f37..8c7013e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1824,6 +1824,10 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 	bacpy(&rp.addr.bdaddr, &conn->dst);
 	rp.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 
+	/* Override status if local device rejected pairing */
+	if (status && conn->auth_rejected)
+		status = MGMT_STATUS_AUTH_REJECTED;
+
 	cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE, status,
 		     &rp, sizeof(rp));
 
@@ -2022,6 +2026,11 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
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
@@ -3260,13 +3269,18 @@ int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
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
+	if (auth_rejected)
+		ev.status = MGMT_STATUS_AUTH_REJECTED;
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


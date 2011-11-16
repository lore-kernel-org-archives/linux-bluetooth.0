Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH-v3 3/9] Bluetooth: User Pairing Response restructuring
Date: Wed, 16 Nov 2011 10:37:47 -0800
Message-Id: <1321468673-13925-4-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1321468673-13925-1-git-send-email-bgix@codeaurora.org>
References: <1321468673-13925-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are 4 possible User Responses to pairing requests,
and they all share the same checks and handling. This
restructures the handling of the two Confirm responses
in preperation for the second two.

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 net/bluetooth/mgmt.c |   96 ++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 69 insertions(+), 27 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5562c21..b1d4f05 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1438,28 +1438,14 @@ unlock:
 	return err;
 }
 
-static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
-							u16 len, int success)
+static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
+					u16 mgmt_op, u16 hci_op, __le32 passkey)
 {
-	struct mgmt_cp_user_confirm_reply *cp = (void *) data;
-	u16 mgmt_op, hci_op;
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
+	struct hci_conn *conn;
 	int err;
 
-	BT_DBG("");
-
-	if (success) {
-		mgmt_op = MGMT_OP_USER_CONFIRM_REPLY;
-		hci_op = HCI_OP_USER_CONFIRM_REPLY;
-	} else {
-		mgmt_op = MGMT_OP_USER_CONFIRM_NEG_REPLY;
-		hci_op = HCI_OP_USER_CONFIRM_NEG_REPLY;
-	}
-
-	if (len != sizeof(*cp))
-		return cmd_status(sk, index, mgmt_op, EINVAL);
-
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, mgmt_op, ENODEV);
@@ -1468,26 +1454,81 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, mgmt_op, ENETDOWN);
-		goto failed;
+		goto done;
 	}
 
-	cmd = mgmt_pending_add(sk, mgmt_op, hdev, data, len);
+	/*
+	 * Check for an existing ACL link, if present pair via
+	 * HCI commands.
+	 *
+	 * If no ACL link is present, check for an LE link and if
+	 * present, pair via the SMP engine.
+	 *
+	 * If neither ACL nor LE links are present, fail with error.
+	 */
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
+	if (!conn) {
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, bdaddr);
+		if (!conn) {
+			err = cmd_status(sk, index, mgmt_op, ENOTCONN);
+			goto done;
+		}
+
+		/* Continue with pairing via SMP */
+
+		err = cmd_status(sk, index, mgmt_op, 0);
+		goto done;
+	}
+
+	cmd = mgmt_pending_add(sk, mgmt_op, hdev, bdaddr, sizeof(*bdaddr));
 	if (!cmd) {
 		err = -ENOMEM;
-		goto failed;
+		goto done;
 	}
 
-	err = hci_send_cmd(hdev, hci_op, sizeof(cp->bdaddr), &cp->bdaddr);
+	/* Continue with pairing via HCI */
+	err = hci_send_cmd(hdev, hci_op, sizeof(*bdaddr), bdaddr);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-failed:
+done:
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
 	return err;
 }
 
+static int user_confirm_reply(struct sock *sk, u16 index, void *data, u16 len)
+{
+	struct mgmt_cp_user_confirm_reply *cp = (void *) data;
+
+	BT_DBG("");
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_USER_CONFIRM_REPLY,
+									EINVAL);
+
+	return user_pairing_resp(sk, index, &cp->bdaddr,
+			MGMT_OP_USER_CONFIRM_REPLY,
+			HCI_OP_USER_CONFIRM_REPLY, 0);
+}
+
+static int user_confirm_neg_reply(struct sock *sk, u16 index, void *data,
+									u16 len)
+{
+	struct mgmt_cp_user_confirm_reply *cp = (void *) data;
+
+	BT_DBG("");
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_USER_CONFIRM_NEG_REPLY,
+									EINVAL);
+
+	return user_pairing_resp(sk, index, &cp->bdaddr,
+			MGMT_OP_USER_CONFIRM_NEG_REPLY,
+			HCI_OP_USER_CONFIRM_NEG_REPLY, 0);
+}
+
 static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
 								u16 len)
 {
@@ -1924,10 +1965,11 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		err = pair_device(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_USER_CONFIRM_REPLY:
-		err = user_confirm_reply(sk, index, buf + sizeof(*hdr), len, 1);
+		err = user_confirm_reply(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
-		err = user_confirm_reply(sk, index, buf + sizeof(*hdr), len, 0);
+		err = user_confirm_neg_reply(sk, index, buf + sizeof(*hdr),
+									len);
 		break;
 	case MGMT_OP_SET_LOCAL_NAME:
 		err = set_local_name(sk, index, buf + sizeof(*hdr), len);
@@ -2285,7 +2327,7 @@ int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
 									NULL);
 }
 
-static int confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+static int user_pairing_resp_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 							u8 status, u8 opcode)
 {
 	struct pending_cmd *cmd;
@@ -2308,14 +2350,14 @@ static int confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 int mgmt_user_confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 								u8 status)
 {
-	return confirm_reply_complete(hdev, bdaddr, status,
+	return user_pairing_resp_complete(hdev, bdaddr, status,
 						MGMT_OP_USER_CONFIRM_REPLY);
 }
 
 int mgmt_user_confirm_neg_reply_complete(struct hci_dev *hdev,
 						bdaddr_t *bdaddr, u8 status)
 {
-	return confirm_reply_complete(hdev, bdaddr, status,
+	return user_pairing_resp_complete(hdev, bdaddr, status,
 					MGMT_OP_USER_CONFIRM_NEG_REPLY);
 }
 
-- 
1.7.7.2

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 

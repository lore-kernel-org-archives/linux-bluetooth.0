Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 2/2] Bluetooth: Add Passkey for SSP & SMP pairing
Date: Wed,  9 Nov 2011 11:13:47 -0800
Message-Id: <1320866027-14202-3-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1320866027-14202-1-git-send-email-bgix@codeaurora.org>
References: <1320866027-14202-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some Man-In-The-Middle (MITM) protection schemes require
User Passkey Entry.

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 include/net/bluetooth/hci.h  |    8 ++++
 include/net/bluetooth/mgmt.h |   12 ++++++
 net/bluetooth/mgmt.c         |   77 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 139ce2a..ac107b5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -453,6 +453,14 @@ struct hci_rp_user_confirm_reply {
 
 #define HCI_OP_USER_CONFIRM_NEG_REPLY	0x042d
 
+#define HCI_OP_USER_PASSKEY_REPLY		0x042e
+struct hci_cp_user_passkey_reply {
+	bdaddr_t bdaddr;
+	__u32	passkey;
+} __packed;
+
+#define HCI_OP_USER_PASSKEY_NEG_REPLY	0x042f
+
 #define HCI_OP_REMOTE_OOB_DATA_REPLY	0x0430
 struct hci_cp_remote_oob_data_reply {
 	bdaddr_t bdaddr;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 3e320c9..aa56bd5 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -228,6 +228,18 @@ struct mgmt_cp_set_fast_connectable {
 	__u8 enable;
 } __packed;
 
+#define MGMT_OP_USER_PASSKEY_REPLY	0x0020
+struct mgmt_cp_user_passkey_reply {
+	bdaddr_t bdaddr;
+	__le32 passkey;
+} __packed;
+
+#define MGMT_OP_USER_PASSKEY_NEG_REPLY	0x0021
+struct mgmt_cp_user_passkey_neg_reply {
+	bdaddr_t bdaddr;
+} __packed;
+
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6c35f8d..c6e1ad4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1462,7 +1462,6 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
 
 		err = cmd_status(sk, index, mgmt_op, 0);
 		goto done;
-
 	}
 
 	cmd = mgmt_pending_add(sk, mgmt_op, hdev, data, len);
@@ -1482,6 +1481,76 @@ done:
 	return err;
 }
 
+static int user_passkey_reply(struct sock *sk, u16 index, unsigned char *data,
+							u16 len, int success)
+{
+	struct mgmt_cp_user_passkey_reply *cp = (void *) data;
+	u16 mgmt_op, hci_op;
+	u32 passkey = 0;
+	struct pending_cmd *cmd;
+	struct hci_dev *hdev;
+	struct hci_conn *conn;
+	int expected_len, err = 0;
+
+	BT_DBG("");
+
+	if (success) {
+		mgmt_op = MGMT_OP_USER_PASSKEY_REPLY;
+		hci_op = HCI_OP_USER_PASSKEY_REPLY;
+		expected_len = sizeof(*cp);
+		passkey = le32_to_cpu(cp->passkey);
+	} else {
+		mgmt_op = MGMT_OP_USER_PASSKEY_NEG_REPLY;
+		hci_op = HCI_OP_USER_PASSKEY_NEG_REPLY;
+		expected_len = sizeof(struct mgmt_cp_user_passkey_neg_reply);
+	}
+
+	if (len != expected_len)
+		return cmd_status(sk, index, mgmt_op, EINVAL);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, mgmt_op, ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		err = cmd_status(sk, index, mgmt_op, ENETDOWN);
+		goto done;
+	}
+
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
+	if (!conn) {
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
+		if (!conn) {
+			err = cmd_status(sk, index, mgmt_op, ENOTCONN);
+			goto done;
+		}
+
+		/* Forward Passkey response to SMP */
+
+		err = cmd_status(sk, index, mgmt_op, 0);
+		goto done;
+	}
+
+	cmd = mgmt_pending_add(sk, mgmt_op, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	err = hci_send_cmd(hdev, hci_op, len, cp);
+
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+done:
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
 								u16 len)
 {
@@ -1923,6 +1992,12 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
 		err = user_confirm_reply(sk, index, buf + sizeof(*hdr), len, 0);
 		break;
+	case MGMT_OP_USER_PASSKEY_REPLY:
+		err = user_passkey_reply(sk, index, buf + sizeof(*hdr), len, 1);
+		break;
+	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
+		err = user_passkey_reply(sk, index, buf + sizeof(*hdr), len, 0);
+		break;
 	case MGMT_OP_SET_LOCAL_NAME:
 		err = set_local_name(sk, index, buf + sizeof(*hdr), len);
 		break;
-- 
1.7.7.2
-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 

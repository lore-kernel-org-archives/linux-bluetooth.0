Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <padovan@profusion.mobi>
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 2/3] Bluetooth: Add MGMT opcode for User Passkey entry
Date: Thu, 10 Nov 2011 12:52:54 -0800
Message-Id: <1320958375-24425-3-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1320958375-24425-1-git-send-email-bgix@codeaurora.org>
References: <1320958375-24425-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 include/net/bluetooth/hci.h  |    8 +++
 include/net/bluetooth/mgmt.h |   11 +++
 net/bluetooth/mgmt.c         |  143 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+), 0 deletions(-)

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
index 3e320c9..d67683f 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -228,6 +228,17 @@ struct mgmt_cp_set_fast_connectable {
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
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 761d607..d5116c2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1482,6 +1482,128 @@ done:
 	return err;
 }
 
+static int user_passkey_reply(struct sock *sk, u16 index, unsigned char *data,
+									u16 len)
+{
+	struct mgmt_cp_user_passkey_reply *cp = (void *) data;
+	struct pending_cmd *cmd;
+	struct hci_dev *hdev;
+	struct hci_conn *conn;
+	int err = 0;
+
+	BT_DBG("");
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_REPLY,
+									EINVAL);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_REPLY,
+									ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		err = cmd_status(sk, index, MGMT_OP_USER_PASSKEY_REPLY,
+								ENETDOWN);
+		goto done;
+	}
+
+	/* Route command to HCI (if ACL Link) or SMP (if LE Link) */
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
+	if (!conn) {
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
+		if (!conn) {
+			err = cmd_status(sk, index, MGMT_OP_USER_PASSKEY_REPLY,
+								ENOTCONN);
+			goto done;
+		}
+
+		/* Forward Passkey response to SMP */
+
+		err = cmd_status(sk, index, MGMT_OP_USER_PASSKEY_REPLY, 0);
+		goto done;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_USER_PASSKEY_REPLY, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	err = hci_send_cmd(hdev, HCI_OP_USER_PASSKEY_REPLY, len, cp);
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
+static int user_passkey_neg_reply(struct sock *sk, u16 index,
+						unsigned char *data, u16 len)
+{
+	struct mgmt_cp_user_passkey_neg_reply *cp = (void *) data;
+	struct pending_cmd *cmd;
+	struct hci_dev *hdev;
+	struct hci_conn *conn;
+	int err = 0;
+
+	BT_DBG("");
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_NEG_REPLY,
+									EINVAL);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_NEG_REPLY,
+									ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		err = cmd_status(sk, index, MGMT_OP_USER_PASSKEY_NEG_REPLY,
+								ENETDOWN);
+		goto done;
+	}
+
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
+	if (!conn) {
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
+		if (!conn) {
+			err = cmd_status(sk, index,
+					MGMT_OP_USER_PASSKEY_NEG_REPLY,
+					ENOTCONN);
+			goto done;
+		}
+
+		/* Forward Passkey response to SMP */
+
+		err = cmd_status(sk, index, MGMT_OP_USER_PASSKEY_NEG_REPLY, 0);
+		goto done;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_USER_PASSKEY_NEG_REPLY, hdev, data,
+									len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	err = hci_send_cmd(hdev, HCI_OP_USER_PASSKEY_NEG_REPLY, len, cp);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+done:
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
 static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
 								u16 len)
 {
@@ -1923,6 +2045,13 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
 		err = user_confirm_reply(sk, index, buf + sizeof(*hdr), len, 0);
 		break;
+	case MGMT_OP_USER_PASSKEY_REPLY:
+		err = user_passkey_reply(sk, index, buf + sizeof(*hdr), len);
+		break;
+	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
+		err = user_passkey_neg_reply(sk, index, buf + sizeof(*hdr),
+									len);
+		break;
 	case MGMT_OP_SET_LOCAL_NAME:
 		err = set_local_name(sk, index, buf + sizeof(*hdr), len);
 		break;
@@ -2281,6 +2410,20 @@ int mgmt_user_confirm_neg_reply_complete(struct hci_dev *hdev,
 					MGMT_OP_USER_CONFIRM_NEG_REPLY);
 }
 
+int mgmt_user_passkey_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+								u8 status)
+{
+	return confirm_reply_complete(hdev, bdaddr, status,
+						MGMT_OP_USER_PASSKEY_REPLY);
+}
+
+int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev,
+						bdaddr_t *bdaddr, u8 status)
+{
+	return confirm_reply_complete(hdev, bdaddr, status,
+					MGMT_OP_USER_PASSKEY_NEG_REPLY);
+}
+
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status)
 {
 	struct mgmt_ev_auth_failed ev;
-- 
1.7.7.2

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 

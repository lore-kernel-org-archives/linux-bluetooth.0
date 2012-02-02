Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: mgmt: Implement Cancel Pair Device command
Date: Wed,  1 Feb 2012 18:05:54 -0800
Message-Id: <1328148354-14869-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch implements the Cancel Pair Device command for mgmt. It's used
by user space to cancel an ongoing pairing attempt which was triggered
by the Pair Device command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    1 +
 net/bluetooth/mgmt.c         |   51 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 42eb48b..72975fd 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -39,6 +39,7 @@
 #define MGMT_STATUS_INVALID_PARAMS	0x0d
 #define MGMT_STATUS_DISCONNECTED	0x0e
 #define MGMT_STATUS_NOT_POWERED		0x0f
+#define MGMT_STATUS_CANCELLED		0x10
 
 struct mgmt_hdr {
 	__le16 opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8970799..00ab083 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1594,6 +1594,54 @@ unlock:
 	return err;
 }
 
+static int cancel_pair_device(struct sock *sk, u16 index,
+						unsigned char *data, u16 len)
+{
+	struct mgmt_addr_info *addr = (void *) data;
+	struct hci_dev *hdev;
+	struct pending_cmd *cmd;
+	struct hci_conn *conn;
+	int err;
+
+	BT_DBG("");
+
+	if (len != sizeof(*addr))
+		return cmd_status(sk, index, MGMT_OP_CANCEL_PAIR_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_CANCEL_PAIR_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	cmd = mgmt_pending_find(MGMT_OP_PAIR_DEVICE, hdev);
+	if (!cmd) {
+		err = cmd_status(sk, index, MGMT_OP_CANCEL_PAIR_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS);
+		goto unlock;
+	}
+
+	conn = cmd->user_data;
+
+	if (bacmp(&addr->bdaddr, &conn->dst) != 0) {
+		err = cmd_status(sk, index, MGMT_OP_CANCEL_PAIR_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS);
+		goto unlock;
+	}
+
+	pairing_complete(cmd, MGMT_STATUS_CANCELLED);
+
+	err = cmd_complete(sk, index, MGMT_OP_CANCEL_PAIR_DEVICE, addr,
+								sizeof(*addr));
+unlock:
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
 					u16 mgmt_op, u16 hci_op, __le32 passkey)
 {
@@ -2271,6 +2319,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_PAIR_DEVICE:
 		err = pair_device(sk, index, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_CANCEL_PAIR_DEVICE:
+		err = cancel_pair_device(sk, index, buf + sizeof(*hdr), len);
+		break;
 	case MGMT_OP_USER_CONFIRM_REPLY:
 		err = user_confirm_reply(sk, index, buf + sizeof(*hdr), len);
 		break;
-- 
1.7.9


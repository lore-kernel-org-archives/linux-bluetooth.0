Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/4] Bluetooth: Add read_local_oob_data management command
Date: Tue, 1 Mar 2011 18:23:35 +0100
Message-ID: <1299000216-6570-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1299000216-6570-1-git-send-email-szymon.janc@tieto.com>
References: <1299000216-6570-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a command to read local OOB data to the managment interface.
The command maps directly to the Read Local OOB Data HCI command.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 include/net/bluetooth/hci.h      |    7 +++
 include/net/bluetooth/hci_core.h |    2 +
 include/net/bluetooth/mgmt.h     |    6 +++
 net/bluetooth/hci_event.c        |   15 +++++++
 net/bluetooth/mgmt.c             |   85 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ec6acf2..20840dc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -611,6 +611,13 @@ struct hci_cp_write_ssp_mode {
 	__u8     mode;
 } __packed;
 
+#define HCI_OP_READ_LOCAL_OOB_DATA		0x0c57
+struct hci_rp_read_local_oob_data {
+	__u8     status;
+	__u8     hash[16];
+	__u8     randomizer[16];
+} __packed;
+
 #define HCI_OP_READ_INQ_RSP_TX_POWER	0x0c58
 
 #define HCI_OP_READ_LOCAL_VERSION	0x1001
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 441dadb..c8b7ee6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -767,6 +767,8 @@ int mgmt_user_confirm_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_user_confirm_neg_reply_complete(u16 index, bdaddr_t *bdaddr,
 								u8 status);
 int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status);
+int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
+								u8 status);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 5fabfa8..916b1c6 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -167,6 +167,12 @@ struct mgmt_rp_user_confirm_reply {
 
 #define MGMT_OP_USER_CONFIRM_NEG_REPLY	0x0016
 
+#define MGMT_OP_READ_LOCAL_OOB_DATA	0x0017
+struct mgmt_rp_read_local_oob_data {
+	__u8 hash[16];
+	__u8 randomizer[16];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3fbfa50..4faab87 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -807,6 +807,17 @@ static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
 								rp->status);
 }
 
+static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
+							struct sk_buff *skb)
+{
+	struct hci_rp_read_local_oob_data *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	mgmt_read_local_oob_data_reply_complete(hdev->id, rp->hash,
+						rp->randomizer, rp->status);
+}
+
 static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
 							struct sk_buff *skb)
 {
@@ -1749,6 +1760,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_pin_code_neg_reply(hdev, skb);
 		break;
 
+	case HCI_OP_READ_LOCAL_OOB_DATA:
+		hci_cc_read_local_oob_data_reply(hdev, skb);
+		break;
+
 	case HCI_OP_LE_READ_BUFFER_SIZE:
 		hci_cc_le_read_buffer_size(hdev, skb);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 97d7240..ba43b85 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1259,6 +1259,57 @@ failed:
 	return err;
 }
 
+static int read_local_oob_data(struct sock *sk, u16 index)
+{
+	struct hci_dev *hdev;
+	struct pending_cmd *cmd;
+	int err;
+
+	BT_DBG("hci%u", index);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
+									ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
+								ENETDOWN);
+		goto unlock;
+	}
+
+	if (!(hdev->features[6] & LMP_SIMPLE_PAIR)) {
+		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
+								EOPNOTSUPP);
+		goto unlock;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, index)) {
+		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA, EBUSY);
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_READ_LOCAL_OOB_DATA, index, NULL, 0);
+
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	err = hci_send_cmd(hdev, HCI_OP_READ_LOCAL_OOB_DATA, 0, NULL);
+
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
@@ -1354,6 +1405,10 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
 		err = user_confirm_reply(sk, index, buf + sizeof(*hdr), len, 0);
 		break;
+	case MGMT_OP_READ_LOCAL_OOB_DATA:
+		err = read_local_oob_data(sk, index);
+		break;
+
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode, 0x01);
@@ -1652,3 +1707,33 @@ int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status)
 
 	return mgmt_event(MGMT_EV_AUTH_FAILED, index, &ev, sizeof(ev), NULL);
 }
+
+int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
+								u8 status)
+{
+	struct pending_cmd *cmd;
+	int err;
+
+	BT_DBG("hci%u status %u", index, status);
+
+	cmd = mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, index);
+	if (!cmd)
+		return -ENOENT;
+
+	if (status) {
+		err = cmd_status(cmd->sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
+									EIO);
+	} else {
+		struct mgmt_rp_read_local_oob_data rp;
+
+		memcpy(rp.hash, hash, 16);
+		memcpy(rp.randomizer, randomizer, 16);
+
+		err = cmd_complete(cmd->sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
+							&rp, sizeof(rp));
+	}
+
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
-- 
1.7.0.4


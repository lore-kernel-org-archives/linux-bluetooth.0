Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/10] Bluetooth: Add read_local_oob_data management command
Date: Thu, 17 Feb 2011 14:16:36 +0100
Message-ID: <1297948601-12723-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
References: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
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
 include/net/bluetooth/mgmt.h     |   14 ++++++
 net/bluetooth/hci_event.c        |   15 ++++++
 net/bluetooth/mgmt.c             |   92 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 130 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a5f8c46..7d1aef9 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -600,6 +600,13 @@ struct hci_cp_write_ssp_mode {
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
index 7ee921d..704f265 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -746,6 +746,8 @@ int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_pin_code_request(u16 index, bdaddr_t *bdaddr);
 int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
+int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
+								u8 status);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index a5cc1e0..18e2fb6 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -160,6 +160,20 @@ struct mgmt_cp_set_io_capability {
 	__u8 io_capability;
 } __packed;
 
+
+#define MGMT_OP_READ_LOCAL_OOB_DATA	0x0017
+struct mgmt_cp_read_local_oob_data {
+	__le16 index;
+} __packed;
+struct mgmt_rp_read_local_oob_data {
+	__le16 index;
+	__u8 hash[16];
+	__u8 randomizer[16];
+} __packed;
+struct mgmt_rp_read_local_oob_data_failed {
+	__le16 index;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1741936..053fcf7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -796,6 +796,17 @@ static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
 	hci_req_complete(hdev, HCI_OP_LE_READ_BUFFER_SIZE, rp->status);
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
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%x", hdev->name, status);
@@ -1723,6 +1734,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
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
index dee82fe..2847934 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1058,6 +1058,60 @@ static int set_io_capability(struct sock *sk, unsigned char *data, u16 len)
 						&dev_id, sizeof(dev_id));
 }
 
+static int read_local_oob_data(struct sock *sk, unsigned char *data, u16 len)
+{
+	struct hci_dev *hdev;
+	struct mgmt_cp_read_local_oob_data *cp;
+	struct mgmt_rp_read_local_oob_data_failed rp;
+	u16 dev_id;
+	int err;
+
+	cp = (void *) data;
+	dev_id = get_unaligned_le16(&cp->index);
+	rp.index = cp->index;
+
+	BT_DBG("hci%u", dev_id);
+
+	hdev = hci_dev_get(dev_id);
+	if (!hdev)
+		return cmd_status(sk, MGMT_OP_READ_LOCAL_OOB_DATA, ENODEV, &rp,
+								sizeof(rp));
+
+	hci_dev_lock_bh(hdev);
+
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		err = -ENETDOWN;
+		goto unlock;
+	}
+
+	if (!(hdev->features[6] & LMP_SIMPLE_PAIR)) {
+		err = -EPERM;
+		goto unlock;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, dev_id)) {
+		err = -EBUSY;
+		goto unlock;
+	}
+
+	err = mgmt_pending_add(sk, MGMT_OP_READ_LOCAL_OOB_DATA, dev_id, data,
+									len);
+	if (err == 0)
+		err = hci_send_cmd(hdev, HCI_OP_READ_LOCAL_OOB_DATA, 0, NULL);
+
+unlock:
+	if (err < 0) {
+		err = cmd_status(sk, MGMT_OP_READ_LOCAL_OOB_DATA, -err, &rp,
+								sizeof(rp));
+		mgmt_pending_remove(MGMT_OP_READ_LOCAL_OOB_DATA, dev_id);
+	}
+
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
@@ -1143,6 +1197,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_SET_IO_CAPABILITY:
 		err = set_io_capability(sk, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_READ_LOCAL_OOB_DATA:
+		err = read_local_oob_data(sk, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, opcode, 0x01, NULL, 0);
@@ -1404,3 +1461,38 @@ int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 
 	return err;
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
+		struct mgmt_rp_read_local_oob_data_failed rp;
+		put_unaligned_le16(index, &rp.index);
+
+		err = cmd_status(cmd->sk, MGMT_OP_READ_LOCAL_OOB_DATA, EIO, &rp,
+								sizeof(rp));
+	} else {
+		struct mgmt_rp_read_local_oob_data rp;
+
+		put_unaligned_le16(index, &rp.index);
+		memcpy(rp.hash, hash, 16);
+		memcpy(rp.randomizer, randomizer, 16);
+
+		err = cmd_complete(cmd->sk, MGMT_OP_READ_LOCAL_OOB_DATA, &rp,
+								sizeof(rp));
+	}
+
+	list_del(&cmd->list);
+	mgmt_pending_free(cmd);
+
+	return err;
+}
-- 
1.7.0.4


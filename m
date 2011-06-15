Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC 2/2] Bluetooth: Implement Read Transmit Power Level command
Date: Wed, 15 Jun 2011 17:12:21 -0400
Message-Id: <4df91f9a.e14fec0a.4a53.298b@mx.google.com>
In-Reply-To: <1308172341-24844-1-git-send-email-y>
References: <y>
 <1308172341-24844-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Add Read Transmit Power Level command in Management Interface and all
infrastructure need for that.

Read Transmit Power Level command is defined on Part E, section 7.3.35
of Bluetooth 4.0 Spec.

Signed-off-by: Bruna Moreira <bruna.moreira@openbossa.org>
---
 include/net/bluetooth/hci.h      |   10 ++++
 include/net/bluetooth/hci_core.h |    3 +
 include/net/bluetooth/mgmt.h     |   10 ++++
 net/bluetooth/hci_event.c        |   24 +++++++++
 net/bluetooth/mgmt.c             |  107 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 154 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ba6a4f8..5959fcf 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -632,6 +632,16 @@ struct hci_cp_write_voice_setting {
 	__le16   voice_setting;
 } __packed;
 
+#define HCI_OP_READ_TX_POWER	0x0c2d
+struct hci_cp_read_tx_power {
+	__le16   handle;
+} __packed;
+struct hci_rp_read_tx_power {
+	__u8     status;
+	__le16   handle;
+	__s8     level;
+} __packed;
+
 #define HCI_OP_HOST_BUFFER_SIZE		0x0c33
 struct hci_cp_host_buffer_size {
 	__le16   acl_mtu;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 18e13f5..13e292b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -842,6 +842,9 @@ int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 								u8 status);
 int mgmt_read_rssi_complete(u16 index, bdaddr_t *bdaddr, s8 rssi, u8 status);
 int mgmt_read_rssi_failed(u16 index);
+int mgmt_read_tx_power_complete(u16 index, bdaddr_t *bdaddr, s8 level,
+								u8 status);
+int mgmt_read_tx_power_failed(u16 index);
 int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
 							u8 *eir, u8 eir_len);
 int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index d71f648..31be2b3 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -211,6 +211,16 @@ struct mgmt_rp_read_rssi {
 	__s8 rssi;
 } __packed;
 
+#define MGMT_OP_READ_TX_POWER_LEVEL	0x001E
+struct mgmt_cp_read_tx_power_level {
+	bdaddr_t bdaddr;
+} __packed;
+struct mgmt_rp_read_tx_power_level {
+	bdaddr_t bdaddr;
+	__u8 status;
+	__s8 level;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 02a32e9..1c87e17 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -777,6 +777,26 @@ static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
 		conn->pin_length = cp->pin_len;
 }
 
+static void hci_cc_read_tx_power(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_read_tx_power *rp = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	if (!test_bit(HCI_MGMT, &hdev->flags))
+		return;
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
+	if (!conn) {
+		mgmt_read_tx_power_failed(hdev->id);
+		return;
+	}
+
+	mgmt_read_tx_power_complete(hdev->id, &conn->dst, rp->level,
+								rp->status);
+}
+
 static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_pin_code_neg_reply *rp = (void *) skb->data;
@@ -1929,6 +1949,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_read_rssi(hdev, skb);
 		break;
 
+	case HCI_OP_READ_TX_POWER:
+		hci_cc_read_tx_power(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ab37958..3f4c369 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1695,6 +1695,70 @@ unlock:
 	return err;
 }
 
+static int read_tx_power_level(struct sock *sk, u16 index,
+						unsigned char *data, u16 len)
+{
+	struct hci_dev *hdev;
+	struct mgmt_cp_read_tx_power_level *cp = (void *) data;
+	struct hci_cp_read_tx_power hci_cp;
+	struct pending_cmd *cmd;
+	struct hci_conn *conn;
+	int err;
+
+	BT_DBG("hci%u", index);
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_READ_TX_POWER_LEVEL,
+									EINVAL);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_READ_TX_POWER_LEVEL,
+									ENODEV);
+
+	hci_dev_lock(hdev);
+
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		err = cmd_status(sk, index, MGMT_OP_READ_TX_POWER_LEVEL,
+								ENETDOWN);
+		goto unlock;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_READ_TX_POWER_LEVEL, index)) {
+		err = cmd_status(sk, index, MGMT_OP_READ_TX_POWER_LEVEL, EBUSY);
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_READ_TX_POWER_LEVEL, index, data,
+									len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
+	if (!conn)
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
+
+	if (!conn) {
+		err = cmd_status(sk, index, MGMT_OP_READ_TX_POWER_LEVEL,
+								ENOTCONN);
+		goto unlock;
+	}
+
+	put_unaligned_le16(conn->handle, &hci_cp.handle);
+
+	err = hci_send_cmd(hdev, HCI_OP_READ_TX_POWER, sizeof(hci_cp), &hci_cp);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 int mgmt_read_rssi_failed(u16 index)
 {
 	struct pending_cmd *cmd;
@@ -2043,6 +2107,10 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_READ_RSSI:
 		err = read_rssi(sk, index, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_READ_TX_POWER_LEVEL:
+		err = read_tx_power_level(sk, index, buf + sizeof(*hdr),
+									len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode, 0x01);
@@ -2427,6 +2495,45 @@ int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 	return err;
 }
 
+int mgmt_read_tx_power_failed(u16 index)
+{
+	struct pending_cmd *cmd;
+	int err;
+
+	cmd = mgmt_pending_find(MGMT_OP_READ_TX_POWER_LEVEL, index);
+	if (!cmd)
+		return -ENOENT;
+
+	err = cmd_status(cmd->sk, index, MGMT_OP_READ_TX_POWER_LEVEL, EIO);
+
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
+
+int mgmt_read_tx_power_complete(u16 index, bdaddr_t *bdaddr, s8 level,
+								u8 status)
+{
+	struct pending_cmd *cmd;
+	struct mgmt_rp_read_tx_power_level rp;
+	int err;
+
+	cmd = mgmt_pending_find(MGMT_OP_READ_TX_POWER_LEVEL, index);
+	if (!cmd)
+		return -ENOENT;
+
+	bacpy(&rp.bdaddr, bdaddr);
+	rp.status = status;
+	rp.level = level;
+
+	err = cmd_complete(cmd->sk, index, MGMT_OP_READ_TX_POWER_LEVEL, &rp,
+								sizeof(rp));
+
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
+
 int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
 							u8 *eir, u8 eir_len)
 {
-- 
1.7.4.1


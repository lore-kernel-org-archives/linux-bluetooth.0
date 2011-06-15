Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC 1/2] Bluetooth: Implement Read RSSI command
Date: Wed, 15 Jun 2011 17:12:20 -0400
Message-Id: <4df91f98.e14fec0a.4a53.298a@mx.google.com>
In-Reply-To: <1308172341-24844-1-git-send-email-y>
References: <y>
 <1308172341-24844-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch implements helper functions to make Read RSSI command
interceptable by Management Interface. It adds a new wrapper in HCI
layer and add a hook to call mgmt_read_rssi_complete when MGMT Interface
has been loaded.

Read RSSI command is defined on Part E, section 7.5.4 of Bluetooth 4.0
Spec.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/hci.h      |   10 ++++
 include/net/bluetooth/hci_core.h |    2 +
 include/net/bluetooth/mgmt.h     |   10 ++++
 net/bluetooth/hci_event.c        |   24 +++++++++
 net/bluetooth/mgmt.c             |   99 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 145 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0f04c42..ba6a4f8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -545,6 +545,16 @@ struct hci_cp_set_event_flt {
 	__u8     condition[0];
 } __packed;
 
+#define HCI_OP_READ_RSSI		0x1405
+struct hci_cp_read_rssi {
+	__le16	handle;
+} __packed;
+struct hci_rp_read_rssi {
+	__u8	status;
+	__le16	handle;
+	__s8	rssi;
+} __packed;
+
 /* Filter types */
 #define HCI_FLT_CLEAR_ALL	0x00
 #define HCI_FLT_INQ_RESULT	0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5a7aa74..18e13f5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -840,6 +840,8 @@ int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_set_local_name_complete(u16 index, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 								u8 status);
+int mgmt_read_rssi_complete(u16 index, bdaddr_t *bdaddr, s8 rssi, u8 status);
+int mgmt_read_rssi_failed(u16 index);
 int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
 							u8 *eir, u8 eir_len);
 int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 9663f5d..d71f648 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -201,6 +201,16 @@ struct mgmt_cp_remove_remote_oob_data {
 
 #define MGMT_OP_STOP_DISCOVERY		0x001C
 
+#define MGMT_OP_READ_RSSI		0x001D
+struct mgmt_cp_read_rssi {
+	bdaddr_t bdaddr;
+} __packed;
+struct mgmt_rp_read_rssi {
+	__u8 status;
+	bdaddr_t bdaddr;
+	__s8 rssi;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a4cd22b..02a32e9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -900,6 +900,26 @@ static void hci_cc_le_ltk_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, HCI_OP_LE_LTK_NEG_REPLY, rp->status);
 }
 
+static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_read_rssi *rp = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	if (!test_bit(HCI_MGMT, &hdev->flags))
+		return;
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
+	if (!conn) {
+		mgmt_read_rssi_failed(hdev->id);
+		return;
+	}
+
+	mgmt_read_rssi_complete(hdev->id, &conn->dst, rp->rssi,
+							rp->status);
+}
+
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%x", hdev->name, status);
@@ -1905,6 +1925,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_le_ltk_neg_reply(hdev, skb);
 		break;
 
+	case HCI_OP_READ_RSSI:
+		hci_cc_read_rssi(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cbc922a..ab37958 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1637,6 +1637,102 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 	return err;
 }
 
+static int read_rssi(struct sock *sk, u16 index, unsigned char *data, u16 len)
+{
+	struct hci_dev *hdev;
+	struct mgmt_cp_read_rssi *cp = (void *) data;
+	struct hci_cp_read_rssi rs;
+	struct hci_conn *conn;
+	struct pending_cmd *cmd;
+	int err;
+
+	BT_DBG("hci%u", index);
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_READ_RSSI, EINVAL);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_READ_RSSI, ENODEV);
+
+	hci_dev_lock(hdev);
+
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		err = cmd_status(sk, index, MGMT_OP_READ_RSSI, ENETDOWN);
+		goto unlock;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_READ_RSSI, index)) {
+		err = cmd_status(sk, index, MGMT_OP_READ_RSSI, EBUSY);
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_READ_RSSI, index, NULL, 0);
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
+		err = cmd_status(sk, index, MGMT_OP_READ_RSSI, ENOTCONN);
+		goto unlock;
+	}
+
+	put_unaligned_le16(conn->handle, &rs.handle);
+
+	err = hci_send_cmd(hdev, HCI_OP_READ_RSSI, sizeof(rs), &rs);
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
+int mgmt_read_rssi_failed(u16 index)
+{
+	struct pending_cmd *cmd;
+	int err = 0;
+
+	cmd = mgmt_pending_find(MGMT_OP_READ_RSSI, index);
+	if (!cmd)
+		return -ENOENT;
+
+	err = cmd_status(cmd->sk, index, MGMT_OP_READ_RSSI, EIO);
+
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
+
+int mgmt_read_rssi_complete(u16 index, bdaddr_t *bdaddr, s8 rssi, u8 status)
+{
+	struct pending_cmd *cmd;
+	struct mgmt_rp_read_rssi rp;
+	int err;
+
+	cmd = mgmt_pending_find(MGMT_OP_READ_RSSI, index);
+	if (!cmd)
+		return -ENOENT;
+
+	bacpy(&rp.bdaddr, bdaddr);
+	rp.status = status;
+	rp.rssi = rssi;
+
+	err = cmd_complete(cmd->sk, index, MGMT_OP_READ_RSSI, &rp,
+								sizeof(rp));
+
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
+
 static int start_inquiry(struct hci_dev *hdev, __u8 inq_length)
 {
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
@@ -1944,6 +2040,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_STOP_DISCOVERY:
 		err = stop_discovery(sk, index);
 		break;
+	case MGMT_OP_READ_RSSI:
+		err = read_rssi(sk, index, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode, 0x01);
-- 
1.7.4.1


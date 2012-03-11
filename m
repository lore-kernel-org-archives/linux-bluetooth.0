Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Bruna Moreira <bruna.moreira@openbossa.org>,
	Arik Nemtsov <arik@wizery.com>
Subject: [PATCH v2] Bluetooth: Implement Read Transmit Power Level command
Date: Sun, 11 Mar 2012 15:36:03 +0200
Message-Id: <1331472963-808-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Add Read Transmit Power Level command in Management Interface and all
infrastructure need for that.

Read Transmit Power Level command is defined on Part E, section 7.3.35
of Bluetooth 4.0 Spec.

[Arik: Rebase to master, add type argument to HCI command, small
bug fixes and style changes]

Signed-off-by: Bruna Moreira <bruna.moreira@openbossa.org>
Signed-off-by: Arik Nemtsov <arik@wizery.com>
---
v1->2: remove spurious hci_dev_put(), needed before the rebase

 include/net/bluetooth/hci.h      |   11 ++++
 include/net/bluetooth/hci_core.h |    4 ++
 include/net/bluetooth/mgmt.h     |   12 ++++
 net/bluetooth/hci_event.c        |   24 +++++++++
 net/bluetooth/mgmt.c             |  107 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 158 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 344b0f9..b055922 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -679,6 +679,17 @@ struct hci_cp_write_voice_setting {
 	__le16   voice_setting;
 } __packed;
 
+#define HCI_OP_READ_TX_POWER		0x0c2d
+struct hci_cp_read_tx_power {
+	__le16   handle;
+	__u8     type;
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
index daefaac..7d5da34 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1029,6 +1029,10 @@ int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
 int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent);
+int mgmt_read_tx_power_complete(struct hci_dev *dev, bdaddr_t *bdaddr,
+				u8 link_type, u8 addr_type, s8 level,
+				u8 status);
+int mgmt_read_tx_power_failed(struct hci_dev *hdev);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index ffc1377..1aab829 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -341,6 +341,18 @@ struct mgmt_cp_unblock_device {
 } __packed;
 #define MGMT_UNBLOCK_DEVICE_SIZE	MGMT_ADDR_INFO_SIZE
 
+#define MGMT_OP_READ_TX_POWER_LEVEL	0x0028
+struct mgmt_cp_read_tx_power_level {
+	struct	mgmt_addr_info addr;
+	__u8	type;
+} __packed;
+#define MGMT_READ_TX_POWER_LEVEL_SIZE	(MGMT_ADDR_INFO_SIZE + 1)
+struct mgmt_rp_read_tx_power_level {
+	struct	mgmt_addr_info addr;
+	__u8	status;
+	__s8	level;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index badb785..ca93343 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -932,6 +932,26 @@ unlock:
 	hci_dev_unlock(hdev);
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
+		mgmt_read_tx_power_failed(hdev);
+		return;
+	}
+
+	mgmt_read_tx_power_complete(hdev, &conn->dst, conn->type,
+				    conn->dst_type, rp->level, rp->status);
+}
+
 static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_pin_code_neg_reply *rp = (void *) skb->data;
@@ -2333,6 +2353,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_write_le_host_supported(hdev, skb);
 		break;
 
+	case HCI_OP_READ_TX_POWER:
+		hci_cc_read_tx_power(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7fcff88..d97b2fb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -78,6 +78,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_CONFIRM_NAME,
 	MGMT_OP_BLOCK_DEVICE,
 	MGMT_OP_UNBLOCK_DEVICE,
+	MGMT_OP_READ_TX_POWER_LEVEL,
 };
 
 static const u16 mgmt_events[] = {
@@ -1690,6 +1691,69 @@ unlock:
 	return err;
 }
 
+static int read_tx_power_level(struct sock *sk, struct hci_dev *hdev,
+			       void *data, u16 len)
+{
+	struct mgmt_cp_read_tx_power_level *cp = data;
+	struct hci_cp_read_tx_power hci_cp;
+	struct pending_cmd *cmd;
+	struct hci_conn *conn;
+	int err;
+
+	BT_DBG("");
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, hdev->id, MGMT_OP_READ_TX_POWER_LEVEL,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_READ_TX_POWER_LEVEL,
+				 MGMT_STATUS_NOT_POWERED);
+		goto unlock;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_READ_TX_POWER_LEVEL, hdev)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_READ_TX_POWER_LEVEL,
+				 MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_READ_TX_POWER_LEVEL, hdev, data,
+			       len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	if (cp->addr.type == MGMT_ADDR_BREDR)
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+					       &cp->addr.bdaddr);
+	else
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
+					       &cp->addr.bdaddr);
+
+	if (!conn) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_READ_TX_POWER_LEVEL,
+				 MGMT_STATUS_NOT_CONNECTED);
+		mgmt_pending_remove(cmd);
+		goto unlock;
+	}
+
+	put_unaligned_le16(conn->handle, &hci_cp.handle);
+	hci_cp.type = cp->type;
+
+	err = hci_send_cmd(hdev, HCI_OP_READ_TX_POWER, sizeof(hci_cp), &hci_cp);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static int send_pin_code_neg_reply(struct sock *sk, struct hci_dev *hdev,
 				   struct mgmt_cp_pin_code_neg_reply *cp)
 {
@@ -2642,6 +2706,7 @@ struct mgmt_handler {
 	{ confirm_name,           false, MGMT_CONFIRM_NAME_SIZE },
 	{ block_device,           false, MGMT_BLOCK_DEVICE_SIZE },
 	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
+	{ read_tx_power_level,    false, MGMT_READ_TX_POWER_LEVEL_SIZE },
 };
 
 
@@ -3435,6 +3500,48 @@ int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	return err;
 }
 
+int mgmt_read_tx_power_failed(struct hci_dev *hdev)
+{
+	struct pending_cmd *cmd;
+	int err;
+
+	cmd = mgmt_pending_find(MGMT_OP_READ_TX_POWER_LEVEL, hdev);
+	if (!cmd)
+		return -ENOENT;
+
+	err = cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_TX_POWER_LEVEL,
+			 MGMT_STATUS_FAILED);
+
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
+
+int mgmt_read_tx_power_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				u8 link_type, u8 addr_type, s8 level,
+				u8 status)
+{
+	struct pending_cmd *cmd;
+	struct mgmt_rp_read_tx_power_level rp;
+	int err;
+
+	cmd = mgmt_pending_find(MGMT_OP_READ_TX_POWER_LEVEL, hdev);
+	if (!cmd)
+		return -ENOENT;
+
+	bacpy(&rp.addr.bdaddr, bdaddr);
+	rp.addr.type = link_to_mgmt(link_type, addr_type);
+	rp.status = status;
+	rp.level = level;
+
+	err = cmd_complete(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status),
+			   &rp, sizeof(rp));
+
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
+
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name, u8
 		      ssp, u8 *eir, u16 eir_len)
-- 
1.7.5.4


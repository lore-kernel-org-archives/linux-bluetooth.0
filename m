Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] Bluetooth: Add support for read remote rssi
Date: Tue, 25 Mar 2014 23:46:15 +0100
Message-ID: <1395787575-26716-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add support for read remote rssi.
This is needed for example for proximity scenarios.

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 include/net/bluetooth/hci.h      | 10 +++++
 include/net/bluetooth/hci_core.h |  3 ++
 include/net/bluetooth/mgmt.h     | 10 +++++
 net/bluetooth/hci_event.c        | 24 ++++++++++++
 net/bluetooth/mgmt.c             | 82 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4261a67..2e023e8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1064,6 +1064,16 @@ struct hci_rp_read_page_scan_type {
 	#define PAGE_SCAN_TYPE_STANDARD		0x00
 	#define PAGE_SCAN_TYPE_INTERLACED	0x01
 
+#define HCI_OP_READ_REMOTE_RSSI		0x1405
+struct hci_cp_read_remote_rssi {
+	__le16   handle;
+} __packed;
+struct hci_rp_read_remote_rssi {
+	__u8     status;
+	__le16   handle;
+	__s8     rssi;
+} __packed;
+
 #define HCI_OP_READ_LOCAL_AMP_INFO	0x1409
 struct hci_rp_read_local_amp_info {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index abd38a2..95837b7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1283,6 +1283,9 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 		   bool persistent);
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
+void mgmt_read_remote_rssi_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				    u8 link_type, u8 addr_type, s8 rssi,
+				    u8 status);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index d4b571c..16a0201 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -409,6 +409,16 @@ struct mgmt_cp_load_irks {
 } __packed;
 #define MGMT_LOAD_IRKS_SIZE		2
 
+#define MGMT_OP_READ_REMOTE_RSSI	0x0031
+#define MGMT_READ_REMOTE_RSSI_SIZE	MGMT_ADDR_INFO_SIZE
+struct mgmt_cp_read_remote_rssi {
+	struct mgmt_addr_info addr;
+} __packed;
+struct mgmt_rp_read_remote_rssi {
+	struct mgmt_addr_info addr;
+	__s8 rssi;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2ecb34f..88d5d88 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1230,6 +1230,26 @@ static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_read_remote_rssi(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_read_remote_rssi *rp = (void *)skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
+	if (!conn)
+		goto unlock;
+
+	mgmt_read_remote_rssi_complete(hdev, &conn->dst, conn->type,
+				       conn->dst_type, rp->rssi, rp->status);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_write_remote_amp_assoc(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
@@ -2632,6 +2652,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_set_adv_param(hdev, skb);
 		break;
 
+	case HCI_OP_READ_REMOTE_RSSI:
+		hci_cc_read_remote_rssi(hdev, skb);
+		break;
+
 	case HCI_OP_WRITE_REMOTE_AMP_ASSOC:
 		hci_cc_write_remote_amp_assoc(hdev, skb);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6229d1f..c00a53b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -83,6 +83,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_DEBUG_KEYS,
 	MGMT_OP_SET_PRIVACY,
 	MGMT_OP_LOAD_IRKS,
+	MGMT_OP_READ_REMOTE_RSSI,
 };
 
 static const u16 mgmt_events[] = {
@@ -4470,6 +4471,64 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 	return err;
 }
 
+static int read_remote_rssi(struct sock *sk, struct hci_dev *hdev,
+			       void *data, u16 len)
+{
+	struct mgmt_cp_read_remote_rssi *cp = data;
+	struct mgmt_rp_read_remote_rssi rp;
+	struct hci_cp_read_remote_rssi rc;
+	struct pending_cmd *cmd;
+	struct hci_conn *conn;
+	int err;
+
+	BT_DBG("");
+
+	memset(&rp, 0, sizeof(rp));
+	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
+	rp.addr.type = cp->addr.type;
+
+	if (!bdaddr_type_is_valid(cp->addr.type))
+		return cmd_complete(sk, hdev->id, MGMT_OP_READ_REMOTE_RSSI,
+				    MGMT_STATUS_INVALID_PARAMS,
+				    &rp, sizeof(rp));
+
+	hci_dev_lock(hdev);
+
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		err = cmd_complete(sk, hdev->id, MGMT_OP_READ_REMOTE_RSSI,
+				   MGMT_STATUS_NOT_POWERED, &rp, sizeof(rp));
+		goto done;
+	}
+
+	if (cp->addr.type == BDADDR_BREDR)
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+					       &cp->addr.bdaddr);
+	else
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
+
+	if (!conn || conn->state == BT_OPEN || conn->state == BT_CLOSED) {
+		err = cmd_complete(sk, hdev->id, MGMT_OP_READ_REMOTE_RSSI,
+				   MGMT_STATUS_NOT_CONNECTED, &rp, sizeof(rp));
+		goto done;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_READ_REMOTE_RSSI, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	rc.handle = cpu_to_le16(conn->handle);
+
+	err = hci_send_cmd(hdev, HCI_OP_READ_REMOTE_RSSI, sizeof(rc), &rc);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+done:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static bool ltk_is_valid(struct mgmt_ltk_info *key)
 {
 	if (key->master != 0x00 && key->master != 0x01)
@@ -4610,6 +4669,7 @@ static const struct mgmt_handler {
 	{ set_debug_keys,         false, MGMT_SETTING_SIZE },
 	{ set_privacy,            false, MGMT_SET_PRIVACY_SIZE },
 	{ load_irks,              true,  MGMT_LOAD_IRKS_SIZE },
+	{ read_remote_rssi,       false, MGMT_READ_REMOTE_RSSI_SIZE },
 };
 
 
@@ -5829,3 +5889,25 @@ void mgmt_reenable_advertising(struct hci_dev *hdev)
 		new_settings(hdev, NULL);
 	}
 }
+
+void mgmt_read_remote_rssi_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				    u8 link_type, u8 addr_type, s8 rssi,
+				    u8 status)
+{
+	struct pending_cmd *cmd;
+	struct mgmt_rp_read_remote_rssi rp;
+
+	memset(&rp, 0, sizeof(rp));
+	bacpy(&rp.addr.bdaddr, bdaddr);
+	rp.addr.type = link_to_bdaddr(link_type, addr_type);
+	rp.rssi = rssi;
+
+	cmd = mgmt_pending_find(MGMT_OP_READ_REMOTE_RSSI, hdev);
+	if (!cmd)
+		return;
+
+	cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(status),
+		     &rp, sizeof(rp));
+
+	mgmt_pending_remove(cmd);
+}
-- 
1.8.4


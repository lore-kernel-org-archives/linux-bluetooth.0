Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [PATCH 05/12] Bluetooth: Add set broadcaster MGMT command
Date: Fri, 14 Dec 2012 14:51:31 -0400
Message-Id: <1355511098-10190-6-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>

This command will enable or disable broadcaster mode. Data can be added
with set_controller_data command.

If LE_ENABLED is set, the HCI_OP_LE_SET_ADV_ENABLE command will be sent.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  8 ++++
 include/net/bluetooth/mgmt.h     |  3 ++
 net/bluetooth/hci_event.c        | 28 +++++++++---
 net/bluetooth/mgmt.c             | 93 +++++++++++++++++++++++++++++++++++++++-
 5 files changed, 127 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a89ff01..efbdd3d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -121,6 +121,7 @@ enum {
 	HCI_LINK_SECURITY,
 	HCI_PENDING_CLASS,
 	HCI_PERIODIC_INQ,
+	HCI_BROADCASTER,
 };
 
 /* HCI ioctl defines */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cf8d125..56af0fd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -131,6 +131,10 @@ struct broadcast_data {
 	u8 data[0];
 };
 
+enum {
+	LE_ADV_REQ_REASON_BROADCASTER,
+};
+
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
 struct amp_assoc {
@@ -293,6 +297,8 @@ struct hci_dev {
 	struct list_head	broadcast_data;
 	__u16			broadcast_data_len;
 
+	__u8			le_adv_req_reason;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
@@ -1122,6 +1128,8 @@ int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 					    u8 *randomizer, u8 status);
 int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
+int mgmt_set_broadcaster_complete(struct hci_dev *hdev, bool changed,
+				  u8 status);
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
 		      u8 ssp, u8 *eir, u16 eir_len);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index bbb4b4a..bd64816 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -92,6 +92,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_BREDR		0x00000080
 #define MGMT_SETTING_HS			0x00000100
 #define MGMT_SETTING_LE			0x00000200
+#define MGMT_SETTING_BROADCASTER	0x00000400
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -365,6 +366,8 @@ struct mgmt_cp_unset_controller_data {
 } __packed;
 #define MGMT_UNSET_CONTROLLER_DATA_SIZE	1
 
+#define MGMT_OP_SET_BROADCASTER		0x002B
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8f84f71..46f76d6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1204,6 +1204,7 @@ static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
 static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 *sent, status = *((__u8 *) skb->data);
+	__u8 enable;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
@@ -1211,13 +1212,30 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!sent)
 		return;
 
+	enable = *sent;
+
 	hci_dev_lock(hdev);
 
-	if (!status) {
-		if (*sent)
-			set_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
-		else
-			clear_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+	if (hdev->le_adv_req_reason == LE_ADV_REQ_REASON_BROADCASTER) {
+		bool changed = false;
+		if (enable) {
+			if (!test_and_set_bit(HCI_BROADCASTER,
+					      &hdev->dev_flags))
+				changed = true;
+		} else {
+			if (test_and_clear_bit(HCI_BROADCASTER,
+					       &hdev->dev_flags))
+				changed = true;
+		}
+		if (!test_bit(HCI_INIT, &hdev->flags))
+			mgmt_set_broadcaster_complete(hdev, changed, status);
+	} else {
+		if (!status) {
+			if (enable)
+				set_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+			else
+				clear_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+		}
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0aa96bb..608e81af 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -392,8 +392,10 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (enable_hs)
 		settings |= MGMT_SETTING_HS;
 
-	if (lmp_le_capable(hdev))
+	if (lmp_le_capable(hdev)) {
 		settings |= MGMT_SETTING_LE;
+		settings |= MGMT_SETTING_BROADCASTER;
+	}
 
 	return settings;
 }
@@ -420,6 +422,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
 		settings |= MGMT_SETTING_LE;
 
+	if (test_bit(HCI_BROADCASTER, &hdev->dev_flags))
+		settings |= MGMT_SETTING_BROADCASTER;
+
 	if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags))
 		settings |= MGMT_SETTING_LINK_SECURITY;
 
@@ -2762,6 +2767,64 @@ static int unset_controller_data(struct sock *sk, struct hci_dev *hdev,
 			    NULL, 0);
 }
 
+static int set_broadcaster_le(struct sock *sk, struct hci_dev *hdev, u8 enable)
+{
+	struct pending_cmd *cmd;
+	int err;
+
+	BT_DBG("%s enable:%i", hdev->name, enable);
+
+	hci_dev_lock(hdev);
+
+	if (!hdev_is_powered(hdev)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_BROADCASTER,
+				  MGMT_STATUS_NOT_POWERED);
+		goto unlock;
+	}
+
+	if (enable == test_bit(HCI_BROADCASTER, &hdev->dev_flags)) {
+		err = send_settings_rsp(sk, MGMT_OP_SET_BROADCASTER, hdev);
+		goto unlock;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_SET_BROADCASTER, hdev)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_BROADCASTER,
+				 MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_BROADCASTER, hdev, NULL, 0);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	hdev->le_adv_req_reason = LE_ADV_REQ_REASON_BROADCASTER;
+
+	err = hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
+			   &enable);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
+static int set_broadcaster(struct sock *sk, struct hci_dev *hdev, void *data,
+			   u16 len)
+{
+	struct mgmt_mode *cp = data;
+
+	BT_DBG("%s val:%i", hdev->name, cp->val);
+
+	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_BROADCASTER,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	return set_broadcaster_le(sk, hdev, cp->val);
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -2811,6 +2874,7 @@ static const struct mgmt_handler {
 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
 	{ set_controller_data,    true,  MGMT_SET_CONTROLLER_DATA_SIZE },
 	{ unset_controller_data,  false, MGMT_UNSET_CONTROLLER_DATA_SIZE },
+	{ set_broadcaster,        false, MGMT_SETTING_SIZE },
 };
 
 
@@ -3667,6 +3731,33 @@ int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	return err;
 }
 
+int mgmt_set_broadcaster_complete(struct hci_dev *hdev, bool changed, u8 status)
+{
+	struct pending_cmd *cmd;
+	struct cmd_lookup match = { NULL, hdev };
+	int err = 0;
+
+	cmd = mgmt_pending_find(MGMT_OP_SET_BROADCASTER, hdev);
+	if (!cmd)
+		return -ENOENT;
+
+	if (status) {
+		u8 mgmt_err = mgmt_status(status);
+		cmd_status_rsp(cmd, &mgmt_err);
+		return err;
+	}
+
+	settings_rsp(cmd, &match);
+
+	if (changed)
+		err = new_settings(hdev, match.sk);
+
+	if (match.sk)
+		sock_put(match.sk);
+
+	return err;
+}
+
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name, u8
 		      ssp, u8 *eir, u16 eir_len)
-- 
1.8.0.2


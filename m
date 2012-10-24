Return-Path: <cyrus@holtmann.org>
From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [RFC 7/9] Bluetooth: Add set broadcaster MGMT command
Date: Wed, 24 Oct 2012 12:58:13 -0300
Message-Id: <1351094295-10418-8-git-send-email-aloisio.almeida@openbossa.org>
In-Reply-To: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
References: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command will enable or disable broadcaster mode. Data can be added
with set_controller_data command.

If LE_ENABLED is set, the HCI_OP_LE_SET_ADV_ENABLE command will be sent.

This command is available on the powered off state.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/mgmt.h     |    3 +
 net/bluetooth/hci_event.c        |   21 +++++++
 net/bluetooth/mgmt.c             |  116 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 142 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1dadf3d..591450c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -120,6 +120,7 @@ enum {
 	HCI_LINK_SECURITY,
 	HCI_PENDING_CLASS,
 	HCI_PERIODIC_INQ,
+	HCI_BROADCASTER,
 };
 
 /* HCI ioctl defines */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d5d4dc4..fc26210 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1088,6 +1088,7 @@ int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 					    u8 *randomizer, u8 status);
 int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
+int mgmt_set_broadcaster_complete(struct hci_dev *hdev, u8 enable, u8 status);
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
index 3df6e67..7ad2b0d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1330,6 +1330,23 @@ static void hci_cc_le_set_adv_params(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, HCI_OP_LE_SET_ADV_PARAMS, status);
 }
 
+static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+	__u8 enable;
+	void *sent;
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADV_ENABLE);
+	if (!sent)
+		return;
+
+	enable = *((__u8 *) sent);
+
+	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
+	    !test_bit(HCI_INIT, &hdev->flags))
+		mgmt_set_broadcaster_complete(hdev, enable, status);
+}
+
 static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
@@ -2593,6 +2610,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_le_set_adv_params(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_ADV_ENABLE:
+		hci_cc_le_set_adv_enable(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a094ef3..705859f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -380,6 +380,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	settings |= MGMT_SETTING_FAST_CONNECTABLE;
 	settings |= MGMT_SETTING_DISCOVERABLE;
 	settings |= MGMT_SETTING_PAIRABLE;
+	settings |= MGMT_SETTING_BROADCASTER;
 
 	if (lmp_ssp_capable(hdev))
 		settings |= MGMT_SETTING_SSP;
@@ -420,6 +421,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
 		settings |= MGMT_SETTING_LE;
 
+	if (test_bit(HCI_BROADCASTER, &hdev->dev_flags))
+		settings |= MGMT_SETTING_BROADCASTER;
+
 	if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags))
 		settings |= MGMT_SETTING_LINK_SECURITY;
 
@@ -2776,6 +2780,74 @@ static int unset_controller_data(struct sock *sk, struct hci_dev *hdev,
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
+		bool changed = false;
+
+		if (enable != test_bit(HCI_BROADCASTER, &hdev->dev_flags)) {
+			change_bit(HCI_BROADCASTER, &hdev->dev_flags);
+			changed = true;
+		}
+
+		err = send_settings_rsp(sk, MGMT_OP_SET_BROADCASTER, hdev);
+		if (err < 0)
+			goto unlock;
+
+		if (changed)
+			err = new_settings(hdev, sk);
+
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
@@ -2825,6 +2897,7 @@ static const struct mgmt_handler {
 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
 	{ set_controller_data,    true,  MGMT_SET_CONTROLLER_DATA_SIZE },
 	{ unset_controller_data,  false, MGMT_UNSET_CONTROLLER_DATA_SIZE },
+	{ set_broadcaster,        false, MGMT_SETTING_SIZE },
 };
 
 
@@ -3007,6 +3080,14 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 
 		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
 			update_adv_data(hdev);
+
+		if (test_bit(HCI_BROADCASTER, &hdev->dev_flags) &&
+		    test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+			u8 enable = 1;
+			hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+				     sizeof(enable), &enable);
+		}
+
 	} else {
 		u8 status = MGMT_STATUS_NOT_POWERED;
 		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
@@ -3664,6 +3745,41 @@ int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	return err;
 }
 
+int mgmt_set_broadcaster_complete(struct hci_dev *hdev, u8 enable, u8 status)
+{
+	struct cmd_lookup match = { NULL, hdev };
+	bool changed = false;
+	int err = 0;
+
+	if (status) {
+		u8 mgmt_err = mgmt_status(status);
+
+		mgmt_pending_foreach(MGMT_OP_SET_BROADCASTER, hdev,
+				     cmd_status_rsp, &mgmt_err);
+
+		return err;
+	}
+
+	if (enable) {
+		if (!test_and_set_bit(HCI_BROADCASTER, &hdev->dev_flags))
+			changed = true;
+	} else {
+		if (test_and_clear_bit(HCI_BROADCASTER, &hdev->dev_flags))
+			changed = true;
+	}
+
+	mgmt_pending_foreach(MGMT_OP_SET_BROADCASTER, hdev, settings_rsp,
+			     &match);
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
1.7.10.4


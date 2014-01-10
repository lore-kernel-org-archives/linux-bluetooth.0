Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 08/15] Bluetooth: Add management command for enabling Secure Connections
Date: Fri, 10 Jan 2014 01:29:35 -0800
Message-Id: <1389346182-12387-8-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The support for Secure Connections need to be explicitly enabled by
userspace. This is required since only userspace that can handle the
new link key types should enable support for Secure Connections.

This command handling is similar to how Secure Simple Pairing enabling
is done. It also tracks the case when Secure Connections support is
enabled via raw HCI commands. This makes sure that the host features
page is updated as well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |   1 +
 include/net/bluetooth/mgmt.h     |   2 +
 net/bluetooth/hci_event.c        |  32 ++++++++++++
 net/bluetooth/mgmt.c             | 106 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bb984d0626b7..1eb55ec40ac0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1125,6 +1125,7 @@ void mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, u8 status);
 void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
 void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
+void mgmt_sc_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 				    u8 status);
 void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 4ec17dec62e0..8a2c78175997 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -370,6 +370,8 @@ struct mgmt_cp_set_scan_params {
 } __packed;
 #define MGMT_SET_SCAN_PARAMS_SIZE	4
 
+#define MGMT_OP_SET_SECURE_CONN		0x002D
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b3c5396e0c1b..820a01965ce3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -461,6 +461,34 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
+static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+	struct hci_cp_write_sc_support *sent;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_SC_SUPPORT);
+	if (!sent)
+		return;
+
+	if (!status) {
+		if (sent->support)
+			hdev->features[1][0] |= LMP_HOST_SC;
+		else
+			hdev->features[1][0] &= ~LMP_HOST_SC;
+	}
+
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+		mgmt_sc_enable_complete(hdev, sent->support, status);
+	else if (!status) {
+		if (sent->support)
+			set_bit(HCI_SC_ENABLED, &hdev->dev_flags);
+		else
+			clear_bit(HCI_SC_ENABLED, &hdev->dev_flags);
+	}
+}
+
 static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_read_local_version *rp = (void *) skb->data;
@@ -2147,6 +2175,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_write_ssp_mode(hdev, skb);
 		break;
 
+	case HCI_OP_WRITE_SC_SUPPORT:
+		hci_cc_write_sc_support(hdev, skb);
+		break;
+
 	case HCI_OP_READ_LOCAL_VERSION:
 		hci_cc_read_local_version(hdev, skb);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b00fa0253cba..68a3c998d19c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4006,6 +4006,79 @@ unlock:
 	return err;
 }
 
+static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
+			   void *data, u16 len)
+{
+	struct mgmt_mode *cp = data;
+	struct pending_cmd *cmd;
+	u8 status;
+	int err;
+
+	BT_DBG("request for %s", hdev->name);
+
+	status = mgmt_bredr_support(hdev);
+	if (status)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
+				  status);
+
+	if (!lmp_sc_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	if (!hdev_is_powered(hdev)) {
+		bool changed;
+
+		if (cp->val)
+			changed = !test_and_set_bit(HCI_SC_ENABLED,
+						    &hdev->dev_flags);
+		else
+			changed = test_and_clear_bit(HCI_SC_ENABLED,
+						     &hdev->dev_flags);
+
+		err = send_settings_rsp(sk, MGMT_OP_SET_SECURE_CONN, hdev);
+		if (err < 0)
+			goto failed;
+
+		if (changed)
+			err = new_settings(hdev, sk);
+
+		goto failed;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_SET_SECURE_CONN, hdev)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
+				 MGMT_STATUS_BUSY);
+		goto failed;
+	}
+
+	if (!!cp->val == test_bit(HCI_SC_ENABLED, &hdev->dev_flags)) {
+		err = send_settings_rsp(sk, MGMT_OP_SET_SECURE_CONN, hdev);
+		goto failed;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_SECURE_CONN, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	err = hci_send_cmd(hdev, HCI_OP_WRITE_SC_SUPPORT, 1, &cp->val);
+	if (err < 0) {
+		mgmt_pending_remove(cmd);
+		goto failed;
+	}
+
+failed:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static bool ltk_is_valid(struct mgmt_ltk_info *key)
 {
 	if (key->authenticated != 0x00 && key->authenticated != 0x01)
@@ -4134,6 +4207,7 @@ static const struct mgmt_handler {
 	{ set_bredr,              false, MGMT_SETTING_SIZE },
 	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
 	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
+	{ set_secure_conn,        false, MGMT_SETTING_SIZE },
 };
 
 
@@ -4917,6 +4991,38 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	hci_req_run(&req, NULL);
 }
 
+void mgmt_sc_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
+{
+	struct cmd_lookup match = { NULL, hdev };
+	bool changed = false;
+
+	if (status) {
+		u8 mgmt_err = mgmt_status(status);
+
+		if (enable && test_and_clear_bit(HCI_SC_ENABLED,
+						 &hdev->dev_flags))
+			new_settings(hdev, NULL);
+
+		mgmt_pending_foreach(MGMT_OP_SET_SECURE_CONN, hdev,
+				     cmd_status_rsp, &mgmt_err);
+		return;
+	}
+
+	if (enable)
+		changed = !test_and_set_bit(HCI_SC_ENABLED, &hdev->dev_flags);
+	else
+		changed = test_and_clear_bit(HCI_SC_ENABLED, &hdev->dev_flags);
+
+	mgmt_pending_foreach(MGMT_OP_SET_SECURE_CONN, hdev,
+			     settings_rsp, &match);
+
+	if (changed)
+		new_settings(hdev, match.sk);
+
+	if (match.sk)
+		sock_put(match.sk);
+}
+
 static void sk_lookup(struct pending_cmd *cmd, void *data)
 {
 	struct cmd_lookup *match = data;
-- 
1.8.4.2


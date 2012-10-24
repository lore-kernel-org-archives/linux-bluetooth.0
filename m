Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: mgmt: Add support for switching to LE peripheral mode
Date: Thu, 25 Oct 2012 00:09:55 +0300
Message-Id: <1351112996-9597-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch extends the mgmt_set_le command to allow for a new value
(0x02) to mean that LE should be enabled together with advertising
enabled. This paves the way for acting in a fully functional LE
peripheral role. The change to the mgmt_set_le command is fully
backwards compatible as the value 0x01 means LE central role (which was
the old behavior).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      |    2 +
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/mgmt.h     |    6 ++
 net/bluetooth/hci_event.c        |   57 +++++++++++++
 net/bluetooth/mgmt.c             |  166 +++++++++++++++++++++++++++++++-------
 5 files changed, 204 insertions(+), 28 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6c414f4..a633da0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -939,6 +939,8 @@ struct hci_rp_le_read_adv_tx_power {
 	__s8	tx_power;
 } __packed;
 
+#define HCI_OP_LE_SET_ADV_ENABLE	0x200a
+
 #define HCI_OP_LE_SET_SCAN_PARAM	0x200b
 struct hci_cp_le_set_scan_param {
 	__u8    type;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b3490c6..9d7e94e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1083,6 +1083,7 @@ int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 					    u8 *randomizer, u8 status);
 int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
+int mgmt_le_adv_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
 		      u8 ssp, u8 *eir, u16 eir_len);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 22980a7..26c9a4d 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -92,6 +92,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_BREDR		0x00000080
 #define MGMT_SETTING_HS			0x00000100
 #define MGMT_SETTING_LE			0x00000200
+#define MGMT_SETTING_PERIPHERAL		0x00000400
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -134,6 +135,11 @@ struct mgmt_cp_set_discoverable {
 #define MGMT_OP_SET_HS			0x000C
 
 #define MGMT_OP_SET_LE			0x000D
+
+#define MGMT_LE_OFF			0x00
+#define MGMT_LE_CENTRAL			0x01
+#define MGMT_LE_PERIPHERAL		0x02
+
 #define MGMT_OP_SET_DEV_CLASS		0x000E
 struct mgmt_cp_set_dev_class {
 	__u8	major;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dc60d31..ed6b1e2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -790,9 +790,24 @@ static void hci_set_le_support(struct hci_dev *hdev)
 		cp.simul = !!lmp_le_br_capable(hdev);
 	}
 
+	/* If the host features don't reflect the desired state for LE
+	 * then send the write_le_host_supported command. The command
+	 * complete handler for it will take care of any necessary
+	 * subsequent commands like set_adv_enable.
+	 *
+	 * If the host features for LE are already correct and
+	 * peripheral mode is enabled directly send the le_set_adv
+	 * command. The value of &cp.le is used so that advertising will
+	 * not be enabled in the exceptional case that LE for some
+	 * reason isn't enabled - something that should only be possible
+	 * if someone is doing direct raw access to HCI.
+	 */
 	if (cp.le != !!lmp_host_le_capable(hdev))
 		hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(cp),
 			     &cp);
+	else if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
+		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(cp.le),
+			     &cp.le);
 }
 
 static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
@@ -1196,6 +1211,39 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
+static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 *sent, status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADV_ENABLE);
+	if (!sent)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (!status) {
+		/* These set_bit and clear_bit calls will not actually
+		 * change anything if mgmt was used since the flag is
+		 * already set in the mgmt command handler. The calls
+		 * are here so that the reported settings remain correct
+		 * if mgmt is bypassed e.g. with hciconfig.
+		 */
+		if (*sent)
+			set_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+		else
+			clear_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+	}
+
+	if (!test_bit(HCI_INIT, &hdev->flags))
+		mgmt_le_adv_enable_complete(hdev, *sent, status);
+
+	hci_dev_unlock(hdev);
+
+	hci_req_complete(hdev, HCI_OP_LE_SET_ADV_ENABLE, status);
+}
+
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 				      struct sk_buff *skb)
 {
@@ -1299,6 +1347,11 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 			hdev->host_features[0] |= LMP_HOST_LE_BREDR;
 		else
 			hdev->host_features[0] &= ~LMP_HOST_LE_BREDR;
+
+		if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags) &&
+		    test_bit(HCI_INIT, &hdev->flags))
+			hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+				     sizeof(sent->le), &sent->le);
 	}
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
@@ -2561,6 +2614,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_le_set_scan_param(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_ADV_ENABLE:
+		hci_cc_le_set_adv_enable(hdev, skb);
+		break;
+
 	case HCI_OP_LE_SET_SCAN_ENABLE:
 		hci_cc_le_set_scan_enable(hdev, skb);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9fe386f..6770835 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -393,8 +393,10 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (enable_hs)
 		settings |= MGMT_SETTING_HS;
 
-	if (lmp_le_capable(hdev))
+	if (lmp_le_capable(hdev)) {
 		settings |= MGMT_SETTING_LE;
+		settings |= MGMT_SETTING_PERIPHERAL;
+	}
 
 	return settings;
 }
@@ -418,9 +420,13 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (lmp_bredr_capable(hdev))
 		settings |= MGMT_SETTING_BREDR;
 
-	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
 		settings |= MGMT_SETTING_LE;
 
+		if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
+			settings |= MGMT_SETTING_PERIPHERAL;
+	}
+
 	if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags))
 		settings |= MGMT_SETTING_LINK_SECURITY;
 
@@ -1207,13 +1213,36 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	return send_settings_rsp(sk, MGMT_OP_SET_HS, hdev);
 }
 
+static u8 get_le_mode(struct hci_dev *hdev)
+{
+	if (lmp_host_le_capable(hdev)) {
+		if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
+			return MGMT_LE_PERIPHERAL;
+		return MGMT_LE_CENTRAL;
+	}
+
+	return MGMT_LE_OFF;
+}
+
+static bool valid_le_mode(u8 mode)
+{
+	switch (mode) {
+	case MGMT_LE_OFF:
+	case MGMT_LE_CENTRAL:
+	case MGMT_LE_PERIPHERAL:
+		return true;
+	}
+
+	return false;
+}
+
 static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
-	struct mgmt_mode *cp = data;
 	struct hci_cp_write_le_host_supported hci_cp;
+	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
+	u8 old_mode, new_mode;
 	int err;
-	u8 val, enabled;
 
 	BT_DBG("request for %s", hdev->name);
 
@@ -1225,48 +1254,78 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto unlock;
 	}
 
-	val = !!cp->val;
-	enabled = !!lmp_host_le_capable(hdev);
+	if (!valid_le_mode(cp->val)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
+				 MGMT_STATUS_INVALID_PARAMS);
+		goto unlock;
+	}
 
-	if (!hdev_is_powered(hdev) || val == enabled) {
-		bool changed = false;
+	if (mgmt_pending_find(MGMT_OP_SET_LE, hdev)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
+				 MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	new_mode = cp->val;
+	old_mode = get_le_mode(hdev);
+
+	BT_DBG("%s old_mode %u new_mode %u", hdev->name, old_mode, new_mode);
+
+	if (new_mode == old_mode) {
+		err = send_settings_rsp(sk, MGMT_OP_SET_LE, hdev);
+		goto unlock;
+	}
+
+	/* If we're switching away from or into peripheral role toggle
+	 * the corresponding flag
+	 */
+	if (old_mode == MGMT_LE_PERIPHERAL || new_mode == MGMT_LE_PERIPHERAL)
+		change_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
 
-		if (val != test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+	if (!hdev_is_powered(hdev)) {
+		if (old_mode == MGMT_LE_OFF || new_mode == MGMT_LE_OFF)
 			change_bit(HCI_LE_ENABLED, &hdev->dev_flags);
-			changed = true;
-		}
 
 		err = send_settings_rsp(sk, MGMT_OP_SET_LE, hdev);
 		if (err < 0)
 			goto unlock;
 
-		if (changed)
-			err = new_settings(hdev, sk);
+		err = new_settings(hdev, sk);
 
 		goto unlock;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_LE, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
-				 MGMT_STATUS_BUSY);
-		goto unlock;
-	}
-
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LE, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto unlock;
 	}
 
+	/* If we're doing a mode change from central to peripheral or to
+	 * any mode from peripheral start by sending the set_adv_enable
+	 * command.
+	 */
+	if ((old_mode != MGMT_LE_OFF && new_mode == MGMT_LE_PERIPHERAL) ||
+	    old_mode == MGMT_LE_PERIPHERAL) {
+		u8 adv_enable = (new_mode == MGMT_LE_PERIPHERAL);
+
+		err = hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+				   sizeof(adv_enable), &adv_enable);
+		if (err < 0)
+			mgmt_pending_remove(cmd);
+
+		goto unlock;
+	}
+
 	memset(&hci_cp, 0, sizeof(hci_cp));
 
-	if (val) {
-		hci_cp.le = val;
+	if (new_mode != MGMT_LE_OFF) {
+		hci_cp.le = 1;
 		hci_cp.simul = !!lmp_le_br_capable(hdev);
 	}
 
-	err = hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
-			   &hci_cp);
+	err = hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED,
+			   sizeof(hci_cp), &hci_cp);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -3569,7 +3628,8 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 
 int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 {
-	struct cmd_lookup match = { NULL, hdev };
+	struct pending_cmd *cmd;
+	struct mgmt_mode *cp;
 	bool changed = false;
 	int err = 0;
 
@@ -3594,17 +3654,67 @@ int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 			changed = true;
 	}
 
-	mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, settings_rsp, &match);
+	cmd = mgmt_pending_find(MGMT_OP_SET_LE, hdev);
+	if (!cmd)
+		goto done;
+
+	cp = cmd->param;
+	if (enable && cp->val == MGMT_LE_PERIPHERAL)
+		return hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+				    sizeof(enable), &enable);
+
+	send_settings_rsp(cmd->sk, cmd->opcode, hdev);
+	list_del(&cmd->list);
 
+done:
 	if (changed)
-		err = new_settings(hdev, match.sk);
+		err = new_settings(hdev, cmd ? cmd->sk : NULL);
 
-	if (match.sk)
-		sock_put(match.sk);
+	if (cmd)
+		mgmt_pending_free(cmd);
 
 	return err;
 }
 
+int mgmt_le_adv_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
+{
+	struct pending_cmd *cmd;
+	struct mgmt_mode *cp;
+
+	if (status) {
+		u8 mgmt_err = mgmt_status(status);
+
+		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, cmd_status_rsp,
+				     &mgmt_err);
+
+		return 0;
+	}
+
+	cmd = mgmt_pending_find(MGMT_OP_SET_LE, hdev);
+	if (!cmd) {
+		new_settings(hdev, NULL);
+		return 0;
+	}
+
+	cp = cmd->param;
+	if (!enable && cp->val == MGMT_LE_OFF) {
+		struct hci_cp_write_le_host_supported hci_cp;
+
+		memset(&hci_cp, 0, sizeof(hci_cp));
+
+		return hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED,
+				    sizeof(hci_cp), &hci_cp);
+	}
+
+	new_settings(hdev, cmd->sk);
+	send_settings_rsp(cmd->sk, cmd->opcode, hdev);
+
+	list_del(&cmd->list);
+	mgmt_pending_free(cmd);
+
+	return 0;
+}
+
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name, u8
 		      ssp, u8 *eir, u16 eir_len)
-- 
1.7.10.4


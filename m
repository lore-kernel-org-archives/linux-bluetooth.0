Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for Set External Configuration management command
Date: Fri,  4 Jul 2014 18:11:55 +0200
Message-Id: <1404490315-30656-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Set External Configuration management command allows for switching
between configured and unconfigured start if HCI_QURIK_EXTERNAL_CONFIG
is set by the transport driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h  |  1 +
 include/net/bluetooth/mgmt.h |  6 ++++
 net/bluetooth/mgmt.c         | 77 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4f1c4c7e2f00..80c5fc947fbc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -173,6 +173,7 @@ enum {
 	HCI_UNREGISTER,
 	HCI_UNCONFIGURED,
 	HCI_USER_CHANNEL,
+	HCI_EXT_CONFIGURED,
 
 	HCI_LE_SCAN,
 	HCI_SSP_ENABLED,
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 3984678ffab1..c7d537f1bd19 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -483,6 +483,12 @@ struct mgmt_rp_read_config_info {
 	__le32	missing_options;
 } __packed;
 
+#define MGMT_OP_SET_EXTERNAL_CONFIG	0x0038
+struct mgmt_cp_set_external_config {
+	__u8 config;
+} __packed;
+#define MGMT_SET_EXTERNAL_CONFIG_SIZE	1
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d2d0e051e4f2..91bccef63f30 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -91,6 +91,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_LOAD_CONN_PARAM,
 	MGMT_OP_READ_UNCONF_INDEX_LIST,
 	MGMT_OP_READ_CONFIG_INFO,
+	MGMT_OP_SET_EXTERNAL_CONFIG,
 };
 
 static const u16 mgmt_events[] = {
@@ -441,11 +442,25 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static bool is_configured(struct hci_dev *hdev)
+{
+	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) &&
+	    !test_bit(HCI_EXT_CONFIGURED, &hdev->dev_flags))
+		return false;
+
+	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
+	    !bacmp(&hdev->public_addr, BDADDR_ANY))
+		return false;
+
+	return true;
+}
+
 static __le32 get_missing_options(struct hci_dev *hdev)
 {
 	u32 options = 0;
 
-	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks))
+	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) &&
+	    !test_bit(HCI_EXT_CONFIGURED, &hdev->dev_flags))
 		options |= MGMT_OPTION_EXTERNAL_CONFIG;
 
 	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
@@ -455,6 +470,14 @@ static __le32 get_missing_options(struct hci_dev *hdev)
 	return cpu_to_le32(options);
 }
 
+static int send_options_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
+{
+	__le32 options = get_missing_options(hdev);
+
+	return cmd_complete(sk, hdev->id, opcode, 0, &options,
+			    sizeof(options));
+}
+
 static int read_config_info(struct sock *sk, struct hci_dev *hdev,
 			    void *data, u16 data_len)
 {
@@ -5355,6 +5378,54 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 	return cmd_complete(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM, 0, NULL, 0);
 }
 
+static int set_external_config(struct sock *sk, struct hci_dev *hdev,
+			       void *data, u16 len)
+{
+	struct mgmt_cp_set_external_config *cp = data;
+	bool changed;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	if (hdev_is_powered(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_EXTERNAL_CONFIG,
+				  MGMT_STATUS_REJECTED);
+
+	if (cp->config != 0x00 && cp->config != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_EXTERNAL_CONFIG,
+				    MGMT_STATUS_INVALID_PARAMS);
+
+	if (!test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_EXTERNAL_CONFIG,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	hci_dev_lock(hdev);
+
+	if (cp->config)
+		changed = !test_and_set_bit(HCI_EXT_CONFIGURED,
+					    &hdev->dev_flags);
+	else
+		changed = test_and_clear_bit(HCI_EXT_CONFIGURED,
+					     &hdev->dev_flags);
+
+	err = send_options_rsp(sk, MGMT_OP_SET_EXTERNAL_CONFIG, hdev);
+	if (err < 0)
+		goto unlock;
+
+	if (!changed)
+		goto unlock;
+
+	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) == is_configured(hdev)) {
+		mgmt_index_removed(hdev);
+		change_bit(HCI_UNCONFIGURED, &hdev->dev_flags);
+		mgmt_index_added(hdev);
+	}
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -5417,6 +5488,7 @@ static const struct mgmt_handler {
 	{ load_conn_param,        true,  MGMT_LOAD_CONN_PARAM_SIZE },
 	{ read_unconf_index_list, false, MGMT_READ_UNCONF_INDEX_LIST_SIZE },
 	{ read_config_info,       false, MGMT_READ_CONFIG_INFO_SIZE },
+	{ set_external_config,    false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
 };
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
@@ -5469,7 +5541,8 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		}
 
 		if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
-		    opcode != MGMT_OP_READ_CONFIG_INFO) {
+		    opcode != MGMT_OP_READ_CONFIG_INFO &&
+		    opcode != MGMT_OP_SET_EXTERNAL_CONFIG) {
 			err = cmd_status(sk, index, opcode,
 					 MGMT_STATUS_INVALID_INDEX);
 			goto done;
-- 
1.9.3


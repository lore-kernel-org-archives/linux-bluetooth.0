Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for controller configuration info command
Date: Fri,  4 Jul 2014 00:46:56 +0200
Message-Id: <1404427616-34654-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Read Controller Configuration Information command allows retrieving
details about possible configurations option. The supported options are
returned and also the missing options (if any).

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h | 11 +++++++++++
 net/bluetooth/mgmt.c         | 28 ++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index e0786cfa5490..0579eb3952e3 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -97,6 +97,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_SECURE_CONN	0x00000800
 #define MGMT_SETTING_DEBUG_KEYS		0x00001000
 #define MGMT_SETTING_PRIVACY		0x00002000
+#define MGMT_SETTING_CONFIGURATION	0x00004000
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -471,6 +472,16 @@ struct mgmt_rp_read_unconf_index_list {
 	__le16	index[0];
 } __packed;
 
+#define MGMT_OPTION_PUBLIC_ADDRESS	0x00000001
+
+#define MGMT_OP_READ_CONFIG_INFO	0x0037
+#define MGMT_READ_CONFIG_INFO_SIZE	0
+struct mgmt_rp_read_config_info {
+	__le16	manufacturer;
+	__le32	supported_options;
+	__le32	missing_options;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 59ca4057955c..474b6dcdf665 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -90,6 +90,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_REMOVE_DEVICE,
 	MGMT_OP_LOAD_CONN_PARAM,
 	MGMT_OP_READ_UNCONF_INDEX_LIST,
+	MGMT_OP_READ_CONFIG_INFO,
 };
 
 static const u16 mgmt_events[] = {
@@ -440,6 +441,29 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int read_config_info(struct sock *sk, struct hci_dev *hdev,
+			    void *data, u16 data_len)
+{
+	struct mgmt_rp_read_config_info rp;
+
+	BT_DBG("sock %p %s", sk, hdev->name);
+
+	hci_dev_lock(hdev);
+
+	memset(&rp, 0, sizeof(rp));
+	rp.manufacturer = cpu_to_le16(hdev->manufacturer);
+	if (hdev->set_bdaddr)
+		rp.supported_options = cpu_to_le32(MGMT_OPTION_PUBLIC_ADDRESS);
+	else
+		rp.supported_options = cpu_to_le32(0);
+	rp.missing_options = cpu_to_le32(0);
+
+	hci_dev_unlock(hdev);
+
+	return cmd_complete(sk, hdev->id, MGMT_OP_READ_CONFIG_INFO, 0, &rp,
+			    sizeof(rp));
+}
+
 static u32 get_supported_settings(struct hci_dev *hdev)
 {
 	u32 settings = 0;
@@ -472,6 +496,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 		settings |= MGMT_SETTING_PRIVACY;
 	}
 
+	if (hdev->set_bdaddr)
+		settings |= MGMT_SETTING_CONFIGURATION;
+
 	return settings;
 }
 
@@ -5371,6 +5398,7 @@ static const struct mgmt_handler {
 	{ remove_device,          false, MGMT_REMOVE_DEVICE_SIZE },
 	{ load_conn_param,        true,  MGMT_LOAD_CONN_PARAM_SIZE },
 	{ read_unconf_index_list, false, MGMT_READ_UNCONF_INDEX_LIST_SIZE },
+	{ read_config_info,       false, MGMT_READ_CONFIG_INFO_SIZE },
 };
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
-- 
1.9.3


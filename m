Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 1/6] Bluetooth: Add definitions for Add/Remove Advertising mgmt commands
Date: Thu, 19 Mar 2015 17:04:32 -0700
Message-Id: <1426809877-22469-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1426809877-22469-1-git-send-email-armansito@chromium.org>
References: <1426809877-22469-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds definitions for the Add Advertising and Remove
Advertising MGMT commands with stubs that initially return
"Not Supported" as command status.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 include/net/bluetooth/mgmt.h | 24 ++++++++++++++++++++++++
 net/bluetooth/mgmt.c         | 25 +++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index a1a6867..c60a408 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -539,6 +539,30 @@ struct mgmt_rp_read_adv_features {
 	__u8   instance[0];
 } __packed;
 
+#define MGMT_OP_ADD_ADVERTISING		0x003E
+struct mgmt_cp_add_advertising {
+	__u8	instance;
+	__le32	flags;
+	__le16	duration;
+	__le16	timeout;
+	__u8	adv_data_len;
+	__u8	scan_rsp_len;
+	__u8	data[0];
+} __packed;
+#define MGMT_ADD_ADVERTISING_SIZE	11
+struct mgmt_rp_add_advertising {
+	__u8	instance;
+} __packed;
+
+#define MGMT_OP_REMOVE_ADVERTISING	0x003F
+struct mgmt_cp_remove_advertising {
+	__u8	instance;
+} __packed;
+#define MGMT_REMOVE_ADVERTISING_SIZE	1
+struct mgmt_rp_remove_advertising {
+	__u8	instance;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f3a9579..467cac9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -100,6 +100,8 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
 	MGMT_OP_READ_EXT_INDEX_LIST,
 	MGMT_OP_READ_ADV_FEATURES,
+	MGMT_OP_ADD_ADVERTISING,
+	MGMT_OP_REMOVE_ADVERTISING,
 };
 
 static const u16 mgmt_events[] = {
@@ -6315,6 +6317,26 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int add_advertising(struct sock *sk, struct hci_dev *hdev,
+			   void *data, u16 data_len)
+{
+	BT_DBG("%s", hdev->name);
+
+	/* TODO: Implement this command. */
+	return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
+			       MGMT_STATUS_NOT_SUPPORTED);
+}
+
+static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
+			      void *data, u16 data_len)
+{
+	BT_DBG("%s", hdev->name);
+
+	/* TODO: Implement this command. */
+	return mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADVERTISING,
+			       MGMT_STATUS_NOT_SUPPORTED);
+}
+
 static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ NULL }, /* 0x0000 (no command) */
 	{ read_version,            MGMT_READ_VERSION_SIZE,
@@ -6399,6 +6421,9 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 						HCI_MGMT_NO_HDEV |
 						HCI_MGMT_UNTRUSTED },
 	{ read_adv_features,       MGMT_READ_ADV_FEATURES_SIZE },
+	{ add_advertising,         MGMT_ADD_ADVERTISING_SIZE,
+						HCI_MGMT_VAR_LEN },
+	{ remove_advertising,      MGMT_REMOVE_ADVERTISING_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.2.0.rc0.207.ga3a616c


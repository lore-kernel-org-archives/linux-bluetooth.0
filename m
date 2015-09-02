Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v3 3/8] emulator: add BT_HCI_CMD_LE_CREATE_CONN_CANCEL handling
Date: Wed,  2 Sep 2015 10:51:10 -0700
Message-Id: <1441216275-2954-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1441216275-2954-1-git-send-email-jpawlowski@google.com>
References: <1441216275-2954-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling of BT_HCI_CMD_LE_CREATE_CONN_CANCEL command.

If btdev_set_le_noresp_conn_request is called on btdev, other devices that
try to connect to it will stuck on BT_HCI_CMD_LE_CREATE_CONN, by not
sending bt_hci_evt_le_conn_complete event back. Thanks to that,
BT_HCI_CMD_LE_CREATE_CONN_CANCEL can be triggered to cancel connect
attempt.
---
 emulator/btdev.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 emulator/btdev.h  |  2 ++
 emulator/hciemu.c |  8 ++++++++
 emulator/hciemu.h |  3 +++
 4 files changed, 58 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 60e8e8c..1645776 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -145,6 +145,11 @@ struct btdev {
 	uint16_t sync_train_interval;
 	uint32_t sync_train_timeout;
 	uint8_t  sync_train_service_data;
+
+	bool     le_noresp_conn_request;
+	bool     pending_le_conn;
+	uint8_t  pending_le_conn_addr[6];
+	uint8_t  pending_le_conn_addr_type;
 };
 
 struct inquiry_data {
@@ -674,6 +679,11 @@ bool btdev_is_le_scan_enabled(struct btdev *btdev)
 	return btdev->le_scan_enable;
 }
 
+void btdev_set_le_noresp_conn_request(struct btdev *btdev, bool value)
+{
+	btdev->le_noresp_conn_request = value;
+}
+
 static bool use_ssp(struct btdev *btdev1, struct btdev *btdev2)
 {
 	if (btdev1->auth_enable || btdev2->auth_enable)
@@ -1134,6 +1144,9 @@ static void le_conn_complete(struct btdev *btdev,
 		cc->handle = cpu_to_le16(42);
 	}
 
+	if (btdev->pending_le_conn)
+		btdev->pending_le_conn = false;
+
 	cc->status = status;
 	cc->peer_addr_type = bdaddr_type;
 	memcpy(cc->peer_addr, bdaddr, 6);
@@ -1183,6 +1196,13 @@ static void le_conn_request(struct btdev *btdev, const uint8_t *bdaddr,
 {
 	struct btdev *remote = find_btdev_by_bdaddr_type(bdaddr, bdaddr_type);
 
+	if (remote && remote->le_noresp_conn_request) {
+		btdev->pending_le_conn = true;
+		memcpy(btdev->pending_le_conn_addr, bdaddr, 6);
+		btdev->pending_le_conn_addr_type = bdaddr_type;
+		return;
+	}
+
 	if (remote && adv_connectable(remote) && adv_match(btdev, remote) &&
 					remote->le_adv_own_addr == bdaddr_type)
 		le_conn_complete(btdev, bdaddr, bdaddr_type, 0);
@@ -1191,6 +1211,14 @@ static void le_conn_request(struct btdev *btdev, const uint8_t *bdaddr,
 					BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
 }
 
+static void le_conn_cancel_request(struct btdev *btdev)
+{
+	if (btdev->pending_le_conn)
+		le_conn_complete(btdev, btdev->pending_le_conn_addr,
+					btdev->pending_le_conn_addr_type,
+					BT_HCI_ERR_UNKNOWN_CONN_ID);
+}
+
 static void conn_request(struct btdev *btdev, const uint8_t *bdaddr)
 {
 	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
@@ -2963,6 +2991,17 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
 		break;
 
+	case BT_HCI_CMD_LE_CREATE_CONN_CANCEL:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			goto unsupported;
+
+		if (btdev->pending_le_conn)
+			cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		else
+			cmd_status(btdev, BT_HCI_ERR_COMMAND_DISALLOWED,
+								opcode);
+		break;
+
 	case BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE:
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			goto unsupported;
@@ -3331,6 +3370,12 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 		le_conn_request(btdev, lecc->peer_addr, lecc->peer_addr_type);
 		break;
 
+	case BT_HCI_CMD_LE_CREATE_CONN_CANCEL:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			return;
+		le_conn_cancel_request(btdev);
+		break;
+
 	case BT_HCI_CMD_LE_CONN_UPDATE:
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			return;
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 8b116e4..e0e9f15 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -82,6 +82,8 @@ uint8_t *btdev_get_features(struct btdev *btdev);
 
 bool btdev_is_le_scan_enabled(struct btdev *btdev);
 
+void btdev_set_le_noresp_conn_request(struct btdev *btdev, bool value);
+
 void btdev_set_command_handler(struct btdev *btdev, btdev_command_func handler,
 							void *user_data);
 
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index c04aa6d..2e57b1f 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -435,6 +435,14 @@ const bool hciemu_is_master_le_scan_enabled(struct hciemu *hciemu)
 	return btdev_is_le_scan_enabled(hciemu->master_dev);
 }
 
+void hciemu_set_client_le_noresp_conn_request(struct hciemu *hciemu, bool value)
+{
+	if (!hciemu || !hciemu->client_dev)
+		return;
+
+	btdev_set_le_noresp_conn_request(hciemu->client_dev, value);
+}
+
 bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
 			hciemu_command_func_t function, void *user_data)
 {
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index a526d8c..3c2d098 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -55,6 +55,9 @@ const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu);
 
 const bool hciemu_is_master_le_scan_enabled(struct hciemu *hciemu);
 
+void hciemu_set_client_le_noresp_conn_request(struct hciemu *hciemu,
+								bool value);
+
 typedef void (*hciemu_command_func_t)(uint16_t opcode, const void *data,
 						uint8_t len, void *user_data);
 
-- 
2.1.4


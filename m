Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] android/handsfree: Add initial support for configure WBS commmand
Date: Wed, 17 Dec 2014 15:53:31 +0100
Message-Id: <1418828013-12385-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds required IPC message and handler for configure WBS command.
---
 android/hal-handsfree.c | 17 ++++++++++++++---
 android/hal-ipc-api.txt | 12 ++++++++++++
 android/hal-msg.h       | 10 ++++++++++
 android/handsfree.c     | 21 +++++++++++++++++++++
 4 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 2c638e6..279b26a 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -832,11 +832,22 @@ static void cleanup(void)
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 static bt_status_t configure_wbs(bt_bdaddr_t *bd_addr, bthf_wbs_config_t config)
 {
-	/* TODO: implement */
+	struct hal_cmd_handsfree_configure_wbs cmd;
 
-	DBG("");
+	DBG("%u", config);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+	cmd.config = config;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+					HAL_OP_HANDSFREE_CONFIGURE_WBS,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 #endif
 
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 01490fa..f15c12e 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -955,6 +955,18 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
+	Opcode 0x0f - Configure WBS command/response
+
+		Command parameters: Remote address (6 octets)
+		                    Config (1 octet)
+		Response parameters: <none>
+
+		Valid config values: 0x00 = None
+		                     0x01 = No
+		                     0x02 = Yes
+
+		In case of an error, the error response will be returned.
+
 Notifications:
 
 	Opcode 0x81 - Connection State notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 88b0c52..ecc1150 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -624,6 +624,16 @@ struct hal_cmd_handsfree_phone_state_change {
 	uint8_t number[0];
 } __attribute__((packed));
 
+#define HAL_HANDSFREE_WBS_NONE			0x00
+#define HAL_HANDSFREE_WBS_NO			0x01
+#define HAL_HANDSFREE_WBS_YES			0x02
+
+#define HAL_OP_HANDSFREE_CONFIGURE_WBS		0x0F
+struct hal_cmd_handsfree_configure_wbs {
+	uint8_t bdaddr[6];
+	uint8_t config;
+} __attribute__((packed));
+
 /* AVRCP TARGET HAL API */
 
 #define HAL_AVRCP_PLAY_STATUS_STOPPED	0x00
diff --git a/android/handsfree.c b/android/handsfree.c
index 7fbe64b..da89623 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2496,6 +2496,24 @@ failed:
 				HAL_OP_HANDSFREE_PHONE_STATE_CHANGE, status);
 }
 
+static void handle_configure_wbs(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_handsfree_configure_wbs *cmd = buf;
+	uint8_t status;
+
+	switch (cmd->config) {
+	case HAL_HANDSFREE_WBS_NONE:
+	case HAL_HANDSFREE_WBS_NO:
+	case HAL_HANDSFREE_WBS_YES:
+	default:
+		status = HAL_STATUS_FAILED;
+		break;
+	}
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+					HAL_OP_HANDSFREE_CONFIGURE_WBS, status);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HANDSFREE_CONNECT */
 	{ handle_connect, false,
@@ -2537,6 +2555,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HANDSFREE_PHONE_STATE_CHANGE */
 	{ handle_phone_state_change, true,
 		sizeof(struct hal_cmd_handsfree_phone_state_change) },
+	/* HAL_OP_HANDSFREE_CONFIGURE_WBS */
+	{ handle_configure_wbs, false,
+		sizeof(struct hal_cmd_handsfree_configure_wbs) },
 };
 
 static sdp_record_t *headset_ag_record(void)
-- 
1.9.1


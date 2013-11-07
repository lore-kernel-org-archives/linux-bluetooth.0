Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] android: Rename a2dp HAL related IPC API to match service name
Date: Thu, 7 Nov 2013 11:27:35 +0100
Message-ID: <1383820057-15728-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use 'Android HAL name' string from IPC doc as base for names.
---
 android/a2dp.c    | 10 ++++++----
 android/hal-av.c  | 16 ++++++++--------
 android/hal-msg.h | 18 ++++++++++--------
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 28ab4b1..88f49ea 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -40,14 +40,16 @@
 
 static GIOChannel *notification_io = NULL;
 
-static uint8_t bt_a2dp_connect(struct hal_cmd_av_connect *cmd, uint16_t len)
+static uint8_t bt_a2dp_connect(struct hal_cmd_a2dp_connect *cmd,
+								uint16_t len)
 {
 	DBG("Not Implemented");
 
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t bt_a2dp_disconnect(struct hal_cmd_av_connect *cmd, uint16_t len)
+static uint8_t bt_a2dp_disconnect(struct hal_cmd_a2dp_connect *cmd,
+								uint16_t len)
 {
 	DBG("Not Implemented");
 
@@ -60,10 +62,10 @@ void bt_a2dp_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 	uint8_t status = HAL_STATUS_FAILED;
 
 	switch (opcode) {
-	case HAL_OP_AV_CONNECT:
+	case HAL_OP_A2DP_CONNECT:
 		status = bt_a2dp_connect(buf, len);
 		break;
-	case HAL_OP_AV_DISCONNECT:
+	case HAL_OP_A2DP_DISCONNECT:
 		status = bt_a2dp_disconnect(buf, len);
 		break;
 	default:
diff --git a/android/hal-av.c b/android/hal-av.c
index 9e1b3df..2ebf801 100644
--- a/android/hal-av.c
+++ b/android/hal-av.c
@@ -33,7 +33,7 @@ static bool interface_ready(void)
 
 static void handle_connection_state(void *buf)
 {
-	struct hal_ev_av_connection_state *ev = buf;
+	struct hal_ev_a2dp_connection_state *ev = buf;
 
 	if (cbs->connection_state_cb)
 		cbs->connection_state_cb(ev->state,
@@ -42,7 +42,7 @@ static void handle_connection_state(void *buf)
 
 static void handle_audio_state(void *buf)
 {
-	struct hal_ev_av_audio_state *ev = buf;
+	struct hal_ev_a2dp_audio_state *ev = buf;
 
 	if (cbs->audio_state_cb)
 		cbs->audio_state_cb(ev->state, (bt_bdaddr_t *)(ev->bdaddr));
@@ -55,10 +55,10 @@ void bt_notify_av(uint16_t opcode, void *buf, uint16_t len)
 		return;
 
 	switch (opcode) {
-	case HAL_EV_AV_CONNECTION_STATE:
+	case HAL_EV_A2DP_CONNECTION_STATE:
 		handle_connection_state(buf);
 		break;
-	case HAL_EV_AV_AUDIO_STATE:
+	case HAL_EV_A2DP_AUDIO_STATE:
 		handle_audio_state(buf);
 		break;
 	default:
@@ -69,7 +69,7 @@ void bt_notify_av(uint16_t opcode, void *buf, uint16_t len)
 
 static bt_status_t av_connect(bt_bdaddr_t *bd_addr)
 {
-	struct hal_cmd_av_connect cmd;
+	struct hal_cmd_a2dp_connect cmd;
 
 	DBG("");
 
@@ -78,13 +78,13 @@ static bt_status_t av_connect(bt_bdaddr_t *bd_addr)
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_A2DP, HAL_OP_AV_CONNECT,
+	return hal_ipc_cmd(HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_CONNECT,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t av_disconnect(bt_bdaddr_t *bd_addr)
 {
-	struct hal_cmd_av_disconnect cmd;
+	struct hal_cmd_a2dp_disconnect cmd;
 
 	DBG("");
 
@@ -93,7 +93,7 @@ static bt_status_t av_disconnect(bt_bdaddr_t *bd_addr)
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_A2DP, HAL_OP_AV_DISCONNECT,
+	return hal_ipc_cmd(HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_DISCONNECT,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index a5e5c76..c52e495 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -301,13 +301,15 @@ struct hal_cmd_hid_send_data {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
-#define HAL_OP_AV_CONNECT	0x01
-struct hal_cmd_av_connect {
+/* a2dp HAL API*/
+
+#define HAL_OP_A2DP_CONNECT	0x01
+struct hal_cmd_a2dp_connect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
-#define HAL_OP_AV_DISCONNECT	0x02
-struct hal_cmd_av_disconnect {
+#define HAL_OP_A2DP_DISCONNECT	0x02
+struct hal_cmd_a2dp_disconnect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
@@ -475,14 +477,14 @@ struct hal_ev_hid_get_report {
 	uint8_t  data[0];
 } __attribute__((packed));
 
-#define HAL_EV_AV_CONNECTION_STATE	0x81
-struct hal_ev_av_connection_state {
+#define HAL_EV_A2DP_CONNECTION_STATE	0x81
+struct hal_ev_a2dp_connection_state {
 	uint8_t state;
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
-#define HAL_EV_AV_AUDIO_STATE	0x82
-struct hal_ev_av_audio_state {
+#define HAL_EV_A2DP_AUDIO_STATE	0x82
+struct hal_ev_a2dp_audio_state {
 	uint8_t state;
 	uint8_t bdaddr[6];
 } __attribute__((packed));
-- 
1.8.4.2


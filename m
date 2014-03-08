Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/20] android/handsfree: Add support for unknown AT commands
Date: Sat,  8 Mar 2014 01:19:47 +0100
Message-Id: <1394238004-15691-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those commands are passed to Framework without parsing.
---
 android/handsfree.c | 64 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 10 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index c49a35b..e104c4a 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -161,19 +161,35 @@ static void device_cleanup(void)
 	memset(&device, 0, sizeof(device));
 }
 
-static void at_command_handler(const char *command, void *user_data)
+static void disconnect_watch(void *user_data)
 {
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	DBG("");
 
-	if (device.state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED)
-		hfp_gw_disconnect(device.gw);
+	device_cleanup();
 }
 
-static void disconnect_watch(void *user_data)
+static void at_cmd_unknown(const char *command, void *user_data)
 {
-	DBG("");
+	uint8_t buf[IPC_MTU];
+	struct hal_ev_handsfree_unknown_at *ev = (void *) buf;
 
-	device_cleanup();
+	if (device.state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED) {
+		hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+		hfp_gw_disconnect(device.gw);
+		return;
+	}
+
+	/* copy while string including terminating NULL */
+	ev->len = strlen(command) + 1;
+	memcpy(ev->buf, command, ev->len);
+
+	if (ev->len > IPC_MTU - sizeof(*ev)) {
+		hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+		return;
+	}
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+			HAL_EV_HANDSFREE_UNKNOWN_AT, sizeof(*ev) + ev->len, ev);
 }
 
 static void at_cmd_vgs_vgm(struct hfp_gw_result *result,
@@ -674,7 +690,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	g_io_channel_set_close_on_unref(chan, FALSE);
 
 	hfp_gw_set_close_on_unref(device.gw, true);
-	hfp_gw_set_command_handler(device.gw, at_command_handler, NULL, NULL);
+	hfp_gw_set_command_handler(device.gw, at_cmd_unknown, NULL, NULL);
 	hfp_gw_set_disconnect_handler(device.gw, disconnect_watch, NULL, NULL);
 
 
@@ -1147,19 +1163,47 @@ static void handle_cind(const void *buf, uint16_t len)
 
 static void handle_formatted_at_resp(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_handsfree_formatted_at_response *cmd = buf;
+	char *at;
+
 	DBG("");
 
+	if (len != sizeof(*cmd) + cmd->len) {
+		error("Invalid formatted AT response command, terminating");
+		raise(SIGTERM);
+		return;
+	}
+
+	DBG("");
+
+	at = g_malloc0(cmd->len + 1);
+
+	memcpy(at, cmd->buf, cmd->len);
+
+	hfp_gw_send_info(device.gw, "%s", at);
+
+	g_free(at);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE,
-					HAL_STATUS_FAILED);
+					HAL_STATUS_SUCCESS);
 }
 
 static void handle_at_resp(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_handsfree_at_response *cmd = buf;
+
 	DBG("");
 
+	/* TODO handle +CME ERROR when AT+CMEE support is added */
+
+	if (cmd->response == HAL_HANDSFREE_AT_RESPONSE_OK)
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+	else
+		hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-			HAL_OP_HANDSFREE_AT_RESPONSE, HAL_STATUS_FAILED);
+			HAL_OP_HANDSFREE_AT_RESPONSE, HAL_STATUS_SUCCESS);
 }
 
 static void handle_clcc_resp(const void *buf, uint16_t len)
-- 
1.8.5.3


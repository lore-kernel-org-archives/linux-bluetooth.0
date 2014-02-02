Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/13] android/hal-handsfree: Implement sending commands
Date: Sun,  2 Feb 2014 22:09:16 +0100
Message-Id: <1391375364-27106-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
References: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This implements HAL interface methods and pass commands over IPC.
---
 android/hal-handsfree.c | 344 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 344 insertions(+)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 6e11367..601c14f 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -223,6 +223,336 @@ static bt_status_t init(bthf_callbacks_t *callbacks)
 	return ret;
 }
 
+static bt_status_t handsfree_connect(bt_bdaddr_t *bd_addr)
+{
+	struct hal_cmd_handsfree_connect cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_CONNECT,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+}
+
+static bt_status_t disconnect(bt_bdaddr_t *bd_addr)
+{
+	struct hal_cmd_handsfree_disconnect cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+				HAL_OP_HANDSFREE_DISCONNECT, sizeof(cmd), &cmd,
+				0, NULL, NULL);
+}
+
+static bt_status_t connect_audio(bt_bdaddr_t *bd_addr)
+{
+	struct hal_cmd_handsfree_connect_audio cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+				HAL_OP_HANDSFREE_CONNECT_AUDIO, sizeof(cmd),
+				&cmd, 0, NULL, NULL);
+}
+
+static bt_status_t disconnect_audio(bt_bdaddr_t *bd_addr)
+{
+	struct hal_cmd_handsfree_disconnect_audio cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+				HAL_OP_HANDSFREE_DISCONNECT_AUDIO, sizeof(cmd),
+				&cmd, 0, NULL, NULL);
+}
+
+static bt_status_t start_voice_recognition(void)
+{
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_START_VR,
+							0, NULL, 0, NULL, NULL);
+}
+
+static bt_status_t stop_voice_recognition(void)
+{
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_STOP_VR,
+							0, NULL, 0, NULL, NULL);
+}
+
+static bt_status_t volume_control(bthf_volume_type_t type, int volume)
+{
+	struct hal_cmd_handsfree_volume_control cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd.type = type;
+	cmd.volume = volume;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+				HAL_OP_HANDSFREE_VOLUME_CONTROL, sizeof(cmd),
+				&cmd, 0, NULL, NULL);
+}
+
+static bt_status_t device_status_notification(bthf_network_state_t state,
+						bthf_service_type_t type,
+						int signal, int battery)
+{
+	struct hal_cmd_handsfree_device_status_notif cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd.state = state;
+	cmd.type = type;
+	cmd.signal = signal;
+	cmd.battery = battery;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+					HAL_OP_HANDSFREE_DEVICE_STATUS_NOTIF,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+}
+
+static bt_status_t cops_response(const char *cops)
+{
+	struct hal_cmd_handsfree_cops_response *cmd;
+	bt_status_t status;
+	int len;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!cops)
+		return BT_STATUS_PARM_INVALID;
+
+	len = sizeof(*cmd) + strlen(cops);
+
+	cmd = malloc(len);
+	if (!cmd)
+		return BT_STATUS_NOMEM;
+
+	cmd->len = strlen(cops);
+	memcpy(cmd->buf, cops, cmd->len);
+
+	status = hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+				HAL_OP_HANDSFREE_COPS_RESPONSE, len, cmd, 0,
+				NULL, NULL);
+
+	free(cmd);
+
+	return status;
+}
+
+static bt_status_t cind_response(int svc, int num_active, int num_held,
+					bthf_call_state_t state, int signal,
+					int roam, int batt_chg)
+{
+	struct hal_cmd_handsfree_cind_response cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd.svc = svc;
+	cmd.num_active = num_active;
+	cmd.num_held = num_held;
+	cmd.state = state;
+	cmd.signal = signal;
+	cmd.roam = roam;
+	cmd.batt_chg = batt_chg;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+					HAL_OP_HANDSFREE_CIND_RESPONSE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+}
+
+static bt_status_t formatted_at_response(const char *rsp)
+{
+	struct hal_cmd_handsfree_formatted_at_response *cmd;
+	bt_status_t status;
+	int len;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!rsp)
+		return BT_STATUS_PARM_INVALID;
+
+	len = sizeof(*cmd) + strlen(rsp);
+
+	cmd = malloc(len);
+	if (!cmd)
+		return BT_STATUS_NOMEM;
+
+	cmd->len = strlen(rsp);
+	memcpy(cmd->buf, rsp, cmd->len);
+
+	status = hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+				HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE, len,
+				cmd, 0, NULL, NULL);
+
+	free(cmd);
+
+	return status;
+}
+
+static bt_status_t at_response(bthf_at_response_t response, int error)
+{
+	struct hal_cmd_handsfree_at_response cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd.response = response;
+	cmd.error = error;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+					HAL_OP_HANDSFREE_AT_RESPONSE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+}
+
+static bt_status_t clcc_response(int index, bthf_call_direction_t dir,
+					bthf_call_state_t state,
+					bthf_call_mode_t mode,
+					bthf_call_mpty_type_t mpty,
+					const char *number,
+					bthf_call_addrtype_t type)
+{
+	struct hal_cmd_handsfree_clcc_response *cmd;
+	bt_status_t status;
+	int len;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	len = sizeof(*cmd);
+	if (number)
+		len += strlen(number);
+
+	cmd = malloc(len);
+	if (!cmd)
+		return BT_STATUS_NOMEM;
+
+	cmd->index = index;
+	cmd->dir = dir;
+	cmd->state = state;
+	cmd->mode = mode;
+	cmd->mpty = mpty;
+	cmd->type = type;
+
+	if (number) {
+		cmd->number_len = strlen(number);
+		memcpy(cmd->number, number, cmd->number_len);
+	} else {
+		cmd->number_len = 0;
+	}
+
+	status = hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+					HAL_OP_HANDSFREE_CLCC_RESPONSE, len,
+					cmd, 0, NULL, NULL);
+
+	free(cmd);
+
+	return status;
+}
+
+static bt_status_t phone_state_change(int num_active, int num_held,
+					bthf_call_state_t state,
+					const char *number,
+					bthf_call_addrtype_t type)
+{
+	struct hal_cmd_handsfree_phone_state_change *cmd;
+	bt_status_t status;
+	int len;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	len = sizeof(*cmd);
+	if (number)
+		len += strlen(number);
+
+	cmd = malloc(len);
+	if (!cmd)
+		return BT_STATUS_NOMEM;
+
+	cmd->num_active = num_active;
+	cmd->num_held = num_held;
+	cmd->state = state;
+	cmd->type = type;
+
+	if (number) {
+		cmd->number_len = strlen(number);
+		memcpy(cmd->number, number, cmd->number_len);
+	} else {
+		cmd->number_len = 0;
+	}
+
+	status = hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
+					HAL_OP_HANDSFREE_PHONE_STATE_CHANGE,
+					len, cmd, 0, NULL, NULL);
+
+	free(cmd);
+
+	return status;
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -245,6 +575,20 @@ static void cleanup(void)
 static bthf_interface_t iface = {
 	.size = sizeof(iface),
 	.init = init,
+	.connect = handsfree_connect,
+	.disconnect = disconnect,
+	.connect_audio = connect_audio,
+	.disconnect_audio = disconnect_audio,
+	.start_voice_recognition = start_voice_recognition,
+	.stop_voice_recognition = stop_voice_recognition,
+	.volume_control = volume_control,
+	.device_status_notification = device_status_notification,
+	.cops_response = cops_response,
+	.cind_response = cind_response,
+	.formatted_at_response = formatted_at_response,
+	.at_response = at_response,
+	.clcc_response = clcc_response,
+	.phone_state_change = phone_state_change,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3


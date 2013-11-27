Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/13] android/hidhost: Use generic IPC message handling for commands
Date: Wed, 27 Nov 2013 12:54:59 +0100
Message-Id: <1385553305-5807-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
References: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handlers are registered on service register and unregistered on
unregister.
---
 android/hidhost.c | 317 +++++++++++++++++++++++++++++++++---------------------
 android/hidhost.h |   2 -
 2 files changed, 193 insertions(+), 126 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index d97af03..5b98152 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -723,9 +723,10 @@ fail:
 	hid_device_free(dev);
 }
 
-static uint8_t bt_hid_connect(struct hal_cmd_hidhost_connect *cmd,
-								uint16_t len)
+static void bt_hid_connect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_connect *cmd = buf;
+	uint8_t status = HAL_STATUS_SUCCESS;
 	struct hid_device *dev;
 	char addr[18];
 	bdaddr_t dst;
@@ -734,14 +735,13 @@ static uint8_t bt_hid_connect(struct hal_cmd_hidhost_connect *cmd,
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
-
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
-	if (l)
-		return HAL_STATUS_FAILED;
+	if (l) {
+		status = HAL_STATUS_FAILED;
+		goto fail;
+	}
 
 	dev = g_new0(struct hid_device, 1);
 	bacpy(&dev->dst, &dst);
@@ -755,32 +755,35 @@ static uint8_t bt_hid_connect(struct hal_cmd_hidhost_connect *cmd,
 					hid_sdp_search_cb, dev, NULL) < 0) {
 		error("Failed to search sdp details");
 		hid_device_free(dev);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto fail;
 	}
 
 	devices = g_slist_append(devices, dev);
 	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTING);
 
-	return HAL_STATUS_SUCCESS;
+fail:
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_HIDHOST,
+					HAL_OP_HIDHOST_CONNECT, status);
 }
 
-static uint8_t bt_hid_disconnect(struct hal_cmd_hidhost_disconnect *cmd,
-								uint16_t len)
+static void bt_hid_disconnect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_disconnect *cmd = buf;
+	uint8_t status = HAL_STATUS_SUCCESS;
 	struct hid_device *dev;
 	GSList *l;
 	bdaddr_t dst;
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
-
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
-	if (!l)
-		return HAL_STATUS_FAILED;
+	if (!l) {
+		status = HAL_STATUS_FAILED;
+		goto fail;
+	}
 
 	dev = l->data;
 
@@ -793,12 +796,15 @@ static uint8_t bt_hid_disconnect(struct hal_cmd_hidhost_disconnect *cmd,
 
 	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTING);
 
-	return HAL_STATUS_SUCCESS;
+fail:
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_HIDHOST,
+					HAL_OP_HIDHOST_DISCONNECT, status);
 }
 
-static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hidhost_virtual_unplug *cmd,
-								uint16_t len)
+static void bt_hid_virtual_unplug(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_virtual_unplug *cmd = buf;
+	uint8_t status = HAL_STATUS_FAILED;
 	struct hid_device *dev;
 	GSList *l;
 	bdaddr_t dst;
@@ -807,19 +813,16 @@ static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hidhost_virtual_unplug *cmd,
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
-
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
 	if (!l)
-		return HAL_STATUS_FAILED;
+		goto fail;
 
 	dev = l->data;
 
 	if (!(dev->ctrl_io))
-		return HAL_STATUS_FAILED;
+		goto fail;
 
 	hdr = HID_MSG_CONTROL | HID_VIRTUAL_CABLE_UNPLUG;
 
@@ -828,7 +831,7 @@ static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hidhost_virtual_unplug *cmd,
 	if (write(fd, &hdr, sizeof(hdr)) < 0) {
 		error("error writing virtual unplug command: %s (%d)",
 						strerror(errno), errno);
-		return HAL_STATUS_FAILED;
+		goto fail;
 	}
 
 	/* Wait either channels to HUP */
@@ -840,10 +843,14 @@ static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hidhost_virtual_unplug *cmd,
 
 	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTING);
 
-	return HAL_STATUS_SUCCESS;
+	status = HAL_STATUS_SUCCESS;
+
+fail:
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_HIDHOST,
+					HAL_OP_HIDHOST_VIRTUAL_UNPLUG, status);
 }
 
-static uint8_t bt_hid_info(struct hal_cmd_hidhost_set_info *cmd, uint16_t len)
+static void bt_hid_info(const void *buf, uint16_t len)
 {
 	/* Data from hal_cmd_hidhost_set_info is usefull only when we create
 	 * UHID device. Once device is created all the transactions will be
@@ -851,12 +858,14 @@ static uint8_t bt_hid_info(struct hal_cmd_hidhost_set_info *cmd, uint16_t len)
 	 * once device is created with HID internals. */
 	DBG("Not supported");
 
-	return HAL_STATUS_UNSUPPORTED;
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_HIDHOST,
+			HAL_OP_HIDHOST_SET_INFO, HAL_STATUS_UNSUPPORTED);
 }
 
-static uint8_t bt_hid_get_protocol(struct hal_cmd_hidhost_get_protocol *cmd,
-								uint16_t len)
+static void bt_hid_get_protocol(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_get_protocol *cmd = buf;
+	uint8_t status = HAL_STATUS_SUCCESS;
 	struct hid_device *dev;
 	GSList *l;
 	bdaddr_t dst;
@@ -865,19 +874,20 @@ static uint8_t bt_hid_get_protocol(struct hal_cmd_hidhost_get_protocol *cmd,
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
-
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
-	if (!l)
-		return HAL_STATUS_FAILED;
+	if (!l) {
+		status = HAL_STATUS_FAILED;
+		goto fail;
+	}
 
 	dev = l->data;
 
-	if (dev->boot_dev)
-		return HAL_STATUS_UNSUPPORTED;
+	if (dev->boot_dev) {
+		status = HAL_STATUS_UNSUPPORTED;
+		goto fail;
+	}
 
 	hdr = HID_MSG_GET_PROTOCOL | cmd->mode;
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
@@ -885,16 +895,21 @@ static uint8_t bt_hid_get_protocol(struct hal_cmd_hidhost_get_protocol *cmd,
 	if (write(fd, &hdr, sizeof(hdr)) < 0) {
 		error("error writing device_get_protocol: %s (%d)",
 						strerror(errno), errno);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto fail;
 	}
 
 	dev->last_hid_msg = HID_MSG_GET_PROTOCOL;
-	return HAL_STATUS_SUCCESS;
+
+fail:
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_HIDHOST,
+					HAL_OP_HIDHOST_GET_PROTOCOL, status);
 }
 
-static uint8_t bt_hid_set_protocol(struct hal_cmd_hidhost_set_protocol *cmd,
-								uint16_t len)
+static void bt_hid_set_protocol(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_set_protocol *cmd = buf;
+	uint8_t status = HAL_STATUS_SUCCESS;
 	struct hid_device *dev;
 	GSList *l;
 	bdaddr_t dst;
@@ -903,19 +918,20 @@ static uint8_t bt_hid_set_protocol(struct hal_cmd_hidhost_set_protocol *cmd,
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
-
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
-	if (!l)
-		return HAL_STATUS_FAILED;
+	if (!l) {
+		status = HAL_STATUS_FAILED;
+		goto fail;
+	}
 
 	dev = l->data;
 
-	if (dev->boot_dev)
-		return HAL_STATUS_UNSUPPORTED;
+	if (dev->boot_dev) {
+		status = HAL_STATUS_UNSUPPORTED;
+		goto fail;
+	}
 
 	hdr = HID_MSG_SET_PROTOCOL | cmd->mode;
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
@@ -923,16 +939,21 @@ static uint8_t bt_hid_set_protocol(struct hal_cmd_hidhost_set_protocol *cmd,
 	if (write(fd, &hdr, sizeof(hdr)) < 0) {
 		error("error writing device_set_protocol: %s (%d)",
 						strerror(errno), errno);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto fail;
 	}
 
 	dev->last_hid_msg = HID_MSG_SET_PROTOCOL;
-	return HAL_STATUS_SUCCESS;
+
+fail:
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_HIDHOST,
+					HAL_OP_HIDHOST_SET_PROTOCOL, status);
 }
 
-static uint8_t bt_hid_get_report(struct hal_cmd_hidhost_get_report *cmd,
-								uint16_t len)
+static void bt_hid_get_report(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_get_report *cmd = buf;
+	uint8_t status = HAL_STATUS_SUCCESS;
 	struct hid_device *dev;
 	GSList *l;
 	bdaddr_t dst;
@@ -942,20 +963,21 @@ static uint8_t bt_hid_get_report(struct hal_cmd_hidhost_get_report *cmd,
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
-
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
-	if (!l)
-		return HAL_STATUS_FAILED;
+	if (!l) {
+		status = HAL_STATUS_FAILED;
+		goto fail;
+	}
 
 	dev = l->data;
 	req_size = (cmd->buf_size > 0) ? 4 : 2;
 	req = g_try_malloc0(req_size);
-	if (!req)
-		return HAL_STATUS_NOMEM;
+	if (!req) {
+		status = HAL_STATUS_NOMEM;
+		goto fail;
+	}
 
 	req[0] = HID_MSG_GET_REPORT | cmd->type;
 	req[1] = cmd->id;
@@ -971,17 +993,22 @@ static uint8_t bt_hid_get_report(struct hal_cmd_hidhost_get_report *cmd,
 		error("error writing hid_get_report: %s (%d)",
 						strerror(errno), errno);
 		g_free(req);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto fail;
 	}
 
 	dev->last_hid_msg = HID_MSG_GET_REPORT;
 	g_free(req);
-	return HAL_STATUS_SUCCESS;
+
+fail:
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_HIDHOST,
+					HAL_OP_HIDHOST_GET_REPORT, status);
 }
 
-static uint8_t bt_hid_set_report(struct hal_cmd_hidhost_set_report *cmd,
-								uint16_t len)
+static void bt_hid_set_report(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_set_report *cmd = buf;
+	uint8_t status = HAL_STATUS_SUCCESS;
 	struct hid_device *dev;
 	GSList *l;
 	bdaddr_t dst;
@@ -991,24 +1018,34 @@ static uint8_t bt_hid_set_report(struct hal_cmd_hidhost_set_report *cmd,
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
+	if (len != sizeof(*cmd) + cmd->len) {
+		error("Invalid hid set report size (%u bytes), terminating",
+									len);
+		raise(SIGTERM);
+		return;
+	}
 
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
-	if (!l)
-		return HAL_STATUS_FAILED;
+	if (!l) {
+		status = HAL_STATUS_FAILED;
+		goto fail;
+	}
 
 	dev = l->data;
 
-	if (!(dev->ctrl_io))
-		return HAL_STATUS_FAILED;
+	if (!(dev->ctrl_io)) {
+		status = HAL_STATUS_FAILED;
+		goto fail;
+	}
 
 	req_size = 1 + (cmd->len / 2);
 	req = g_try_malloc0(req_size);
-	if (!req)
-		return HAL_STATUS_NOMEM;
+	if (!req) {
+		status = HAL_STATUS_NOMEM;
+		goto fail;
+	}
 
 	req[0] = HID_MSG_SET_REPORT | cmd->type;
 	/* Report data coming to HAL is in ascii format, HAL sends
@@ -1022,17 +1059,22 @@ static uint8_t bt_hid_set_report(struct hal_cmd_hidhost_set_report *cmd,
 		error("error writing hid_set_report: %s (%d)",
 						strerror(errno), errno);
 		g_free(req);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto fail;
 	}
 
 	dev->last_hid_msg = HID_MSG_SET_REPORT;
 	g_free(req);
-	return HAL_STATUS_SUCCESS;
+
+fail:
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_HIDHOST,
+					HAL_OP_HIDHOST_SET_REPORT, status);
 }
 
-static uint8_t bt_hid_send_data(struct hal_cmd_hidhost_send_data *cmd,
-								uint16_t len)
+static void bt_hid_send_data(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_send_data *cmd = buf;
+	uint8_t status = HAL_STATUS_SUCCESS;
 	struct hid_device *dev;
 	GSList *l;
 	bdaddr_t dst;
@@ -1042,24 +1084,34 @@ static uint8_t bt_hid_send_data(struct hal_cmd_hidhost_send_data *cmd,
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
+	if (len != sizeof(*cmd) + cmd->len) {
+		error("Invalid hid send data size (%u bytes), terminating",
+									len);
+		raise(SIGTERM);
+		return;
+	}
 
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
-	if (!l)
-		return HAL_STATUS_FAILED;
+	if (!l) {
+		status = HAL_STATUS_FAILED;
+		goto fail;
+	}
 
 	dev = l->data;
 
-	if (!(dev->intr_io))
-		return HAL_STATUS_FAILED;
+	if (!(dev->intr_io)) {
+		status = HAL_STATUS_FAILED;
+		goto fail;
+	}
 
 	req_size = 1 + (cmd->len / 2);
 	req = g_try_malloc0(req_size);
-	if (!req)
-		return HAL_STATUS_NOMEM;
+	if (!req) {
+		status = HAL_STATUS_NOMEM;
+		goto fail;
+	}
 
 	req[0] = HID_MSG_DATA | HID_DATA_TYPE_OUTPUT;
 	/* Report data coming to HAL is in ascii format, HAL sends
@@ -1073,53 +1125,65 @@ static uint8_t bt_hid_send_data(struct hal_cmd_hidhost_send_data *cmd,
 		error("error writing data to HID device: %s (%d)",
 						strerror(errno), errno);
 		g_free(req);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto fail;
 	}
 
 	g_free(req);
-	return HAL_STATUS_SUCCESS;
-}
-
-void bt_hid_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
-{
-	uint8_t status = HAL_STATUS_FAILED;
 
-	switch (opcode) {
-	case HAL_OP_HIDHOST_CONNECT:
-		status = bt_hid_connect(buf, len);
-		break;
-	case HAL_OP_HIDHOST_DISCONNECT:
-		status = bt_hid_disconnect(buf, len);
-		break;
-	case HAL_OP_HIDHOST_VIRTUAL_UNPLUG:
-		status = bt_hid_virtual_unplug(buf, len);
-		break;
-	case HAL_OP_HIDHOST_SET_INFO:
-		status = bt_hid_info(buf, len);
-		break;
-	case HAL_OP_HIDHOST_GET_PROTOCOL:
-		status = bt_hid_get_protocol(buf, len);
-		break;
-	case HAL_OP_HIDHOST_SET_PROTOCOL:
-		status = bt_hid_set_protocol(buf, len);
-		break;
-	case HAL_OP_HIDHOST_GET_REPORT:
-		status = bt_hid_get_report(buf, len);
-		break;
-	case HAL_OP_HIDHOST_SET_REPORT:
-		status = bt_hid_set_report(buf, len);
-		break;
-	case HAL_OP_HIDHOST_SEND_DATA:
-		status = bt_hid_send_data(buf, len);
-		break;
-	default:
-		DBG("Unhandled command, opcode 0x%x", opcode);
-		break;
-	}
-
-	ipc_send_rsp(sk, HAL_SERVICE_ID_HIDHOST, opcode, status);
+fail:
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_HIDHOST,
+					HAL_OP_HIDHOST_SEND_DATA, status);
 }
 
+static const struct ipc_handler cmd_handlers[] = {
+	{	/* HAL_OP_HIDHOST_CONNECT */
+		.handler = bt_hid_connect,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_hidhost_connect)
+	},
+	{	/* HAL_OP_HIDHOST_DISCONNECT */
+		.handler = bt_hid_disconnect,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_hidhost_disconnect)
+	},
+	{	/* HAL_OP_HIDHOST_VIRTUAL_UNPLUG */
+		.handler = bt_hid_virtual_unplug,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_hidhost_virtual_unplug)
+	},
+	{	/* HAL_OP_HIDHOST_SET_INFO */
+		.handler = bt_hid_info,
+		.var_len = true,
+		.data_len = sizeof(struct hal_cmd_hidhost_set_info)
+	},
+	{	/* HAL_OP_HIDHOST_GET_PROTOCOL */
+		.handler = bt_hid_get_protocol,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_hidhost_get_protocol)
+	},
+	{	/* HAL_OP_HIDHOST_SET_PROTOCOL */
+		.handler = bt_hid_set_protocol,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_hidhost_get_protocol)
+	},
+	{	/* HAL_OP_HIDHOST_GET_REPORT */
+		.handler = bt_hid_get_report,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_hidhost_get_report)
+	},
+	{	/* HAL_OP_HIDHOST_SET_REPORT */
+		.handler = bt_hid_set_report,
+		.var_len = true,
+		.data_len = sizeof(struct hal_cmd_hidhost_set_report)
+	},
+	{	/* HAL_OP_HIDHOST_SEND_DATA */
+		.handler = bt_hid_send_data,
+		.var_len = true,
+		.data_len = sizeof(struct hal_cmd_hidhost_send_data)
+	},
+};
+
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct hid_device *dev;
@@ -1229,6 +1293,9 @@ bool bt_hid_register(int cmd_sk, int notif_sk, const bdaddr_t *addr)
 	command_sk = cmd_sk;
 	notification_sk = notif_sk;
 
+	ipc_register(HAL_SERVICE_ID_HIDHOST, cmd_handlers,
+				sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
+
 	return true;
 }
 
@@ -1263,4 +1330,6 @@ void bt_hid_unregister(void)
 		g_io_channel_unref(intr_io);
 		intr_io = NULL;
 	}
+
+	ipc_unregister(HAL_SERVICE_ID_HIDHOST);
 }
diff --git a/android/hidhost.h b/android/hidhost.h
index 4486ee9..9738ea5 100644
--- a/android/hidhost.h
+++ b/android/hidhost.h
@@ -21,7 +21,5 @@
  *
  */
 
-void bt_hid_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
-
 bool bt_hid_register(int cmd_sk, int notif_sk, const bdaddr_t *addr);
 void bt_hid_unregister(void);
-- 
1.8.3.2


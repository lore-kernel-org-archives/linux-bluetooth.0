Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 6/9] android/hidhost: Use generic IPC message handling for commands
Date: Mon,  2 Dec 2013 13:20:45 +0100
Message-Id: <1385986848-8023-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
References: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handlers are registered on service register and unregistered on
unregister.
---
 android/hidhost.c | 309 ++++++++++++++++++++++++++++++++----------------------
 android/hidhost.h |   2 -
 2 files changed, 184 insertions(+), 127 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 44310ed..38194d0 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -720,10 +720,11 @@ fail:
 	hid_device_free(dev);
 }
 
-static uint8_t bt_hid_connect(struct hal_cmd_hidhost_connect *cmd,
-								uint16_t len)
+static void bt_hid_connect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_connect *cmd = buf;
 	struct hid_device *dev;
+	uint8_t status;
 	char addr[18];
 	bdaddr_t dst;
 	GSList *l;
@@ -731,14 +732,13 @@ static uint8_t bt_hid_connect(struct hal_cmd_hidhost_connect *cmd,
 
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
+		goto failed;
+	}
 
 	dev = g_new0(struct hid_device, 1);
 	bacpy(&dev->dst, &dst);
@@ -752,32 +752,36 @@ static uint8_t bt_hid_connect(struct hal_cmd_hidhost_connect *cmd,
 					hid_sdp_search_cb, dev, NULL) < 0) {
 		error("Failed to search sdp details");
 		hid_device_free(dev);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto failed;
 	}
 
 	devices = g_slist_append(devices, dev);
 	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTING);
 
-	return HAL_STATUS_SUCCESS;
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_CONNECT, status);
 }
 
-static uint8_t bt_hid_disconnect(struct hal_cmd_hidhost_disconnect *cmd,
-								uint16_t len)
+static void bt_hid_disconnect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_disconnect *cmd = buf;
 	struct hid_device *dev;
+	uint8_t status;
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
+		goto failed;
+	}
 
 	dev = l->data;
 
@@ -790,33 +794,38 @@ static uint8_t bt_hid_disconnect(struct hal_cmd_hidhost_disconnect *cmd,
 
 	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTING);
 
-	return HAL_STATUS_SUCCESS;
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_DISCONNECT, status);
 }
 
-static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hidhost_virtual_unplug *cmd,
-								uint16_t len)
+static void bt_hid_virtual_unplug(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_virtual_unplug *cmd = buf;
 	struct hid_device *dev;
 	GSList *l;
+	uint8_t status;
 	bdaddr_t dst;
 	uint8_t hdr;
 	int fd;
 
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
+		goto failed;
+	}
 
 	dev = l->data;
 
-	if (!(dev->ctrl_io))
-		return HAL_STATUS_FAILED;
+	if (!(dev->ctrl_io)) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
 	hdr = HID_MSG_CONTROL | HID_VIRTUAL_CABLE_UNPLUG;
 
@@ -825,7 +834,8 @@ static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hidhost_virtual_unplug *cmd,
 	if (write(fd, &hdr, sizeof(hdr)) < 0) {
 		error("error writing virtual unplug command: %s (%d)",
 						strerror(errno), errno);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto failed;
 	}
 
 	/* Wait either channels to HUP */
@@ -837,10 +847,14 @@ static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hidhost_virtual_unplug *cmd,
 
 	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTING);
 
-	return HAL_STATUS_SUCCESS;
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_VIRTUAL_UNPLUG,
+									status);
 }
 
-static uint8_t bt_hid_info(struct hal_cmd_hidhost_set_info *cmd, uint16_t len)
+static void bt_hid_info(const void *buf, uint16_t len)
 {
 	/* Data from hal_cmd_hidhost_set_info is usefull only when we create
 	 * UHID device. Once device is created all the transactions will be
@@ -848,33 +862,36 @@ static uint8_t bt_hid_info(struct hal_cmd_hidhost_set_info *cmd, uint16_t len)
 	 * once device is created with HID internals. */
 	DBG("Not supported");
 
-	return HAL_STATUS_UNSUPPORTED;
+	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_INFO,
+							HAL_STATUS_UNSUPPORTED);
 }
 
-static uint8_t bt_hid_get_protocol(struct hal_cmd_hidhost_get_protocol *cmd,
-								uint16_t len)
+static void bt_hid_get_protocol(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_get_protocol *cmd = buf;
 	struct hid_device *dev;
 	GSList *l;
 	bdaddr_t dst;
 	int fd;
 	uint8_t hdr;
+	uint8_t status;
 
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
+		goto failed;
+	}
 
 	dev = l->data;
 
-	if (dev->boot_dev)
-		return HAL_STATUS_UNSUPPORTED;
+	if (dev->boot_dev) {
+		status = HAL_STATUS_UNSUPPORTED;
+		goto failed;
+	}
 
 	hdr = HID_MSG_GET_PROTOCOL | cmd->mode;
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
@@ -882,37 +899,45 @@ static uint8_t bt_hid_get_protocol(struct hal_cmd_hidhost_get_protocol *cmd,
 	if (write(fd, &hdr, sizeof(hdr)) < 0) {
 		error("error writing device_get_protocol: %s (%d)",
 						strerror(errno), errno);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto failed;
 	}
 
 	dev->last_hid_msg = HID_MSG_GET_PROTOCOL;
-	return HAL_STATUS_SUCCESS;
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_GET_PROTOCOL,
+									status);
 }
 
-static uint8_t bt_hid_set_protocol(struct hal_cmd_hidhost_set_protocol *cmd,
-								uint16_t len)
+static void bt_hid_set_protocol(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_set_protocol *cmd = buf;
 	struct hid_device *dev;
 	GSList *l;
 	bdaddr_t dst;
 	int fd;
 	uint8_t hdr;
+	uint8_t status;
 
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
+		goto failed;
+	}
 
 	dev = l->data;
 
-	if (dev->boot_dev)
-		return HAL_STATUS_UNSUPPORTED;
+	if (dev->boot_dev) {
+		status = HAL_STATUS_UNSUPPORTED;
+		goto failed;
+	}
 
 	hdr = HID_MSG_SET_PROTOCOL | cmd->mode;
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
@@ -920,39 +945,47 @@ static uint8_t bt_hid_set_protocol(struct hal_cmd_hidhost_set_protocol *cmd,
 	if (write(fd, &hdr, sizeof(hdr)) < 0) {
 		error("error writing device_set_protocol: %s (%d)",
 						strerror(errno), errno);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto failed;
 	}
 
 	dev->last_hid_msg = HID_MSG_SET_PROTOCOL;
-	return HAL_STATUS_SUCCESS;
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_PROTOCOL,
+									status);
 }
 
-static uint8_t bt_hid_get_report(struct hal_cmd_hidhost_get_report *cmd,
-								uint16_t len)
+static void bt_hid_get_report(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_get_report *cmd = buf;
 	struct hid_device *dev;
 	GSList *l;
 	bdaddr_t dst;
 	int fd;
 	uint8_t *req;
 	uint8_t req_size;
+	uint8_t status;
 
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
+		goto failed;
+	}
 
 	dev = l->data;
 	req_size = (cmd->buf_size > 0) ? 4 : 2;
 	req = g_try_malloc0(req_size);
-	if (!req)
-		return HAL_STATUS_NOMEM;
+	if (!req) {
+		status = HAL_STATUS_NOMEM;
+		goto failed;
+	}
 
 	req[0] = HID_MSG_GET_REPORT | cmd->type;
 	req[1] = cmd->id;
@@ -968,44 +1001,60 @@ static uint8_t bt_hid_get_report(struct hal_cmd_hidhost_get_report *cmd,
 		error("error writing hid_get_report: %s (%d)",
 						strerror(errno), errno);
 		g_free(req);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto failed;
 	}
 
 	dev->last_hid_msg = HID_MSG_GET_REPORT;
 	g_free(req);
-	return HAL_STATUS_SUCCESS;
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_GET_REPORT, status);
 }
 
-static uint8_t bt_hid_set_report(struct hal_cmd_hidhost_set_report *cmd,
-								uint16_t len)
+static void bt_hid_set_report(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_set_report *cmd = buf;
 	struct hid_device *dev;
 	GSList *l;
 	bdaddr_t dst;
 	int i, fd;
 	uint8_t *req;
 	uint8_t req_size;
+	uint8_t status;
 
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
+		goto failed;
+	}
 
 	dev = l->data;
 
-	if (!(dev->ctrl_io))
-		return HAL_STATUS_FAILED;
+	if (!(dev->ctrl_io)) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
 	req_size = 1 + (cmd->len / 2);
 	req = g_try_malloc0(req_size);
-	if (!req)
-		return HAL_STATUS_NOMEM;
+	if (!req) {
+		status = HAL_STATUS_NOMEM;
+		goto failed;
+	}
 
 	req[0] = HID_MSG_SET_REPORT | cmd->type;
 	/* Report data coming to HAL is in ascii format, HAL sends
@@ -1019,44 +1068,60 @@ static uint8_t bt_hid_set_report(struct hal_cmd_hidhost_set_report *cmd,
 		error("error writing hid_set_report: %s (%d)",
 						strerror(errno), errno);
 		g_free(req);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto failed;
 	}
 
 	dev->last_hid_msg = HID_MSG_SET_REPORT;
 	g_free(req);
-	return HAL_STATUS_SUCCESS;
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_REPORT, status);
 }
 
-static uint8_t bt_hid_send_data(struct hal_cmd_hidhost_send_data *cmd,
-								uint16_t len)
+static void bt_hid_send_data(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_hidhost_send_data *cmd = buf;
 	struct hid_device *dev;
 	GSList *l;
 	bdaddr_t dst;
 	int i, fd;
 	uint8_t *req;
 	uint8_t req_size;
+	uint8_t status;
 
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
+		goto failed;
+	}
 
 	dev = l->data;
 
-	if (!(dev->intr_io))
-		return HAL_STATUS_FAILED;
+	if (!(dev->intr_io)) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
 	req_size = 1 + (cmd->len / 2);
 	req = g_try_malloc0(req_size);
-	if (!req)
-		return HAL_STATUS_NOMEM;
+	if (!req) {
+		status = HAL_STATUS_NOMEM;
+		goto failed;
+	}
 
 	req[0] = HID_MSG_DATA | HID_DATA_TYPE_OUTPUT;
 	/* Report data coming to HAL is in ascii format, HAL sends
@@ -1070,53 +1135,42 @@ static uint8_t bt_hid_send_data(struct hal_cmd_hidhost_send_data *cmd,
 		error("error writing data to HID device: %s (%d)",
 						strerror(errno), errno);
 		g_free(req);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto failed;
 	}
 
 	g_free(req);
-	return HAL_STATUS_SUCCESS;
-}
 
-void bt_hid_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
-{
-	uint8_t status = HAL_STATUS_FAILED;
+	status = HAL_STATUS_SUCCESS;
 
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
-	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, opcode, status);
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SEND_DATA, status);
 }
 
+static const struct ipc_handler cmd_handlers[] = {
+	/* HAL_OP_HIDHOST_CONNECT */
+	{ bt_hid_connect, false, sizeof(struct hal_cmd_hidhost_connect) },
+	/* HAL_OP_HIDHOST_DISCONNECT */
+	{ bt_hid_disconnect, false, sizeof(struct hal_cmd_hidhost_disconnect) },
+	/* HAL_OP_HIDHOST_VIRTUAL_UNPLUG */
+	{ bt_hid_virtual_unplug, false,
+				sizeof(struct hal_cmd_hidhost_virtual_unplug) },
+	/* HAL_OP_HIDHOST_SET_INFO */
+	{ bt_hid_info, true, sizeof(struct hal_cmd_hidhost_set_info) },
+	/* HAL_OP_HIDHOST_GET_PROTOCOL */
+	{ bt_hid_get_protocol, false,
+				sizeof(struct hal_cmd_hidhost_get_protocol) },
+	/* HAL_OP_HIDHOST_SET_PROTOCOL */
+	{ bt_hid_set_protocol, false,
+				sizeof(struct hal_cmd_hidhost_get_protocol) },
+	/* HAL_OP_HIDHOST_GET_REPORT */
+	{ bt_hid_get_report, false, sizeof(struct hal_cmd_hidhost_get_report) },
+	/* HAL_OP_HIDHOST_SET_REPORT */
+	{ bt_hid_set_report, true, sizeof(struct hal_cmd_hidhost_set_report) },
+	/* HAL_OP_HIDHOST_SEND_DATA */
+	{ bt_hid_send_data, true, sizeof(struct hal_cmd_hidhost_send_data)  },
+};
+
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct hid_device *dev;
@@ -1224,6 +1278,9 @@ bool bt_hid_register(const bdaddr_t *addr)
 		return false;
 	}
 
+	ipc_register(HAL_SERVICE_ID_HIDHOST, cmd_handlers,
+				sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
+
 	return true;
 }
 
@@ -1253,4 +1310,6 @@ void bt_hid_unregister(void)
 		g_io_channel_unref(intr_io);
 		intr_io = NULL;
 	}
+
+	ipc_unregister(HAL_SERVICE_ID_HIDHOST);
 }
diff --git a/android/hidhost.h b/android/hidhost.h
index b5545fb..ea14446 100644
--- a/android/hidhost.h
+++ b/android/hidhost.h
@@ -21,7 +21,5 @@
  *
  */
 
-void bt_hid_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
-
 bool bt_hid_register(const bdaddr_t *addr);
 void bt_hid_unregister(void);
-- 
1.8.3.2


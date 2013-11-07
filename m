Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] android: Rename hidhost HAL related IPC API to match service name
Date: Thu, 7 Nov 2013 17:17:02 +0100
Message-ID: <1383841024-11965-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use 'Android HAL name' string from IPC doc as base for names.
---
 android/hal-hidhost.c | 72 +++++++++++++++++++++---------------------
 android/hal-msg.h     | 80 +++++++++++++++++++++++------------------------
 android/hid.c         | 86 ++++++++++++++++++++++++++-------------------------
 3 files changed, 120 insertions(+), 118 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index f1a2223..ed730cf 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -33,7 +33,7 @@ static bool interface_ready(void)
 
 static void handle_conn_state(void *buf)
 {
-	struct hal_ev_hid_conn_state *ev = buf;
+	struct hal_ev_hidhost_conn_state *ev = buf;
 
 	if (bt_hh_cbacks->connection_state_cb)
 		bt_hh_cbacks->connection_state_cb((bt_bdaddr_t *) ev->bdaddr,
@@ -42,7 +42,7 @@ static void handle_conn_state(void *buf)
 
 static void handle_info(void *buf)
 {
-	struct hal_ev_hid_info *ev = buf;
+	struct hal_ev_hidhost_info *ev = buf;
 	bthh_hid_info_t info;
 
 	info.attr_mask = ev->attr;
@@ -61,7 +61,7 @@ static void handle_info(void *buf)
 
 static void handle_proto_mode(void *buf)
 {
-	struct hal_ev_hid_proto_mode *ev = buf;
+	struct hal_ev_hidhost_proto_mode *ev = buf;
 
 	if (bt_hh_cbacks->protocol_mode_cb)
 		bt_hh_cbacks->protocol_mode_cb((bt_bdaddr_t *) ev->bdaddr,
@@ -70,7 +70,7 @@ static void handle_proto_mode(void *buf)
 
 static void handle_get_report(void *buf)
 {
-	struct hal_ev_hid_get_report *ev = buf;
+	struct hal_ev_hidhost_get_report *ev = buf;
 
 	if (bt_hh_cbacks->get_report_cb)
 		bt_hh_cbacks->get_report_cb((bt_bdaddr_t *) ev->bdaddr,
@@ -84,16 +84,16 @@ void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len)
 		return;
 
 	switch (opcode) {
-	case HAL_EV_HID_CONN_STATE:
+	case HAL_EV_HIDHOST_CONN_STATE:
 		handle_conn_state(buf);
 		break;
-	case HAL_EV_HID_INFO:
+	case HAL_EV_HIDHOST_INFO:
 		handle_info(buf);
 		break;
-	case HAL_EV_HID_PROTO_MODE:
+	case HAL_EV_HIDHOST_PROTO_MODE:
 		handle_proto_mode(buf);
 		break;
-	case HAL_EV_HID_GET_REPORT:
+	case HAL_EV_HIDHOST_GET_REPORT:
 		handle_get_report(buf);
 		break;
 	default:
@@ -104,7 +104,7 @@ void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len)
 
 static bt_status_t hh_connect(bt_bdaddr_t *bd_addr)
 {
-	struct hal_cmd_hid_connect cmd;
+	struct hal_cmd_hidhost_connect cmd;
 
 	DBG("");
 
@@ -116,13 +116,13 @@ static bt_status_t hh_connect(bt_bdaddr_t *bd_addr)
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HID_CONNECT,
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_CONNECT,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t hh_disconnect(bt_bdaddr_t *bd_addr)
 {
-	struct hal_cmd_hid_disconnect cmd;
+	struct hal_cmd_hidhost_disconnect cmd;
 
 	DBG("");
 
@@ -134,13 +134,13 @@ static bt_status_t hh_disconnect(bt_bdaddr_t *bd_addr)
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HID_DISCONNECT,
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_DISCONNECT,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t hh_virtual_unplug(bt_bdaddr_t *bd_addr)
 {
-	struct hal_cmd_hid_vp cmd;
+	struct hal_cmd_hidhost_vp cmd;
 
 	DBG("");
 
@@ -152,13 +152,13 @@ static bt_status_t hh_virtual_unplug(bt_bdaddr_t *bd_addr)
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HID_VP,
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_VP,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t hh_set_info(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info)
 {
-	struct hal_cmd_hid_set_info cmd;
+	struct hal_cmd_hidhost_set_info cmd;
 
 	DBG("");
 
@@ -178,14 +178,14 @@ static bt_status_t hh_set_info(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info)
 	cmd.descr_len = hid_info.dl_len;
 	memcpy(cmd.descr, hid_info.dsc_list, cmd.descr_len);
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HID_SET_INFO,
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_INFO,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t hh_get_protocol(bt_bdaddr_t *bd_addr,
 					bthh_protocol_mode_t protocol_mode)
 {
-	struct hal_cmd_hid_get_protocol cmd;
+	struct hal_cmd_hidhost_get_protocol cmd;
 
 	DBG("");
 
@@ -199,24 +199,24 @@ static bt_status_t hh_get_protocol(bt_bdaddr_t *bd_addr,
 
 	switch (protocol_mode) {
 	case BTHH_REPORT_MODE:
-		cmd.mode = HAL_HID_REPORT_PROTOCOL;
+		cmd.mode = HAL_HIDHOST_REPORT_PROTOCOL;
 		break;
 	case BTHH_BOOT_MODE:
-		cmd.mode = HAL_HID_BOOT_PROTOCOL;
+		cmd.mode = HAL_HIDHOST_BOOT_PROTOCOL;
 		break;
 	default:
 		return BT_STATUS_PARM_INVALID;
 	}
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST,
-				HAL_OP_HID_GET_PROTOCOL,
+				HAL_OP_HIDHOST_GET_PROTOCOL,
 				sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t hh_set_protocol(bt_bdaddr_t *bd_addr,
 					bthh_protocol_mode_t protocol_mode)
 {
-	struct hal_cmd_hid_set_protocol cmd;
+	struct hal_cmd_hidhost_set_protocol cmd;
 
 	DBG("");
 
@@ -230,17 +230,17 @@ static bt_status_t hh_set_protocol(bt_bdaddr_t *bd_addr,
 
 	switch (protocol_mode) {
 	case BTHH_REPORT_MODE:
-		cmd.mode = HAL_HID_REPORT_PROTOCOL;
+		cmd.mode = HAL_HIDHOST_REPORT_PROTOCOL;
 		break;
 	case BTHH_BOOT_MODE:
-		cmd.mode = HAL_HID_BOOT_PROTOCOL;
+		cmd.mode = HAL_HIDHOST_BOOT_PROTOCOL;
 		break;
 	default:
 		return BT_STATUS_PARM_INVALID;
 	}
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST,
-				HAL_OP_HID_SET_PROTOCOL,
+				HAL_OP_HIDHOST_SET_PROTOCOL,
 				sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
@@ -249,7 +249,7 @@ static bt_status_t hh_get_report(bt_bdaddr_t *bd_addr,
 						uint8_t report_id,
 						int buffer_size)
 {
-	struct hal_cmd_hid_get_report cmd;
+	struct hal_cmd_hidhost_get_report cmd;
 
 	DBG("");
 
@@ -265,19 +265,19 @@ static bt_status_t hh_get_report(bt_bdaddr_t *bd_addr,
 
 	switch (report_type) {
 	case BTHH_INPUT_REPORT:
-		cmd.type = HAL_HID_INPUT_REPORT;
+		cmd.type = HAL_HIDHOST_INPUT_REPORT;
 		break;
 	case BTHH_OUTPUT_REPORT:
-		cmd.type = HAL_HID_OUTPUT_REPORT;
+		cmd.type = HAL_HIDHOST_OUTPUT_REPORT;
 		break;
 	case BTHH_FEATURE_REPORT:
-		cmd.type = HAL_HID_FEATURE_REPORT;
+		cmd.type = HAL_HIDHOST_FEATURE_REPORT;
 		break;
 	default:
 		return BT_STATUS_PARM_INVALID;
 	}
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HID_GET_REPORT,
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_GET_REPORT,
 			sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
@@ -285,7 +285,7 @@ static bt_status_t hh_set_report(bt_bdaddr_t *bd_addr,
 						bthh_report_type_t report_type,
 						char *report)
 {
-	struct hal_cmd_hid_set_report cmd;
+	struct hal_cmd_hidhost_set_report cmd;
 
 	DBG("");
 
@@ -301,25 +301,25 @@ static bt_status_t hh_set_report(bt_bdaddr_t *bd_addr,
 
 	switch (report_type) {
 	case BTHH_INPUT_REPORT:
-		cmd.type = HAL_HID_INPUT_REPORT;
+		cmd.type = HAL_HIDHOST_INPUT_REPORT;
 		break;
 	case BTHH_OUTPUT_REPORT:
-		cmd.type = HAL_HID_OUTPUT_REPORT;
+		cmd.type = HAL_HIDHOST_OUTPUT_REPORT;
 		break;
 	case BTHH_FEATURE_REPORT:
-		cmd.type = HAL_HID_FEATURE_REPORT;
+		cmd.type = HAL_HIDHOST_FEATURE_REPORT;
 		break;
 	default:
 		return BT_STATUS_PARM_INVALID;
 	}
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HID_SET_REPORT,
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_REPORT,
 				sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t hh_send_data(bt_bdaddr_t *bd_addr, char *data)
 {
-	struct hal_cmd_hid_send_data cmd;
+	struct hal_cmd_hidhost_send_data cmd;
 
 	DBG("");
 
@@ -331,7 +331,7 @@ static bt_status_t hh_send_data(bt_bdaddr_t *bd_addr, char *data)
 
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HID_SEND_DATA,
+	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SEND_DATA,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index e1feb19..7045c8c 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -232,23 +232,23 @@ struct hal_cmd_sock_connect {
 	uint8_t  flags;
 } __attribute__((packed));
 
-#define HAL_OP_HID_CONNECT		0x01
-struct hal_cmd_hid_connect {
+#define HAL_OP_HIDHOST_CONNECT		0x01
+struct hal_cmd_hidhost_connect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
-#define HAL_OP_HID_DISCONNECT		0x02
-struct hal_cmd_hid_disconnect {
+#define HAL_OP_HIDHOST_DISCONNECT		0x02
+struct hal_cmd_hidhost_disconnect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
-#define HAL_OP_HID_VP			0x03
-struct hal_cmd_hid_vp {
+#define HAL_OP_HIDHOST_VP			0x03
+struct hal_cmd_hidhost_vp {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
-#define HAL_OP_HID_SET_INFO		0x04
-struct hal_cmd_hid_set_info {
+#define HAL_OP_HIDHOST_SET_INFO		0x04
+struct hal_cmd_hidhost_set_info {
 	uint8_t  bdaddr[6];
 	uint8_t  attr;
 	uint8_t  subclass;
@@ -260,44 +260,44 @@ struct hal_cmd_hid_set_info {
 	uint8_t  descr[0];
 } __attribute__((packed));
 
-#define HAL_HID_REPORT_PROTOCOL		0x00
-#define HAL_HID_BOOT_PROTOCOL		0x01
-#define HAL_HID_UNSUPPORTED_PROTOCOL	0xff
+#define HAL_HIDHOST_REPORT_PROTOCOL		0x00
+#define HAL_HIDHOST_BOOT_PROTOCOL		0x01
+#define HAL_HIDHOST_UNSUPPORTED_PROTOCOL	0xff
 
-#define HAL_OP_HID_GET_PROTOCOL	0x05
-struct hal_cmd_hid_get_protocol {
+#define HAL_OP_HIDHOST_GET_PROTOCOL	0x05
+struct hal_cmd_hidhost_get_protocol {
 	uint8_t bdaddr[6];
 	uint8_t mode;
 } __attribute__((packed));
 
-#define HAL_OP_HID_SET_PROTOCOL	0x06
-struct hal_cmd_hid_set_protocol {
+#define HAL_OP_HIDHOST_SET_PROTOCOL	0x06
+struct hal_cmd_hidhost_set_protocol {
 	uint8_t bdaddr[6];
 	uint8_t mode;
 } __attribute__((packed));
 
-#define HAL_HID_INPUT_REPORT		0x01
-#define HAL_HID_OUTPUT_REPORT		0x02
-#define HAL_HID_FEATURE_REPORT		0x03
+#define HAL_HIDHOST_INPUT_REPORT		0x01
+#define HAL_HIDHOST_OUTPUT_REPORT		0x02
+#define HAL_HIDHOST_FEATURE_REPORT		0x03
 
-#define HAL_OP_HID_GET_REPORT		0x07
-struct hal_cmd_hid_get_report {
+#define HAL_OP_HIDHOST_GET_REPORT		0x07
+struct hal_cmd_hidhost_get_report {
 	uint8_t  bdaddr[6];
 	uint8_t  type;
 	uint8_t  id;
 	uint16_t buf_size;
 } __attribute__((packed));
 
-#define HAL_OP_HID_SET_REPORT		0x08
-struct hal_cmd_hid_set_report {
+#define HAL_OP_HIDHOST_SET_REPORT		0x08
+struct hal_cmd_hidhost_set_report {
 	uint8_t  bdaddr[6];
 	uint8_t  type;
 	uint16_t len;
 	uint8_t  data[670];
 } __attribute__((packed));
 
-#define HAL_OP_HID_SEND_DATA		0x09
-struct hal_cmd_hid_send_data {
+#define HAL_OP_HIDHOST_SEND_DATA		0x09
+struct hal_cmd_hidhost_send_data {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
@@ -432,24 +432,24 @@ struct hal_ev_le_test_mode {
 	uint16_t num_packets;
 } __attribute__((packed));
 
-#define HAL_HID_STATE_CONNECTED		0x00
-#define HAL_HID_STATE_CONNECTING	0x01
-#define HAL_HID_STATE_DISCONNECTED	0x02
-#define HAL_HID_STATE_DISCONNECTING	0x03
-#define HAL_HID_STATE_NO_HID		0x07
-#define HAL_HID_STATE_FAILED		0x08
-#define HAL_HID_STATE_UNKNOWN		0x09
+#define HAL_HIDHOST_STATE_CONNECTED		0x00
+#define HAL_HIDHOST_STATE_CONNECTING	0x01
+#define HAL_HIDHOST_STATE_DISCONNECTED	0x02
+#define HAL_HIDHOST_STATE_DISCONNECTING	0x03
+#define HAL_HIDHOST_STATE_NO_HID		0x07
+#define HAL_HIDHOST_STATE_FAILED		0x08
+#define HAL_HIDHOST_STATE_UNKNOWN		0x09
 
-#define HAL_EV_HID_CONN_STATE		0x81
-struct hal_ev_hid_conn_state {
+#define HAL_EV_HIDHOST_CONN_STATE		0x81
+struct hal_ev_hidhost_conn_state {
 	uint8_t bdaddr[6];
 	uint8_t state;
 } __attribute__((packed));
 
-#define HAL_HID_STATUS_OK		0x00
+#define HAL_HIDHOST_STATUS_OK		0x00
 
-#define HAL_EV_HID_INFO			0x82
-struct hal_ev_hid_info {
+#define HAL_EV_HIDHOST_INFO			0x82
+struct hal_ev_hidhost_info {
 	uint8_t  bdaddr[6];
 	uint8_t  attr;
 	uint8_t  subclass;
@@ -462,15 +462,15 @@ struct hal_ev_hid_info {
 	uint8_t  descr[884];
 } __attribute__((packed));
 
-#define HAL_EV_HID_PROTO_MODE		0x83
-struct hal_ev_hid_proto_mode {
+#define HAL_EV_HIDHOST_PROTO_MODE		0x83
+struct hal_ev_hidhost_proto_mode {
 	uint8_t bdaddr[6];
 	uint8_t status;
 	uint8_t mode;
 } __attribute__((packed));
 
-#define HAL_EV_HID_GET_REPORT		0x85
-struct hal_ev_hid_get_report {
+#define HAL_EV_HIDHOST_GET_REPORT		0x85
+struct hal_ev_hidhost_get_report {
 	uint8_t  bdaddr[6];
 	uint8_t  status;
 	uint16_t len;
diff --git a/android/hid.c b/android/hid.c
index 93b828c..1089301 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -255,7 +255,7 @@ static gboolean intr_io_watch_cb(GIOChannel *chan, gpointer data)
 
 static void bt_hid_notify_state(struct hid_device *dev, uint8_t state)
 {
-	struct hal_ev_hid_conn_state ev;
+	struct hal_ev_hidhost_conn_state ev;
 	char address[18];
 
 	if (dev->state == state)
@@ -270,7 +270,7 @@ static void bt_hid_notify_state(struct hid_device *dev, uint8_t state)
 	ev.state = state;
 
 	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST,
-				HAL_EV_HID_CONN_STATE, sizeof(ev), &ev, -1);
+			HAL_EV_HIDHOST_CONN_STATE, sizeof(ev), &ev, -1);
 }
 
 static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond,
@@ -304,7 +304,7 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond,
 static void bt_hid_notify_proto_mode(struct hid_device *dev, uint8_t *buf,
 									int len)
 {
-	struct hal_ev_hid_proto_mode ev;
+	struct hal_ev_hidhost_proto_mode ev;
 	char address[18];
 
 	ba2str(&dev->dst, address);
@@ -314,34 +314,34 @@ static void bt_hid_notify_proto_mode(struct hid_device *dev, uint8_t *buf,
 	bdaddr2android(&dev->dst, ev.bdaddr);
 
 	if (buf[0] == HID_MSG_DATA) {
-		ev.status = HAL_HID_STATUS_OK;
+		ev.status = HAL_HIDHOST_STATUS_OK;
 		if (buf[1] == HID_PROTO_REPORT)
-			ev.mode = HAL_HID_REPORT_PROTOCOL;
+			ev.mode = HAL_HIDHOST_REPORT_PROTOCOL;
 		else if (buf[1] == HID_PROTO_BOOT)
-			ev.mode = HAL_HID_BOOT_PROTOCOL;
+			ev.mode = HAL_HIDHOST_BOOT_PROTOCOL;
 		else
-			ev.mode = HAL_HID_UNSUPPORTED_PROTOCOL;
+			ev.mode = HAL_HIDHOST_UNSUPPORTED_PROTOCOL;
 
 	} else {
 		ev.status = buf[0];
-		ev.mode = HAL_HID_UNSUPPORTED_PROTOCOL;
+		ev.mode = HAL_HIDHOST_UNSUPPORTED_PROTOCOL;
 	}
 
 	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST,
-				HAL_EV_HID_PROTO_MODE, sizeof(ev), &ev, -1);
+			HAL_EV_HIDHOST_PROTO_MODE, sizeof(ev), &ev, -1);
 }
 
 static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
 									int len)
 {
-	struct hal_ev_hid_get_report *ev;
+	struct hal_ev_hidhost_get_report *ev;
 	int ev_len;
 	char address[18];
 
 	ba2str(&dev->dst, address);
 	DBG("device %s", address);
 
-	ev_len = sizeof(*ev) + sizeof(struct hal_ev_hid_get_report) + 1;
+	ev_len = sizeof(*ev) + sizeof(struct hal_ev_hidhost_get_report) + 1;
 
 	if (!((buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_INPUT)) ||
 			(buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_OUTPUT)) ||
@@ -356,7 +356,7 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
 	 * protocol mode id doesn't exist */
 	ev_len += (dev->boot_dev) ? (len - 1) : (len - 2);
 	ev = g_malloc0(ev_len);
-	ev->status = HAL_HID_STATUS_OK;
+	ev->status = HAL_HIDHOST_STATUS_OK;
 	bdaddr2android(&dev->dst, ev->bdaddr);
 
 	/* Report porotocol mode reply contains id after hdr, in boot
@@ -371,7 +371,7 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
 
 send:
 	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST,
-					HAL_EV_HID_GET_REPORT, ev_len, ev, -1);
+				HAL_EV_HIDHOST_GET_REPORT, ev_len, ev, -1);
 	g_free(ev);
 }
 
@@ -416,7 +416,7 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond,
 		return ctrl_io_watch_cb(chan, data);
 
 	ba2str(&dev->dst, address);
-	bt_hid_notify_state(dev, HAL_HID_STATE_DISCONNECTED);
+	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTED);
 
 	/* Checking for intr_watch avoids a double g_io_channel_shutdown since
 	 * it's likely that intr_watch_cb has been queued for dispatching in
@@ -434,7 +434,7 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond,
 
 static void bt_hid_set_info(struct hid_device *dev)
 {
-	struct hal_ev_hid_info ev;
+	struct hal_ev_hidhost_info ev;
 
 	DBG("");
 
@@ -450,7 +450,7 @@ static void bt_hid_set_info(struct hid_device *dev)
 	memset(ev.descr, 0, sizeof(ev.descr));
 	memcpy(ev.descr, dev->rd_data, ev.descr_len);
 
-	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST, HAL_EV_HID_INFO,
+	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST, HAL_EV_HIDHOST_INFO,
 							sizeof(ev), &ev, -1);
 }
 
@@ -463,7 +463,7 @@ static int uhid_create(struct hid_device *dev)
 	dev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
 	if (dev->uhid_fd < 0) {
 		error("Failed to open uHID device: %s", strerror(errno));
-		bt_hid_notify_state(dev, HAL_HID_STATE_NO_HID);
+		bt_hid_notify_state(dev, HAL_HIDHOST_STATE_NO_HID);
 		return -errno;
 	}
 
@@ -512,7 +512,7 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				intr_watch_cb, dev);
 
-	bt_hid_notify_state(dev, HAL_HID_STATE_CONNECTED);
+	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTED);
 
 	return;
 
@@ -542,7 +542,7 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 	DBG("");
 
 	if (conn_err) {
-		bt_hid_notify_state(dev, HAL_HID_STATE_DISCONNECTED);
+		bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTED);
 		error("%s", conn_err->message);
 		goto failed;
 	}
@@ -663,11 +663,12 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 	return;
 
 fail:
-	bt_hid_notify_state(dev, HAL_HID_STATE_DISCONNECTED);
+	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTED);
 	hid_device_free(dev);
 }
 
-static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
+static uint8_t bt_hid_connect(struct hal_cmd_hidhost_connect *cmd,
+								uint16_t len)
 {
 	struct hid_device *dev;
 	char addr[18];
@@ -703,12 +704,12 @@ static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
 	}
 
 	devices = g_slist_append(devices, dev);
-	bt_hid_notify_state(dev, HAL_HID_STATE_CONNECTING);
+	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTING);
 
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t bt_hid_disconnect(struct hal_cmd_hid_disconnect *cmd,
+static uint8_t bt_hid_disconnect(struct hal_cmd_hidhost_disconnect *cmd,
 								uint16_t len)
 {
 	struct hid_device *dev;
@@ -735,26 +736,27 @@ static uint8_t bt_hid_disconnect(struct hal_cmd_hid_disconnect *cmd,
 	if (dev->ctrl_io)
 		g_io_channel_shutdown(dev->ctrl_io, TRUE, NULL);
 
-	bt_hid_notify_state(dev, HAL_HID_STATE_DISCONNECTING);
+	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTING);
 
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hid_vp *cmd, uint16_t len)
+static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hidhost_vp *cmd,
+								uint16_t len)
 {
 	DBG("Not Implemented");
 
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t bt_hid_info(struct hal_cmd_hid_set_info *cmd, uint16_t len)
+static uint8_t bt_hid_info(struct hal_cmd_hidhost_set_info *cmd, uint16_t len)
 {
 	DBG("Not Implemented");
 
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t bt_hid_get_protocol(struct hal_cmd_hid_get_protocol *cmd,
+static uint8_t bt_hid_get_protocol(struct hal_cmd_hidhost_get_protocol *cmd,
 								uint16_t len)
 {
 	struct hid_device *dev;
@@ -791,7 +793,7 @@ static uint8_t bt_hid_get_protocol(struct hal_cmd_hid_get_protocol *cmd,
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t bt_hid_set_protocol(struct hal_cmd_hid_set_protocol *cmd,
+static uint8_t bt_hid_set_protocol(struct hal_cmd_hidhost_set_protocol *cmd,
 								uint16_t len)
 {
 	struct hid_device *dev;
@@ -828,7 +830,7 @@ static uint8_t bt_hid_set_protocol(struct hal_cmd_hid_set_protocol *cmd,
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t bt_hid_get_report(struct hal_cmd_hid_get_report *cmd,
+static uint8_t bt_hid_get_report(struct hal_cmd_hidhost_get_report *cmd,
 								uint16_t len)
 {
 	struct hid_device *dev;
@@ -876,7 +878,7 @@ static uint8_t bt_hid_get_report(struct hal_cmd_hid_get_report *cmd,
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t bt_hid_set_report(struct hal_cmd_hid_set_report *cmd,
+static uint8_t bt_hid_set_report(struct hal_cmd_hidhost_set_report *cmd,
 								uint16_t len)
 {
 	struct hid_device *dev;
@@ -919,7 +921,7 @@ static uint8_t bt_hid_set_report(struct hal_cmd_hid_set_report *cmd,
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t bt_hid_send_data(struct hal_cmd_hid_send_data *cmd,
+static uint8_t bt_hid_send_data(struct hal_cmd_hidhost_send_data *cmd,
 								uint16_t len)
 {
 	DBG("Not Implemented");
@@ -932,31 +934,31 @@ void bt_hid_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 	uint8_t status = HAL_STATUS_FAILED;
 
 	switch (opcode) {
-	case HAL_OP_HID_CONNECT:
+	case HAL_OP_HIDHOST_CONNECT:
 		status = bt_hid_connect(buf, len);
 		break;
-	case HAL_OP_HID_DISCONNECT:
+	case HAL_OP_HIDHOST_DISCONNECT:
 		status = bt_hid_disconnect(buf, len);
 		break;
-	case HAL_OP_HID_VP:
+	case HAL_OP_HIDHOST_VP:
 		status = bt_hid_virtual_unplug(buf, len);
 		break;
-	case HAL_OP_HID_SET_INFO:
+	case HAL_OP_HIDHOST_SET_INFO:
 		status = bt_hid_info(buf, len);
 		break;
-	case HAL_OP_HID_GET_PROTOCOL:
+	case HAL_OP_HIDHOST_GET_PROTOCOL:
 		status = bt_hid_get_protocol(buf, len);
 		break;
-	case HAL_OP_HID_SET_PROTOCOL:
+	case HAL_OP_HIDHOST_SET_PROTOCOL:
 		status = bt_hid_set_protocol(buf, len);
 		break;
-	case HAL_OP_HID_GET_REPORT:
+	case HAL_OP_HIDHOST_GET_REPORT:
 		status = bt_hid_get_report(buf, len);
 		break;
-	case HAL_OP_HID_SET_REPORT:
+	case HAL_OP_HIDHOST_SET_REPORT:
 		status = bt_hid_set_report(buf, len);
 		break;
-	case HAL_OP_HID_SEND_DATA:
+	case HAL_OP_HIDHOST_SEND_DATA:
 		status = bt_hid_send_data(buf, len);
 		break;
 	default:
@@ -1020,7 +1022,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		dev->ctrl_watch = g_io_add_watch(dev->ctrl_io,
 					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 					ctrl_watch_cb, dev);
-		bt_hid_notify_state(dev, HAL_HID_STATE_CONNECTING);
+		bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTING);
 		break;
 
 	case L2CAP_PSM_HIDP_INTR:
@@ -1033,7 +1035,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		dev->intr_watch = g_io_add_watch(dev->intr_io,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				intr_watch_cb, dev);
-		bt_hid_notify_state(dev, HAL_HID_STATE_CONNECTED);
+		bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTED);
 		break;
 	}
 }
-- 
1.8.4.2


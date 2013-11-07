Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/4] android: Pass notification socket fd to service handlers
Date: Thu, 7 Nov 2013 10:10:35 +0100
Message-ID: <1383815437-521-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383815437-521-1-git-send-email-szymon.janc@tieto.com>
References: <1383815437-521-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

IPC helpers were converted to accept socket, not GIOChannel so there
is no need of passing former to handlers.
---
 android/a2dp.c    | 15 +++++------
 android/a2dp.h    |  5 ++--
 android/adapter.c | 78 +++++++++++++++++++++----------------------------------
 android/adapter.h |  6 ++---
 android/hid.c     | 30 +++++++++------------
 android/hid.h     |  4 +--
 android/main.c    | 26 ++++++++-----------
 android/pan.c     | 15 +++++------
 android/pan.h     |  4 +--
 android/socket.c  |  6 ++---
 android/socket.h  |  5 ++--
 11 files changed, 77 insertions(+), 117 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index ab7719f..0d3bfc5 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -38,7 +38,7 @@
 #include "hal-msg.h"
 #include "ipc.h"
 
-static GIOChannel *notification_io = NULL;
+static int notification_sk = -1;
 
 static uint8_t bt_a2dp_connect(struct hal_cmd_av_connect *cmd, uint16_t len)
 {
@@ -54,8 +54,7 @@ static uint8_t bt_a2dp_disconnect(struct hal_cmd_av_connect *cmd, uint16_t len)
 	return HAL_STATUS_FAILED;
 }
 
-void bt_a2dp_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-								uint16_t len)
+void bt_a2dp_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 {
 	uint8_t status = HAL_STATUS_FAILED;
 
@@ -71,15 +70,14 @@ void bt_a2dp_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 		break;
 	}
 
-	ipc_send_rsp(g_io_channel_unix_get_fd(io), HAL_SERVICE_ID_A2DP,
-								status);
+	ipc_send_rsp(sk, HAL_SERVICE_ID_A2DP, status);
 }
 
-bool bt_a2dp_register(GIOChannel *io, const bdaddr_t *addr)
+bool bt_a2dp_register(int sk, const bdaddr_t *addr)
 {
 	DBG("");
 
-	notification_io = g_io_channel_ref(io);
+	notification_sk = sk;
 
 	return true;
 }
@@ -88,6 +86,5 @@ void bt_a2dp_unregister(void)
 {
 	DBG("");
 
-	g_io_channel_unref(notification_io);
-	notification_io = NULL;
+	notification_sk = -1;
 }
diff --git a/android/a2dp.h b/android/a2dp.h
index a5ac53e..3531618 100644
--- a/android/a2dp.h
+++ b/android/a2dp.h
@@ -21,8 +21,7 @@
  *
  */
 
-void bt_a2dp_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-								uint16_t len);
+void bt_a2dp_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_a2dp_register(GIOChannel *io, const bdaddr_t *addr);
+bool bt_a2dp_register(int sk, const bdaddr_t *addr);
 void bt_a2dp_unregister(void);
diff --git a/android/adapter.c b/android/adapter.c
index 8a62582..69b3695 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -48,7 +48,7 @@
 /* Default to DisplayYesNo */
 #define DEFAULT_IO_CAPABILITY 0x01
 
-static GIOChannel *notification_io = NULL;
+static int notification_sk = -1;
 /* This list contains addresses which are asked for records */
 static GSList *browse_reqs;
 
@@ -102,9 +102,8 @@ static void adapter_name_changed(const uint8_t *name)
 	ev->props[0].len = len;
 	memcpy(ev->props->val, name, len);
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
-			sizeof(buf), ev, -1);
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);
 }
 
 static void adapter_set_name(const uint8_t *name)
@@ -144,9 +143,8 @@ static void powered_changed(void)
 
 	DBG("%u", ev.state);
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_STATE_CHANGED,
-			sizeof(ev), &ev, -1);
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_ADAPTER_STATE_CHANGED, sizeof(ev), &ev, -1);
 }
 
 static uint8_t settings2scan_mode(void)
@@ -185,9 +183,8 @@ static void scan_mode_changed(void)
 
 	DBG("mode %u", *mode);
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
-			len, ev, -1);
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_ADAPTER_PROPS_CHANGED, len, ev, -1);
 
 	g_free(ev);
 }
@@ -208,9 +205,8 @@ static void adapter_class_changed(void)
 	ev->props[0].len = sizeof(uint32_t);
 	memcpy(ev->props->val, &adapter->dev_class, sizeof(uint32_t));
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
-			len, ev, -1);
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_ADAPTER_PROPS_CHANGED, len, ev, -1);
 
 	g_free(ev);
 }
@@ -304,9 +300,8 @@ static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 	ev.state = state;
 	bdaddr2android(addr, ev.bdaddr);
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_BOND_STATE_CHANGED,
-			sizeof(ev), &ev, -1);
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_BOND_STATE_CHANGED, sizeof(ev), &ev, -1);
 }
 
 static void browse_req_free(struct browse_req *req)
@@ -339,9 +334,8 @@ static void remote_uuids_callback(struct browse_req *req)
 	ev->props[0].len = sizeof(uint128_t) * g_slist_length(req->uuids);
 	fill_uuids(req->uuids, ev->props[0].val);
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_REMOTE_DEVICE_PROPS,
-			len, ev, -1);
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_REMOTE_DEVICE_PROPS, len, ev, -1);
 
 	g_free(ev);
 }
@@ -519,9 +513,8 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 	memset(&hal_ev, 0, sizeof(hal_ev));
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_PIN_REQUEST,
-			sizeof(hal_ev), &hal_ev, -1);
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH, HAL_EV_PIN_REQUEST,
+						sizeof(hal_ev), &hal_ev, -1);
 }
 
 static void send_ssp_request(const bdaddr_t *addr, uint8_t variant,
@@ -535,9 +528,8 @@ static void send_ssp_request(const bdaddr_t *addr, uint8_t variant,
 	ev.pairing_variant = variant;
 	ev.passkey = passkey;
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_SSP_REQUEST,
-			sizeof(ev), &ev, -1);
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH, HAL_EV_SSP_REQUEST,
+							sizeof(ev), &ev, -1);
 }
 
 static void user_confirm_request_callback(uint16_t index, uint16_t length,
@@ -628,10 +620,8 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 		cp.state = HAL_DISCOVERY_STATE_STOPPED;
 	}
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-						HAL_SERVICE_ID_BLUETOOTH,
-						HAL_EV_DISCOVERY_STATE_CHANGED,
-						sizeof(cp), &cp, -1);
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp, -1);
 }
 
 static void confirm_name_complete(uint8_t status, uint16_t length,
@@ -766,9 +756,8 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		ev->num_props += fill_device_props(prop, remote, eir.class,
 								rssi, eir.name);
 
-		ipc_send(g_io_channel_unix_get_fd(notification_io),
-				HAL_SERVICE_ID_BLUETOOTH, HAL_EV_DEVICE_FOUND,
-				buff_size, ev, -1);
+		ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_DEVICE_FOUND, buff_size, ev, -1);
 		g_free(buf);
 	} else {
 		struct hal_ev_remote_device_props *ev = NULL;
@@ -783,8 +772,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		ev->status = HAL_STATUS_SUCCESS;
 		bdaddr2android(bdaddr, ev->bdaddr);
 
-		ipc_send(g_io_channel_unix_get_fd(notification_io),
-				HAL_SERVICE_ID_BLUETOOTH,
+		ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
 				HAL_EV_REMOTE_DEVICE_PROPS, buff_size, ev, -1);
 		g_free(buf);
 	}
@@ -858,8 +846,7 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 	hal_ev.state = HAL_ACL_STATE_CONNECTED;
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-			HAL_SERVICE_ID_BLUETOOTH,
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
 }
 
@@ -878,8 +865,7 @@ static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
 	hal_ev.state = HAL_ACL_STATE_DISCONNECTED;
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-			HAL_SERVICE_ID_BLUETOOTH,
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
 }
 
@@ -1225,9 +1211,8 @@ static void get_address(void)
 	ev->props[0].len = sizeof(bdaddr_t);
 	bdaddr2android(&adapter->bdaddr, ev->props[0].val);
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
-			len, ev, -1);
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_ADAPTER_PROPS_CHANGED, len, ev, -1);
 
 	g_free(ev);
 }
@@ -1699,11 +1684,9 @@ static uint8_t get_remote_services(void *buf, uint16_t len)
 	return browse_remote_sdp(&addr);
 }
 
-void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-								uint16_t len)
+void bt_adapter_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 {
 	uint8_t status = HAL_STATUS_FAILED;
-	int sk = g_io_channel_unix_get_fd(io);
 
 	switch (opcode) {
 	case HAL_OP_ENABLE:
@@ -1825,11 +1808,11 @@ const bdaddr_t *bt_adapter_get_address(void)
 	return &adapter->bdaddr;
 }
 
-bool bt_adapter_register(GIOChannel *io)
+bool bt_adapter_register(int sk)
 {
 	DBG("");
 
-	notification_io = g_io_channel_ref(io);
+	notification_sk = sk;
 
 	return true;
 }
@@ -1838,6 +1821,5 @@ void bt_adapter_unregister(void)
 {
 	DBG("");
 
-	g_io_channel_unref(notification_io);
-	notification_io = NULL;
+	notification_sk = -1;
 }
diff --git a/android/adapter.h b/android/adapter.h
index 2afc67a..08f4f48 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -24,7 +24,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include <glib.h>
 
 #include "lib/bluetooth.h"
 
@@ -33,10 +32,9 @@ typedef void (*bt_adapter_ready)(int err);
 void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 							bt_adapter_ready cb);
 
-void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-								uint16_t len);
+void bt_adapter_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
 const bdaddr_t *bt_adapter_get_address(void);
 
-bool bt_adapter_register(GIOChannel *io);
+bool bt_adapter_register(int sk);
 void bt_adapter_unregister(void);
diff --git a/android/hid.c b/android/hid.c
index 6122c9b..93b828c 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -73,7 +73,7 @@
 /* HID GET REPORT Size Field */
 #define HID_GET_REPORT_SIZE_FIELD	0x08
 
-static GIOChannel *notification_io = NULL;
+static int notification_sk = -1;
 static GIOChannel *ctrl_io = NULL;
 static GIOChannel *intr_io = NULL;
 static GSList *devices = NULL;
@@ -269,8 +269,7 @@ static void bt_hid_notify_state(struct hid_device *dev, uint8_t state)
 	bdaddr2android(&dev->dst, ev.bdaddr);
 	ev.state = state;
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-				HAL_SERVICE_ID_HIDHOST,
+	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST,
 				HAL_EV_HID_CONN_STATE, sizeof(ev), &ev, -1);
 }
 
@@ -328,8 +327,7 @@ static void bt_hid_notify_proto_mode(struct hid_device *dev, uint8_t *buf,
 		ev.mode = HAL_HID_UNSUPPORTED_PROTOCOL;
 	}
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-				HAL_SERVICE_ID_HIDHOST,
+	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST,
 				HAL_EV_HID_PROTO_MODE, sizeof(ev), &ev, -1);
 }
 
@@ -372,9 +370,8 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
 	}
 
 send:
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-			HAL_SERVICE_ID_HIDHOST, HAL_EV_HID_GET_REPORT,
-						ev_len, ev, -1);
+	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST,
+					HAL_EV_HID_GET_REPORT, ev_len, ev, -1);
 	g_free(ev);
 }
 
@@ -453,8 +450,7 @@ static void bt_hid_set_info(struct hid_device *dev)
 	memset(ev.descr, 0, sizeof(ev.descr));
 	memcpy(ev.descr, dev->rd_data, ev.descr_len);
 
-	ipc_send(g_io_channel_unix_get_fd(notification_io),
-			HAL_SERVICE_ID_HIDHOST, HAL_EV_HID_INFO,
+	ipc_send(notification_sk, HAL_SERVICE_ID_HIDHOST, HAL_EV_HID_INFO,
 							sizeof(ev), &ev, -1);
 }
 
@@ -931,7 +927,7 @@ static uint8_t bt_hid_send_data(struct hal_cmd_hid_send_data *cmd,
 	return HAL_STATUS_FAILED;
 }
 
-void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
+void bt_hid_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 {
 	uint8_t status = HAL_STATUS_FAILED;
 
@@ -968,8 +964,7 @@ void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
 		break;
 	}
 
-	ipc_send_rsp(g_io_channel_unix_get_fd(io), HAL_SERVICE_ID_HIDHOST,
-								status);
+	ipc_send_rsp(sk, HAL_SERVICE_ID_HIDHOST, status);
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
@@ -1043,15 +1038,13 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 }
 
-bool bt_hid_register(GIOChannel *io, const bdaddr_t *addr)
+bool bt_hid_register(int sk, const bdaddr_t *addr)
 {
 	GError *err = NULL;
 	const bdaddr_t *src = bt_adapter_get_address();
 
 	DBG("");
 
-	notification_io = g_io_channel_ref(io);
-
 	ctrl_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
@@ -1075,6 +1068,8 @@ bool bt_hid_register(GIOChannel *io, const bdaddr_t *addr)
 		return false;
 	}
 
+	notification_sk = sk;
+
 	return true;
 }
 
@@ -1082,8 +1077,7 @@ void bt_hid_unregister(void)
 {
 	DBG("");
 
-	g_io_channel_unref(notification_io);
-	notification_io = NULL;
+	notification_sk = -1;
 
 	if (ctrl_io) {
 		g_io_channel_shutdown(ctrl_io, TRUE, NULL);
diff --git a/android/hid.h b/android/hid.h
index 674b35a..688086a 100644
--- a/android/hid.h
+++ b/android/hid.h
@@ -21,7 +21,7 @@
  *
  */
 
-void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len);
+void bt_hid_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_hid_register(GIOChannel *io, const bdaddr_t *addr);
+bool bt_hid_register(int sk, const bdaddr_t *addr);
 void bt_hid_unregister(void);
diff --git a/android/main.c b/android/main.c
index 558ca11..2c587b1 100644
--- a/android/main.c
+++ b/android/main.c
@@ -80,33 +80,34 @@ static void service_register(void *buf, uint16_t len)
 {
 	struct hal_cmd_register_module *m = buf;
 	const bdaddr_t *adapter_bdaddr = bt_adapter_get_address();
+	int sk = g_io_channel_unix_get_fd(hal_notif_io);
 
 	if (m->service_id > HAL_SERVICE_ID_MAX || services[m->service_id])
 		goto failed;
 
 	switch (m->service_id) {
 	case HAL_SERVICE_ID_BLUETOOTH:
-		if (!bt_adapter_register(hal_notif_io))
+		if (!bt_adapter_register(sk))
 			goto failed;
 
 		break;
 	case HAL_SERVICE_ID_SOCK:
-		if (!bt_socket_register(hal_notif_io, adapter_bdaddr))
+		if (!bt_socket_register(sk, adapter_bdaddr))
 			goto failed;
 
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
-		if (!bt_hid_register(hal_notif_io, adapter_bdaddr))
+		if (!bt_hid_register(sk, adapter_bdaddr))
 			goto failed;
 
 		break;
 	case HAL_SERVICE_ID_A2DP:
-		if (!bt_a2dp_register(hal_notif_io, adapter_bdaddr))
+		if (!bt_a2dp_register(sk, adapter_bdaddr))
 			goto failed;
 
 		break;
 	case HAL_SERVICE_ID_PAN:
-		if (!bt_a2dp_register(hal_notif_io, adapter_bdaddr))
+		if (!bt_a2dp_register(sk, adapter_bdaddr))
 			goto failed;
 
 		break;
@@ -256,24 +257,19 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		handle_service_core(msg->opcode, buf + sizeof(*msg), msg->len);
 		break;
 	case HAL_SERVICE_ID_BLUETOOTH:
-		bt_adapter_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
-								msg->len);
+		bt_adapter_handle_cmd(fd, msg->opcode, msg->payload, msg->len);
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
-		bt_hid_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
-								msg->len);
+		bt_hid_handle_cmd(fd, msg->opcode, msg->payload, msg->len);
 		break;
 	case HAL_SERVICE_ID_SOCK:
-		bt_sock_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
-								msg->len);
+		bt_sock_handle_cmd(fd, msg->opcode, msg->payload, msg->len);
 		break;
 	case HAL_SERVICE_ID_A2DP:
-		bt_a2dp_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
-								msg->len);
+		bt_a2dp_handle_cmd(fd, msg->opcode, msg->payload, msg->len);
 		break;
 	case HAL_SERVICE_ID_PAN:
-		bt_pan_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
-								msg->len);
+		bt_pan_handle_cmd(fd, msg->opcode, msg->payload, msg->len);
 		break;
 	default:
 		ipc_send_rsp(fd, msg->service_id, HAL_STATUS_FAILED);
diff --git a/android/pan.c b/android/pan.c
index 0f6f1c7..061e611 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -35,7 +35,7 @@
 #include "hal-msg.h"
 #include "ipc.h"
 
-static GIOChannel *notification_io = NULL;
+static int notification_sk = -1;
 
 static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
 {
@@ -65,8 +65,7 @@ static uint8_t bt_pan_disconnect(struct hal_cmd_pan_connect *cmd, uint16_t len)
 	return HAL_STATUS_FAILED;
 }
 
-void bt_pan_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-								uint16_t len)
+void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 {
 	uint8_t status = HAL_STATUS_FAILED;
 
@@ -88,15 +87,14 @@ void bt_pan_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 		break;
 	}
 
-	ipc_send_rsp(g_io_channel_unix_get_fd(io), HAL_SERVICE_ID_A2DP,
-								status);
+	ipc_send_rsp(sk, HAL_SERVICE_ID_A2DP, status);
 }
 
-bool bt_pan_register(GIOChannel *io, const bdaddr_t *addr)
+bool bt_pan_register(int sk, const bdaddr_t *addr)
 {
 	DBG("");
 
-	notification_io = g_io_channel_ref(io);
+	notification_sk = sk;
 
 	return true;
 }
@@ -105,6 +103,5 @@ void bt_pan_unregister(void)
 {
 	DBG("");
 
-	g_io_channel_unref(notification_io);
-	notification_io = NULL;
+	notification_sk = -1;
 }
diff --git a/android/pan.h b/android/pan.h
index 1ffba9d..2430378 100644
--- a/android/pan.h
+++ b/android/pan.h
@@ -21,7 +21,7 @@
  *
  */
 
-void bt_pan_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len);
+void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_pan_register(GIOChannel *io, const bdaddr_t *addr);
+bool bt_pan_register(int sk, const bdaddr_t *addr);
 void bt_pan_unregister(void);
diff --git a/android/socket.c b/android/socket.c
index c1b0c1d..c283c5f 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -50,10 +50,8 @@ static int handle_connect(void *buf)
 	return -1;
 }
 
-void bt_sock_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-							uint16_t len)
+void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 {
-	int sk = g_io_channel_unix_get_fd(io);
 	int fd;
 
 	switch (opcode) {
@@ -79,7 +77,7 @@ void bt_sock_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 	ipc_send_rsp(sk, HAL_SERVICE_ID_SOCK, HAL_STATUS_FAILED);
 }
 
-bool bt_socket_register(GIOChannel *io, const bdaddr_t *addr)
+bool bt_socket_register(int sk, const bdaddr_t *addr)
 {
 	DBG("");
 
diff --git a/android/socket.h b/android/socket.h
index 2b3b940..7aa5574 100644
--- a/android/socket.h
+++ b/android/socket.h
@@ -21,8 +21,7 @@
  *
  */
 
-void bt_sock_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-						uint16_t len);
+void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_socket_register(GIOChannel *io, const bdaddr_t *addr);
+bool bt_socket_register(int sk, const bdaddr_t *addr);
 void bt_socket_unregister(void);
-- 
1.8.4.2


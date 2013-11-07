Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/4] android: Make IPC helpers accept file descriptor
Date: Thu, 7 Nov 2013 10:10:34 +0100
Message-ID: <1383815437-521-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to pass GIOChannel as writes are done immediately.
---
 android/a2dp.c    |  3 ++-
 android/adapter.c | 71 ++++++++++++++++++++++++++++++++-----------------------
 android/hid.c     | 15 ++++++++----
 android/ipc.c     | 10 ++++----
 android/ipc.h     |  4 ++--
 android/main.c    | 20 +++++++++-------
 android/pan.c     |  3 ++-
 android/socket.c  |  7 +++---
 8 files changed, 77 insertions(+), 56 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 28ab4b1..ab7719f 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -71,7 +71,8 @@ void bt_a2dp_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 		break;
 	}
 
-	ipc_send_rsp(io, HAL_SERVICE_ID_A2DP, status);
+	ipc_send_rsp(g_io_channel_unix_get_fd(io), HAL_SERVICE_ID_A2DP,
+								status);
 }
 
 bool bt_a2dp_register(GIOChannel *io, const bdaddr_t *addr)
diff --git a/android/adapter.c b/android/adapter.c
index cf5edcd..8a62582 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -102,8 +102,9 @@ static void adapter_name_changed(const uint8_t *name)
 	ev->props[0].len = len;
 	memcpy(ev->props->val, name, len);
 
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
+			sizeof(buf), ev, -1);
 }
 
 static void adapter_set_name(const uint8_t *name)
@@ -143,8 +144,9 @@ static void powered_changed(void)
 
 	DBG("%u", ev.state);
 
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_ADAPTER_STATE_CHANGED, sizeof(ev), &ev, -1);
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_STATE_CHANGED,
+			sizeof(ev), &ev, -1);
 }
 
 static uint8_t settings2scan_mode(void)
@@ -183,8 +185,9 @@ static void scan_mode_changed(void)
 
 	DBG("mode %u", *mode);
 
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
-				HAL_EV_ADAPTER_PROPS_CHANGED, len, ev, -1);
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
+			len, ev, -1);
 
 	g_free(ev);
 }
@@ -205,8 +208,9 @@ static void adapter_class_changed(void)
 	ev->props[0].len = sizeof(uint32_t);
 	memcpy(ev->props->val, &adapter->dev_class, sizeof(uint32_t));
 
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
-				HAL_EV_ADAPTER_PROPS_CHANGED, len, ev, -1);
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
+			len, ev, -1);
 
 	g_free(ev);
 }
@@ -300,8 +304,9 @@ static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 	ev.state = state;
 	bdaddr2android(addr, ev.bdaddr);
 
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_BOND_STATE_CHANGED, sizeof(ev), &ev, -1);
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_BOND_STATE_CHANGED,
+			sizeof(ev), &ev, -1);
 }
 
 static void browse_req_free(struct browse_req *req)
@@ -334,8 +339,9 @@ static void remote_uuids_callback(struct browse_req *req)
 	ev->props[0].len = sizeof(uint128_t) * g_slist_length(req->uuids);
 	fill_uuids(req->uuids, ev->props[0].val);
 
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
-				HAL_EV_REMOTE_DEVICE_PROPS, len, ev, -1);
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_REMOTE_DEVICE_PROPS,
+			len, ev, -1);
 
 	g_free(ev);
 }
@@ -513,8 +519,9 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 	memset(&hal_ev, 0, sizeof(hal_ev));
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH, HAL_EV_PIN_REQUEST,
-						sizeof(hal_ev), &hal_ev, -1);
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_PIN_REQUEST,
+			sizeof(hal_ev), &hal_ev, -1);
 }
 
 static void send_ssp_request(const bdaddr_t *addr, uint8_t variant,
@@ -528,8 +535,9 @@ static void send_ssp_request(const bdaddr_t *addr, uint8_t variant,
 	ev.pairing_variant = variant;
 	ev.passkey = passkey;
 
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH, HAL_EV_SSP_REQUEST,
-						sizeof(ev), &ev, -1);
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_SSP_REQUEST,
+			sizeof(ev), &ev, -1);
 }
 
 static void user_confirm_request_callback(uint16_t index, uint16_t length,
@@ -620,7 +628,8 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 		cp.state = HAL_DISCOVERY_STATE_STOPPED;
 	}
 
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+						HAL_SERVICE_ID_BLUETOOTH,
 						HAL_EV_DISCOVERY_STATE_CHANGED,
 						sizeof(cp), &cp, -1);
 }
@@ -757,9 +766,9 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		ev->num_props += fill_device_props(prop, remote, eir.class,
 								rssi, eir.name);
 
-		ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
-							HAL_EV_DEVICE_FOUND,
-							buff_size, ev, -1);
+		ipc_send(g_io_channel_unix_get_fd(notification_io),
+				HAL_SERVICE_ID_BLUETOOTH, HAL_EV_DEVICE_FOUND,
+				buff_size, ev, -1);
 		g_free(buf);
 	} else {
 		struct hal_ev_remote_device_props *ev = NULL;
@@ -774,9 +783,9 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		ev->status = HAL_STATUS_SUCCESS;
 		bdaddr2android(bdaddr, ev->bdaddr);
 
-		ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
-						HAL_EV_REMOTE_DEVICE_PROPS,
-						buff_size, ev, -1);
+		ipc_send(g_io_channel_unix_get_fd(notification_io),
+				HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_REMOTE_DEVICE_PROPS, buff_size, ev, -1);
 		g_free(buf);
 	}
 
@@ -849,7 +858,8 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 	hal_ev.state = HAL_ACL_STATE_CONNECTED;
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+			HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
 }
 
@@ -868,7 +878,8 @@ static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
 	hal_ev.state = HAL_ACL_STATE_DISCONNECTED;
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+			HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
 }
 
@@ -1214,8 +1225,9 @@ static void get_address(void)
 	ev->props[0].len = sizeof(bdaddr_t);
 	bdaddr2android(&adapter->bdaddr, ev->props[0].val);
 
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
-				HAL_EV_ADAPTER_PROPS_CHANGED, len, ev, -1);
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+			HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
+			len, ev, -1);
 
 	g_free(ev);
 }
@@ -1691,6 +1703,7 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 								uint16_t len)
 {
 	uint8_t status = HAL_STATUS_FAILED;
+	int sk = g_io_channel_unix_get_fd(io);
 
 	switch (opcode) {
 	case HAL_OP_ENABLE:
@@ -1798,13 +1811,13 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 		goto error;
 	}
 
-	ipc_send(io, HAL_SERVICE_ID_BLUETOOTH, opcode, 0, NULL, -1);
+	ipc_send(sk, HAL_SERVICE_ID_BLUETOOTH, opcode, 0, NULL, -1);
 	return;
 
 error:
 	error("Error handling command 0x%02x status %u", opcode, status);
 
-	ipc_send_rsp(io, HAL_SERVICE_ID_BLUETOOTH, status);
+	ipc_send_rsp(sk, HAL_SERVICE_ID_BLUETOOTH, status);
 }
 
 const bdaddr_t *bt_adapter_get_address(void)
diff --git a/android/hid.c b/android/hid.c
index c38c4c1..6122c9b 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -269,7 +269,8 @@ static void bt_hid_notify_state(struct hid_device *dev, uint8_t state)
 	bdaddr2android(&dev->dst, ev.bdaddr);
 	ev.state = state;
 
-	ipc_send(notification_io, HAL_SERVICE_ID_HIDHOST,
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+				HAL_SERVICE_ID_HIDHOST,
 				HAL_EV_HID_CONN_STATE, sizeof(ev), &ev, -1);
 }
 
@@ -327,7 +328,8 @@ static void bt_hid_notify_proto_mode(struct hid_device *dev, uint8_t *buf,
 		ev.mode = HAL_HID_UNSUPPORTED_PROTOCOL;
 	}
 
-	ipc_send(notification_io, HAL_SERVICE_ID_HIDHOST,
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+				HAL_SERVICE_ID_HIDHOST,
 				HAL_EV_HID_PROTO_MODE, sizeof(ev), &ev, -1);
 }
 
@@ -370,7 +372,8 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
 	}
 
 send:
-	ipc_send(notification_io, HAL_SERVICE_ID_HIDHOST, HAL_EV_HID_GET_REPORT,
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+			HAL_SERVICE_ID_HIDHOST, HAL_EV_HID_GET_REPORT,
 						ev_len, ev, -1);
 	g_free(ev);
 }
@@ -450,7 +453,8 @@ static void bt_hid_set_info(struct hid_device *dev)
 	memset(ev.descr, 0, sizeof(ev.descr));
 	memcpy(ev.descr, dev->rd_data, ev.descr_len);
 
-	ipc_send(notification_io, HAL_SERVICE_ID_HIDHOST, HAL_EV_HID_INFO,
+	ipc_send(g_io_channel_unix_get_fd(notification_io),
+			HAL_SERVICE_ID_HIDHOST, HAL_EV_HID_INFO,
 							sizeof(ev), &ev, -1);
 }
 
@@ -964,7 +968,8 @@ void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
 		break;
 	}
 
-	ipc_send_rsp(io, HAL_SERVICE_ID_HIDHOST, status);
+	ipc_send_rsp(g_io_channel_unix_get_fd(io), HAL_SERVICE_ID_HIDHOST,
+								status);
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
diff --git a/android/ipc.c b/android/ipc.c
index e672bf8..9a8657d 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -32,13 +32,11 @@
 #include <signal.h>
 #include <sys/socket.h>
 
-#include <glib.h>
-
 #include "hal-msg.h"
 #include "ipc.h"
 #include "log.h"
 
-void ipc_send(GIOChannel *io, uint8_t service_id, uint8_t opcode, uint16_t len,
+void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd)
 {
 	struct msghdr msg;
@@ -76,17 +74,17 @@ void ipc_send(GIOChannel *io, uint8_t service_id, uint8_t opcode, uint16_t len,
 		msg.msg_controllen = sizeof(cmsgbuf);
 	}
 
-	if (sendmsg(g_io_channel_unix_get_fd(io), &msg, 0) < 0) {
+	if (sendmsg(sk, &msg, 0) < 0) {
 		error("IPC send failed, terminating :%s", strerror(errno));
 		raise(SIGTERM);
 	}
 }
 
-void ipc_send_rsp(GIOChannel *io, uint8_t service_id, uint8_t status)
+void ipc_send_rsp(int sk, uint8_t service_id, uint8_t status)
 {
 	struct hal_status s;
 
 	s.code = status;
 
-	ipc_send(io, service_id, HAL_OP_STATUS, sizeof(s), &s, -1);
+	ipc_send(sk, service_id, HAL_OP_STATUS, sizeof(s), &s, -1);
 }
diff --git a/android/ipc.h b/android/ipc.h
index 093c84c..cf0f3d6 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -21,6 +21,6 @@
  *
  */
 
-void ipc_send(GIOChannel *io, uint8_t service_id, uint8_t opcode, uint16_t len,
+void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd);
-void ipc_send_rsp(GIOChannel *io, uint8_t service_id, uint8_t status);
+void ipc_send_rsp(int sk, uint8_t service_id, uint8_t status);
diff --git a/android/main.c b/android/main.c
index 75004cf..558ca11 100644
--- a/android/main.c
+++ b/android/main.c
@@ -117,13 +117,14 @@ static void service_register(void *buf, uint16_t len)
 
 	services[m->service_id] = true;
 
-	ipc_send(hal_cmd_io, HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE, 0,
-								NULL, -1);
+	ipc_send(g_io_channel_unix_get_fd(hal_cmd_io), HAL_SERVICE_ID_CORE,
+					HAL_OP_REGISTER_MODULE, 0, NULL, -1);
 
 	info("Service ID=%u registered", m->service_id);
 	return;
 failed:
-	ipc_send_rsp(hal_cmd_io, HAL_SERVICE_ID_CORE, HAL_STATUS_FAILED);
+	ipc_send_rsp(g_io_channel_unix_get_fd(hal_cmd_io),
+				HAL_SERVICE_ID_CORE, HAL_STATUS_FAILED);
 }
 
 static void service_unregister(void *buf, uint16_t len)
@@ -158,13 +159,14 @@ static void service_unregister(void *buf, uint16_t len)
 
 	services[m->service_id] = false;
 
-	ipc_send(hal_cmd_io, HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
-								0, NULL, -1);
+	ipc_send(g_io_channel_unix_get_fd(hal_cmd_io), HAL_SERVICE_ID_CORE,
+					HAL_OP_UNREGISTER_MODULE, 0, NULL, -1);
 
 	info("Service ID=%u unregistered", m->service_id);
 	return;
 failed:
-	ipc_send_rsp(hal_cmd_io, HAL_SERVICE_ID_CORE, HAL_STATUS_FAILED);
+	ipc_send_rsp(g_io_channel_unix_get_fd(hal_cmd_io),
+				HAL_SERVICE_ID_CORE, HAL_STATUS_FAILED);
 }
 
 static void handle_service_core(uint8_t opcode, void *buf, uint16_t len)
@@ -177,8 +179,8 @@ static void handle_service_core(uint8_t opcode, void *buf, uint16_t len)
 		service_unregister(buf, len);
 		break;
 	default:
-		ipc_send_rsp(hal_cmd_io, HAL_SERVICE_ID_CORE,
-							HAL_STATUS_FAILED);
+		ipc_send_rsp(g_io_channel_unix_get_fd(hal_cmd_io),
+				HAL_SERVICE_ID_CORE, HAL_STATUS_FAILED);
 		break;
 	}
 }
@@ -274,7 +276,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 								msg->len);
 		break;
 	default:
-		ipc_send_rsp(hal_cmd_io, msg->service_id, HAL_STATUS_FAILED);
+		ipc_send_rsp(fd, msg->service_id, HAL_STATUS_FAILED);
 		break;
 	}
 
diff --git a/android/pan.c b/android/pan.c
index 0cc3590..0f6f1c7 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -88,7 +88,8 @@ void bt_pan_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 		break;
 	}
 
-	ipc_send_rsp(io, HAL_SERVICE_ID_A2DP, status);
+	ipc_send_rsp(g_io_channel_unix_get_fd(io), HAL_SERVICE_ID_A2DP,
+								status);
 }
 
 bool bt_pan_register(GIOChannel *io, const bdaddr_t *addr)
diff --git a/android/socket.c b/android/socket.c
index e32be46..c1b0c1d 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -53,6 +53,7 @@ static int handle_connect(void *buf)
 void bt_sock_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 							uint16_t len)
 {
+	int sk = g_io_channel_unix_get_fd(io);
 	int fd;
 
 	switch (opcode) {
@@ -61,21 +62,21 @@ void bt_sock_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 		if (fd < 0)
 			break;
 
-		ipc_send(io, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
+		ipc_send(sk, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
 		return;
 	case HAL_OP_SOCK_CONNECT:
 		fd = handle_connect(buf);
 		if (fd < 0)
 			break;
 
-		ipc_send(io, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
+		ipc_send(sk, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
 		return;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
 		break;
 	}
 
-	ipc_send_rsp(io, HAL_SERVICE_ID_SOCK, HAL_STATUS_FAILED);
+	ipc_send_rsp(sk, HAL_SERVICE_ID_SOCK, HAL_STATUS_FAILED);
 }
 
 bool bt_socket_register(GIOChannel *io, const bdaddr_t *addr)
-- 
1.8.4.2


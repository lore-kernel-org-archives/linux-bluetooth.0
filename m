Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] android/hal: Use hidhost instead of hh in hidhost HAL
Date: Thu, 7 Nov 2013 17:17:04 +0100
Message-ID: <1383841024-11965-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383841024-11965-1-git-send-email-szymon.janc@tieto.com>
References: <1383841024-11965-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Match functions names to HAL name. Where not needed hh prefix is
removed.
---
 android/hal-hidhost.c | 78 +++++++++++++++++++++++++--------------------------
 android/hal-ipc.c     |  2 +-
 android/hal.h         |  2 +-
 3 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index ed730cf..3c147e8 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -24,19 +24,19 @@
 #include "hal-msg.h"
 #include "hal-ipc.h"
 
-static const bthh_callbacks_t *bt_hh_cbacks;
+static const bthh_callbacks_t *cbacks;
 
 static bool interface_ready(void)
 {
-	return bt_hh_cbacks != NULL;
+	return cbacks != NULL;
 }
 
 static void handle_conn_state(void *buf)
 {
 	struct hal_ev_hidhost_conn_state *ev = buf;
 
-	if (bt_hh_cbacks->connection_state_cb)
-		bt_hh_cbacks->connection_state_cb((bt_bdaddr_t *) ev->bdaddr,
+	if (cbacks->connection_state_cb)
+		cbacks->connection_state_cb((bt_bdaddr_t *) ev->bdaddr,
 								ev->state);
 }
 
@@ -55,16 +55,16 @@ static void handle_info(void *buf)
 	info.dl_len = ev->descr_len;
 	memcpy(info.dsc_list, ev->descr, info.dl_len);
 
-	if (bt_hh_cbacks->hid_info_cb)
-		bt_hh_cbacks->hid_info_cb((bt_bdaddr_t *) ev->bdaddr, info);
+	if (cbacks->hid_info_cb)
+		cbacks->hid_info_cb((bt_bdaddr_t *) ev->bdaddr, info);
 }
 
 static void handle_proto_mode(void *buf)
 {
 	struct hal_ev_hidhost_proto_mode *ev = buf;
 
-	if (bt_hh_cbacks->protocol_mode_cb)
-		bt_hh_cbacks->protocol_mode_cb((bt_bdaddr_t *) ev->bdaddr,
+	if (cbacks->protocol_mode_cb)
+		cbacks->protocol_mode_cb((bt_bdaddr_t *) ev->bdaddr,
 							ev->status, ev->mode);
 }
 
@@ -72,13 +72,13 @@ static void handle_get_report(void *buf)
 {
 	struct hal_ev_hidhost_get_report *ev = buf;
 
-	if (bt_hh_cbacks->get_report_cb)
-		bt_hh_cbacks->get_report_cb((bt_bdaddr_t *) ev->bdaddr,
-						ev->status, ev->data, ev->len);
+	if (cbacks->get_report_cb)
+		cbacks->get_report_cb((bt_bdaddr_t *) ev->bdaddr, ev->status,
+							ev->data, ev->len);
 }
 
 /* will be called from notification thread context */
-void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len)
+void bt_notify_hidhost(uint16_t opcode, void *buf, uint16_t len)
 {
 	if (!interface_ready())
 		return;
@@ -102,7 +102,7 @@ void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len)
 	}
 }
 
-static bt_status_t hh_connect(bt_bdaddr_t *bd_addr)
+static bt_status_t hidhost_connect(bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_hidhost_connect cmd;
 
@@ -120,7 +120,7 @@ static bt_status_t hh_connect(bt_bdaddr_t *bd_addr)
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
-static bt_status_t hh_disconnect(bt_bdaddr_t *bd_addr)
+static bt_status_t disconnect(bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_hidhost_disconnect cmd;
 
@@ -138,7 +138,7 @@ static bt_status_t hh_disconnect(bt_bdaddr_t *bd_addr)
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
-static bt_status_t hh_virtual_unplug(bt_bdaddr_t *bd_addr)
+static bt_status_t virtual_unplug(bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_hidhost_vp cmd;
 
@@ -156,7 +156,7 @@ static bt_status_t hh_virtual_unplug(bt_bdaddr_t *bd_addr)
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
-static bt_status_t hh_set_info(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info)
+static bt_status_t set_info(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info)
 {
 	struct hal_cmd_hidhost_set_info cmd;
 
@@ -182,7 +182,7 @@ static bt_status_t hh_set_info(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info)
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
-static bt_status_t hh_get_protocol(bt_bdaddr_t *bd_addr,
+static bt_status_t get_protocol(bt_bdaddr_t *bd_addr,
 					bthh_protocol_mode_t protocol_mode)
 {
 	struct hal_cmd_hidhost_get_protocol cmd;
@@ -213,7 +213,7 @@ static bt_status_t hh_get_protocol(bt_bdaddr_t *bd_addr,
 				sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
-static bt_status_t hh_set_protocol(bt_bdaddr_t *bd_addr,
+static bt_status_t set_protocol(bt_bdaddr_t *bd_addr,
 					bthh_protocol_mode_t protocol_mode)
 {
 	struct hal_cmd_hidhost_set_protocol cmd;
@@ -244,7 +244,7 @@ static bt_status_t hh_set_protocol(bt_bdaddr_t *bd_addr,
 				sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
-static bt_status_t hh_get_report(bt_bdaddr_t *bd_addr,
+static bt_status_t get_report(bt_bdaddr_t *bd_addr,
 						bthh_report_type_t report_type,
 						uint8_t report_id,
 						int buffer_size)
@@ -281,7 +281,7 @@ static bt_status_t hh_get_report(bt_bdaddr_t *bd_addr,
 			sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
-static bt_status_t hh_set_report(bt_bdaddr_t *bd_addr,
+static bt_status_t set_report(bt_bdaddr_t *bd_addr,
 						bthh_report_type_t report_type,
 						char *report)
 {
@@ -317,7 +317,7 @@ static bt_status_t hh_set_report(bt_bdaddr_t *bd_addr,
 				sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
-static bt_status_t hh_send_data(bt_bdaddr_t *bd_addr, char *data)
+static bt_status_t send_data(bt_bdaddr_t *bd_addr, char *data)
 {
 	struct hal_cmd_hidhost_send_data cmd;
 
@@ -335,14 +335,14 @@ static bt_status_t hh_send_data(bt_bdaddr_t *bd_addr, char *data)
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
-static bt_status_t hh_init(bthh_callbacks_t *callbacks)
+static bt_status_t init(bthh_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
 
 	DBG("");
 
 	/* store reference to user callbacks */
-	bt_hh_cbacks = callbacks;
+	cbacks = callbacks;
 
 	cmd.service_id = HAL_SERVICE_ID_HIDHOST;
 
@@ -350,7 +350,7 @@ static bt_status_t hh_init(bthh_callbacks_t *callbacks)
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
-static void hh_cleanup(void)
+static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
 
@@ -359,7 +359,7 @@ static void hh_cleanup(void)
 	if (!interface_ready())
 		return;
 
-	bt_hh_cbacks = NULL;
+	cbacks = NULL;
 
 	cmd.service_id = HAL_SERVICE_ID_HIDHOST;
 
@@ -367,22 +367,22 @@ static void hh_cleanup(void)
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
-static bthh_interface_t hh_if = {
-	.size = sizeof(hh_if),
-	.init = hh_init,
-	.connect = hh_connect,
-	.disconnect = hh_disconnect,
-	.virtual_unplug = hh_virtual_unplug,
-	.set_info = hh_set_info,
-	.get_protocol = hh_get_protocol,
-	.set_protocol = hh_set_protocol,
-	.get_report = hh_get_report,
-	.set_report = hh_set_report,
-	.send_data = hh_send_data,
-	.cleanup = hh_cleanup
+static bthh_interface_t hidhost_if = {
+	.size = sizeof(hidhost_if),
+	.init = init,
+	.connect = hidhost_connect,
+	.disconnect = disconnect,
+	.virtual_unplug = virtual_unplug,
+	.set_info = set_info,
+	.get_protocol = get_protocol,
+	.set_protocol = set_protocol,
+	.get_report = get_report,
+	.set_report = set_report,
+	.send_data = send_data,
+	.cleanup = cleanup
 };
 
 bthh_interface_t *bt_get_hidhost_interface(void)
 {
-	return &hh_if;
+	return &hidhost_if;
 }
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index a34061d..e1c8dd7 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -50,7 +50,7 @@ static void notification_dispatch(struct hal_hdr *msg, int fd)
 		bt_notify_adapter(msg->opcode, msg->payload, msg->len);
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
-		bt_notify_hh(msg->opcode, msg->payload, msg->len);
+		bt_notify_hidhost(msg->opcode, msg->payload, msg->len);
 		break;
 	case HAL_SERVICE_ID_A2DP:
 		bt_notify_a2dp(msg->opcode, msg->payload, msg->len);
diff --git a/android/hal.h b/android/hal.h
index f47ec2a..2ce7932 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -29,5 +29,5 @@ btav_interface_t *bt_get_a2dp_interface(void);
 void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len);
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
-void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len);
+void bt_notify_hidhost(uint16_t opcode, void *buf, uint16_t len);
 void bt_notify_a2dp(uint16_t opcode, void *buf, uint16_t len);
-- 
1.8.4.2


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] android/hal-hidhost: Use generic IPC message handling for events
Date: Sat, 16 Nov 2013 15:13:26 +0100
Message-Id: <1384611208-18536-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384611208-18536-1-git-send-email-szymon.janc@tieto.com>
References: <1384611208-18536-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Register handlers on service init and unregister on cleanup.
---
 android/hal-hidhost.c | 75 +++++++++++++++++++++++++++++----------------------
 android/hal.h         |  1 -
 2 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 2ce17a3..27ce492 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -32,7 +32,7 @@ static bool interface_ready(void)
 	return cbacks != NULL;
 }
 
-static void handle_conn_state(void *buf)
+static void handle_conn_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_hidhost_conn_state *ev = buf;
 
@@ -41,7 +41,7 @@ static void handle_conn_state(void *buf)
 								ev->state);
 }
 
-static void handle_info(void *buf)
+static void handle_info(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_hidhost_info *ev = buf;
 	bthh_hid_info_t info;
@@ -60,7 +60,7 @@ static void handle_info(void *buf)
 		cbacks->hid_info_cb((bt_bdaddr_t *) ev->bdaddr, info);
 }
 
-static void handle_proto_mode(void *buf)
+static void handle_proto_mode(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_hidhost_proto_mode *ev = buf;
 
@@ -69,16 +69,21 @@ static void handle_proto_mode(void *buf)
 							ev->status, ev->mode);
 }
 
-static void handle_get_report(void *buf)
+static void handle_get_report(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_hidhost_get_report *ev = buf;
 
+	if (len != sizeof(*ev) + ev->len) {
+		error("invalid get report event, aborting");
+		exit(EXIT_FAILURE);
+	}
+
 	if (cbacks->get_report_cb)
 		cbacks->get_report_cb((bt_bdaddr_t *) ev->bdaddr, ev->status,
 							ev->data, ev->len);
 }
 
-static void handle_virtual_unplug(void *buf)
+static void handle_virtual_unplug(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_hidhost_virtual_unplug *ev = buf;
 
@@ -87,33 +92,34 @@ static void handle_virtual_unplug(void *buf)
 								ev->status);
 }
 
-/* will be called from notification thread context */
-void bt_notify_hidhost(uint8_t opcode, void *buf, uint16_t len)
-{
-	if (!interface_ready())
-		return;
-
-	switch (opcode) {
-	case HAL_EV_HIDHOST_CONN_STATE:
-		handle_conn_state(buf);
-		break;
-	case HAL_EV_HIDHOST_INFO:
-		handle_info(buf);
-		break;
-	case HAL_EV_HIDHOST_PROTO_MODE:
-		handle_proto_mode(buf);
-		break;
-	case HAL_EV_HIDHOST_GET_REPORT:
-		handle_get_report(buf);
-		break;
-	case HAL_EV_HIDHOST_VIRTUAL_UNPLUG:
-		handle_virtual_unplug(buf);
-		break;
-	default:
-		DBG("Unhandled callback opcode=0x%x", opcode);
-		break;
-	}
-}
+/* handlers will be called from notification thread context */
+static const struct hal_ipc_handler ev_handlers[] = {
+	{
+		.handler = handle_conn_state,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_hidhost_conn_state)
+	},
+	{
+		.handler = handle_info,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_hidhost_info),
+	},
+	{
+		.handler = handle_proto_mode,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_hidhost_proto_mode),
+	},
+	{
+		.handler = handle_get_report,
+		.var_len = true,
+		.data_len = sizeof(struct hal_ev_hidhost_get_report),
+	},
+	{
+		.handler = handle_virtual_unplug,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_hidhost_virtual_unplug),
+	},
+};
 
 static bt_status_t hidhost_connect(bt_bdaddr_t *bd_addr)
 {
@@ -362,6 +368,9 @@ static bt_status_t init(bthh_callbacks_t *callbacks)
 	/* store reference to user callbacks */
 	cbacks = callbacks;
 
+	hal_ipc_register(HAL_SERVICE_ID_HIDHOST, ev_handlers,
+				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
+
 	cmd.service_id = HAL_SERVICE_ID_HIDHOST;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
@@ -383,6 +392,8 @@ static void cleanup(void)
 
 	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
+
+	hal_ipc_unregister(HAL_SERVICE_ID_HIDHOST);
 }
 
 static bthh_interface_t hidhost_if = {
diff --git a/android/hal.h b/android/hal.h
index 67dad5d..58426a9 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -28,6 +28,5 @@ btav_interface_t *bt_get_a2dp_interface(void);
 
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
-void bt_notify_hidhost(uint8_t opcode, void *buf, uint16_t len);
 void bt_notify_a2dp(uint8_t opcode, void *buf, uint16_t len);
 void bt_notify_pan(uint8_t opcode, void *buf, uint16_t len);
-- 
1.8.4.2


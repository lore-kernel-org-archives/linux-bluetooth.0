Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 4/6] android/hal-pan: Use generic IPC message handling for events
Date: Mon, 18 Nov 2013 15:35:03 +0100
Message-Id: <1384785305-17084-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384785305-17084-1-git-send-email-szymon.janc@tieto.com>
References: <1384785305-17084-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Register handlers on service init and unregister on cleanup.
---
 android/hal-pan.c | 40 +++++++++++++++++++++-------------------
 android/hal.h     |  1 -
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/android/hal-pan.c b/android/hal-pan.c
index 2bc560e..0ca9e12 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -31,7 +31,7 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
-static void handle_conn_state(void *buf)
+static void handle_conn_state(void *buf, uint16_t len)
 {
 	struct hal_ev_pan_conn_state *ev = buf;
 
@@ -41,7 +41,7 @@ static void handle_conn_state(void *buf)
 					ev->local_role, ev->remote_role);
 }
 
-static void handle_ctrl_state(void *buf)
+static void handle_ctrl_state(void *buf, uint16_t len)
 {
 	struct hal_ev_pan_ctrl_state *ev = buf;
 
@@ -50,23 +50,20 @@ static void handle_ctrl_state(void *buf)
 					ev->local_role, (char *)ev->name);
 }
 
-void bt_notify_pan(uint8_t opcode, void *buf, uint16_t len)
-{
-	if (!interface_ready())
-		return;
-
-	switch (opcode) {
-	case HAL_EV_PAN_CONN_STATE:
-		handle_conn_state(buf);
-		break;
-	case HAL_EV_PAN_CTRL_STATE:
-		handle_ctrl_state(buf);
-		break;
-	default:
-		DBG("Unhandled callback opcode=0x%x", opcode);
-		break;
-	}
-}
+/* handlers will be called from notification thread context,
+ * index in table equals to 'opcode - HAL_MINIMUM_EVENT' */
+static const struct hal_ipc_handler ev_handlers[] = {
+	{	/* HAL_EV_PAN_CTRL_STATE */
+		.handler = handle_conn_state,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_pan_conn_state),
+	},
+	{	/* HAL_EV_PAN_CONN_STATE */
+		.handler = handle_ctrl_state,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_pan_ctrl_state),
+	},
+};
 
 static bt_status_t pan_enable(int local_role)
 {
@@ -143,6 +140,9 @@ static bt_status_t pan_init(const btpan_callbacks_t *callbacks)
 
 	cbs = callbacks;
 
+	hal_ipc_register(HAL_SERVICE_ID_PAN, ev_handlers,
+				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
+
 	cmd.service_id = HAL_SERVICE_ID_PAN;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
@@ -164,6 +164,8 @@ static void pan_cleanup()
 
 	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
+
+	hal_ipc_unregister(HAL_SERVICE_ID_PAN);
 }
 
 static btpan_interface_t pan_if = {
diff --git a/android/hal.h b/android/hal.h
index 58426a9..6bd4c5a 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -29,4 +29,3 @@ btav_interface_t *bt_get_a2dp_interface(void);
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
 void bt_notify_a2dp(uint8_t opcode, void *buf, uint16_t len);
-void bt_notify_pan(uint8_t opcode, void *buf, uint16_t len);
-- 
1.8.4.2


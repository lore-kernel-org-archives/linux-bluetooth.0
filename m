Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] android/hal-a2dp: Use generic IPC message handling for events
Date: Sat, 16 Nov 2013 15:13:28 +0100
Message-Id: <1384611208-18536-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384611208-18536-1-git-send-email-szymon.janc@tieto.com>
References: <1384611208-18536-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Register handlers on service init and unregister on cleanup.
---
 android/hal-a2dp.c | 40 ++++++++++++++++++++--------------------
 android/hal.h      |  1 -
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index e9fadb7..baa4b10 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -31,7 +31,7 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
-static void handle_conn_state(void *buf)
+static void handle_conn_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_a2dp_conn_state *ev = buf;
 
@@ -40,7 +40,7 @@ static void handle_conn_state(void *buf)
 						(bt_bdaddr_t *) (ev->bdaddr));
 }
 
-static void handle_audio_state(void *buf)
+static void handle_audio_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_a2dp_audio_state *ev = buf;
 
@@ -48,24 +48,19 @@ static void handle_audio_state(void *buf)
 		cbs->audio_state_cb(ev->state, (bt_bdaddr_t *)(ev->bdaddr));
 }
 
-/* will be called from notification thread context */
-void bt_notify_a2dp(uint8_t opcode, void *buf, uint16_t len)
-{
-	if (!interface_ready())
-		return;
-
-	switch (opcode) {
-	case HAL_EV_A2DP_CONN_STATE:
-		handle_conn_state(buf);
-		break;
-	case HAL_EV_A2DP_AUDIO_STATE:
-		handle_audio_state(buf);
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
+		.data_len = sizeof(struct hal_ev_pan_conn_state),
+	},
+	{
+		.handler = handle_audio_state,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_pan_ctrl_state),
+	},
+};
 
 static bt_status_t a2dp_connect(bt_bdaddr_t *bd_addr)
 {
@@ -105,6 +100,9 @@ static bt_status_t init(btav_callbacks_t *callbacks)
 
 	cbs = callbacks;
 
+	hal_ipc_register(HAL_SERVICE_ID_A2DP, ev_handlers,
+				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
+
 	cmd.service_id = HAL_SERVICE_ID_A2DP;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
@@ -126,6 +124,8 @@ static void cleanup()
 
 	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
+
+	hal_ipc_unregister(HAL_SERVICE_ID_A2DP);
 }
 
 static btav_interface_t iface = {
diff --git a/android/hal.h b/android/hal.h
index 6bd4c5a..b475411 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -28,4 +28,3 @@ btav_interface_t *bt_get_a2dp_interface(void);
 
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
-void bt_notify_a2dp(uint8_t opcode, void *buf, uint16_t len);
-- 
1.8.4.2


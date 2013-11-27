Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/13] android/a2dp: Use generic IPC message handling for commands
Date: Wed, 27 Nov 2013 12:55:02 +0100
Message-Id: <1385553305-5807-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
References: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handlers are registered on service register and unregistered on
unregister.
---
 android/a2dp.c | 73 +++++++++++++++++++++++++++++++---------------------------
 android/a2dp.h |  2 --
 2 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 87b1abb..6f79cc5 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -166,9 +166,11 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_CONNECTED);
 }
 
-static uint8_t bt_a2dp_connect(struct hal_cmd_a2dp_connect *cmd, uint16_t len)
+static void bt_a2dp_connect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_a2dp_connect *cmd = buf;
 	struct a2dp_device *dev;
+	uint8_t status = HAL_STATUS_SUCCESS;
 	char addr[18];
 	bdaddr_t dst;
 	GSList *l;
@@ -176,14 +178,13 @@ static uint8_t bt_a2dp_connect(struct hal_cmd_a2dp_connect *cmd, uint16_t len)
 
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
 
 	dev = a2dp_device_new(&dst);
 	dev->io = bt_io_connect(signaling_connect_cb, dev, NULL, &err,
@@ -196,7 +197,8 @@ static uint8_t bt_a2dp_connect(struct hal_cmd_a2dp_connect *cmd, uint16_t len)
 		error("%s", err->message);
 		g_error_free(err);
 		a2dp_device_free(dev);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto fail;
 	}
 
 	ba2str(&dev->dst, addr);
@@ -204,26 +206,28 @@ static uint8_t bt_a2dp_connect(struct hal_cmd_a2dp_connect *cmd, uint16_t len)
 
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_CONNECTING);
 
-	return HAL_STATUS_SUCCESS;
+fail:
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_CONNECT,
+								status);
 }
 
-static uint8_t bt_a2dp_disconnect(struct hal_cmd_a2dp_connect *cmd,
-								uint16_t len)
+static void bt_a2dp_disconnect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_a2dp_connect *cmd = buf;
+	uint8_t status = HAL_STATUS_SUCCESS;
 	struct a2dp_device *dev;
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
 
@@ -233,27 +237,23 @@ static uint8_t bt_a2dp_disconnect(struct hal_cmd_a2dp_connect *cmd,
 
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTING);
 
-	return HAL_STATUS_SUCCESS;
+fail:
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_DISCONNECT,
+								status);
 }
 
-void bt_a2dp_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
-{
-	uint8_t status = HAL_STATUS_FAILED;
-
-	switch (opcode) {
-	case HAL_OP_A2DP_CONNECT:
-		status = bt_a2dp_connect(buf, len);
-		break;
-	case HAL_OP_A2DP_DISCONNECT:
-		status = bt_a2dp_disconnect(buf, len);
-		break;
-	default:
-		DBG("Unhandled command, opcode 0x%x", opcode);
-		break;
-	}
-
-	ipc_send_rsp(sk, HAL_SERVICE_ID_A2DP, opcode, status);
-}
+static const struct ipc_handler cmd_handlers[] = {
+	{	/* HAL_OP_A2DP_CONNECT */
+		.handler = bt_a2dp_connect,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_a2dp_connect)
+	},
+	{	/* HAL_OP_A2DP_DISCONNECT */
+		.handler = bt_a2dp_disconnect,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_a2dp_disconnect)
+	},
+};
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
@@ -388,6 +388,9 @@ bool bt_a2dp_register(int cmd_sk, int notif_sk, const bdaddr_t *addr)
 	notification_sk = notif_sk;
 	command_sk = cmd_sk;
 
+	ipc_register(HAL_SERVICE_ID_A2DP, cmd_handlers,
+				sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
+
 	return true;
 }
 
@@ -411,6 +414,8 @@ void bt_a2dp_unregister(void)
 	notification_sk = -1;
 	command_sk = -1;
 
+	ipc_unregister(HAL_SERVICE_ID_A2DP);
+
 	bt_adapter_remove_record(record_id);
 	record_id = 0;
 
diff --git a/android/a2dp.h b/android/a2dp.h
index 720b681..e23fe3a 100644
--- a/android/a2dp.h
+++ b/android/a2dp.h
@@ -21,7 +21,5 @@
  *
  */
 
-void bt_a2dp_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
-
 bool bt_a2dp_register(int cmd_sk, int notif_sk, const bdaddr_t *addr);
 void bt_a2dp_unregister(void);
-- 
1.8.3.2


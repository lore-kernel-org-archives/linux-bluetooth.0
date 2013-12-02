Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 8/9] android/a2dp: Use generic IPC message handling for commands
Date: Mon,  2 Dec 2013 13:20:47 +0100
Message-Id: <1385986848-8023-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
References: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handlers are registered on service register and unregistered on
unregister.
---
 android/a2dp.c | 69 +++++++++++++++++++++++++++++-----------------------------
 android/a2dp.h |  2 --
 2 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 99aa14d..98c138e 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -164,9 +164,11 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_CONNECTED);
 }
 
-static uint8_t bt_a2dp_connect(struct hal_cmd_a2dp_connect *cmd, uint16_t len)
+static void bt_a2dp_connect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_a2dp_connect *cmd = buf;
 	struct a2dp_device *dev;
+	uint8_t status;
 	char addr[18];
 	bdaddr_t dst;
 	GSList *l;
@@ -174,14 +176,13 @@ static uint8_t bt_a2dp_connect(struct hal_cmd_a2dp_connect *cmd, uint16_t len)
 
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
 
 	dev = a2dp_device_new(&dst);
 	dev->io = bt_io_connect(signaling_connect_cb, dev, NULL, &err,
@@ -194,7 +195,8 @@ static uint8_t bt_a2dp_connect(struct hal_cmd_a2dp_connect *cmd, uint16_t len)
 		error("%s", err->message);
 		g_error_free(err);
 		a2dp_device_free(dev);
-		return HAL_STATUS_FAILED;
+		status = HAL_STATUS_FAILED;
+		goto failed;
 	}
 
 	ba2str(&dev->dst, addr);
@@ -202,26 +204,29 @@ static uint8_t bt_a2dp_connect(struct hal_cmd_a2dp_connect *cmd, uint16_t len)
 
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_CONNECTING);
 
-	return HAL_STATUS_SUCCESS;
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_CONNECT, status);
 }
 
-static uint8_t bt_a2dp_disconnect(struct hal_cmd_a2dp_connect *cmd,
-								uint16_t len)
+static void bt_a2dp_disconnect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_a2dp_connect *cmd = buf;
+	uint8_t status;
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
+		goto failed;
+	}
 
 	dev = l->data;
 
@@ -231,28 +236,19 @@ static uint8_t bt_a2dp_disconnect(struct hal_cmd_a2dp_connect *cmd,
 
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTING);
 
-	return HAL_STATUS_SUCCESS;
-}
-
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
+	status = HAL_STATUS_SUCCESS;
 
-	ipc_send_rsp(HAL_SERVICE_ID_A2DP, opcode, status);
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_DISCONNECT, status);
 }
 
+static const struct ipc_handler cmd_handlers[] = {
+	/* HAL_OP_A2DP_CONNECT */
+	{ bt_a2dp_connect, false, sizeof(struct hal_cmd_a2dp_connect) },
+	/* HAL_OP_A2DP_DISCONNECT */
+	{ bt_a2dp_disconnect, false, sizeof(struct hal_cmd_a2dp_disconnect) },
+};
+
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct a2dp_device *dev;
@@ -380,6 +376,9 @@ bool bt_a2dp_register(const bdaddr_t *addr)
 	}
 	record_id = rec->handle;
 
+	ipc_register(HAL_SERVICE_ID_A2DP, cmd_handlers,
+				sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
+
 	return true;
 }
 
@@ -397,6 +396,8 @@ void bt_a2dp_unregister(void)
 	g_slist_foreach(devices, a2dp_device_disconnected, NULL);
 	devices = NULL;
 
+
+	ipc_unregister(HAL_SERVICE_ID_A2DP);
 	bt_adapter_remove_record(record_id);
 	record_id = 0;
 
diff --git a/android/a2dp.h b/android/a2dp.h
index 2a1eb3c..7e9b2f6 100644
--- a/android/a2dp.h
+++ b/android/a2dp.h
@@ -21,7 +21,5 @@
  *
  */
 
-void bt_a2dp_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
-
 bool bt_a2dp_register(const bdaddr_t *addr);
 void bt_a2dp_unregister(void);
-- 
1.8.3.2


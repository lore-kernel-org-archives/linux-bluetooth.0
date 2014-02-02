Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/13] android/handsfree: Add stubs for commands handlers
Date: Sun,  2 Feb 2014 22:09:14 +0100
Message-Id: <1391375364-27106-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
References: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add empty handlers for all IPC commands.
---
 android/handsfree.c | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 169 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index fb48ff1..3c0d52b 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -26,16 +26,184 @@
 #endif
 
 #include <stdbool.h>
+#include <glib.h>
 
 #include "lib/bluetooth.h"
 #include "handsfree.h"
+#include "src/log.h"
+#include "hal-msg.h"
+#include "ipc.h"
+
+static bdaddr_t adapter_addr;
+
+static void handle_connect(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_CONNECT,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_disconnect(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_DISCONNECT,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_connect_audio(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_CONNECT_AUDIO,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_disconnect_audio(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE,
+			HAL_OP_HANDSFREE_DISCONNECT_AUDIO, HAL_STATUS_FAILED);
+}
+
+static void handle_start_vr(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_START_VR,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_stop_vr(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_STOP_VR,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_volume_control(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_VOLUME_CONTROL,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_device_status_notif(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE,
+					HAL_OP_HANDSFREE_DEVICE_STATUS_NOTIF,
+					HAL_STATUS_FAILED);
+}
+
+static void handle_cops(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_COPS_RESPONSE,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_cind(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_CIND_RESPONSE,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_formatted_at_resp(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE,
+					HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE,
+					HAL_STATUS_FAILED);
+}
+
+static void handle_at_resp(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_AT_RESPONSE,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_clcc_resp(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_CLCC_RESPONSE,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_phone_state_change(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE,
+					HAL_OP_HANDSFREE_PHONE_STATE_CHANGE,
+					HAL_STATUS_FAILED);
+}
+
+static const struct ipc_handler cmd_handlers[] = {
+	/* HAL_OP_HANDSFREE_CONNECT */
+	{ handle_connect, false, sizeof(struct hal_cmd_handsfree_connect)},
+	/* HAL_OP_HANDSFREE_DISCONNECT */
+	{handle_disconnect, false, sizeof(struct hal_cmd_handsfree_disconnect)},
+	/*HAL_OP_HANDSFREE_CONNECT_AUDIO*/
+	{handle_connect_audio, false,
+			sizeof(struct hal_cmd_handsfree_connect_audio)},
+	/*HAL_OP_HANDSFREE_DISCONNECT_AUDIO*/
+	{handle_disconnect_audio, false,
+			sizeof(struct hal_cmd_handsfree_disconnect_audio)},
+	/* define HAL_OP_HANDSFREE_START_VR */
+	{handle_start_vr, false, 0 },
+	/* define HAL_OP_HANDSFREE_STOP_VR */
+	{handle_stop_vr, false, 0 },
+	/* HAL_OP_HANDSFREE_VOLUME_CONTROL */
+	{handle_volume_control, false,
+			sizeof(struct hal_cmd_handsfree_volume_control)},
+	/* HAL_OP_HANDSFREE_DEVICE_STATUS_NOTIF */
+	{handle_device_status_notif, false,
+			sizeof(struct hal_cmd_handsfree_device_status_notif)},
+	/* HAL_OP_HANDSFREE_COPS_RESPONSE */
+	{handle_cops, true, sizeof(struct hal_cmd_handsfree_cops_response)},
+	/* HAL_OP_HANDSFREE_CIND_RESPONSE */
+	{ handle_cind, false, sizeof(struct hal_cmd_handsfree_cind_response)},
+	/* HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE */
+	{handle_formatted_at_resp, true,
+			sizeof(struct hal_cmd_handsfree_formatted_at_response)},
+	/* HAL_OP_HANDSFREE_AT_RESPONSE */
+	{handle_at_resp, false, sizeof(struct hal_cmd_handsfree_at_response)},
+	/* HAL_OP_HANDSFREE_CLCC_RESPONSE */
+	{handle_clcc_resp, true,
+			sizeof(struct hal_cmd_handsfree_clcc_response)},
+	/* HAL_OP_HANDSFREE_PHONE_STATE_CHANGE */
+	{handle_phone_state_change, true,
+			sizeof(struct hal_cmd_handsfree_phone_state_change)},
+};
 
 bool bt_handsfree_register(const bdaddr_t *addr)
 {
-	return false;
+	DBG("");
+
+	bacpy(&adapter_addr, addr);
+
+	ipc_register(HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
+						G_N_ELEMENTS(cmd_handlers));
+
+	return true;
 }
 
 void bt_handsfree_unregister(void)
 {
+	DBG("");
 
+	ipc_unregister(HAL_SERVICE_ID_HANDSFREE);
 }
-- 
1.8.5.3


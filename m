Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] android/hal: Rename hal-av.c to hal-a2dp.c
Date: Thu, 7 Nov 2013 11:27:36 +0100
Message-ID: <1383820057-15728-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383820057-15728-1-git-send-email-szymon.janc@tieto.com>
References: <1383820057-15728-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Name of HAL implementation will match Android HAL name. This will make
code navigation easier as daemon part and HAL library implementation
will be in foo.c and hal-foo.c respectively.
---
 android/Android.mk  |   2 +-
 android/Makefile.am |   4 +-
 android/hal-a2dp.c  | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-av.c    | 134 ----------------------------------------------------
 4 files changed, 137 insertions(+), 137 deletions(-)
 create mode 100644 android/hal-a2dp.c
 delete mode 100644 android/hal-av.c

diff --git a/android/Android.mk b/android/Android.mk
index d76dfaf..f9bf070 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -86,7 +86,7 @@ LOCAL_SRC_FILES := \
 	hal-sock.c \
 	hal-hidhost.c \
 	hal-pan.c \
-	hal-av.c \
+	hal-a2dp.c \
 	client/textconv.c \
 
 LOCAL_C_INCLUDES += \
diff --git a/android/Makefile.am b/android/Makefile.am
index 8619641..6790f24 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -33,7 +33,7 @@ android_libhal_internal_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hal-sock.c \
 					android/hal-hidhost.c \
 					android/hal-pan.c \
-					android/hal-av.c \
+					android/hal-a2dp.c \
 					android/hardware/bluetooth.h \
 					android/hardware/bt_av.h \
 					android/hardware/bt_gatt.h \
@@ -86,7 +86,7 @@ EXTRA_DIST += android/hal-bluetooth.c \
 		android/hal-sock.c \
 		android/hal-hidhost.c \
 		android/hal-pan.c \
-		android/hal-av.c \
+		android/hal-a2dp.c \
 		android/hal-log.h
 
 EXTRA_DIST += android/client/terminal.c \
diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
new file mode 100644
index 0000000..2ebf801
--- /dev/null
+++ b/android/hal-a2dp.c
@@ -0,0 +1,134 @@
+/*
+ * Copyright (C) 2013 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <string.h>
+
+#include "hal-log.h"
+#include "hal.h"
+#include "hal-msg.h"
+#include "hal-ipc.h"
+
+static const btav_callbacks_t *cbs = NULL;
+
+static bool interface_ready(void)
+{
+	return cbs != NULL;
+}
+
+static void handle_connection_state(void *buf)
+{
+	struct hal_ev_a2dp_connection_state *ev = buf;
+
+	if (cbs->connection_state_cb)
+		cbs->connection_state_cb(ev->state,
+						(bt_bdaddr_t *) (ev->bdaddr));
+}
+
+static void handle_audio_state(void *buf)
+{
+	struct hal_ev_a2dp_audio_state *ev = buf;
+
+	if (cbs->audio_state_cb)
+		cbs->audio_state_cb(ev->state, (bt_bdaddr_t *)(ev->bdaddr));
+}
+
+/* will be called from notification thread context */
+void bt_notify_av(uint16_t opcode, void *buf, uint16_t len)
+{
+	if (!interface_ready())
+		return;
+
+	switch (opcode) {
+	case HAL_EV_A2DP_CONNECTION_STATE:
+		handle_connection_state(buf);
+		break;
+	case HAL_EV_A2DP_AUDIO_STATE:
+		handle_audio_state(buf);
+		break;
+	default:
+		DBG("Unhandled callback opcode=0x%x", opcode);
+		break;
+	}
+}
+
+static bt_status_t av_connect(bt_bdaddr_t *bd_addr)
+{
+	struct hal_cmd_a2dp_connect cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_CONNECT,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+}
+
+static bt_status_t av_disconnect(bt_bdaddr_t *bd_addr)
+{
+	struct hal_cmd_a2dp_disconnect cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_DISCONNECT,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+}
+
+static bt_status_t av_init(btav_callbacks_t *callbacks)
+{
+	DBG("");
+
+	cbs = callbacks;
+
+	/* TODO: enable service */
+
+	return BT_STATUS_SUCCESS;
+}
+
+static void av_cleanup()
+{
+	DBG("");
+
+	if (!interface_ready())
+		return;
+
+	/* TODO: disable service */
+
+	cbs = NULL;
+}
+
+static btav_interface_t iface = {
+	.size = sizeof(iface),
+	.init = av_init,
+	.connect = av_connect,
+	.disconnect = av_disconnect,
+	.cleanup = av_cleanup
+};
+
+btav_interface_t *bt_get_av_interface()
+{
+	return &iface;
+}
diff --git a/android/hal-av.c b/android/hal-av.c
deleted file mode 100644
index 2ebf801..0000000
--- a/android/hal-av.c
+++ /dev/null
@@ -1,134 +0,0 @@
-/*
- * Copyright (C) 2013 Intel Corporation
- *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
- */
-
-#include <stdbool.h>
-#include <stddef.h>
-#include <string.h>
-
-#include "hal-log.h"
-#include "hal.h"
-#include "hal-msg.h"
-#include "hal-ipc.h"
-
-static const btav_callbacks_t *cbs = NULL;
-
-static bool interface_ready(void)
-{
-	return cbs != NULL;
-}
-
-static void handle_connection_state(void *buf)
-{
-	struct hal_ev_a2dp_connection_state *ev = buf;
-
-	if (cbs->connection_state_cb)
-		cbs->connection_state_cb(ev->state,
-						(bt_bdaddr_t *) (ev->bdaddr));
-}
-
-static void handle_audio_state(void *buf)
-{
-	struct hal_ev_a2dp_audio_state *ev = buf;
-
-	if (cbs->audio_state_cb)
-		cbs->audio_state_cb(ev->state, (bt_bdaddr_t *)(ev->bdaddr));
-}
-
-/* will be called from notification thread context */
-void bt_notify_av(uint16_t opcode, void *buf, uint16_t len)
-{
-	if (!interface_ready())
-		return;
-
-	switch (opcode) {
-	case HAL_EV_A2DP_CONNECTION_STATE:
-		handle_connection_state(buf);
-		break;
-	case HAL_EV_A2DP_AUDIO_STATE:
-		handle_audio_state(buf);
-		break;
-	default:
-		DBG("Unhandled callback opcode=0x%x", opcode);
-		break;
-	}
-}
-
-static bt_status_t av_connect(bt_bdaddr_t *bd_addr)
-{
-	struct hal_cmd_a2dp_connect cmd;
-
-	DBG("");
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
-
-	return hal_ipc_cmd(HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_CONNECT,
-					sizeof(cmd), &cmd, NULL, NULL, NULL);
-}
-
-static bt_status_t av_disconnect(bt_bdaddr_t *bd_addr)
-{
-	struct hal_cmd_a2dp_disconnect cmd;
-
-	DBG("");
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
-
-	return hal_ipc_cmd(HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_DISCONNECT,
-					sizeof(cmd), &cmd, NULL, NULL, NULL);
-}
-
-static bt_status_t av_init(btav_callbacks_t *callbacks)
-{
-	DBG("");
-
-	cbs = callbacks;
-
-	/* TODO: enable service */
-
-	return BT_STATUS_SUCCESS;
-}
-
-static void av_cleanup()
-{
-	DBG("");
-
-	if (!interface_ready())
-		return;
-
-	/* TODO: disable service */
-
-	cbs = NULL;
-}
-
-static btav_interface_t iface = {
-	.size = sizeof(iface),
-	.init = av_init,
-	.connect = av_connect,
-	.disconnect = av_disconnect,
-	.cleanup = av_cleanup
-};
-
-btav_interface_t *bt_get_av_interface()
-{
-	return &iface;
-}
-- 
1.8.4.2


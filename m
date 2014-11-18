Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 1/2] android/hal-avrcp-ctrl: Create separate HAL for AVRCP CTRL
Date: Tue, 18 Nov 2014 15:34:42 +0200
Message-Id: <1416317683-15258-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1416317683-15258-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1416317683-15258-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Moving AVRCP CTRL interface HAL related code to hal-avrcp-ctrl.c.
Separate HAL for every interface.
---
 android/Android.mk       |   3 +-
 android/Makefile.am      |   1 +
 android/hal-avrcp-ctrl.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-avrcp.c      | 121 ---------------------------------------
 4 files changed, 147 insertions(+), 122 deletions(-)
 create mode 100644 android/hal-avrcp-ctrl.c

diff --git a/android/Android.mk b/android/Android.mk
index ffbc943..2d3403a 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -137,7 +137,8 @@ LOCAL_SRC_FILES := \
 ifeq ($(ANDROID_GE_5_0_0), 1)
 LOCAL_SRC_FILES += \
 	bluez/android/hal-handsfree-client.c \
-	bluez/android/hal-map-client.c
+	bluez/android/hal-map-client.c \
+	bluez/android/hal-avrcp-ctrl.c
 endif
 
 LOCAL_C_INCLUDES += \
diff --git a/android/Makefile.am b/android/Makefile.am
index 8085fb5..d807aaa 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -65,6 +65,7 @@ android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hal-pan.c \
 					android/hal-a2dp.c \
 					android/hal-avrcp.c \
+					android/hal-avrcp-ctrl.c \
 					android/hal-handsfree.c \
 					android/hal-handsfree-client.c \
 					android/hal-gatt.c \
diff --git a/android/hal-avrcp-ctrl.c b/android/hal-avrcp-ctrl.c
new file mode 100644
index 0000000..e289fcd
--- /dev/null
+++ b/android/hal-avrcp-ctrl.c
@@ -0,0 +1,144 @@
+/*
+ * Copyright (C) 2014 Intel Corporation
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
+#include <stdlib.h>
+
+#include "hal-utils.h"
+#include "hal-log.h"
+#include "hal.h"
+#include "hal-msg.h"
+#include "ipc-common.h"
+#include "hal-ipc.h"
+
+static const btrc_ctrl_callbacks_t *cbs = NULL;
+
+static bool interface_ready(void)
+{
+	return cbs != NULL;
+}
+
+static void handle_connection_state(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_avrcp_ctrl_conn_state *ev = buf;
+
+	if (cbs->connection_state_cb)
+		cbs->connection_state_cb(ev->state,
+						(bt_bdaddr_t *) (ev->bdaddr));
+}
+
+static void handle_passthrough_rsp(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_avrcp_ctrl_passthrough_rsp *ev = buf;
+
+	if (cbs->passthrough_rsp_cb)
+		cbs->passthrough_rsp_cb(ev->id, ev->key_state);
+}
+
+/*
+ * handlers will be called from notification thread context,
+ * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
+ */
+static const struct hal_ipc_handler ev_handlers[] = {
+	/* HAL_EV_AVRCP_CTRL_CONN_STATE */
+	{ handle_connection_state, false,
+			sizeof(struct hal_ev_avrcp_ctrl_conn_state) },
+	/* HAL_EV_AVRCP_CTRL_PASSTHROUGH_RSP */
+	{ handle_passthrough_rsp, false,
+			sizeof(struct hal_ev_avrcp_ctrl_passthrough_rsp) },
+};
+
+static bt_status_t init(btrc_ctrl_callbacks_t *callbacks)
+{
+	struct hal_cmd_register_module cmd;
+	int ret;
+
+	DBG("");
+
+	if (interface_ready())
+		return BT_STATUS_DONE;
+
+	cbs = callbacks;
+
+	hal_ipc_register(HAL_SERVICE_ID_AVRCP_CTRL, ev_handlers,
+				sizeof(ev_handlers) / sizeof(ev_handlers[0]));
+
+	cmd.service_id = HAL_SERVICE_ID_AVRCP_CTRL;
+	cmd.mode = HAL_MODE_DEFAULT;
+
+	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+
+	if (ret != BT_STATUS_SUCCESS) {
+		cbs = NULL;
+		hal_ipc_unregister(HAL_SERVICE_ID_AVRCP_CTRL);
+	}
+
+	return ret;
+}
+
+static bt_status_t send_pass_through_cmd(bt_bdaddr_t *bd_addr, uint8_t key_code,
+							uint8_t key_state)
+{
+	struct hal_cmd_avrcp_ctrl_send_passthrough cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+	cmd.key_code = key_code;
+	cmd.key_state = key_state;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP_CTRL,
+					HAL_OP_AVRCP_CTRL_SEND_PASSTHROUGH,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+}
+
+static void cleanup(void)
+{
+	struct hal_cmd_unregister_module cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return;
+
+	cbs = NULL;
+
+	cmd.service_id = HAL_SERVICE_ID_AVRCP_CTRL;
+
+	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+
+	hal_ipc_unregister(HAL_SERVICE_ID_AVRCP_CTRL);
+}
+
+static btrc_ctrl_interface_t iface = {
+	.size = sizeof(iface),
+	.init = init,
+	.send_pass_through_cmd = send_pass_through_cmd,
+	.cleanup = cleanup
+};
+
+btrc_ctrl_interface_t *bt_get_avrcp_ctrl_interface(void)
+{
+	return &iface;
+}
diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index b9b8ab9..6c7f195 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -29,10 +29,6 @@
 
 static const btrc_callbacks_t *cbs = NULL;
 
-#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
-static const btrc_ctrl_callbacks_t *ctrl_cbs = NULL;
-#endif
-
 static bool interface_ready(void)
 {
 	return cbs != NULL;
@@ -690,120 +686,3 @@ btrc_interface_t *bt_get_avrcp_interface(void)
 {
 	return &iface;
 }
-
-#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
-
-static bool ctrl_interface_ready(void)
-{
-	return ctrl_cbs != NULL;
-}
-
-static void handle_connection_state(void *buf, uint16_t len, int fd)
-{
-	struct hal_ev_avrcp_ctrl_conn_state *ev = buf;
-
-	if (ctrl_cbs->connection_state_cb)
-		ctrl_cbs->connection_state_cb(ev->state,
-						(bt_bdaddr_t *) (ev->bdaddr));
-}
-
-static void handle_passthrough_rsp(void *buf, uint16_t len, int fd)
-{
-	struct hal_ev_avrcp_ctrl_passthrough_rsp *ev = buf;
-
-	if (ctrl_cbs->passthrough_rsp_cb)
-		ctrl_cbs->passthrough_rsp_cb(ev->id, ev->key_state);
-}
-
-/*
- * handlers will be called from notification thread context,
- * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
- */
-static const struct hal_ipc_handler ctrl_ev_handlers[] = {
-	/* HAL_EV_AVRCP_CTRL_CONN_STATE */
-	{ handle_connection_state, false,
-			sizeof(struct hal_ev_avrcp_ctrl_conn_state) },
-	/* HAL_EV_AVRCP_CTRL_PASSTHROUGH_RSP */
-	{ handle_passthrough_rsp, false,
-			sizeof(struct hal_ev_avrcp_ctrl_passthrough_rsp) },
-};
-
-static bt_status_t ctrl_init(btrc_ctrl_callbacks_t *callbacks)
-{
-	struct hal_cmd_register_module cmd;
-	int ret;
-
-	DBG("");
-
-	if (ctrl_interface_ready())
-		return BT_STATUS_DONE;
-
-	ctrl_cbs = callbacks;
-
-	hal_ipc_register(HAL_SERVICE_ID_AVRCP_CTRL, ctrl_ev_handlers,
-			sizeof(ctrl_ev_handlers) / sizeof(ctrl_ev_handlers[0]));
-
-	cmd.service_id = HAL_SERVICE_ID_AVRCP_CTRL;
-	cmd.mode = HAL_MODE_DEFAULT;
-
-	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-					sizeof(cmd), &cmd, NULL, NULL, NULL);
-
-	if (ret != BT_STATUS_SUCCESS) {
-		cbs = NULL;
-		hal_ipc_unregister(HAL_SERVICE_ID_AVRCP_CTRL);
-	}
-
-	return ret;
-}
-
-static bt_status_t send_pass_through_cmd(bt_bdaddr_t *bd_addr, uint8_t key_code,
-							uint8_t key_state)
-{
-	struct hal_cmd_avrcp_ctrl_send_passthrough cmd;
-
-	DBG("");
-
-	if (!ctrl_interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
-	cmd.key_code = key_code;
-	cmd.key_state = key_state;
-
-	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP_CTRL,
-					HAL_OP_AVRCP_CTRL_SEND_PASSTHROUGH,
-					sizeof(cmd), &cmd, NULL, NULL, NULL);
-}
-
-static void ctrl_cleanup(void)
-{
-	struct hal_cmd_unregister_module cmd;
-
-	DBG("");
-
-	if (!ctrl_interface_ready())
-		return;
-
-	ctrl_cbs = NULL;
-
-	cmd.service_id = HAL_SERVICE_ID_AVRCP_CTRL;
-
-	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
-					sizeof(cmd), &cmd, NULL, NULL, NULL);
-
-	hal_ipc_unregister(HAL_SERVICE_ID_AVRCP_CTRL);
-}
-
-static btrc_ctrl_interface_t ctrl_iface = {
-	.size = sizeof(ctrl_iface),
-	.init = ctrl_init,
-	.send_pass_through_cmd = send_pass_through_cmd,
-	.cleanup = ctrl_cleanup
-};
-
-btrc_ctrl_interface_t *bt_get_avrcp_ctrl_interface(void)
-{
-	return &ctrl_iface;
-}
-#endif
-- 
2.1.0


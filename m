Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 3/5] android/hal-avrcp: Add suuport for new AVRCP ctrl interface
Date: Mon, 10 Nov 2014 16:05:07 +0200
Message-Id: <1415628309-7384-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1415628309-7384-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1415628309-7384-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-avrcp.c     | 122 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-bluetooth.c |   3 ++
 android/hal.h           |   1 +
 3 files changed, 126 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 761ddfb..4202bfa 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -20,6 +20,7 @@
 #include <string.h>
 #include <stdlib.h>
 
+#include "hal-utils.h"
 #include "hal-log.h"
 #include "hal.h"
 #include "hal-msg.h"
@@ -28,6 +29,10 @@
 
 static const btrc_callbacks_t *cbs = NULL;
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static const btrc_ctrl_callbacks_t *ctrl_cbs = NULL;
+#endif
+
 static bool interface_ready(void)
 {
 	return cbs != NULL;
@@ -684,3 +689,120 @@ btrc_interface_t *bt_get_avrcp_interface(void)
 {
 	return &iface;
 }
+
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+
+static bool ctrl_interface_ready(void)
+{
+	return ctrl_cbs != NULL;
+}
+
+static void handle_connection_state(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_avrcp_ctrl_conn_state *ev = buf;
+
+	if (ctrl_cbs->connection_state_cb)
+		ctrl_cbs->connection_state_cb(ev->state,
+						(bt_bdaddr_t *) (ev->bdaddr));
+}
+
+static void handle_passthrough_rsp(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_avrcp_ctrl_passthrough_rsp *ev = buf;
+
+	if (ctrl_cbs->passthrough_rsp_cb)
+		ctrl_cbs->passthrough_rsp_cb(ev->id, ev->key_state);
+}
+
+/*
+ * handlers will be called from notification thread context,
+ * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
+ */
+static const struct hal_ipc_handler ctrl_ev_handlers[] = {
+	/* HAL_EV_AVRCP_CTRL_CONN_STATE */
+	{ handle_connection_state, false,
+			sizeof(struct hal_ev_avrcp_ctrl_conn_state) },
+	/* HAL_EV_AVRCP_CTRL_PASSTHROUGH_RSP */
+	{ handle_passthrough_rsp, false,
+			sizeof(struct hal_ev_avrcp_ctrl_passthrough_rsp) },
+};
+
+static bt_status_t ctrl_init(btrc_ctrl_callbacks_t *callbacks)
+{
+	struct hal_cmd_register_module cmd;
+	int ret;
+
+	DBG("");
+
+	if (ctrl_interface_ready())
+		return BT_STATUS_DONE;
+
+	ctrl_cbs = callbacks;
+
+	hal_ipc_register(HAL_SERVICE_ID_AVRCP_CTRL, ctrl_ev_handlers,
+			sizeof(ctrl_ev_handlers) / sizeof(ctrl_ev_handlers[0]));
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
+	if (!ctrl_interface_ready())
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
+static void ctrl_cleanup(void)
+{
+	struct hal_cmd_unregister_module cmd;
+
+	DBG("");
+
+	if (!ctrl_interface_ready())
+		return;
+
+	ctrl_cbs = NULL;
+
+	cmd.service_id = HAL_SERVICE_ID_AVRCP_CTRL;
+
+	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+
+	hal_ipc_unregister(HAL_SERVICE_ID_AVRCP_CTRL);
+}
+
+static btrc_ctrl_interface_t ctrl_iface = {
+	.size = sizeof(ctrl_iface),
+	.init = ctrl_init,
+	.send_pass_through_cmd = send_pass_through_cmd,
+	.cleanup = ctrl_cleanup
+};
+
+btrc_ctrl_interface_t *bt_get_avrcp_ctrl_interface(void)
+{
+	return &ctrl_iface;
+}
+#endif
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 9b5ce16..164e232 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -866,6 +866,9 @@ static const void *get_profile_interface(const char *profile_id)
 		return bt_get_health_interface();
 
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	if (!strcmp(profile_id, BT_PROFILE_AV_RC_CTRL_ID))
+		return bt_get_avrcp_ctrl_interface();
+
 	if (!strcmp(profile_id, BT_PROFILE_HANDSFREE_CLIENT_ID))
 		return bt_get_hf_client_interface();
 
diff --git a/android/hal.h b/android/hal.h
index 76555a0..9e29dff 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -44,6 +44,7 @@ btgatt_interface_t *bt_get_gatt_interface(void);
 bthl_interface_t *bt_get_health_interface(void);
 
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+btrc_ctrl_interface_t *bt_get_avrcp_ctrl_interface(void);
 bthf_client_interface_t *bt_get_hf_client_interface(void);
 btmce_interface_t *bt_get_map_client_interface(void);
 #endif
-- 
2.1.0


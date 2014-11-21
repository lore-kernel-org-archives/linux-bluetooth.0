Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/4] android/hal: Add HAL for A2DP Sink role
Date: Fri, 21 Nov 2014 16:13:53 +0100
Message-Id: <1416582835-7712-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416582835-7712-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416582835-7712-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This role was introduced with some devices in Android 5. The same set
of IPC structs and defines is used as in Sink as it uses the same HAL
API as Source does, but just yet another instance of HAL.
---
 android/Android.mk      |   1 +
 android/Makefile.am     |   1 +
 android/hal-a2dp-sink.c | 163 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-bluetooth.c |   3 +
 android/hal-msg.h       |  12 +++-
 android/hal.h           |   1 +
 6 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100644 android/hal-a2dp-sink.c

diff --git a/android/Android.mk b/android/Android.mk
index adc5255..70dbc42 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -138,6 +138,7 @@ ifeq ($(ANDROID_GE_5_0_0), 1)
 LOCAL_SRC_FILES += \
 	bluez/android/hal-handsfree-client.c \
 	bluez/android/hal-map-client.c \
+	bluez/android/hal-a2dp-sink.c \
 	bluez/android/hal-avrcp-ctrl.c
 endif
 
diff --git a/android/Makefile.am b/android/Makefile.am
index 3787489..58fe81a 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -64,6 +64,7 @@ android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hal-health.c \
 					android/hal-pan.c \
 					android/hal-a2dp.c \
+					android/hal-a2dp-sink.c \
 					android/hal-avrcp.c \
 					android/hal-avrcp-ctrl.c \
 					android/hal-handsfree.c \
diff --git a/android/hal-a2dp-sink.c b/android/hal-a2dp-sink.c
new file mode 100644
index 0000000..001b022
--- /dev/null
+++ b/android/hal-a2dp-sink.c
@@ -0,0 +1,163 @@
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
+static void handle_conn_state(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_a2dp_conn_state *ev = buf;
+
+	if (cbs->connection_state_cb)
+		cbs->connection_state_cb(ev->state,
+						(bt_bdaddr_t *) (ev->bdaddr));
+}
+
+static void handle_audio_state(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_a2dp_audio_state *ev = buf;
+
+	if (cbs->audio_state_cb)
+		cbs->audio_state_cb(ev->state, (bt_bdaddr_t *)(ev->bdaddr));
+}
+
+static void handle_audio_config(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_a2dp_audio_config *ev = buf;
+
+	if (cbs->audio_config_cb)
+		cbs->audio_config_cb((bt_bdaddr_t *)(ev->bdaddr),
+					ev->sample_rate, ev->channel_count);
+}
+
+/*
+ * handlers will be called from notification thread context,
+ * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
+ */
+static const struct hal_ipc_handler ev_handlers[] = {
+	/* HAL_EV_A2DP_CONN_STATE */
+	{ handle_conn_state, false, sizeof(struct hal_ev_a2dp_conn_state) },
+	/* HAL_EV_A2DP_AUDIO_STATE */
+	{ handle_audio_state, false, sizeof(struct hal_ev_a2dp_audio_state) },
+	/* HAL_EV_A2DP_AUDIO_CONFIG */
+	{ handle_audio_config, false, sizeof(struct hal_ev_a2dp_audio_config) },
+};
+
+static bt_status_t a2dp_connect(bt_bdaddr_t *bd_addr)
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
+	return hal_ipc_cmd(HAL_SERVICE_ID_A2DP_SINK, HAL_OP_A2DP_CONNECT,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+}
+
+static bt_status_t disconnect(bt_bdaddr_t *bd_addr)
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
+	return hal_ipc_cmd(HAL_SERVICE_ID_A2DP_SINK, HAL_OP_A2DP_DISCONNECT,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+}
+
+static bt_status_t init(btav_callbacks_t *callbacks)
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
+	hal_ipc_register(HAL_SERVICE_ID_A2DP_SINK, ev_handlers,
+				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
+
+	cmd.service_id = HAL_SERVICE_ID_A2DP_SINK;
+	cmd.mode = HAL_MODE_DEFAULT;
+	cmd.max_clients = 1;
+
+	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+
+	if (ret != BT_STATUS_SUCCESS) {
+		cbs = NULL;
+		hal_ipc_unregister(HAL_SERVICE_ID_A2DP_SINK);
+	}
+
+	return ret;
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
+	cmd.service_id = HAL_SERVICE_ID_A2DP_SINK;
+
+	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+
+	hal_ipc_unregister(HAL_SERVICE_ID_A2DP_SINK);
+}
+
+static btav_interface_t iface = {
+	.size = sizeof(iface),
+	.init = init,
+	.connect = a2dp_connect,
+	.disconnect = disconnect,
+	.cleanup = cleanup
+};
+
+btav_interface_t *bt_get_a2dp_sink_interface(void)
+{
+	return &iface;
+}
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 68811df..5d77c34 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -876,6 +876,9 @@ static const void *get_profile_interface(const char *profile_id)
 
 	if (!strcmp(profile_id, BT_PROFILE_MAP_CLIENT_ID))
 		return bt_get_map_client_interface();
+
+	if (!strcmp(profile_id, BT_PROFILE_ADVANCED_AUDIO_SINK_ID))
+		return bt_get_a2dp_sink_interface();
 #endif
 
 	return NULL;
diff --git a/android/hal-msg.h b/android/hal-msg.h
index ca512d4..5396404 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -38,8 +38,9 @@ static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
 #define HAL_SERVICE_ID_HANDSFREE_CLIENT	10
 #define HAL_SERVICE_ID_MAP_CLIENT	11
 #define HAL_SERVICE_ID_AVRCP_CTRL	12
+#define HAL_SERVICE_ID_A2DP_SINK	13
 
-#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_AVRCP_CTRL
+#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_A2DP_SINK
 
 /* Core Service */
 
@@ -352,7 +353,7 @@ struct hal_cmd_hidhost_send_data {
 	uint8_t  data[0];
 } __attribute__((packed));
 
-/* a2dp HAL API */
+/* a2dp source and sink HAL API */
 
 #define HAL_OP_A2DP_CONNECT	0x01
 struct hal_cmd_a2dp_connect {
@@ -1482,6 +1483,13 @@ struct hal_ev_a2dp_audio_state {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+#define HAL_EV_A2DP_AUDIO_CONFIG		0x83
+struct hal_ev_a2dp_audio_config {
+	uint8_t  bdaddr[6];
+	uint32_t sample_rate;
+	uint8_t  channel_count;
+} __attribute__((packed));
+
 #define HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED	0x00
 #define HAL_EV_HANDSFREE_CONN_STATE_CONNECTING		0x01
 #define HAL_EV_HANDSFREE_CONN_STATE_CONNECTED		0x02
diff --git a/android/hal.h b/android/hal.h
index 9e29dff..709c197 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -47,6 +47,7 @@ bthl_interface_t *bt_get_health_interface(void);
 btrc_ctrl_interface_t *bt_get_avrcp_ctrl_interface(void);
 bthf_client_interface_t *bt_get_hf_client_interface(void);
 btmce_interface_t *bt_get_map_client_interface(void);
+btav_interface_t *bt_get_a2dp_sink_interface(void);
 #endif
 
 void bt_thread_associate(void);
-- 
1.9.1


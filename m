Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/8]  android: Add initial skeleton for AVRCP in the HAL
Date: Sun, 26 Jan 2014 15:55:42 -0800
Message-Id: <1390780546-18402-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390780546-18402-1-git-send-email-luiz.dentz@gmail.com>
References: <1390780546-18402-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/Android.mk      |  1 +
 android/Makefile.am     |  1 +
 android/hal-avrcp.c     | 87 +++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-bluetooth.c |  3 ++
 android/hal.h           |  2 ++
 5 files changed, 94 insertions(+)
 create mode 100644 android/hal-avrcp.c

diff --git a/android/Android.mk b/android/Android.mk
index 169eba8..0bd8b91 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -98,6 +98,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/hal-hidhost.c \
 	bluez/android/hal-pan.c \
 	bluez/android/hal-a2dp.c \
+	bluez/android/hal-avrcp.c \
 	bluez/android/hal-utils.c \
 
 LOCAL_C_INCLUDES += \
diff --git a/android/Makefile.am b/android/Makefile.am
index d4a76bb..664524f 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -50,6 +50,7 @@ android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hal-hidhost.c \
 					android/hal-pan.c \
 					android/hal-a2dp.c \
+					android/hal-avrcp.c \
 					android/hardware/bluetooth.h \
 					android/hardware/bt_av.h \
 					android/hardware/bt_gatt.h \
diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
new file mode 100644
index 0000000..01d233b
--- /dev/null
+++ b/android/hal-avrcp.c
@@ -0,0 +1,87 @@
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
+static const btrc_callbacks_t *cbs = NULL;
+
+static bool interface_ready(void)
+{
+	return cbs != NULL;
+}
+
+static bt_status_t init(btrc_callbacks_t *callbacks)
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
+	cmd.service_id = HAL_SERVICE_ID_AVRCP;
+
+	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+
+	if (ret != BT_STATUS_SUCCESS) {
+		cbs = NULL;
+		hal_ipc_unregister(HAL_SERVICE_ID_AVRCP);
+	}
+
+	return ret;
+}
+
+static void cleanup()
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
+	cmd.service_id = HAL_SERVICE_ID_AVRCP;
+
+	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+
+	hal_ipc_unregister(HAL_SERVICE_ID_AVRCP);
+}
+
+static btrc_interface_t iface = {
+	.size = sizeof(iface),
+	.init = init,
+	.cleanup = cleanup
+};
+
+btrc_interface_t *bt_get_avrcp_interface()
+{
+	return &iface;
+}
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 4f0e7b7..0dac158 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -762,6 +762,9 @@ static const void *get_profile_interface(const char *profile_id)
 	if (!strcmp(profile_id, BT_PROFILE_ADVANCED_AUDIO_ID))
 		return bt_get_a2dp_interface();
 
+	if (!strcmp(profile_id, BT_PROFILE_AV_RC_ID))
+		return bt_get_avrcp_interface();
+
 	return NULL;
 }
 
diff --git a/android/hal.h b/android/hal.h
index b475411..1ff4fbd 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -20,11 +20,13 @@
 #include <hardware/bt_hh.h>
 #include <hardware/bt_pan.h>
 #include <hardware/bt_av.h>
+#include <hardware/bt_rc.h>
 
 btsock_interface_t *bt_get_sock_interface(void);
 bthh_interface_t *bt_get_hidhost_interface(void);
 btpan_interface_t *bt_get_pan_interface(void);
 btav_interface_t *bt_get_a2dp_interface(void);
+btrc_interface_t *bt_get_avrcp_interface(void);
 
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
-- 
1.8.4.2


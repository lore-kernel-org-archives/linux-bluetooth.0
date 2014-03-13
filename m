Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 07/15] android/hal-health: Add hal-health.c with initial get interface call
Date: Thu, 13 Mar 2014 13:58:44 +0200
Message-Id: <1394711932-16560-8-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394711932-16560-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394711932-16560-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Android.mk      |  1 +
 android/Makefile.am     |  1 +
 android/hal-bluetooth.c |  3 +++
 android/hal-health.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 android/hal.h           |  2 ++
 5 files changed, 49 insertions(+)
 create mode 100644 android/hal-health.c

diff --git a/android/Android.mk b/android/Android.mk
index 49bf108..0352beb 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -121,6 +121,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/hal-handsfree.c \
 	bluez/android/hal-gatt.c \
 	bluez/android/hal-utils.c \
+	bluez/android/hal-health.c \
 
 LOCAL_C_INCLUDES += \
 	$(call include-path-for, system-core) \
diff --git a/android/Makefile.am b/android/Makefile.am
index bbd3d2f..d2cfed6 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -52,6 +52,7 @@ plugin_LTLIBRARIES += android/bluetooth.default.la
 android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hal-socket.c \
 					android/hal-hidhost.c \
+					android/hal-health.c \
 					android/hal-pan.c \
 					android/hal-a2dp.c \
 					android/hal-avrcp.c \
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 2bc089e..fcf02f6 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -777,6 +777,9 @@ static const void *get_profile_interface(const char *profile_id)
 	if (!strcmp(profile_id, BT_PROFILE_GATT_ID))
 		return bt_get_gatt_interface();
 
+	if (!strcmp(profile_id, BT_PROFILE_HEALTH_ID))
+		return bt_get_health_interface();
+
 	return NULL;
 }
 
diff --git a/android/hal-health.c b/android/hal-health.c
new file mode 100644
index 0000000..59f8cca
--- /dev/null
+++ b/android/hal-health.c
@@ -0,0 +1,42 @@
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
+#include "hal-log.h"
+#include "hal.h"
+#include "hal-msg.h"
+#include "ipc-common.h"
+#include "hal-ipc.h"
+
+static bthl_interface_t health_if = {
+	.size = sizeof(health_if),
+	.init = NULL,
+	.register_application = NULL,
+	.unregister_application = NULL,
+	.connect_channel = NULL,
+	.destroy_channel = NULL,
+	.cleanup = NULL
+};
+
+bthl_interface_t *bt_get_health_interface(void)
+{
+	return &health_if;
+}
diff --git a/android/hal.h b/android/hal.h
index b1c0216..6998e9a 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -25,6 +25,7 @@
 #include <hardware/bt_gatt.h>
 #include <hardware/bt_gatt_client.h>
 #include <hardware/bt_gatt_server.h>
+#include <hardware/bt_hl.h>
 
 btsock_interface_t *bt_get_socket_interface(void);
 bthh_interface_t *bt_get_hidhost_interface(void);
@@ -33,6 +34,7 @@ btav_interface_t *bt_get_a2dp_interface(void);
 btrc_interface_t *bt_get_avrcp_interface(void);
 bthf_interface_t *bt_get_handsfree_interface(void);
 btgatt_interface_t *bt_get_gatt_interface(void);
+bthl_interface_t *bt_get_health_interface(void);
 
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
-- 
1.8.3.2


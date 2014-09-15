Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 04/15] android/handsfree-client: Add handsfree-client HAL skeleton
Date: Mon, 15 Sep 2014 13:51:17 +0200
Message-Id: <1410781888-1952-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch also introduce BLUEZ_EXTENSIONS flag which is used for not
Android AOSP features like HF Client in this case.

Idea is that BfA for PC is always build with this flag and it is added
to Makefile.am

For Android there is need to set this flag as described in README
---
 android/Android.mk             |   8 ++++
 android/Makefile.am            |   4 +-
 android/hal-bluetooth.c        |   5 ++
 android/hal-handsfree-client.c | 101 +++++++++++++++++++++++++++++++++++++++++
 android/hal.h                  |   8 ++++
 5 files changed, 125 insertions(+), 1 deletion(-)
 create mode 100644 android/hal-handsfree-client.c

diff --git a/android/Android.mk b/android/Android.mk
index aae426d..4a14474 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -129,6 +129,10 @@ LOCAL_SRC_FILES := \
 	bluez/android/hal-utils.c \
 	bluez/android/hal-health.c \
 
+ifeq ($(BLUEZ_EXTENSIONS), true)
+LOCAL_SRC_FILES += bluez/android/hal-handsfree-client.c
+endif
+
 LOCAL_C_INCLUDES += \
 	$(call include-path-for, system-core) \
 	$(call include-path-for, libhardware) \
@@ -138,6 +142,10 @@ LOCAL_SHARED_LIBRARIES := \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
+ifeq ($(BLUEZ_EXTENSIONS), true)
+LOCAL_CFLAGS += -DBLUEZ_EXTENSIONS
+endif
+
 LOCAL_MODULE := bluetooth.default
 LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
 LOCAL_MODULE_TAGS := optional
diff --git a/android/Makefile.am b/android/Makefile.am
index 70b9c3a..b576fda 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -75,6 +75,7 @@ android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hal-a2dp.c \
 					android/hal-avrcp.c \
 					android/hal-handsfree.c \
+					android/hal-handsfree-client.c \
 					android/hal-gatt.c \
 					android/hardware/bluetooth.h \
 					android/hardware/bt_av.h \
@@ -88,6 +89,7 @@ android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hardware/bt_pan.h \
 					android/hardware/bt_rc.h \
 					android/hardware/bt_sock.h \
+					android/hardware/bt_hf_client.h \
 					android/hardware/hardware.h \
 					android/cutils/properties.h \
 					android/ipc-common.h \
@@ -95,7 +97,7 @@ android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hal-ipc.h android/hal-ipc.c \
 					android/hal-utils.h android/hal-utils.c
 
-android_bluetooth_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
+android_bluetooth_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android -DBLUEZ_EXTENSIONS
 android_bluetooth_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
 					-no-undefined
 
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 44eddbd..7c8c2ee 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -783,6 +783,11 @@ static const void *get_profile_interface(const char *profile_id)
 	if (!strcmp(profile_id, BT_PROFILE_HEALTH_ID))
 		return bt_get_health_interface();
 
+#if BLUEZ_EXTENSIONS
+	if (!strcmp(profile_id, BT_PROFILE_HANDSFREE_CLIENT_ID))
+		return bt_get_hf_client_interface();
+#endif
+
 	return NULL;
 }
 
diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
new file mode 100644
index 0000000..9422e0f
--- /dev/null
+++ b/android/hal-handsfree-client.c
@@ -0,0 +1,101 @@
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
+#include <cutils/properties.h>
+
+#include "hal-log.h"
+#include "hal.h"
+#include "hal-msg.h"
+#include "ipc-common.h"
+#include "hal-ipc.h"
+
+static const bthf_client_callbacks_t *cbs = NULL;
+
+static bool interface_ready(void)
+{
+	return cbs != NULL;
+}
+
+/*
+ * handlers will be called from notification thread context,
+ * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
+ */
+static const struct hal_ipc_handler ev_handlers[] = {
+};
+
+static bt_status_t init(bthf_client_callbacks_t *callbacks)
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
+	hal_ipc_register(HAL_SERVICE_ID_HANDSFREE_CLIENT, ev_handlers,
+				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
+
+	cmd.service_id = HAL_SERVICE_ID_HANDSFREE_CLIENT;
+
+	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+
+	if (ret != BT_STATUS_SUCCESS) {
+		cbs = NULL;
+		hal_ipc_unregister(HAL_SERVICE_ID_HANDSFREE_CLIENT);
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
+	cmd.service_id = HAL_SERVICE_ID_HANDSFREE_CLIENT;
+
+	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+
+	hal_ipc_unregister(HAL_SERVICE_ID_HANDSFREE_CLIENT);
+}
+
+static bthf_client_interface_t iface = {
+	.size = sizeof(iface),
+	.init = init,
+	.cleanup = cleanup
+};
+
+bthf_client_interface_t *bt_get_hf_client_interface(void)
+{
+	return &iface;
+}
diff --git a/android/hal.h b/android/hal.h
index 6998e9a..c34022d 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -27,6 +27,10 @@
 #include <hardware/bt_gatt_server.h>
 #include <hardware/bt_hl.h>
 
+#ifdef BLUEZ_EXTENSIONS
+#include <hardware/bt_hf_client.h>
+#endif
+
 btsock_interface_t *bt_get_socket_interface(void);
 bthh_interface_t *bt_get_hidhost_interface(void);
 btpan_interface_t *bt_get_pan_interface(void);
@@ -36,5 +40,9 @@ bthf_interface_t *bt_get_handsfree_interface(void);
 btgatt_interface_t *bt_get_gatt_interface(void);
 bthl_interface_t *bt_get_health_interface(void);
 
+#ifdef BLUEZ_EXTENSIONS
+bthf_client_interface_t *bt_get_hf_client_interface(void);
+#endif
+
 void bt_thread_associate(void);
 void bt_thread_disassociate(void);
-- 
1.8.4


Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 08/11] android: Rename hal_bluetooth.c to hal-bluetooth.c
Date: Wed, 16 Oct 2013 17:36:35 +0300
Message-Id: <1381934198-7955-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381934198-7955-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381934198-7955-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/Android.mk      |    2 +-
 android/hal-bluetooth.c |  384 +++++++++++++++++++++++++++++++++++++++++++++++
 android/hal_bluetooth.c |  384 -----------------------------------------------
 3 files changed, 385 insertions(+), 385 deletions(-)
 create mode 100644 android/hal-bluetooth.c
 delete mode 100644 android/hal_bluetooth.c

diff --git a/android/Android.mk b/android/Android.mk
index 821f1dc..021bb91 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -51,7 +51,7 @@ include $(BUILD_EXECUTABLE)
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
-	hal_bluetooth.c \
+	hal-bluetooth.c \
 	hal_bt_sock.c \
 
 LOCAL_SHARED_LIBRARIES := \
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
new file mode 100644
index 0000000..89b8ebb
--- /dev/null
+++ b/android/hal-bluetooth.c
@@ -0,0 +1,384 @@
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdbool.h>
+
+#include <hardware/bluetooth.h>
+#include <hardware/bt_sock.h>
+
+#include <cutils/sockets.h>
+#include <cutils/properties.h>
+
+#define LOG_TAG "BlueZ"
+#include <cutils/log.h>
+
+#include "hal.h"
+
+#define SERVICE_NAME "bluetoothd"
+
+bt_callbacks_t *bt_hal_cbacks = NULL;
+
+static bool interface_ready(void)
+{
+	return bt_hal_cbacks != NULL;
+}
+
+static bool start_bt_daemon(void)
+{
+	int tries = 40; /* wait 4 seconds for completion */
+
+	ALOGD(__func__);
+
+	/* Start Android Bluetooth daemon service */
+	property_set("ctl.start", SERVICE_NAME);
+
+	while (tries-- > 0) {
+		char val[PROPERTY_VALUE_MAX];
+
+		if (property_get("init.svc." SERVICE_NAME, val, NULL)) {
+			if (!strcmp(val, "running")) {
+				ALOGI("Android BlueZ daemon started");
+				return true;
+			}
+		} else {
+			return false;
+		}
+
+		usleep(100000);
+	}
+
+	return false;
+}
+
+static int init(bt_callbacks_t *callbacks)
+{
+	ALOGD(__func__);
+
+	if (interface_ready())
+		return BT_STATUS_SUCCESS;
+
+	if (start_bt_daemon()) {
+		/* TODO: open channel */
+
+		bt_hal_cbacks = callbacks;
+
+		return BT_STATUS_SUCCESS;
+	}
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int enable(void)
+{
+	ALOGD(__func__);
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int disable(void)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static void cleanup(void)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return;
+
+	bt_hal_cbacks = NULL;
+}
+
+static int get_adapter_properties(void)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int get_adapter_property(bt_property_type_t type)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int set_adapter_property(const bt_property_t *property)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (property == NULL)
+		return BT_STATUS_PARM_INVALID;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int get_remote_device_property(bt_bdaddr_t *remote_addr,
+						bt_property_type_t type)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int set_remote_device_property(bt_bdaddr_t *remote_addr,
+						const bt_property_t *property)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int get_remote_services(bt_bdaddr_t *remote_addr)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int start_discovery(void)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int cancel_discovery(void)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int create_bond(const bt_bdaddr_t *bd_addr)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int cancel_bond(const bt_bdaddr_t *bd_addr)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int remove_bond(const bt_bdaddr_t *bd_addr)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
+				uint8_t pin_len, bt_pin_code_t *pin_code)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
+					uint8_t accept, uint32_t passkey)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static const void *get_profile_interface(const char *profile_id)
+{
+	ALOGD("%s: %s", __func__, profile_id);
+
+	if (!interface_ready())
+		return NULL;
+
+	if (!strcmp(profile_id, BT_PROFILE_SOCKETS_ID))
+		return bt_get_sock_interface();
+
+	return NULL;
+}
+
+static int dut_mode_configure(uint8_t enable)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t len)
+{
+	ALOGD(__func__);
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static const bt_interface_t bluetooth_if = {
+	.size = sizeof(bt_interface_t),
+	.init = init,
+	.enable = enable,
+	.disable = disable,
+	.cleanup = cleanup,
+	.get_adapter_properties = get_adapter_properties,
+	.get_adapter_property = get_adapter_property,
+	.set_adapter_property = set_adapter_property,
+	.get_remote_device_properties = get_remote_device_properties,
+	.get_remote_device_property = get_remote_device_property,
+	.set_remote_device_property = set_remote_device_property,
+	.get_remote_service_record = get_remote_service_record,
+	.get_remote_services = get_remote_services,
+	.start_discovery = start_discovery,
+	.cancel_discovery = cancel_discovery,
+	.create_bond = create_bond,
+	.remove_bond = remove_bond,
+	.cancel_bond = cancel_bond,
+	.pin_reply = pin_reply,
+	.ssp_reply = ssp_reply,
+	.get_profile_interface = get_profile_interface,
+	.dut_mode_configure = dut_mode_configure,
+	.dut_mode_send = dut_mode_send
+};
+
+static const bt_interface_t *get_bluetooth_interface(void)
+{
+	ALOGD(__func__);
+
+	return &bluetooth_if;
+}
+
+static int close_bluetooth(struct hw_device_t *device)
+{
+	ALOGD(__func__);
+
+	cleanup();
+
+	return 0;
+}
+
+static int open_bluetooth(const struct hw_module_t *module, char const *name,
+					struct hw_device_t **device)
+{
+	bluetooth_device_t *dev = malloc(sizeof(bluetooth_device_t));
+
+	ALOGD(__func__);
+
+	memset(dev, 0, sizeof(bluetooth_device_t));
+	dev->common.tag = HARDWARE_DEVICE_TAG;
+	dev->common.version = 0;
+	dev->common.module = (struct hw_module_t *) module;
+	dev->common.close = close_bluetooth;
+	dev->get_bluetooth_interface = get_bluetooth_interface;
+
+	*device = (struct hw_device_t *) dev;
+
+	return 0;
+}
+
+static struct hw_module_methods_t bluetooth_module_methods = {
+	.open = open_bluetooth,
+};
+
+struct hw_module_t HAL_MODULE_INFO_SYM = {
+	.tag = HARDWARE_MODULE_TAG,
+	.version_major = 1,
+	.version_minor = 0,
+	.id = BT_HARDWARE_MODULE_ID,
+	.name = "BlueZ Bluetooth stack",
+	.author = "Intel Corporation",
+	.methods = &bluetooth_module_methods
+};
diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
deleted file mode 100644
index 89b8ebb..0000000
--- a/android/hal_bluetooth.c
+++ /dev/null
@@ -1,384 +0,0 @@
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
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <stdbool.h>
-
-#include <hardware/bluetooth.h>
-#include <hardware/bt_sock.h>
-
-#include <cutils/sockets.h>
-#include <cutils/properties.h>
-
-#define LOG_TAG "BlueZ"
-#include <cutils/log.h>
-
-#include "hal.h"
-
-#define SERVICE_NAME "bluetoothd"
-
-bt_callbacks_t *bt_hal_cbacks = NULL;
-
-static bool interface_ready(void)
-{
-	return bt_hal_cbacks != NULL;
-}
-
-static bool start_bt_daemon(void)
-{
-	int tries = 40; /* wait 4 seconds for completion */
-
-	ALOGD(__func__);
-
-	/* Start Android Bluetooth daemon service */
-	property_set("ctl.start", SERVICE_NAME);
-
-	while (tries-- > 0) {
-		char val[PROPERTY_VALUE_MAX];
-
-		if (property_get("init.svc." SERVICE_NAME, val, NULL)) {
-			if (!strcmp(val, "running")) {
-				ALOGI("Android BlueZ daemon started");
-				return true;
-			}
-		} else {
-			return false;
-		}
-
-		usleep(100000);
-	}
-
-	return false;
-}
-
-static int init(bt_callbacks_t *callbacks)
-{
-	ALOGD(__func__);
-
-	if (interface_ready())
-		return BT_STATUS_SUCCESS;
-
-	if (start_bt_daemon()) {
-		/* TODO: open channel */
-
-		bt_hal_cbacks = callbacks;
-
-		return BT_STATUS_SUCCESS;
-	}
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int enable(void)
-{
-	ALOGD(__func__);
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int disable(void)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static void cleanup(void)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return;
-
-	bt_hal_cbacks = NULL;
-}
-
-static int get_adapter_properties(void)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int get_adapter_property(bt_property_type_t type)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int set_adapter_property(const bt_property_t *property)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	if (property == NULL)
-		return BT_STATUS_PARM_INVALID;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int get_remote_device_property(bt_bdaddr_t *remote_addr,
-						bt_property_type_t type)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int set_remote_device_property(bt_bdaddr_t *remote_addr,
-						const bt_property_t *property)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int get_remote_services(bt_bdaddr_t *remote_addr)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int start_discovery(void)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int cancel_discovery(void)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int create_bond(const bt_bdaddr_t *bd_addr)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	if (!bd_addr)
-		return BT_STATUS_PARM_INVALID;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int cancel_bond(const bt_bdaddr_t *bd_addr)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int remove_bond(const bt_bdaddr_t *bd_addr)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
-				uint8_t pin_len, bt_pin_code_t *pin_code)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
-					uint8_t accept, uint32_t passkey)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	if (!bd_addr)
-		return BT_STATUS_PARM_INVALID;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static const void *get_profile_interface(const char *profile_id)
-{
-	ALOGD("%s: %s", __func__, profile_id);
-
-	if (!interface_ready())
-		return NULL;
-
-	if (!strcmp(profile_id, BT_PROFILE_SOCKETS_ID))
-		return bt_get_sock_interface();
-
-	return NULL;
-}
-
-static int dut_mode_configure(uint8_t enable)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t len)
-{
-	ALOGD(__func__);
-
-	if (!interface_ready())
-		return BT_STATUS_NOT_READY;
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
-static const bt_interface_t bluetooth_if = {
-	.size = sizeof(bt_interface_t),
-	.init = init,
-	.enable = enable,
-	.disable = disable,
-	.cleanup = cleanup,
-	.get_adapter_properties = get_adapter_properties,
-	.get_adapter_property = get_adapter_property,
-	.set_adapter_property = set_adapter_property,
-	.get_remote_device_properties = get_remote_device_properties,
-	.get_remote_device_property = get_remote_device_property,
-	.set_remote_device_property = set_remote_device_property,
-	.get_remote_service_record = get_remote_service_record,
-	.get_remote_services = get_remote_services,
-	.start_discovery = start_discovery,
-	.cancel_discovery = cancel_discovery,
-	.create_bond = create_bond,
-	.remove_bond = remove_bond,
-	.cancel_bond = cancel_bond,
-	.pin_reply = pin_reply,
-	.ssp_reply = ssp_reply,
-	.get_profile_interface = get_profile_interface,
-	.dut_mode_configure = dut_mode_configure,
-	.dut_mode_send = dut_mode_send
-};
-
-static const bt_interface_t *get_bluetooth_interface(void)
-{
-	ALOGD(__func__);
-
-	return &bluetooth_if;
-}
-
-static int close_bluetooth(struct hw_device_t *device)
-{
-	ALOGD(__func__);
-
-	cleanup();
-
-	return 0;
-}
-
-static int open_bluetooth(const struct hw_module_t *module, char const *name,
-					struct hw_device_t **device)
-{
-	bluetooth_device_t *dev = malloc(sizeof(bluetooth_device_t));
-
-	ALOGD(__func__);
-
-	memset(dev, 0, sizeof(bluetooth_device_t));
-	dev->common.tag = HARDWARE_DEVICE_TAG;
-	dev->common.version = 0;
-	dev->common.module = (struct hw_module_t *) module;
-	dev->common.close = close_bluetooth;
-	dev->get_bluetooth_interface = get_bluetooth_interface;
-
-	*device = (struct hw_device_t *) dev;
-
-	return 0;
-}
-
-static struct hw_module_methods_t bluetooth_module_methods = {
-	.open = open_bluetooth,
-};
-
-struct hw_module_t HAL_MODULE_INFO_SYM = {
-	.tag = HARDWARE_MODULE_TAG,
-	.version_major = 1,
-	.version_minor = 0,
-	.id = BT_HARDWARE_MODULE_ID,
-	.name = "BlueZ Bluetooth stack",
-	.author = "Intel Corporation",
-	.methods = &bluetooth_module_methods
-};
-- 
1.7.10.4


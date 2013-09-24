Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] android: Add Adapter Bluetooth HAL template
Date: Tue, 24 Sep 2013 11:31:55 +0300
Message-Id: <1380011516-7847-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380011516-7847-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380011516-7847-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add template for bluetooth.h Android HAL.
---
 android/Android.mk      |   19 +++
 android/hal_bluetooth.c |  367 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 386 insertions(+)
 create mode 100644 android/hal_bluetooth.c

diff --git a/android/Android.mk b/android/Android.mk
index 5d09f00..ca9501f 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -23,3 +23,22 @@ LOCAL_SHARED_LIBRARIES := \
 LOCAL_MODULE := bluezd
 
 include $(BUILD_EXECUTABLE)
+
+#
+# bluetooth.default.so HAL
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	hal_bluetooth.c \
+
+LOCAL_SHARED_LIBRARIES := \
+	libcutils \
+
+LOCAL_MODULE := bluetooth.default
+LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
+LOCAL_MODULE_TAGS := optional
+LOCAL_MODULE_CLASS := SHARED_LIBRARIES
+
+include $(BUILD_SHARED_LIBRARY)
diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
new file mode 100644
index 0000000..4447bed
--- /dev/null
+++ b/android/hal_bluetooth.c
@@ -0,0 +1,367 @@
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
+
+#define LOG_TAG "BlueZ"
+#include <cutils/log.h>
+
+bt_callbacks_t *bt_hal_cbacks = NULL;
+
+static bool interface_ready(void)
+{
+	return bt_hal_cbacks != NULL;
+}
+
+static int init(bt_callbacks_t *callbacks)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == true)
+		return BT_STATUS_SUCCESS;
+
+	/* store reference to user callbacks */
+	bt_hal_cbacks = callbacks;
+
+	/* TODO: Init here bluezd task */
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int enable(void)
+{
+	ALOGI(__func__);
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int disable(void)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static void cleanup(void)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return;
+
+	bt_hal_cbacks = NULL;
+}
+
+static int get_adapter_properties(void)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int get_adapter_property(bt_property_type_t type)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int set_adapter_property(const bt_property_t *property)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	if (property == NULL)
+		return BT_STATUS_PARM_INVALID;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+int get_remote_device_properties(bt_bdaddr_t *remote_addr)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+int get_remote_device_property(bt_bdaddr_t *remote_addr,
+						bt_property_type_t type)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+int set_remote_device_property(bt_bdaddr_t *remote_addr,
+						const bt_property_t *property)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+int get_remote_services(bt_bdaddr_t *remote_addr)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int start_discovery(void)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int cancel_discovery(void)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int create_bond(const bt_bdaddr_t *bd_addr)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	if (bd_addr == NULL)
+		return BT_STATUS_PARM_INVALID;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int cancel_bond(const bt_bdaddr_t *bd_addr)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int remove_bond(const bt_bdaddr_t *bd_addr)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
+				uint8_t pin_len, bt_pin_code_t *pin_code)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
+					uint8_t accept, uint32_t passkey)
+{
+
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	if (bd_addr == NULL)
+		return BT_STATUS_PARM_INVALID;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static const void *get_profile_interface(const char *profile_id)
+{
+	ALOGI("%s: %s", __func__, profile_id);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return NULL;
+
+	return NULL;
+}
+
+int dut_mode_configure(uint8_t enable)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t len)
+{
+	ALOGI(__func__);
+
+	/* sanity check */
+	if (interface_ready() == false)
+		return BT_STATUS_NOT_READY;
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+/**
+ * HAL Interface declaration
+ */
+static const bt_interface_t bluetoothInterface = {
+	sizeof(bt_interface_t),
+	init,
+	enable,
+	disable,
+	cleanup,
+	get_adapter_properties,
+	get_adapter_property,
+	set_adapter_property,
+	get_remote_device_properties,
+	get_remote_device_property,
+	set_remote_device_property,
+	get_remote_service_record,
+	get_remote_services,
+	start_discovery,
+	cancel_discovery,
+	create_bond,
+	remove_bond,
+	cancel_bond,
+	pin_reply,
+	ssp_reply,
+	get_profile_interface,
+	dut_mode_configure,
+	dut_mode_send
+};
+
+const bt_interface_t *bluetooth__get_bluetooth_interface(void)
+{
+	ALOGI(__func__);
+
+	return &bluetoothInterface;
+}
+
+static int close_bluetooth_stack(struct hw_device_t *device)
+{
+	ALOGI(__func__);
+
+	cleanup();
+
+	return 0;
+}
+
+static int open_bluetooth_stack(const struct hw_module_t *module,
+			char const *name, struct hw_device_t **abstraction)
+{
+	bluetooth_device_t *stack = malloc(sizeof(bluetooth_device_t));
+
+	ALOGI(__func__);
+
+	memset(stack, 0, sizeof(bluetooth_device_t));
+	stack->common.tag = HARDWARE_DEVICE_TAG;
+	stack->common.version = 0;
+	stack->common.module = (struct hw_module_t *) module;
+	stack->common.close = close_bluetooth_stack;
+	stack->get_bluetooth_interface = bluetooth__get_bluetooth_interface;
+	*abstraction = (struct hw_device_t *) stack;
+
+	return 0;
+}
+
+static struct hw_module_methods_t bt_stack_module_methods = {
+	.open = open_bluetooth_stack,
+};
+
+struct hw_module_t HAL_MODULE_INFO_SYM = {
+	.tag = HARDWARE_MODULE_TAG,
+	.version_major = 1,
+	.version_minor = 0,
+	.id = BT_HARDWARE_MODULE_ID,
+	.name = "Bluetooth Stack",
+	.author = "The Android Open Source Project",
+	.methods = &bt_stack_module_methods
+};
-- 
1.7.10.4


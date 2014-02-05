Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2] android: Add support for Valgrind in debug variants
Date: Wed, 5 Feb 2014 10:14:13 +0100
Message-ID: <1391591653-17254-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1391591653-17254-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391591653-17254-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows bluetoothd to be run with Valgrind easily in debug
variants.

For userdebug and eng variants bluetoothd is renamed to bluetoothd-main
and bluetoothd acts a wrapper to launch it either with or without
Valgrind (this is decided by value of persist.sys.bluetooth.valgrind
property).
---
 android/Android.mk           | 42 +++++++++++++++++++++++++++++
 android/bluetoothd-wrapper.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 android/bluetoothd-wrapper.c

diff --git a/android/Android.mk b/android/Android.mk
index 20105e6..52745fe 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -82,7 +82,15 @@ $(shell mkdir -p $(LOCAL_PATH)/bluez/lib/bluetooth)
 $(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/bluez/lib/bluetooth/$(file)))
 
 LOCAL_MODULE_TAGS := optional
+
+# for userdebug/eng this module is bluetoothd-main since bluetoothd is used as
+# wrapper to launch bluetooth with Valgrind
+ifneq (,$(filter userdebug eng,$(TARGET_BUILD_VARIANT)))
+LOCAL_MODULE := bluetoothd-main
+LOCAL_STRIP_MODULE := false
+else
 LOCAL_MODULE := bluetoothd
+endif
 
 include $(BUILD_EXECUTABLE)
 
@@ -406,3 +414,37 @@ LOCAL_CFLAGS:= \
 LOCAL_MODULE := libsbc
 
 include $(BUILD_SHARED_LIBRARY)
+
+ifneq (,$(filter userdebug eng,$(TARGET_BUILD_VARIANT)))
+
+#
+# bluetoothd (debug)
+# this is just a wrapper used in userdebug/eng to launch bluetoothd-main
+# with/without Valgrind
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	bluez/android/bluetoothd-wrapper.c
+
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+
+LOCAL_SHARED_LIBRARIES := \
+	libcutils \
+
+LOCAL_MODULE_PATH := $(TARGET_OUT_EXECUTABLES)
+LOCAL_MODULE_TAGS := optional
+LOCAL_MODULE := bluetoothd
+
+LOCAL_REQUIRED_MODULES := \
+	bluetoothd-main \
+	valgrind \
+	memcheck-$(TARGET_ARCH)-linux \
+	vgpreload_core-$(TARGET_ARCH)-linux \
+	vgpreload_memcheck-$(TARGET_ARCH)-linux \
+	default.supp
+
+include $(BUILD_EXECUTABLE)
+
+endif
\ No newline at end of file
diff --git a/android/bluetoothd-wrapper.c b/android/bluetoothd-wrapper.c
new file mode 100644
index 0000000..eb59822
--- /dev/null
+++ b/android/bluetoothd-wrapper.c
@@ -0,0 +1,63 @@
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <cutils/properties.h>
+
+#define PROPERTY_NAME "persist.sys.bluetooth.valgrind"
+
+#define VALGRIND_BIN "/system/bin/valgrind"
+
+#define BLUETOOTHD_BIN "/system/bin/bluetoothd-main"
+
+int main(int argc, char *argv[])
+{
+	char value[PROPERTY_VALUE_MAX];
+	char *prg_argv[4];
+	char *prg_envp[3];
+
+	if (property_get(PROPERTY_NAME, value, "") <= 0)
+		goto run_bluetoothd;
+
+	if (strcasecmp(value, "true") && atoi(value) == 0)
+		goto run_bluetoothd;
+
+	prg_argv[0] = VALGRIND_BIN;
+	prg_argv[1] = "--leak-check=full";
+	prg_argv[2] = BLUETOOTHD_BIN;
+	prg_argv[3] = NULL;
+
+	prg_envp[0] = "G_SLICE=always-malloc";
+	prg_envp[1] = "G_DEBUG=gc-friendly";
+	prg_envp[2] = NULL;
+
+	execve(prg_argv[0], prg_argv, prg_envp);
+
+run_bluetoothd:
+	prg_argv[0] = BLUETOOTHD_BIN;
+	prg_argv[1] = NULL;
+
+	prg_envp[0] = NULL;
+
+	execve(prg_argv[0], prg_argv, prg_envp);
+
+	return 0;
+}
-- 
1.8.5.3


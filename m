Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] android: Load bluetooth.default.so as a module
Date: Fri, 10 Jan 2014 14:14:08 +0200
Message-Id: <1389356048-4333-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389356048-4333-1-git-send-email-luiz.dentz@gmail.com>
References: <1389356048-4333-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes haltest and android-tester to load bluetooth.default.so
instead of linking directly to it.
---
 android/Makefile.am         |  26 +++++-----
 android/hardware/hardware.c | 124 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+), 12 deletions(-)
 create mode 100644 android/hardware/hardware.c

diff --git a/android/Makefile.am b/android/Makefile.am
index 4b843b2..f5e8c99 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -1,4 +1,6 @@
 if ANDROID
+android_plugindir = $(abs_top_srcdir)/android/.libs
+
 noinst_PROGRAMS += android/system-emulator
 
 android_system_emulator_SOURCES = android/system-emulator.c \
@@ -61,7 +63,8 @@ android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hardware/hardware.h \
 					android/cutils/properties.h \
 					android/hal-log.h \
-					android/hal-ipc.h android/hal-ipc.c
+					android/hal-ipc.h android/hal-ipc.c \
+					android/hal-utils.h android/hal-utils.c
 
 android_bluetooth_default_la_CPPFLAGS = -I$(srcdir)/android \
 					-DPLATFORM_SDK_VERSION=19
@@ -86,15 +89,14 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/if-hh.c \
 				android/client/if-pan.c \
 				android/client/if-sock.c \
-				android/client/hwmodule.c \
+				android/hardware/hardware.c \
 				android/hal-utils.h android/hal-utils.c
 
-android_haltest_LDADD = android/bluetooth.default.la
-
 android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
-				-DPLATFORM_SDK_VERSION=19
+				-DPLATFORM_SDK_VERSION=19 \
+				-DPLUGINDIR=\""$(android_plugindir)"\"
 
-android_haltest_LDFLAGS = -pthread
+android_haltest_LDFLAGS = -pthread -ldl
 
 noinst_PROGRAMS += android/android-tester
 
@@ -106,15 +108,15 @@ android_android_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				src/shared/hciemu.h src/shared/hciemu.c \
 				src/shared/tester.h src/shared/tester.c \
-				android/hal-utils.h android/hal-utils.c \
-				android/client/hwmodule.c android/android-tester.c
+				android/hardware/hardware.c \
+				android/android-tester.c
 
-android_android_tester_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
+android_android_tester_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
+				-DPLUGINDIR=\""$(android_plugindir)"\"
 
-android_android_tester_LDADD = lib/libbluetooth-internal.la \
-				android/bluetooth.default.la @GLIB_LIBS@
+android_android_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
-android_android_tester_LDFLAGS = -pthread
+android_android_tester_LDFLAGS = -pthread -ldl
 
 plugin_LTLIBRARIES += android/audio.a2dp.default.la
 
diff --git a/android/hardware/hardware.c b/android/hardware/hardware.c
new file mode 100644
index 0000000..4bd5eba
--- /dev/null
+++ b/android/hardware/hardware.c
@@ -0,0 +1,124 @@
+/*
+ * Copyright (C) 2008 The Android Open Source Project
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
+ */
+
+#include <hardware/hardware.h>
+
+#include <dlfcn.h>
+#include <string.h>
+#include <pthread.h>
+#include <errno.h>
+#include <limits.h>
+#include <stdio.h>
+
+#define LOG_TAG "HAL"
+
+#define LOG_INFO " I"
+#define LOG_WARN " W"
+#define LOG_ERROR " E"
+#define LOG_DEBUG " D"
+#define ALOG(pri, tag, fmt, arg...) fprintf(stderr, tag pri": " fmt"\n", ##arg)
+
+#define info(fmt, arg...) ALOG(LOG_INFO, LOG_TAG, fmt, ##arg)
+#define warn(fmt, arg...) ALOG(LOG_WARN, LOG_TAG, fmt, ##arg)
+#define error(fmt, arg...) ALOG(LOG_ERROR, LOG_TAG, fmt, ##arg)
+
+/**
+ * Load the file defined by the variant and if successful
+ * return the dlopen handle and the hmi.
+ * @return 0 = success, !0 = failure.
+ */
+static int load(const char *id,
+        const char *path,
+        const struct hw_module_t **pHmi)
+{
+    int status;
+    void *handle;
+    struct hw_module_t *hmi;
+    const char *sym = HAL_MODULE_INFO_SYM_AS_STR;
+
+    /*
+     * load the symbols resolving undefined symbols before
+     * dlopen returns. Since RTLD_GLOBAL is not or'd in with
+     * RTLD_NOW the external symbols will not be global
+     */
+    handle = dlopen(path, RTLD_NOW);
+    if (handle == NULL) {
+        char const *err_str = dlerror();
+        error("load: module=%s\n%s", path, err_str?err_str:"unknown");
+        status = -EINVAL;
+        goto done;
+    }
+
+    /* Get the address of the struct hal_module_info. */
+    hmi = (struct hw_module_t *)dlsym(handle, sym);
+    if (hmi == NULL) {
+        error("load: couldn't find symbol %s", sym);
+        status = -EINVAL;
+        goto done;
+    }
+
+    /* Check that the id matches */
+    if (strcmp(id, hmi->id) != 0) {
+        error("load: id=%s != hmi->id=%s", id, hmi->id);
+        status = -EINVAL;
+        goto done;
+    }
+
+    hmi->dso = handle;
+
+    *pHmi = hmi;
+
+    info("loaded HAL id=%s path=%s hmi=%p handle=%p",
+                id, path, *pHmi, handle);
+
+    return 0;
+
+done:
+    hmi = NULL;
+    if (handle != NULL) {
+        dlclose(handle);
+        handle = NULL;
+    }
+
+    return status;
+}
+
+int hw_get_module_by_class(const char *class_id, const char *inst,
+                           const struct hw_module_t **module)
+{
+    char path[PATH_MAX];
+    char name[PATH_MAX];
+
+    if (inst)
+        snprintf(name, PATH_MAX, "%s.%s", class_id, inst);
+    else
+        snprintf(name, PATH_MAX, "%s", class_id);
+
+    /*
+     * Here we rely on the fact that calling dlopen multiple times on
+     * the same .so will simply increment a refcount (and not load
+     * a new copy of the library).
+     * We also assume that dlopen() is thread-safe.
+     */
+    snprintf(path, sizeof(path), "%s/%s.default.so", PLUGINDIR, name);
+
+    return load(class_id, path, module);
+}
+
+int hw_get_module(const char *id, const struct hw_module_t **module)
+{
+    return hw_get_module_by_class(id, NULL, module);
+}
-- 
1.8.4.2


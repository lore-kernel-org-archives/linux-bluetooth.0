Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC 4/8] android: Fix build of HAL library on Linux
Date: Thu, 17 Oct 2013 10:47:05 +0200
Message-ID: <1381999629-9589-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
References: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

Use compat header for stubbing Android specific features not needed
on Linux.
---
 android/android_compat.h | 33 +++++++++++++++++++++++++++++++++
 android/hal_bluetooth.c  |  4 ++++
 android/hal_bt_sock.c    |  4 ++++
 3 files changed, 41 insertions(+)
 create mode 100644 android/android_compat.h

diff --git a/android/android_compat.h b/android/android_compat.h
new file mode 100644
index 0000000..dfe0a0e
--- /dev/null
+++ b/android/android_compat.h
@@ -0,0 +1,33 @@
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
+#define ALOGD(...)
+#define ALOGI(...)
+#define ALOGE(...)
+
+#define PROPERTY_VALUE_MAX 64
+
+static inline int property_get(const char *key, char *value,
+						const char *default_value)
+{
+	return 0;
+}
+
+static inline int property_set(const char *key, const char *value)
+{
+	return 0;
+}
diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
index 9bb9dcf..a34dc91 100644
--- a/android/hal_bluetooth.c
+++ b/android/hal_bluetooth.c
@@ -23,11 +23,15 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 
+#ifdef __BIONIC__
 #include <cutils/sockets.h>
 #include <cutils/properties.h>
 
 #define LOG_TAG "BlueZ"
 #include <cutils/log.h>
+#else
+#include "android_compat.h"
+#endif
 
 #include "hal.h"
 
diff --git a/android/hal_bt_sock.c b/android/hal_bt_sock.c
index 3a6d173..397d1fa 100644
--- a/android/hal_bt_sock.c
+++ b/android/hal_bt_sock.c
@@ -20,8 +20,12 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 
+#ifdef __BIONIC__
 #define LOG_TAG "BlueZ"
 #include <cutils/log.h>
+#else
+#include "android_compat.h"
+#endif
 
 static bt_status_t btsock_listen_rfcomm(const char *service_name,
 					const uint8_t *uuid, int chan,
-- 
1.8.4


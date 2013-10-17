Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 4/9] android: Add cutils/log.h
Date: Thu, 17 Oct 2013 11:55:23 +0300
Message-Id: <1382000128-23762-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
References: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/cutils/log.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 android/cutils/log.h

diff --git a/android/cutils/log.h b/android/cutils/log.h
new file mode 100644
index 0000000..ecdc585
--- /dev/null
+++ b/android/cutils/log.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2007 The Android Open Source Project
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
+/**
+ * This is a temporary hack to enable logging from cutils.
+ */
+
+#ifndef _CUTILS_LOG_H
+#define _CUTILS_LOG_H
+
+#include <stdio.h>
+#define ALOG(level, ...) \
+        ((void)printf("cutils:" level "/" LOG_TAG ": " __VA_ARGS__))
+#define ALOGV(...)   ALOG("V", __VA_ARGS__)
+#define ALOGD(...)   ALOG("D", __VA_ARGS__)
+#define ALOGI(...)   ALOG("I", __VA_ARGS__)
+#define ALOGW(...)   ALOG("W", __VA_ARGS__)
+#define ALOGE(...)   ALOG("E", __VA_ARGS__)
+#define LOG_ALWAYS_FATAL(...)   do { ALOGE(__VA_ARGS__); exit(1); } while (0)
+
+#endif // _CUTILS_LOG_H
-- 
1.8.3.1


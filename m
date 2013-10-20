Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 1/6] android: Add wrapper for HAL logging
Date: Sun, 20 Oct 2013 19:45:41 +0200
Message-Id: <1382291146-23518-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
References: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Provide logging API similar to standard logging used in daemon. This
will allow to log on both Android and Linux (i.e. in haltest).

Another advantage is that now LOG_TAG and message format are configured
from single location.
---
 Makefile.android  |  3 ++-
 android/hal-log.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 android/hal-log.h

diff --git a/Makefile.android b/Makefile.android
index dcaca3c..244a13b 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -59,7 +59,8 @@ EXTRA_DIST += android/Android.mk android/log.c android/device.c \
 EXTRA_DIST += android/hal-bluetooth.c \
 		android/hal-sock.c \
 		android/hal-hidhost.c \
-		android/hal-pan.c
+		android/hal-pan.c \
+		android/hal-log.h
 
 EXTRA_DIST += android/client/terminal.c \
 		android/client/haltest.c \
diff --git a/android/hal-log.h b/android/hal-log.h
new file mode 100644
index 0000000..9bd024d
--- /dev/null
+++ b/android/hal-log.h
@@ -0,0 +1,35 @@
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
+#define LOG_TAG "BlueZ"
+
+#ifdef __BIONIC__
+#include <cutils/log.h>
+#else
+#include <stdio.h>
+#define LOG_INFO " I"
+#define LOG_WARN " W"
+#define LOG_ERROR " E"
+#define LOG_DEBUG " D"
+#define ALOG(pri, tag, fmt, arg...) printf(tag pri": " fmt"\n", ##arg)
+#endif
+
+#define info(fmt, arg...) ALOG(LOG_INFO, LOG_TAG, fmt, ##arg)
+#define warn(fmt, arg...) ALOG(LOG_WARN, LOG_TAG, fmt, ##arg)
+#define error(fmt, arg...) ALOG(LOG_ERROR, LOG_TAG, fmt, ##arg)
+#define DBG(fmt, arg...) ALOG(LOG_DEBUG, LOG_TAG, "%s:%s() "fmt, __FILE__, \
+							__func__, ##arg)
-- 
1.8.4


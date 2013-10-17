Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC 3/8] android: Fix haltest build on Linux
Date: Thu, 17 Oct 2013 10:47:04 +0200
Message-ID: <1381999629-9589-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
References: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

On Linux HAL library is build into haltest binary and can be access
directly. Provide simple implementation of hw_get_module() that does
it.
---
 Makefile.android          |  1 +
 android/client/hwmodule.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 android/client/hwmodule.c

diff --git a/Makefile.android b/Makefile.android
index e4482b2..5abfeaa 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -19,6 +19,7 @@ android_haltest_SOURCES =	android/client/haltest.c \
 				android/client/history.c \
 				android/client/textconv.c \
 				android/client/if-bt.c \
+				android/client/hwmodule.c \
 				android/hal_bluetooth.c \
 				android/hal_bt_sock.c \
 				android/hardware/bt_hf.h \
diff --git a/android/client/hwmodule.c b/android/client/hwmodule.c
new file mode 100644
index 0000000..be3a57b
--- /dev/null
+++ b/android/client/hwmodule.c
@@ -0,0 +1,27 @@
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
+#include "hardware/hardware.h"
+
+int hw_get_module(const char *id, const struct hw_module_t **module)
+{
+	extern struct hw_module_t HAL_MODULE_INFO_SYM;
+
+	*module = &HAL_MODULE_INFO_SYM;
+
+	return 0;
+}
-- 
1.8.4


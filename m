Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] android: Fix haltest build on Linux
Date: Thu, 17 Oct 2013 22:28:38 +0200
Message-Id: <1382041721-19960-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1382041721-19960-1-git-send-email-szymon.janc@gmail.com>
References: <1382041721-19960-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

On Linux HAL library is build into haltest binary and can be access
directly. Provide simple implementation of hw_get_module() that does
it.
---
 Makefile.android          |  3 ++-
 android/client/hwmodule.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 android/client/hwmodule.c

diff --git a/Makefile.android b/Makefile.android
index 3bc95be..00d962d 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -39,7 +39,8 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/terminal.c \
 				android/client/history.c \
 				android/client/textconv.c \
-				android/client/if-bt.c
+				android/client/if-bt.c \
+				android/client/hwmodule.c
 
 android_haltest_LDADD = android/libhal-internal.la
 
diff --git a/android/client/hwmodule.c b/android/client/hwmodule.c
new file mode 100644
index 0000000..80e7475
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
+*/
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
1.8.4.rc3


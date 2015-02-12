Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 5/5] android: Fix btmgmt build
Date: Thu, 12 Feb 2015 18:52:13 +0100
Message-Id: <1423763533-15071-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423763533-15071-1-git-send-email-szymon.janc@tieto.com>
References: <1423763533-15071-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android doesn't provide readline library. Use dummy interactive
implementation while building for Android. Interactive mode
will not work but batch mode is functional.

Eventually Android implementation might be written based on code
used by haltest.
---
 android/Android.mk    |  1 +
 android/Makefile.am   |  1 +
 android/interactive.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 android/interactive.c

diff --git a/android/Android.mk b/android/Android.mk
index 289c1df..e01ed44 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -493,6 +493,7 @@ LOCAL_SRC_FILES := \
 	bluez/src/shared/util.c \
 	bluez/src/shared/gap.c \
 	bluez/src/uuid-helper.c \
+	bluez/android/interactive.c \
 
 LOCAL_C_INCLUDES := \
 	$(LOCAL_PATH)/bluez \
diff --git a/android/Makefile.am b/android/Makefile.am
index 9e73be4..9115a82 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -220,6 +220,7 @@ endif
 EXTRA_DIST += android/Android.mk android/README \
 				android/bluetoothd-wrapper.c \
 				android/log.c \
+				android/interactive.c \
 				android/bluetoothd.te \
 				android/bluetoothd_snoop.te \
 				android/init.bluetooth.rc \
diff --git a/android/interactive.c b/android/interactive.c
new file mode 100644
index 0000000..7da06f8
--- /dev/null
+++ b/android/interactive.c
@@ -0,0 +1,64 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdbool.h>
+#include <stddef.h>
+
+#include "client/interactive.h"
+
+
+bool interactive_init(const char *prompt, interactive_prompt_func_t cb,
+					const struct interactive_command *cmd)
+{
+	return false;
+}
+
+void interactive_cleanup(void)
+{
+
+}
+
+void interactive_update_prompt(const char *prompt)
+{
+
+}
+
+void interactive_prompt(const char *msg)
+{
+
+}
+
+void interactive_release_prompt(void)
+{
+
+}
+
+void interactive_printf(const char *fmt, ...)
+{
+
+}
+
+void interactive_hexdump(const unsigned char *buf, size_t len)
+{
+
+}
-- 
1.9.3


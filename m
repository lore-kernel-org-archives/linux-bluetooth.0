Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/11] android/test: Add initial HAL IPC unit tests
Date: Tue, 19 Aug 2014 21:51:06 +0200
Message-Id: <1408477872-24160-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
References: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore             |  1 +
 android/Makefile.am    |  9 ++++++++
 android/test-hal-ipc.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 android/test-hal-ipc.c

diff --git a/.gitignore b/.gitignore
index 1ee35e2..35e96ab 100644
--- a/.gitignore
+++ b/.gitignore
@@ -131,6 +131,7 @@ android/android-tester
 android/ipc-tester
 android/bluetoothd-snoop
 android/test-ipc
+android/test-hal-ipc
 android/test-*.log
 android/test-*.trs
 
diff --git a/android/Makefile.am b/android/Makefile.am
index 4b93c5b..bc9efe3 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -231,6 +231,15 @@ android_test_ipc_SOURCES = android/test-ipc.c \
 				android/ipc.c android/ipc.h
 android_test_ipc_LDADD = @GLIB_LIBS@
 
+unit_tests += android/test-hal-ipc
+
+android_test_hal_ipc_SOURCES = android/test-hal-ipc.c \
+				src/shared/util.h src/shared/util.c \
+				android/ipc-common.h \
+				android/hal-ipc.c android/hal-ipc.h
+android_test_hal_ipc_LDADD = @GLIB_LIBS@
+android_test_hal_ipc_LDFLAGS = $(AM_LDFLAGS) -pthread
+
 plugin_LTLIBRARIES += android/audio.a2dp.default.la
 
 android_audio_a2dp_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
diff --git a/android/test-hal-ipc.c b/android/test-hal-ipc.c
new file mode 100644
index 0000000..22b6072
--- /dev/null
+++ b/android/test-hal-ipc.c
@@ -0,0 +1,63 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <inttypes.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include <glib.h>
+#include "android/ipc-common.h"
+#include "android/hal-ipc.h"
+
+static const char HAL_SK_PATH[] = "\0test_hal_ipc_socket";
+
+static void test_init(void)
+{
+	g_assert(hal_ipc_init(HAL_SK_PATH, sizeof(HAL_SK_PATH)));
+
+	hal_ipc_cleanup();
+
+	g_assert(hal_ipc_init(HAL_SK_PATH, sizeof(HAL_SK_PATH)));
+
+	hal_ipc_cleanup();
+}
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	if (!g_test_verbose())
+		fclose(stderr);
+
+	g_test_add_func("/android_hal_ipc/init", test_init);
+
+	return g_test_run();
+}
-- 
1.9.3


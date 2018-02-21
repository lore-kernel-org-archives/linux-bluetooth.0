Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/8] shared/mainloop: Add GLIB wrapper
Date: Wed, 21 Feb 2018 16:14:54 +0200
Message-Id: <20180221141456.6656-6-luiz.dentz@gmail.com>
In-Reply-To: <20180221141456.6656-1-luiz.dentz@gmail.com>
References: <20180221141456.6656-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds wrappers function to interface with GLIB mainloop so
applications can use mainloop functions no matter what is the underline
implementation.

Note: Most functions are not actually implemented on purpose since both
io and timeout functions already exists for GLIB covering the same
functionality.
---
 Makefile.am                |   3 +-
 src/shared/mainloop-glib.c | 112 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/mainloop-glib.c

diff --git a/Makefile.am b/Makefile.am
index 02f02a100..daf34b6ca 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -123,7 +123,8 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 
 src_libshared_glib_la_SOURCES = $(shared_sources) \
 				src/shared/io-glib.c \
-				src/shared/timeout-glib.c
+				src/shared/timeout-glib.c \
+				src/shared/mainloop-glib.c
 
 src_libshared_mainloop_la_SOURCES = $(shared_sources) \
 				src/shared/io-mainloop.c \
diff --git a/src/shared/mainloop-glib.c b/src/shared/mainloop-glib.c
new file mode 100644
index 000000000..14d43207a
--- /dev/null
+++ b/src/shared/mainloop-glib.c
@@ -0,0 +1,112 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Intel Corporation
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
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <sys/signalfd.h>
+
+#include <glib.h>
+
+#include "mainloop.h"
+
+static GMainLoop *main_loop;
+static int exit_status;
+
+void mainloop_init(void)
+{
+	main_loop = g_main_loop_new(NULL, FALSE);
+}
+
+void mainloop_quit(void)
+{
+	g_main_loop_quit(main_loop);
+}
+
+void mainloop_exit_success(void)
+{
+	exit_status = EXIT_SUCCESS;
+}
+
+void mainloop_exit_failure(void)
+{
+	exit_status = EXIT_FAILURE;
+}
+
+int mainloop_run(void)
+{
+	if (!main_loop)
+		return -EINVAL;
+
+	g_main_loop_run(main_loop);
+
+	g_main_loop_unref(main_loop);
+	main_loop = NULL;
+
+	return exit_status;
+}
+
+int mainloop_add_fd(int fd, uint32_t events, mainloop_event_func callback,
+				void *user_data, mainloop_destroy_func destroy)
+{
+	return -ENOSYS;
+}
+
+int mainloop_modify_fd(int fd, uint32_t events)
+{
+	return -ENOSYS;
+}
+
+int mainloop_remove_fd(int fd)
+{
+	return -ENOSYS;
+}
+
+int mainloop_add_timeout(unsigned int msec, mainloop_timeout_func callback,
+				void *user_data, mainloop_destroy_func destroy)
+{
+	return -ENOSYS;
+}
+
+int mainloop_modify_timeout(int fd, unsigned int msec)
+{
+	return -ENOSYS;
+}
+
+int mainloop_remove_timeout(int id)
+{
+	return -ENOSYS;
+}
+
+int mainloop_set_signal(sigset_t *mask, mainloop_signal_func callback,
+				void *user_data, mainloop_destroy_func destroy)
+{
+	return -ENOSYS;
+}
-- 
2.14.3


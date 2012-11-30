Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 7/8] adaptername: Refactor adaptername_init/exit to fix exit path
Date: Fri, 30 Nov 2012 14:31:49 +0100
Message-ID: <1354282309-20540-1-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354280264-19036-7-git-send-email-szymon.janc@tieto.com>
References: <1354280264-19036-7-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes adaptername plugin properly cleanup its fds on exit. Fixes
following warnings from valgrind:

16 bytes in 1 blocks are still reachable in loss record 42 of 221
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E92CA2: g_slice_alloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E93ABD: g_slist_prepend (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E78350: g_source_add_poll (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4EB5E32: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E6D0C3: g_io_add_watch_full (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x1565FA: adaptername_init (adaptername.c:302)
   by 0x1712AB: plugin_init (plugin.c:217)
   by 0x1215D2: main (main.c:544)

18 bytes in 1 blocks are still reachable in loss record 58 of 221
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E942DD: g_strdup (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E78A69: g_source_set_name (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4EB5E0B: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E6D0C3: g_io_add_watch_full (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x1565FA: adaptername_init (adaptername.c:302)
   by 0x1712AB: plugin_init (plugin.c:217)
   by 0x1215D2: main (main.c:544)

32 bytes in 1 blocks are still reachable in loss record 86 of 221
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E78722: g_source_set_callback (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E6D0DB: g_io_add_watch_full (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x1565FA: adaptername_init (adaptername.c:302)
   by 0x1712AB: plugin_init (plugin.c:217)
   by 0x1215D2: main (main.c:544)

32 bytes in 1 blocks are still reachable in loss record 87 of 221
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E92CA2: g_slice_alloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E77285: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E775AF: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E78115: g_source_attach (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E6D0E5: g_io_add_watch_full (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x1565FA: adaptername_init (adaptername.c:302)
   by 0x1712AB: plugin_init (plugin.c:217)
   by 0x1215D2: main (main.c:544)

120 bytes in 1 blocks are still reachable in loss record 167 of 221
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4EB66F4: g_io_channel_unix_new (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x1565A9: adaptername_init (adaptername.c:298)
   by 0x1712AB: plugin_init (plugin.c:217)
   by 0x1215D2: main (main.c:544)

120 bytes in 1 blocks are still reachable in loss record 168 of 221
   at 0x4C29DB4: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FAE0: g_malloc0 (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E78044: g_source_new (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4EB5DF9: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E6D0C3: g_io_add_watch_full (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x1565FA: adaptername_init (adaptername.c:302)
   by 0x1712AB: plugin_init (plugin.c:217)
   by 0x1215D2: main (main.c:544)
---
 plugins/adaptername.c |   59 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index 2013b7b..179152f 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -50,8 +50,7 @@
 #define MACHINE_INFO_DIR "/etc/"
 #define MACHINE_INFO_FILE "machine-info"
 
-static GIOChannel *inotify = NULL;
-static int watch_d = -1;
+static guint watchid = 0;
 
 /* This file is part of systemd's hostnamed functionality:
  * http://0pointer.de/public/systemd-man/machine-info.html
@@ -266,20 +265,32 @@ static struct btd_adapter_driver adaptername_driver = {
 	.probe	= adaptername_probe,
 };
 
+struct inotify_data {
+	int inot_fd;
+	int watch_d;
+};
+
+static void destroy_cb(gpointer user_data)
+{
+	struct inotify_data *data = user_data;
+
+	inotify_rm_watch(data->inot_fd, data->watch_d);
+	g_free(data);
+}
+
 static int adaptername_init(void)
 {
-	int err;
-	int inot_fd;
 	guint32 mask;
-
-	err = btd_register_adapter_driver(&adaptername_driver);
-	if (err < 0)
-		return err;
+	GIOChannel *inotify;
+	int inot_fd;
+	int watch_d;
+	struct inotify_data *data;
 
 	inot_fd = inotify_init();
 	if (inot_fd < 0) {
-		error("Failed to setup inotify");
-		return 0;
+		int err = -errno;
+		error("Failed to setup inotify: %s (%d)", strerror(-err), -err);
+		return err;
 	}
 
 	mask = IN_CLOSE_WRITE;
@@ -290,30 +301,38 @@ static int adaptername_init(void)
 
 	watch_d = inotify_add_watch(inot_fd, MACHINE_INFO_DIR, mask);
 	if (watch_d < 0) {
-		error("Failed to setup watch for '%s'", MACHINE_INFO_DIR);
+		int err = -errno;
+		error("Failed to setup watch for '%s': %s (%d)",
+				MACHINE_INFO_DIR, strerror(-err), -err);
 		close(inot_fd);
-		return 0;
+		return err;
 	}
 
+	data = g_new(struct inotify_data, 1);
+	data->inot_fd = inot_fd;
+	data->watch_d = watch_d;
+
 	inotify = g_io_channel_unix_new(inot_fd);
 	g_io_channel_set_close_on_unref(inotify, TRUE);
 	g_io_channel_set_encoding(inotify, NULL, NULL);
 	g_io_channel_set_flags(inotify, G_IO_FLAG_NONBLOCK, NULL);
-	g_io_add_watch(inotify, G_IO_IN, handle_inotify_cb, NULL);
+
+	watchid = g_io_add_watch_full(inotify, G_PRIORITY_DEFAULT, G_IO_IN,
+					handle_inotify_cb, data, destroy_cb);
+
+	g_io_channel_unref(inotify);
+
+	btd_register_adapter_driver(&adaptername_driver);
 
 	return 0;
 }
 
 static void adaptername_exit(void)
 {
-	if (watch_d >= 0 && inotify != NULL) {
-		int inot_fd = g_io_channel_unix_get_fd(inotify);
-		inotify_rm_watch(inot_fd, watch_d);
-	}
 
-	if (inotify != NULL) {
-		g_io_channel_shutdown(inotify, FALSE, NULL);
-		g_io_channel_unref(inotify);
+	if (watchid > 0) {
+		g_source_remove(watchid);
+		watchid = 0;
 	}
 
 	btd_unregister_adapter_driver(&adaptername_driver);
-- 
1.7.9.5


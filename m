Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v3 14/18] test: Add signal handling for gatt-service
Date: Wed, 22 Jan 2014 10:40:21 -0300
Message-Id: <1390398025-28340-15-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1390398025-28340-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390310814-19880-1-git-send-email-claudio.takahasi@openbossa.org>
 <1390398025-28340-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements signal handling to run cleanup tasks before
exiting.
---
 test/gatt-service.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/test/gatt-service.c b/test/gatt-service.c
index 1cb0913..ea801de 100644
--- a/test/gatt-service.c
+++ b/test/gatt-service.c
@@ -27,6 +27,7 @@
 
 #include <errno.h>
 #include <stdio.h>
+#include <sys/signalfd.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
@@ -112,9 +113,57 @@ static void create_services(DBusConnection *conn)
 	printf("Registered service: %s\n", service_path);
 }
 
+static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
+							gpointer user_data)
+{
+	g_main_loop_quit(main_loop);
+
+	return FALSE;
+}
+
+static guint setup_signalfd(void)
+{
+	GIOChannel *channel;
+	guint source;
+	sigset_t mask;
+	int fd;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
+		perror("Failed to set signal mask");
+		return 0;
+	}
+
+	fd = signalfd(-1, &mask, 0);
+	if (fd < 0) {
+		perror("Failed to create signal descriptor");
+		return 0;
+	}
+
+	channel = g_io_channel_unix_new(fd);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+
+	source = g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				signal_handler, NULL);
+
+	g_io_channel_unref(channel);
+
+	return source;
+}
+
 int main(int argc, char *argv[])
 {
 	DBusConnection *dbus_conn;
+	guint signal;
+
+	signal = setup_signalfd();
+	if (signal == 0)
+		return -errno;
 
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 
@@ -129,6 +178,8 @@ int main(int argc, char *argv[])
 
 	g_main_loop_run(main_loop);
 
+	g_source_remove(signal);
+
 	g_slist_free_full(services, g_free);
 	dbus_connection_unref(dbus_conn);
 
-- 
1.8.3.1


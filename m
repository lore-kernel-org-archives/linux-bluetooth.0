Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH] android: Add missing signal handler functionality
Date: Fri, 18 Oct 2013 16:10:02 +0300
Message-Id: <1382101802-23965-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added singal handling based on singalfd and removed sigaction
based code.
---
 android/main.c |   80 +++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 15 deletions(-)

diff --git a/android/main.c b/android/main.c
index 256b83b..4ae654c 100644
--- a/android/main.c
+++ b/android/main.c
@@ -32,6 +32,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <string.h>
+#include <sys/signalfd.h>
 
 #include <glib.h>
 
@@ -54,23 +55,74 @@ static uint8_t mgmt_revision = 0;
 
 static uint16_t adapter_index = MGMT_INDEX_NONE;
 
-static gboolean quit_eventloop(gpointer user_data)
+static volatile sig_atomic_t __terminated = 0;
+
+static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
 {
-	g_main_loop_quit(event_loop);
+	struct signalfd_siginfo si;
+	ssize_t result;
+	int fd;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
+		return FALSE;
+
+	fd = g_io_channel_unix_get_fd(channel);
+
+	result = read(fd, &si, sizeof(si));
+	if (result != sizeof(si))
+		return FALSE;
+
+	switch (si.ssi_signo) {
+	case SIGINT:
+	case SIGTERM:
+		if (__terminated == 0) {
+			info("Terminating");
+			g_main_loop_quit(event_loop);
+		}
+
+		__terminated = 1;
+		break;
+	}
 
-	return FALSE;
+	return TRUE;
 }
 
-static void sig_term(int sig)
+static guint setup_signalfd(void)
 {
-	static bool __terminated = false;
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
 
-	if (!__terminated) {
-		g_timeout_add_seconds(SHUTDOWN_GRACE_SECONDS,
-						quit_eventloop, NULL);
+	fd = signalfd(-1, &mask, 0);
+	if (fd < 0) {
+		perror("Failed to create signal descriptor");
+		return 0;
 	}
 
-	__terminated = true;
+	channel = g_io_channel_unix_new(fd);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+
+	source = g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				signal_handler, NULL);
+
+	g_io_channel_unref(channel);
+
+	return source;
 }
 
 static gboolean option_version = FALSE;
@@ -244,7 +296,7 @@ int main(int argc, char *argv[])
 {
 	GOptionContext *context;
 	GError *err = NULL;
-	struct sigaction sa;
+	guint signal;
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
@@ -267,14 +319,10 @@ int main(int argc, char *argv[])
 	}
 
 	event_loop = g_main_loop_new(NULL, FALSE);
+	signal = setup_signalfd();
 
 	__btd_log_init("*", 0);
 
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = sig_term;
-	sigaction(SIGINT, &sa, NULL);
-	sigaction(SIGTERM, &sa, NULL);
-
 	if (!init_mgmt_interface())
 		return EXIT_FAILURE;
 
@@ -285,6 +333,8 @@ int main(int argc, char *argv[])
 
 	g_main_loop_run(event_loop);
 
+	g_source_remove(signal);
+
 	stop_sdp_server();
 	cleanup_mgmt_interface();
 	g_main_loop_unref(event_loop);
-- 
1.7.9.5


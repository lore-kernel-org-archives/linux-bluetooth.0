Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/3] core: Use signalfd to handle unix signals
Date: Mon,  7 May 2012 17:00:51 -0700
Message-Id: <1336435253-19081-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Writing anything to syslog in the signal handler can cause a deadlock
with any ongoing syslog write.

This is also aligned with what BlueZ and other projects has been doing.
---
 src/main.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/src/main.c b/src/main.c
index 992a646..a2a94f7 100644
--- a/src/main.c
+++ b/src/main.c
@@ -35,6 +35,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
+#include <sys/signalfd.h>
 #include <fcntl.h>
 #include <termios.h>
 #include <getopt.h>
@@ -53,15 +54,82 @@
 
 static GMainLoop *main_loop = NULL;
 
-static void sig_term(int sig)
+static unsigned int __terminated = 0;
+
+static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
 {
-	info("Terminating due to signal %d", sig);
-	g_main_loop_quit(main_loop);
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
+			g_main_loop_quit(main_loop);
+		}
+
+		__terminated = 1;
+		break;
+	case SIGUSR2:
+		__obex_log_enable_debug();
+		break;
+	case SIGPIPE:
+		/* ignore */
+		break;
+	}
+
+	return TRUE;
 }
 
-static void sig_debug(int sig)
+static guint setup_signalfd(void)
 {
-	__obex_log_enable_debug();
+	GIOChannel *channel;
+	guint source;
+	sigset_t mask;
+	int fd;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+	sigaddset(&mask, SIGUSR2);
+	sigaddset(&mask, SIGPIPE);
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
 
 static gboolean option_detach = TRUE;
@@ -179,7 +247,7 @@ int main(int argc, char *argv[])
 {
 	GOptionContext *context;
 	GError *err = NULL;
-	struct sigaction sa;
+	guint signal;
 
 #ifdef NEED_THREADS
 	if (g_thread_supported() == FALSE)
@@ -213,6 +281,8 @@ int main(int argc, char *argv[])
 
 	main_loop = g_main_loop_new(NULL, FALSE);
 
+	signal = setup_signalfd();
+
 #ifdef NEED_THREADS
 	if (dbus_threads_init_default() == FALSE) {
 		fprintf(stderr, "Can't init usage of threads\n");
@@ -251,16 +321,10 @@ int main(int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
 
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = sig_term;
-	sigaction(SIGINT, &sa, NULL);
-	sigaction(SIGTERM, &sa, NULL);
-
-	sa.sa_handler = sig_debug;
-	sigaction(SIGUSR2, &sa, NULL);
-
 	g_main_loop_run(main_loop);
 
+	g_source_remove(signal);
+
 	obex_server_exit();
 
 	plugin_cleanup();
-- 
1.7.7.6


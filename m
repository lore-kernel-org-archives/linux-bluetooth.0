Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH] main: Use glib signal handler
Date: Wed, 19 Oct 2011 11:49:49 +0200
Message-Id: <1319017789-2686-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 src/main.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/src/main.c b/src/main.c
index 5a953c3..3031f09 100644
--- a/src/main.c
+++ b/src/main.c
@@ -33,6 +33,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <signal.h>
+#include <sys/signalfd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 
@@ -252,14 +253,82 @@ static void init_defaults(void)
 
 static GMainLoop *event_loop;
 
-static void sig_term(int sig)
+static unsigned int __terminated = 0;
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
+	case SIGUSR2:
+		__btd_toggle_debug();
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
-	__btd_toggle_debug();
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
 
 static gchar *option_debug = NULL;
@@ -371,9 +440,9 @@ int main(int argc, char *argv[])
 {
 	GOptionContext *context;
 	GError *err = NULL;
-	struct sigaction sa;
 	uint16_t mtu = 0;
 	GKeyFile *config;
+	guint signal;
 
 	init_defaults();
 
@@ -426,19 +495,11 @@ int main(int argc, char *argv[])
 
 	umask(0077);
 
-	__btd_log_init(option_debug, option_detach);
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_flags = SA_NOCLDSTOP;
-	sa.sa_handler = sig_term;
-	sigaction(SIGTERM, &sa, NULL);
-	sigaction(SIGINT,  &sa, NULL);
+	event_loop = g_main_loop_new(NULL, FALSE);
 
-	sa.sa_handler = sig_debug;
-	sigaction(SIGUSR2, &sa, NULL);
+	signal = setup_signalfd();
 
-	sa.sa_handler = SIG_IGN;
-	sigaction(SIGPIPE, &sa, NULL);
+	__btd_log_init(option_debug, option_detach);
 
 	config = load_config(CONFIGDIR "/main.conf");
 
@@ -471,8 +532,6 @@ int main(int argc, char *argv[])
 	 * daemon needs to be re-worked. */
 	plugin_init(config, option_plugin, option_noplugin);
 
-	event_loop = g_main_loop_new(NULL, FALSE);
-
 	if (adapter_ops_setup() < 0) {
 		error("adapter_ops_setup failed");
 		exit(1);
@@ -484,6 +543,8 @@ int main(int argc, char *argv[])
 
 	g_main_loop_run(event_loop);
 
+	g_source_remove(signal);
+
 	disconnect_dbus();
 
 	rfkill_exit();
-- 
1.7.6.4


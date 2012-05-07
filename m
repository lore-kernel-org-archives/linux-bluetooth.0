Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/2] client: Use signalfd to handle unix signals
Date: Mon,  7 May 2012 14:48:26 -0700
Message-Id: <1336427306-17716-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1336427306-17716-1-git-send-email-luiz.dentz@gmail.com>
References: <1336427306-17716-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/main.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 84 insertions(+), 10 deletions(-)

diff --git a/client/main.c b/client/main.c
index 80f9413..7d86833 100644
--- a/client/main.c
+++ b/client/main.c
@@ -30,6 +30,8 @@
 #include <string.h>
 #include <signal.h>
 #include <syslog.h>
+#include <unistd.h>
+#include <sys/signalfd.h>
 
 #include <glib.h>
 #include <gdbus.h>
@@ -39,6 +41,83 @@
 
 static GMainLoop *event_loop = NULL;
 
+static unsigned int __terminated = 0;
+
+static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
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
+		__obex_log_enable_debug();
+		break;
+	case SIGPIPE:
+		/* ignore */
+		break;
+	}
+
+	return TRUE;
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
+}
+
 static char *option_debug = NULL;
 static gboolean option_stderr = FALSE;
 
@@ -62,16 +141,12 @@ static GOptionEntry options[] = {
 	{ NULL },
 };
 
-static void sig_term(int sig)
-{
-	g_main_loop_quit(event_loop);
-}
 
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
-	struct sigaction sa;
 	GError *gerr = NULL;
+	guint signal;
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
@@ -87,6 +162,8 @@ int main(int argc, char *argv[])
 
 	event_loop = g_main_loop_new(NULL, FALSE);
 
+	signal = setup_signalfd();
+
 	__obex_log_init("obex-client", option_debug, !option_stderr);
 
 	if (manager_init() < 0)
@@ -94,13 +171,10 @@ int main(int argc, char *argv[])
 
 	DBG("Entering main loop");
 
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = sig_term;
-	sigaction(SIGINT, &sa, NULL);
-	sigaction(SIGTERM, &sa, NULL);
-
 	g_main_loop_run(event_loop);
 
+	g_source_remove(signal);
+
 	manager_exit();
 
 	g_main_loop_unref(event_loop);
-- 
1.7.7.6


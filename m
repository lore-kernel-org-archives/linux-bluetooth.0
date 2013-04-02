Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ v2 11/13] gatttool: Use bluetoothctl strategy for unix signal handling
Date: Tue,  2 Apr 2013 19:31:28 -0400
Message-Id: <1364945490-17059-12-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
 <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

Now to exit from gatttool at interactive mode, user must use SIGTERM(15)
or press Ctrl+D. SIGINT(2) or Ctrl+C just flushes typed characters and
breaks line.
---
 attrib/interactive.c |   83 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index fa3f82a..9b16ddf 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -29,6 +29,9 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <sys/signalfd.h>
 #include <glib.h>
 
 #include <readline/readline.h>
@@ -922,10 +925,88 @@ static guint setup_standard_input(void)
 	return source;
 }
 
+static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
+							gpointer user_data)
+{
+	static unsigned int __terminated = 0;
+	struct signalfd_siginfo si;
+	ssize_t result;
+	int fd;
+
+	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		g_main_loop_quit(event_loop);
+		return FALSE;
+	}
+
+	fd = g_io_channel_unix_get_fd(channel);
+
+	result = read(fd, &si, sizeof(si));
+	if (result != sizeof(si))
+		return FALSE;
+
+	switch (si.ssi_signo) {
+	case SIGINT:
+		rl_replace_line("", 0);
+		rl_crlf();
+		rl_on_new_line();
+		rl_redisplay();
+		break;
+	case SIGTERM:
+		if (__terminated == 0) {
+			rl_replace_line("", 0);
+			rl_crlf();
+			g_main_loop_quit(event_loop);
+		}
+
+		__terminated = 1;
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
 int interactive(const gchar *src, const gchar *dst,
 		const gchar *dst_type, int psm)
 {
 	guint input;
+	guint signal;
 
 	opt_sec_level = g_strdup("low");
 
@@ -939,6 +1020,7 @@ int interactive(const gchar *src, const gchar *dst,
 	event_loop = g_main_loop_new(NULL, FALSE);
 
 	input = setup_standard_input();
+	signal = setup_signalfd();
 
 	rl_attempted_completion_function = commands_completion;
 	rl_erase_empty_line = 1;
@@ -949,6 +1031,7 @@ int interactive(const gchar *src, const gchar *dst,
 	rl_callback_handler_remove();
 	cmd_disconnect(0, NULL);
 	g_source_remove(input);
+	g_source_remove(signal);
 	g_main_loop_unref(event_loop);
 	g_string_free(prompt, TRUE);
 
-- 
1.7.9.5


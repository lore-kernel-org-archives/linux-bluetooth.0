Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/14] client/bluetooth-player: Add initial code
Date: Fri, 31 May 2013 13:55:37 +0300
Message-Id: <1369997749-8663-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
References: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add initial code for things like input handling as well as some
basic commands.
---
 client/bluetooth-player.c | 318 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 318 insertions(+)

diff --git a/client/bluetooth-player.c b/client/bluetooth-player.c
index b38861a..687c649 100644
--- a/client/bluetooth-player.c
+++ b/client/bluetooth-player.c
@@ -25,7 +25,325 @@
 #include <config.h>
 #endif
 
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <sys/signalfd.h>
+
+#include <readline/readline.h>
+#include <readline/history.h>
+#include <glib.h>
+#include <gdbus.h>
+
+#include "display.h"
+
+/* String display constants */
+#define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
+#define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
+#define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
+
+#define PROMPT_ON	COLOR_BLUE "[bluetooth]" COLOR_OFF "# "
+#define PROMPT_OFF	"[bluetooth]# "
+
+static GMainLoop *main_loop;
+static DBusConnection *dbus_conn;
+
+static void connect_handler(DBusConnection *connection, void *user_data)
+{
+	rl_set_prompt(PROMPT_ON);
+	printf("\r");
+	rl_on_new_line();
+	rl_redisplay();
+}
+
+static void disconnect_handler(DBusConnection *connection, void *user_data)
+{
+	rl_set_prompt(PROMPT_OFF);
+	printf("\r");
+	rl_on_new_line();
+	rl_redisplay();
+}
+
+static void cmd_quit(int argc, char *argv[])
+{
+	g_main_loop_quit(main_loop);
+}
+
+static const struct {
+	const char *cmd;
+	const char *arg;
+	void (*func) (int argc, char *argv[]);
+	const char *desc;
+} cmd_table[] = {
+	{ "quit",         NULL,       cmd_quit, "Quit program" },
+	{ "exit",         NULL,       cmd_quit },
+	{ "help" },
+	{}
+};
+
+static char *cmd_generator(const char *text, int state)
+{
+	static int index, len;
+	const char *cmd;
+
+	if (!state) {
+		index = 0;
+		len = strlen(text);
+	}
+
+	while ((cmd = cmd_table[index].cmd)) {
+		index++;
+
+		if (!strncmp(cmd, text, len))
+			return strdup(cmd);
+	}
+
+	return NULL;
+}
+
+static char **cmd_completion(const char *text, int start, int end)
+{
+	char **matches = NULL;
+
+	if (start == 0) {
+		rl_completion_display_matches_hook = NULL;
+		matches = rl_completion_matches(text, cmd_generator);
+	}
+
+	if (!matches)
+		rl_attempted_completion_over = 1;
+
+	return matches;
+}
+
+static void rl_handler(char *input)
+{
+	int argc;
+	char **argv = NULL;
+	int i;
+
+	if (!input) {
+		rl_insert_text("quit");
+		rl_redisplay();
+		rl_crlf();
+		g_main_loop_quit(main_loop);
+		return;
+	}
+
+	if (!strlen(input))
+		goto done;
+
+	add_history(input);
+
+	argv = g_strsplit(input, " ", -1);
+	if (argv == NULL)
+		goto done;
+
+	for (argc = 0; argv[argc];)
+		argc++;
+
+	if (argc == 0)
+		goto done;
+
+	for (i = 0; cmd_table[i].cmd; i++) {
+		if (strcmp(argv[0], cmd_table[i].cmd))
+			continue;
+
+		if (cmd_table[i].func) {
+			cmd_table[i].func(argc, argv);
+			goto done;
+		}
+	}
+
+	if (strcmp(argv[0], "help")) {
+		printf("Invalid command\n");
+		goto done;
+	}
+
+	printf("Available commands:\n");
+
+	for (i = 0; cmd_table[i].cmd; i++) {
+		if (cmd_table[i].desc)
+			printf("\t%s %s\t%s\n", cmd_table[i].cmd,
+						cmd_table[i].arg ? : "    ",
+						cmd_table[i].desc);
+	}
+
+done:
+	g_strfreev(argv);
+	free(input);
+}
+
+static gboolean option_version = FALSE;
+
+static GOptionEntry options[] = {
+	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
+				"Show version information and exit" },
+	{ NULL },
+};
+
+static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
+							gpointer user_data)
+{
+	static unsigned int __terminated = 0;
+	struct signalfd_siginfo si;
+	ssize_t result;
+	int fd;
+
+	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		g_main_loop_quit(main_loop);
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
+			g_main_loop_quit(main_loop);
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
+static gboolean input_handler(GIOChannel *channel, GIOCondition condition,
+							gpointer user_data)
+{
+	if (condition & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
+		g_main_loop_quit(main_loop);
+		return FALSE;
+	}
+
+	rl_callback_read_char();
+	return TRUE;
+}
+
+static guint setup_standard_input(void)
+{
+	GIOChannel *channel;
+	guint source;
+
+	channel = g_io_channel_unix_new(fileno(stdin));
+
+	source = g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				input_handler, NULL);
+
+	g_io_channel_unref(channel);
+
+	return source;
+}
+
 int main(int argc, char *argv[])
 {
+	GOptionContext *context;
+	GError *error = NULL;
+	GDBusClient *client;
+	guint signal, input;
+
+	context = g_option_context_new(NULL);
+	g_option_context_add_main_entries(context, options, NULL);
+
+	if (g_option_context_parse(context, &argc, &argv, &error) == FALSE) {
+		if (error != NULL) {
+			g_printerr("%s\n", error->message);
+			g_error_free(error);
+		} else
+			g_printerr("An unknown error occurred\n");
+		exit(1);
+	}
+
+	g_option_context_free(context);
+
+	if (option_version == TRUE) {
+		printf("%s\n", VERSION);
+		exit(0);
+	}
+
+	main_loop = g_main_loop_new(NULL, FALSE);
+	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+
+	rl_attempted_completion_function = cmd_completion;
+
+	rl_erase_empty_line = 1;
+	rl_callback_handler_install(NULL, rl_handler);
+
+	rl_set_prompt(PROMPT_OFF);
+	rl_redisplay();
+
+	input = setup_standard_input();
+	signal = setup_signalfd();
+	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
+
+	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
+	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
+
+	g_main_loop_run(main_loop);
+
+	g_dbus_client_unref(client);
+	g_source_remove(signal);
+	g_source_remove(input);
+
+	rl_message("");
+	rl_callback_handler_remove();
+
+	dbus_connection_unref(dbus_conn);
+	g_main_loop_unref(main_loop);
+
 	return 0;
 }
-- 
1.8.1.4


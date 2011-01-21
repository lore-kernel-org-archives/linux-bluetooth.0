Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 3/7] Initial version of igatttool - a interactive gatttool
Date: Fri, 21 Jan 2011 10:46:22 -0300
Message-Id: <1295617586-3398-3-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1295617586-3398-1-git-send-email-sheldon.demario@openbossa.org>
References: <1295617586-3398-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Due the qualification tests, we need a deeper control over the
gatttool's steps.
---
 Makefile.am        |    7 ++-
 attrib/igatttool.c |  225 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 231 insertions(+), 1 deletions(-)
 create mode 100644 attrib/igatttool.c

diff --git a/Makefile.am b/Makefile.am
index 5274435..79365ad 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -175,7 +175,7 @@ builtin_sources += plugins/service.c
 endif
 
 if ATTRIBPLUGIN
-bin_PROGRAMS += attrib/gatttool
+bin_PROGRAMS += attrib/gatttool attrib/igatttool
 
 attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 			  attrib/gattrib.c btio/btio.c \
@@ -183,6 +183,11 @@ attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 			  attrib/gtcommon.h attrib/gtcommon.c
 attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@
 
+attrib_igatttool_SOURCES = attrib/igatttool.c btio/btio.c \
+			   attrib/gtcommon.h attrib/gtcommon.c \
+			  src/glib-helper.h src/glib-helper.c
+attrib_igatttool_LDADD =  lib/libbluetooth.la @GLIB_LIBS@ -lreadline
+
 builtin_modules += attrib
 builtin_sources += attrib/main.c \
 		attrib/manager.h attrib/manager.c \
diff --git a/attrib/igatttool.c b/attrib/igatttool.c
new file mode 100644
index 0000000..9cd2a1e
--- /dev/null
+++ b/attrib/igatttool.c
@@ -0,0 +1,225 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <readline/readline.h>
+#include <readline/history.h>
+#include <glib.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/sdp.h>
+
+#include "btio.h"
+
+#include "gtcommon.h"
+
+GIOChannel *iochannel = NULL;
+GMainLoop *main_loop = NULL;
+gboolean status = FALSE;
+GString *prompt = NULL;
+
+enum state {
+	STATE_DISCONNECTED,
+	STATE_CONNECTING,
+	STATE_CONNECTED
+} conn_state;
+
+static char *get_prompt(void)
+{
+	if (conn_state == STATE_CONNECTING) {
+		g_string_assign(prompt, "Connecting... ");
+		return prompt->str;
+	}
+
+	if (conn_state == STATE_CONNECTED)
+		g_string_assign(prompt, "[CON]");
+	else
+		g_string_assign(prompt, "[   ]");
+
+	if (opt_le)
+		g_string_append(prompt, "[LE]");
+	else
+		g_string_append(prompt, "[BR]");
+
+	g_string_append(prompt, "> ");
+
+	return prompt->str;
+}
+
+static void show_message(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+
+	vprintf(format, ap);
+
+	va_end(ap);
+
+	rl_redisplay();
+}
+
+static void set_state(enum state st)
+{
+	conn_state = st;
+	rl_set_prompt(get_prompt());
+	rl_redisplay();
+}
+
+static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
+{
+	if (gerr) {
+		show_message("connect error: %s\n", gerr->message);
+		set_state(STATE_DISCONNECTED);
+		return;
+	}
+
+	set_state(STATE_CONNECTED);
+}
+
+static void cmd_connect(char **cmd)
+{
+	if (conn_state != STATE_DISCONNECTED)
+		return;
+
+	if (cmd[1] != NULL) {
+		g_free(opt_dst);
+		opt_dst = strdup(cmd[1]);
+	}
+
+	if (opt_dst == NULL) {
+		show_message("Remote Bluetooth address required\n");
+		return;
+	}
+
+	set_state(STATE_CONNECTING);
+	iochannel = do_connect(opt_le, opt_dst, connect_cb);
+	if (iochannel == NULL)
+		set_state(STATE_DISCONNECTED);
+}
+
+static void cmd_disconnect(char **cmd)
+{
+	if (conn_state == STATE_DISCONNECTED)
+		return;
+
+	g_io_channel_shutdown(iochannel, FALSE, NULL);
+	g_io_channel_unref(iochannel);
+	iochannel = NULL;
+
+	set_state(STATE_DISCONNECTED);
+}
+
+static void cmd_exit(char **cmd)
+{
+	g_main_loop_quit(main_loop);
+}
+
+static struct {
+	char *cmd;
+	void (*func)(char **cmd);
+	char *param;
+	char *desc;
+} commands[] = {
+	{ "connect",	cmd_connect,	"<bdaddr>",	"Connect"},
+	{ "disconnect",	cmd_disconnect,	NULL,		"Disconnect"},
+	{ "exit",	cmd_exit,	NULL,		"Exit"},
+	{ NULL, NULL, NULL, NULL}
+};
+
+static void parse_line(char *line_read)
+{
+	char **command;
+	int j;
+
+	if (!(line_read && *line_read))
+		return;
+
+	add_history(line_read);
+
+	line_read = g_strstrip(line_read);
+
+	command = g_strsplit(line_read, " ", -1);
+	for (j = 0; commands[j].cmd; j++) {
+		if (strcasecmp(commands[j].cmd, command[0]))
+			continue;
+
+		commands[j].func(command);
+	}
+
+	g_strfreev(command);
+}
+
+static gboolean prompt_read(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
+		g_io_channel_unref(chan);
+		return FALSE;
+	}
+
+	if (conn_state != STATE_CONNECTING)
+		rl_callback_read_char();
+
+	return TRUE;
+}
+
+int main(int argc, char *argv[])
+{
+	GOptionContext *context;
+	GIOChannel *pchan;
+	GError *gerr;
+	gint events;
+
+	context = g_option_context_new(NULL);
+	g_option_context_add_main_entries(context, options, NULL);
+
+	if (g_option_context_parse(context, &argc, &argv, &gerr) == FALSE) {
+		g_printerr("%s\n", gerr->message);
+		g_error_free(gerr);
+		exit(1);
+	}
+
+	main_loop = g_main_loop_new(NULL, FALSE);
+
+	prompt = g_string_new(NULL);
+
+	pchan = g_io_channel_unix_new(fileno(stdin));
+	g_io_channel_set_close_on_unref(pchan, TRUE);
+	events = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	g_io_add_watch(pchan, events, prompt_read, NULL);
+
+	rl_callback_handler_install(get_prompt(), parse_line);
+
+	g_main_loop_run(main_loop);
+
+	cmd_disconnect(NULL);
+	rl_callback_handler_remove();
+	g_io_channel_unref(pchan);
+	g_main_loop_unref(main_loop);
+	g_option_context_free(context);
+
+	return 0;
+}
-- 
1.7.1


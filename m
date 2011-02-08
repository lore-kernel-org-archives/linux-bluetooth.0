Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 3/5] Add an initial interactive mode to gatttool
Date: Tue,  8 Feb 2011 12:32:14 -0300
Message-Id: <1297179136-14750-3-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1297179136-14750-1-git-send-email-sheldon.demario@openbossa.org>
References: <1297179136-14750-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Mode required to allow better GATT procedures control. Some scenarios
require sequential commands without disconnection and delay between
operations. It is also desirable to change some connection parameters
of an active connection.
---
 Makefile.am        |    8 ++-
 attrib/gatttool.c  |    9 ++++
 attrib/gatttool.h  |   24 ++++++++++
 attrib/igatttool.c |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac       |    1 +
 5 files changed, 169 insertions(+), 2 deletions(-)
 create mode 100644 attrib/gatttool.h
 create mode 100644 attrib/igatttool.c

diff --git a/Makefile.am b/Makefile.am
index e6639a7..ee3cd82 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -175,12 +175,16 @@ builtin_sources += plugins/service.c
 endif
 
 if ATTRIBPLUGIN
+
+if READLINE
 bin_PROGRAMS += attrib/gatttool
 
 attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 			  attrib/gattrib.c btio/btio.c \
-			  src/glib-helper.h src/glib-helper.c
-attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@
+			  src/glib-helper.h src/glib-helper.c \
+			  attrib/gatttool.h attrib/igatttool.c
+attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @READLINE_LIBS@
+endif
 
 builtin_modules += attrib
 builtin_sources += attrib/main.c \
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index c612309..3eb3b0b 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -42,6 +42,7 @@
 #include "gattrib.h"
 #include "glib-helper.h"
 #include "gatt.h"
+#include "gatttool.h"
 
 /* Minimum MTU for L2CAP connections over BR/EDR */
 #define ATT_MIN_MTU_L2CAP 48
@@ -67,6 +68,7 @@ static struct main_opts {
 	gboolean char_desc;
 	gboolean le;
 	gboolean char_write;
+	gboolean interactive;
 } main_opts;
 
 struct characteristic_data {
@@ -565,6 +567,8 @@ static GOptionEntry gatt_options[] = {
 		"Listen for notifications and indications", NULL },
 	{ "le", 0, 0, G_OPTION_ARG_NONE, &main_opts.le,
 		"Use Bluetooth Low Energy transport", NULL },
+	{ "interactive", 'I', G_OPTION_FLAG_IN_MAIN, G_OPTION_ARG_NONE,
+		&main_opts.interactive, "Use interactive mode", NULL },
 	{ NULL },
 };
 
@@ -624,6 +628,11 @@ int main(int argc, char *argv[])
 		g_error_free(gerr);
 	}
 
+	if (main_opts.interactive) {
+		do_interactive();
+		goto done;
+	}
+
 	if (main_opts.primary)
 		callback = primary;
 	else if (main_opts.char_disc)
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
new file mode 100644
index 0000000..9190730
--- /dev/null
+++ b/attrib/gatttool.h
@@ -0,0 +1,24 @@
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
+int do_interactive(void);
diff --git a/attrib/igatttool.c b/attrib/igatttool.c
new file mode 100644
index 0000000..cac97f0
--- /dev/null
+++ b/attrib/igatttool.c
@@ -0,0 +1,129 @@
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
+#include <strings.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <glib.h>
+
+#include <readline/readline.h>
+#include <readline/history.h>
+
+#include "gatttool.h"
+
+static GMainLoop *event_loop;
+
+static void cmd_help(int argcp, char **argvp);
+static void cmd_exit(int argcp, char **argvp);
+
+static struct {
+	const char *cmd;
+	void (*func)(int argcp, char **argvp);
+	const char *desc;
+} commands[] = {
+	{ "help",	cmd_help,	"Show this help"},
+	{ "exit",	cmd_exit,	"Exit interactive mode"},
+	{ NULL, NULL, NULL}
+};
+
+static void cmd_help(int argcp, char **argvp)
+{
+	int i;
+
+	for (i = 0; commands[i].cmd; i++)
+		printf("%-12s\t%s\n", commands[i].cmd, commands[i].desc);
+}
+
+static void cmd_exit(int argcp, char **argvp)
+{
+	rl_callback_handler_remove();
+	g_main_loop_quit(event_loop);
+}
+
+static void parse_line(char *line_read)
+{
+	gchar **argvp;
+	int argcp;
+	int i;
+
+	if (line_read == NULL) {
+		printf("\n");
+		cmd_exit(0, NULL);
+		return;
+	}
+
+	line_read = g_strstrip(line_read);
+
+	if (*line_read == '\0')
+		return;
+
+	add_history(line_read);
+
+	g_shell_parse_argv(line_read, &argcp, &argvp, NULL);
+
+	for (i = 0; commands[i].cmd; i++)
+		if (strcasecmp(commands[i].cmd, argvp[0]) == 0)
+			break;
+
+	if (commands[i].cmd)
+		commands[i].func(argcp, argvp);
+	else
+		printf("%s: command not found\n", argvp[0]);
+
+	g_strfreev(argvp);
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
+	rl_callback_read_char();
+
+	return TRUE;
+}
+
+int do_interactive(void)
+{
+	GIOChannel *pchan;
+	gint events;
+
+	event_loop = g_main_loop_new(NULL, FALSE);
+
+	pchan = g_io_channel_unix_new(fileno(stdin));
+	g_io_channel_set_close_on_unref(pchan, TRUE);
+	events = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	g_io_add_watch(pchan, events, prompt_read, NULL);
+
+	rl_callback_handler_install("> ", parse_line);
+
+	g_main_loop_run(event_loop);
+
+	rl_callback_handler_remove();
+	g_io_channel_unref(pchan);
+	g_main_loop_unref(event_loop);
+
+	return 0;
+}
diff --git a/configure.ac b/configure.ac
index bebdc9c..a8e8fc6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -42,6 +42,7 @@ AC_PATH_GSTREAMER
 AC_PATH_USB
 AC_PATH_SNDFILE
 AC_PATH_OUI
+AC_PATH_READLINE
 
 AC_ARG_BLUEZ
 
-- 
1.7.1


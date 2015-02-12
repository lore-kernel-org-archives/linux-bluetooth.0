Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 1/5] client/display: Add initial code for handling interactive mode
Date: Thu, 12 Feb 2015 18:52:09 +0100
Message-Id: <1423763533-15071-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to have interactive mode code in single place.
This code will allow to register commands, handle input, history,
completion etc.

Another benefit is abstracting readline which will allow to have
different backend on platforms that don't support it (ie Android).
---
 Makefile.tools   |   5 +-
 client/agent.c   |   1 +
 client/display.c | 273 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 client/display.h |  20 +++-
 tools/btmgmt.c   |   4 +-
 5 files changed, 298 insertions(+), 5 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index e28f3cb..d721b4a 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -8,6 +8,7 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/gatt.h client/gatt.c \
 					monitor/uuid.h monitor/uuid.c
 client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@ \
+				src/libshared-mainloop.la \
 				-lreadline
 endif
 
@@ -300,6 +301,7 @@ attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 				attrib/utils.c src/log.c client/display.c \
 				client/display.h
 attrib_gatttool_LDADD = lib/libbluetooth-internal.la \
+			src/libshared-mainloop.la \
 			src/libshared-glib.la @GLIB_LIBS@ -lreadline
 
 tools_obex_client_tool_SOURCES = $(gobex_sources) $(btio_sources) \
@@ -314,11 +316,12 @@ tools_obex_server_tool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 tools_bluetooth_player_SOURCES = tools/bluetooth-player.c \
 				client/display.h client/display.c
 tools_bluetooth_player_LDADD = gdbus/libgdbus-internal.la \
+				src/libshared-mainloop.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ -lreadline
 
 tools_obexctl_SOURCES = tools/obexctl.c \
 				client/display.h client/display.c
-tools_obexctl_LDADD = gdbus/libgdbus-internal.la \
+tools_obexctl_LDADD = gdbus/libgdbus-internal.la src/libshared-mainloop.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ -lreadline
 endif
 
diff --git a/client/agent.c b/client/agent.c
index eeabd5b..1034cad 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <readline/readline.h>
 #include <gdbus.h>
 
diff --git a/client/display.c b/client/display.c
index 619973c..f016853 100644
--- a/client/display.c
+++ b/client/display.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2012  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012-2015  Intel Corporation. All rights reserved.
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -29,10 +29,22 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <stdbool.h>
+#include <unistd.h>
+#include <wordexp.h>
 #include <readline/readline.h>
+#include <readline/history.h>
+
+#include "src/shared/mainloop.h"
+#include "src/shared/io.h"
 
 #include "display.h"
 
+static char *saved_prompt = NULL;
+static int saved_point = 0;
+static struct io *input = NULL;
+static const struct interactive_command *commands = NULL;
+static interactive_prompt_func_t prompt_cb = NULL;
+
 void rl_printf(const char *fmt, ...)
 {
 	va_list args;
@@ -103,3 +115,262 @@ void rl_hexdump(const unsigned char *buf, size_t len)
 		rl_printf("%s\n", str);
 	}
 }
+
+void interactive_release_prompt(void)
+{
+	if (!saved_prompt)
+		return;
+
+	/* This will cause rl_expand_prompt to re-run over the last prompt,
+	 * but our prompt doesn't expand anyway.
+	 */
+	rl_set_prompt(saved_prompt);
+	rl_replace_line("", 0);
+	rl_point = saved_point;
+	rl_redisplay();
+
+	free(saved_prompt);
+	saved_prompt = NULL;
+}
+
+void interactive_update_prompt(const char *prompt)
+{
+	if (saved_prompt) {
+		free(saved_prompt);
+		saved_prompt = strdup(prompt);
+		return;
+	}
+
+	rl_set_prompt(prompt);
+}
+
+void interactive_prompt(const char *msg)
+{
+	if (saved_prompt)
+		return;
+
+	saved_prompt = strdup(rl_prompt);
+	if (!saved_prompt)
+		return;
+
+	saved_point = rl_point;
+
+	rl_set_prompt("");
+	rl_redisplay();
+
+	rl_set_prompt(msg);
+
+	rl_replace_line("", 0);
+	rl_redisplay();
+}
+
+static void cmd_quit(int argc, char **argv)
+{
+	mainloop_exit_success();
+}
+
+static struct interactive_command interactive_cmd[] = {
+	{ "quit",	cmd_quit,	"Exit program"			},
+	{ "exit",	cmd_quit,	"Exit program"			},
+	{ "help",	NULL,		"List supported commands"	},
+	{ }
+};
+
+static char *cmd_generator(const char *text, int state)
+{
+	static int i, j, len;
+	const char *cmd;
+
+	if (!state) {
+		i = 0;
+		j = 0;
+		len = strlen(text);
+	}
+
+	while ((cmd = commands[i].cmd)) {
+		i++;
+
+		if (!strncmp(cmd, text, len))
+			return strdup(cmd);
+	}
+
+	while ((cmd = interactive_cmd[j].cmd)) {
+		j++;
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
+	if (start > 0) {
+		int i;
+
+		for (i = 0; commands[i].cmd; i++) {
+			if (strncmp(commands[i].cmd,
+					rl_line_buffer, start - 1))
+				continue;
+
+			if (!commands[i].gen)
+				continue;
+
+			rl_completion_display_matches_hook = commands[i].disp;
+			matches = rl_completion_matches(text, commands[i].gen);
+			break;
+		}
+	} else {
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
+	wordexp_t w;
+	char *cmd, **argv;
+	size_t argc;
+	int i;
+
+	if (!input) {
+		rl_insert_text("quit");
+		rl_redisplay();
+		rl_crlf();
+		mainloop_quit();
+		return;
+	}
+
+	if (!strlen(input))
+		goto done;
+
+	if (prompt_cb(input))
+		goto done;
+
+	add_history(input);
+
+	if (wordexp(input, &w, WRDE_NOCMD))
+		goto done;
+
+	if (w.we_wordc == 0)
+		goto free_we;
+
+	cmd = w.we_wordv[0];
+	argv = w.we_wordv;
+	argc = w.we_wordc;
+
+	if (!strcmp(cmd, "quit") || !strcmp(cmd, "exit")) {
+		mainloop_quit();
+		goto free_we;
+	}
+
+	for (i = 0; commands[i].cmd; i++) {
+		if (strcmp(cmd, commands[i].cmd))
+			continue;
+
+		if (commands[i].func) {
+			commands[i].func(argc, argv);
+			goto free_we;
+		}
+	}
+
+	for (i = 0; interactive_cmd[i].cmd; i++) {
+		if (strcmp(cmd, interactive_cmd[i].cmd))
+			continue;
+
+		if (interactive_cmd[i].func) {
+			interactive_cmd[i].func(argc, argv);
+			goto free_we;
+		}
+	}
+
+	if (strcmp(cmd, "help")) {
+		rl_printf("Invalid command\n");
+		goto free_we;
+	}
+
+	rl_printf("Available commands:\n");
+
+	for (i = 0; commands[i].cmd; i++) {
+		if (commands[i].doc)
+			rl_printf("  %s %-*s %s\n", commands[i].cmd,
+					(int)(25 - strlen(commands[i].cmd)),
+					"", commands[i].doc ? : "");
+	}
+
+	for (i = 0; interactive_cmd[i].cmd; i++) {
+		if (!interactive_cmd[i].doc)
+			continue;
+
+		rl_printf("  %s %-*s %s\n", interactive_cmd[i].cmd,
+				(int)(25 - strlen(interactive_cmd[i].cmd)),
+				"", interactive_cmd[i].doc ? : "");
+	}
+
+free_we:
+	wordfree(&w);
+done:
+	free(input);
+}
+
+static bool prompt_read(struct io *io, void *user_data)
+{
+	rl_callback_read_char();
+	return true;
+}
+
+static struct io *setup_stdin(void)
+{
+	struct io *io;
+
+	io = io_new(STDIN_FILENO);
+	if (!io)
+		return io;
+
+	io_set_read_handler(io, prompt_read, NULL, NULL);
+
+	return io;
+}
+
+bool interactive_init(const char *prompt, interactive_prompt_func_t cb,
+					const struct interactive_command *cmd)
+{
+	if (!prompt || !cb || !cmd)
+		return false;
+
+	input = setup_stdin();
+	if (!input)
+		return false;
+
+	commands = cmd;
+	prompt_cb = cb;
+
+	rl_attempted_completion_function = cmd_completion;
+
+	rl_erase_empty_line = 1;
+	rl_callback_handler_install(NULL, rl_handler);
+
+	rl_set_prompt(prompt);
+	rl_redisplay();
+
+	return true;
+}
+
+void interactive_cleanup(void)
+{
+	if (!input)
+		return;
+
+	io_destroy(input);
+
+	rl_message("");
+	rl_callback_handler_remove();
+}
diff --git a/client/display.h b/client/display.h
index 88dbbd0..c858639 100644
--- a/client/display.h
+++ b/client/display.h
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2012  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012-2015  Intel Corporation. All rights reserved.
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -29,5 +29,23 @@
 #define COLOR_BOLDGRAY	"\x1B[1;30m"
 #define COLOR_BOLDWHITE	"\x1B[1;37m"
 
+struct interactive_command {
+	char *cmd;
+	void (*func)(int argc, char **argv);
+	char *doc;
+	char * (*gen)(const char *text, int state);
+	void (*disp)(char **matches, int num_matches, int max_length);
+};
+
+typedef bool (*interactive_prompt_func_t)(const char *prompt);
+
+bool interactive_init(const char *prompt, interactive_prompt_func_t cb,
+					const struct interactive_command *cmd);
+void interactive_cleanup(void);
+
+void interactive_update_prompt(const char *prompt);
+void interactive_prompt(const char *msg);
+void interactive_release_prompt(void);
+
 void rl_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
 void rl_hexdump(const unsigned char *buf, size_t len);
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index c8fc9f6..e3bd5ce 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -801,7 +801,7 @@ static bool prompt_input(const char *input)
 	return true;
 }
 
-static void interactive_prompt(const char *msg)
+static void btmgmt_interactive_prompt(const char *msg)
 {
 	if (saved_prompt)
 		return;
@@ -856,7 +856,7 @@ static void ask(uint16_t index, uint16_t req, const struct mgmt_addr_info *addr,
 					COLOR_BOLDGRAY ">>" COLOR_OFF);
 
 	if (interactive) {
-		interactive_prompt(msg);
+		btmgmt_interactive_prompt(msg);
 		va_end(ap);
 		return;
 	}
-- 
1.9.3


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] client: Use bt_shell to process commands.
Date: Fri, 22 Sep 2017 01:00:00 -0400
Message-Id: <20170922050002.24002-3-marcin.kraglak@tieto.com>
In-Reply-To: <20170922050002.24002-1-marcin.kraglak@tieto.com>
References: <20170922050002.24002-1-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use bt_shell to process and print available commands.
---
 Makefile.tools |  3 ++-
 client/main.c  | 44 ++++++--------------------------------------
 2 files changed, 8 insertions(+), 39 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 561302fa1..4893acd8a 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -8,7 +8,8 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/advertising.h \
 					client/advertising.c \
 					client/gatt.h client/gatt.c \
-					monitor/uuid.h monitor/uuid.c
+					monitor/uuid.h monitor/uuid.c \
+					src/shared/bt_shell.h src/shared/bt_shell.c
 client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ -lreadline
 endif
diff --git a/client/main.c b/client/main.c
index 91b728a12..87019b463 100644
--- a/client/main.c
+++ b/client/main.c
@@ -38,6 +38,7 @@
 #include <readline/history.h>
 #include <glib.h>
 
+#include "src/shared/bt_shell.h"
 #include "src/shared/util.h"
 #include "gdbus/gdbus.h"
 #include "monitor/uuid.h"
@@ -2435,14 +2436,7 @@ static void cmd_set_advertise_appearance(const char *arg)
 	ad_advertise_local_appearance(dbus_conn, value);
 }
 
-static const struct {
-	const char *cmd;
-	const char *arg;
-	void (*func) (const char *arg);
-	const char *desc;
-	char * (*gen) (const char *text, int state);
-	void (*disp) (char **matches, int num_matches, int max_length);
-} cmd_table[] = {
+static const struct bt_shell_menu_entry cmd_table[] = {
 	{ "list",         NULL,       cmd_list, "List available controllers" },
 	{ "show",         "[ctrl]",   cmd_show, "Controller information",
 							ctrl_generator },
@@ -2630,7 +2624,6 @@ static char **cmd_completion(const char *text, int start, int end)
 static void rl_handler(char *input)
 {
 	char *cmd, *arg;
-	int i;
 
 	if (!input) {
 		rl_insert_text("quit");
@@ -2659,41 +2652,14 @@ static void rl_handler(char *input)
 			arg[len - 1] = '\0';
 	}
 
-	for (i = 0; cmd_table[i].cmd; i++) {
-		if (strcmp(cmd, cmd_table[i].cmd))
-			continue;
-
-		if (cmd_table[i].func) {
-			cmd_table[i].func(arg);
-			goto done;
-		}
-	}
-
-	printf("Invalid command\n");
+	bt_shell_process(cmd, arg);
 done:
 	free(input);
 }
 
 static void cmd_help(const char *arg)
 {
-	int i;
-
-	printf("Available commands:\n");
-
-	for (i = 0; cmd_table[i].cmd; i++) {
-		if ((int)strlen(cmd_table[i].arg? : "") <=
-					(int)(25 - strlen(cmd_table[i].cmd)))
-			printf("  %s %-*s %s\n", cmd_table[i].cmd,
-					(int)(25 - strlen(cmd_table[i].cmd)),
-					cmd_table[i].arg ? : "",
-					cmd_table[i].desc ? : "");
-		else
-			printf("  %s %-s\n" "  %s %-25s %s\n",
-					cmd_table[i].cmd,
-					cmd_table[i].arg ? : "",
-					"", "",
-					cmd_table[i].desc ? : "");
-	}
+	bt_shell_print_menu();
 }
 
 static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
@@ -2844,6 +2810,7 @@ int main(int argc, char *argv[])
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 	g_dbus_attach_object_manager(dbus_conn);
 
+	bt_shell_init(cmd_table);
 	setlinebuf(stdout);
 	rl_attempted_completion_function = cmd_completion;
 
@@ -2874,6 +2841,7 @@ int main(int argc, char *argv[])
 
 	rl_message("");
 	rl_callback_handler_remove();
+	bt_shell_cleanup();
 
 	dbus_connection_unref(dbus_conn);
 	g_main_loop_unref(main_loop);
-- 
2.13.5


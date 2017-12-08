Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/10] tools/obexctl: Use bt_shell helpers
Date: Fri,  8 Dec 2017 08:52:50 -0200
Message-Id: <20171208105256.18635-4-luiz.dentz@gmail.com>
In-Reply-To: <20171208105256.18635-1-luiz.dentz@gmail.com>
References: <20171208105256.18635-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes obexctl use bt_shell to manage the menus and command
handling.
---
 Makefile.tools  |   5 +-
 tools/obexctl.c | 678 +++++++++++++-------------------------------------------
 2 files changed, 152 insertions(+), 531 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index ba717e6cf..1cf19035d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -394,9 +394,8 @@ tools_bluetooth_player_SOURCES = tools/bluetooth-player.c \
 tools_bluetooth_player_LDADD = gdbus/libgdbus-internal.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ -lreadline
 
-tools_obexctl_SOURCES = tools/obexctl.c \
-				client/display.h client/display.c
-tools_obexctl_LDADD = gdbus/libgdbus-internal.la \
+tools_obexctl_SOURCES = tools/obexctl.c
+tools_obexctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ -lreadline
 
 tools_btmgmt_SOURCES = tools/btmgmt.c src/uuid-helper.c client/display.c
diff --git a/tools/obexctl.c b/tools/obexctl.c
index 33ee180a3..f5ab29612 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -30,17 +30,15 @@
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
-#include <signal.h>
-#include <sys/signalfd.h>
+#include <string.h>
 #include <inttypes.h>
 #include <wordexp.h>
+#include <ctype.h>
 
-#include <readline/readline.h>
-#include <readline/history.h>
 #include <glib.h>
 
 #include "gdbus/gdbus.h"
-#include "client/display.h"
+#include "src/shared/shell.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -59,7 +57,6 @@
 #define OBEX_MAP_INTERFACE "org.bluez.obex.MessageAccess1"
 #define OBEX_MSG_INTERFACE "org.bluez.obex.Message1"
 
-static GMainLoop *main_loop;
 static DBusConnection *dbus_conn;
 static GDBusProxy *default_session;
 static GSList *sessions = NULL;
@@ -78,23 +75,12 @@ struct transfer_data {
 
 static void connect_handler(DBusConnection *connection, void *user_data)
 {
-	rl_set_prompt(PROMPT_ON);
-	printf("\r");
-	rl_on_new_line();
-	rl_redisplay();
+	bt_shell_set_prompt(PROMPT_ON);
 }
 
 static void disconnect_handler(DBusConnection *connection, void *user_data)
 {
-	rl_set_prompt(PROMPT_OFF);
-	printf("\r");
-	rl_on_new_line();
-	rl_redisplay();
-}
-
-static void cmd_quit(int argc, char *argv[])
-{
-	g_main_loop_quit(main_loop);
+	bt_shell_set_prompt(PROMPT_OFF);
 }
 
 static void connect_reply(DBusMessage *message, void *user_data)
@@ -104,12 +90,12 @@ static void connect_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to connect: %s\n", error.name);
+		bt_shell_printf("Failed to connect: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Connection successful\n");
+	bt_shell_printf("Connection successful\n");
 }
 
 static void append_variant(DBusMessageIter *iter, int type, void *val)
@@ -187,13 +173,8 @@ static void cmd_connect(int argc, char *argv[])
 	struct connect_args *args;
 	const char *target = "opp";
 
-	if (argc < 2) {
-		rl_printf("Missing device address argument\n");
-		return;
-	}
-
 	if (!client) {
-		rl_printf("Client proxy not available\n");
+		bt_shell_printf("Client proxy not available\n");
 		return;
 	}
 
@@ -206,11 +187,11 @@ static void cmd_connect(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(client, "CreateSession", connect_setup,
 			connect_reply, args, connect_args_free) == FALSE) {
-		rl_printf("Failed to connect\n");
+		bt_shell_printf("Failed to connect\n");
 		return;
 	}
 
-	rl_printf("Attempting to connect to %s\n", argv[1]);
+	bt_shell_printf("Attempting to connect to %s\n", argv[1]);
 }
 
 static void disconnect_reply(DBusMessage *message, void *user_data)
@@ -220,12 +201,12 @@ static void disconnect_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to disconnect: %s\n", error.name);
+		bt_shell_printf("Failed to disconnect: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Disconnection successful\n");
+	bt_shell_printf("Disconnection successful\n");
 }
 
 static void disconnect_setup(DBusMessageIter *iter, void *user_data)
@@ -262,17 +243,17 @@ static void cmd_disconnect(int argc, char *argv[])
 		proxy = default_session;
 
 	if (proxy == NULL) {
-		rl_printf("Session not available\n");
+		bt_shell_printf("Session not available\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(client, "RemoveSession", disconnect_setup,
 				disconnect_reply, proxy, NULL) == FALSE) {
-		rl_printf("Failed to disconnect\n");
+		bt_shell_printf("Failed to disconnect\n");
 		return;
 	}
 
-	rl_printf("Attempting to disconnect to %s\n",
+	bt_shell_printf("Attempting to disconnect to %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -297,7 +278,7 @@ static void print_proxy(GDBusProxy *proxy, const char *title,
 
 	str = proxy_description(proxy, title, description);
 
-	rl_printf("%s%s\n", str, default_session == proxy ? "[default]" : "");
+	bt_shell_printf("%s%s\n", str, default_session == proxy ? "[default]" : "");
 
 	g_free(str);
 }
@@ -315,7 +296,7 @@ static void cmd_list(int argc, char *arg[])
 static bool check_default_session(void)
 {
 	if (!default_session) {
-		rl_printf("No default session available\n");
+		bt_shell_printf("No default session available\n");
 		return FALSE;
 	}
 
@@ -334,39 +315,39 @@ static void print_iter(const char *label, const char *name,
 	DBusMessageIter subiter;
 
 	if (iter == NULL) {
-		rl_printf("%s%s is nil\n", label, name);
+		bt_shell_printf("%s%s is nil\n", label, name);
 		return;
 	}
 
 	switch (dbus_message_iter_get_arg_type(iter)) {
 	case DBUS_TYPE_INVALID:
-		rl_printf("%s%s is invalid\n", label, name);
+		bt_shell_printf("%s%s is invalid\n", label, name);
 		break;
 	case DBUS_TYPE_STRING:
 	case DBUS_TYPE_OBJECT_PATH:
 		dbus_message_iter_get_basic(iter, &valstr);
-		rl_printf("%s%s: %s\n", label, name, valstr);
+		bt_shell_printf("%s%s: %s\n", label, name, valstr);
 		break;
 	case DBUS_TYPE_BOOLEAN:
 		dbus_message_iter_get_basic(iter, &valbool);
-		rl_printf("%s%s: %s\n", label, name,
+		bt_shell_printf("%s%s: %s\n", label, name,
 					valbool == TRUE ? "yes" : "no");
 		break;
 	case DBUS_TYPE_UINT64:
 		dbus_message_iter_get_basic(iter, &valu64);
-		rl_printf("%s%s: %" PRIu64 "\n", label, name, valu64);
+		bt_shell_printf("%s%s: %" PRIu64 "\n", label, name, valu64);
 		break;
 	case DBUS_TYPE_UINT32:
 		dbus_message_iter_get_basic(iter, &valu32);
-		rl_printf("%s%s: 0x%08x\n", label, name, valu32);
+		bt_shell_printf("%s%s: 0x%08x\n", label, name, valu32);
 		break;
 	case DBUS_TYPE_UINT16:
 		dbus_message_iter_get_basic(iter, &valu16);
-		rl_printf("%s%s: 0x%04x\n", label, name, valu16);
+		bt_shell_printf("%s%s: 0x%04x\n", label, name, valu16);
 		break;
 	case DBUS_TYPE_INT16:
 		dbus_message_iter_get_basic(iter, &vals16);
-		rl_printf("%s%s: %d\n", label, name, vals16);
+		bt_shell_printf("%s%s: %d\n", label, name, vals16);
 		break;
 	case DBUS_TYPE_VARIANT:
 		dbus_message_iter_recurse(iter, &subiter);
@@ -387,7 +368,7 @@ static void print_iter(const char *label, const char *name,
 		print_iter(label, valstr, &subiter);
 		break;
 	default:
-		rl_printf("%s%s has unsupported type\n", label, name);
+		bt_shell_printf("%s%s has unsupported type\n", label, name);
 		break;
 	}
 }
@@ -414,12 +395,12 @@ static void cmd_show(int argc, char *argv[])
 	} else {
 		proxy = find_session(argv[1]);
 		if (!proxy) {
-			rl_printf("Session %s not available\n", argv[1]);
+			bt_shell_printf("Session %s not available\n", argv[1]);
 			return;
 		}
 	}
 
-	rl_printf("Session %s\n", g_dbus_proxy_get_path(proxy));
+	bt_shell_printf("Session %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(proxy, "Destination");
 	print_property(proxy, "Target");
@@ -441,8 +422,7 @@ static void set_default_session(GDBusProxy *proxy)
 	desc = g_strdup_printf(COLOR_BLUE "[%s]" COLOR_OFF "# ", desc);
 
 done:
-	rl_set_prompt(desc);
-	rl_redisplay();
+	bt_shell_set_prompt(desc);
 	g_free(desc);
 }
 
@@ -450,14 +430,9 @@ static void cmd_select(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	if (argc < 2) {
-		rl_printf("Missing session address argument\n");
-		return;
-	}
-
 	proxy = find_session(argv[1]);
 	if (proxy == NULL) {
-		rl_printf("Session %s not available\n", argv[1]);
+		bt_shell_printf("Session %s not available\n", argv[1]);
 		return;
 	}
 
@@ -499,7 +474,7 @@ static GDBusProxy *find_message(const char *path)
 
 static void transfer_info(GDBusProxy *proxy, int argc, char *argv[])
 {
-	rl_printf("Transfer %s\n", g_dbus_proxy_get_path(proxy));
+	bt_shell_printf("Transfer %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(proxy, "Session");
 	print_property(proxy, "Name");
@@ -513,7 +488,7 @@ static void transfer_info(GDBusProxy *proxy, int argc, char *argv[])
 
 static void message_info(GDBusProxy *proxy, int argc, char *argv[])
 {
-	rl_printf("Message %s\n", g_dbus_proxy_get_path(proxy));
+	bt_shell_printf("Message %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(proxy, "Folder");
 	print_property(proxy, "Subject");
@@ -537,11 +512,6 @@ static void cmd_info(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	if (argc < 2) {
-		rl_printf("Missing object path argument\n");
-		return;
-	}
-
 	proxy = find_transfer(argv[1]);
 	if (proxy) {
 		transfer_info(proxy, argc, argv);
@@ -554,7 +524,7 @@ static void cmd_info(int argc, char *argv[])
 		return;
 	}
 
-	rl_printf("Object %s not available\n", argv[1]);
+	bt_shell_printf("Object %s not available\n", argv[1]);
 }
 
 static void cancel_reply(DBusMessage *message, void *user_data)
@@ -564,36 +534,31 @@ static void cancel_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to cancel: %s\n", error.name);
+		bt_shell_printf("Failed to cancel: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Cancel successful\n");
+	bt_shell_printf("Cancel successful\n");
 }
 
 static void cmd_cancel(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	if (argc < 2) {
-		rl_printf("Missing transfer address argument\n");
-		return;
-	}
-
 	proxy = find_transfer(argv[1]);
 	if (!proxy) {
-		rl_printf("Transfer %s not available\n", argv[1]);
+		bt_shell_printf("Transfer %s not available\n", argv[1]);
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "Cancel", NULL, cancel_reply, NULL,
 							NULL) == FALSE) {
-		rl_printf("Failed to cancel transfer\n");
+		bt_shell_printf("Failed to cancel transfer\n");
 		return;
 	}
 
-	rl_printf("Attempting to cancel transfer %s\n",
+	bt_shell_printf("Attempting to cancel transfer %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -604,36 +569,31 @@ static void suspend_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to suspend: %s\n", error.name);
+		bt_shell_printf("Failed to suspend: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Suspend successful\n");
+	bt_shell_printf("Suspend successful\n");
 }
 
 static void cmd_suspend(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	if (argc < 2) {
-		rl_printf("Missing transfer address argument\n");
-		return;
-	}
-
 	proxy = find_transfer(argv[1]);
 	if (!proxy) {
-		rl_printf("Transfer %s not available\n", argv[1]);
+		bt_shell_printf("Transfer %s not available\n", argv[1]);
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "Suspend", NULL, suspend_reply,
 						NULL, NULL) == FALSE) {
-		rl_printf("Failed to suspend transfer\n");
+		bt_shell_printf("Failed to suspend transfer\n");
 		return;
 	}
 
-	rl_printf("Attempting to suspend transfer %s\n",
+	bt_shell_printf("Attempting to suspend transfer %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -644,36 +604,31 @@ static void resume_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to resume: %s\n", error.name);
+		bt_shell_printf("Failed to resume: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Resume successful\n");
+	bt_shell_printf("Resume successful\n");
 }
 
 static void cmd_resume(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	if (argc < 2) {
-		rl_printf("Missing transfer address argument\n");
-		return;
-	}
-
 	proxy = find_transfer(argv[1]);
 	if (!proxy) {
-		rl_printf("Transfer %s not available\n", argv[1]);
+		bt_shell_printf("Transfer %s not available\n", argv[1]);
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "Resume", NULL, resume_reply,
 						NULL, NULL) == FALSE) {
-		rl_printf("Failed to resume transfer\n");
+		bt_shell_printf("Failed to resume transfer\n");
 		return;
 	}
 
-	rl_printf("Attempting to resume transfer %s\n",
+	bt_shell_printf("Attempting to resume transfer %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -743,7 +698,7 @@ static void print_transfer_iter(DBusMessageIter *iter)
 
 	dbus_message_iter_get_basic(iter, &path);
 
-	rl_printf("Transfer %s\n", path);
+	bt_shell_printf("Transfer %s\n", path);
 
 	dbus_message_iter_next(iter);
 
@@ -758,7 +713,7 @@ static void send_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to send/pull: %s\n", error.name);
+		bt_shell_printf("Failed to send/pull: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -777,35 +732,25 @@ static void send_setup(DBusMessageIter *iter, void *user_data)
 
 static void opp_send(GDBusProxy *proxy, int argc, char *argv[])
 {
-	if (argc < 2) {
-		rl_printf("Missing file argument\n");
-		return;
-	}
-
 	if (g_dbus_proxy_method_call(proxy, "SendFile", send_setup, send_reply,
 					g_strdup(argv[1]), g_free) == FALSE) {
-		rl_printf("Failed to send\n");
+		bt_shell_printf("Failed to send\n");
 		return;
 	}
 
-	rl_printf("Attempting to send %s to %s\n", argv[1],
+	bt_shell_printf("Attempting to send %s to %s\n", argv[1],
 						g_dbus_proxy_get_path(proxy));
 }
 
 static void opp_pull(GDBusProxy *proxy, int argc, char *argv[])
 {
-	if (argc < 2) {
-		rl_printf("Missing file argument\n");
-		return;
-	}
-
 	if (g_dbus_proxy_method_call(proxy, "PullBusinessCard", send_setup,
 			send_reply, g_strdup(argv[1]), g_free) == FALSE) {
-		rl_printf("Failed to pull\n");
+		bt_shell_printf("Failed to pull\n");
 		return;
 	}
 
-	rl_printf("Attempting to pull %s from %s\n", argv[1],
+	bt_shell_printf("Attempting to pull %s from %s\n", argv[1],
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -817,7 +762,7 @@ static void push_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to PushMessage: %s\n", error.name);
+		bt_shell_printf("Failed to PushMessage: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -848,19 +793,14 @@ static void push_setup(DBusMessageIter *iter, void *user_data)
 
 static void map_send(GDBusProxy *proxy, int argc, char *argv[])
 {
-	if (argc < 2) {
-		rl_printf("Missing file argument\n");
-		return;
-	}
-
 	if (g_dbus_proxy_method_call(proxy, "PushMessage", push_setup,
 					push_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to send\n");
+		bt_shell_printf("Failed to send\n");
 		return;
 	}
 
-	rl_printf("Attempting to send %s to %s\n", argv[1],
+	bt_shell_printf("Attempting to send %s to %s\n", argv[1],
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -883,7 +823,7 @@ static void cmd_send(int argc, char *argv[])
 		return;
 	}
 
-	rl_printf("Command not supported\n");
+	bt_shell_printf("Command not supported\n");
 }
 
 static void cmd_pull(int argc, char *argv[])
@@ -899,7 +839,7 @@ static void cmd_pull(int argc, char *argv[])
 		return;
 	}
 
-	rl_printf("Command not supported\n");
+	bt_shell_printf("Command not supported\n");
 }
 
 static void change_folder_reply(DBusMessage *message, void *user_data)
@@ -909,12 +849,12 @@ static void change_folder_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to ChangeFolder: %s\n", error.name);
+		bt_shell_printf("Failed to ChangeFolder: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("ChangeFolder successful\n");
+	bt_shell_printf("ChangeFolder successful\n");
 }
 
 static void change_folder_setup(DBusMessageIter *iter, void *user_data)
@@ -932,14 +872,14 @@ static void select_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to Select: %s\n", error.name);
+		bt_shell_printf("Failed to Select: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
 	dbus_message_iter_init(message, &iter);
 
-	rl_printf("Select successful\n");
+	bt_shell_printf("Select successful\n");
 }
 
 static void select_setup(DBusMessageIter *iter, void *user_data)
@@ -958,12 +898,12 @@ static void setfolder_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to SetFolder: %s\n", error.name);
+		bt_shell_printf("Failed to SetFolder: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("SetFolder successful\n");
+	bt_shell_printf("SetFolder successful\n");
 }
 
 static void setfolder_setup(DBusMessageIter *iter, void *user_data)
@@ -1003,53 +943,38 @@ static GDBusProxy *find_pbap(const char *path)
 
 static void ftp_cd(GDBusProxy *proxy, int argc, char *argv[])
 {
-	if (argc < 2) {
-		rl_printf("Missing path argument\n");
-		return;
-	}
-
 	if (g_dbus_proxy_method_call(proxy, "ChangeFolder", change_folder_setup,
 					change_folder_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to ChangeFolder\n");
+		bt_shell_printf("Failed to ChangeFolder\n");
 		return;
 	}
 
-	rl_printf("Attempting to ChangeFolder to %s\n", argv[1]);
+	bt_shell_printf("Attempting to ChangeFolder to %s\n", argv[1]);
 }
 
 static void pbap_cd(GDBusProxy *proxy, int argc, char *argv[])
 {
-	if (argc < 2) {
-		rl_printf("Missing path argument\n");
-		return;
-	}
-
 	if (g_dbus_proxy_method_call(proxy, "Select", select_setup,
 					select_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to Select\n");
+		bt_shell_printf("Failed to Select\n");
 		return;
 	}
 
-	rl_printf("Attempting to Select to %s\n", argv[1]);
+	bt_shell_printf("Attempting to Select to %s\n", argv[1]);
 }
 
 static void map_cd(GDBusProxy *proxy, int argc, char *argv[])
 {
-	if (argc < 2) {
-		rl_printf("Missing path argument\n");
-		return;
-	}
-
 	if (g_dbus_proxy_method_call(proxy, "SetFolder", setfolder_setup,
 					setfolder_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to SetFolder\n");
+		bt_shell_printf("Failed to SetFolder\n");
 		return;
 	}
 
-	rl_printf("Attempting to SetFolder to %s\n", argv[1]);
+	bt_shell_printf("Attempting to SetFolder to %s\n", argv[1]);
 }
 
 static void cmd_cd(int argc, char *argv[])
@@ -1077,7 +1002,7 @@ static void cmd_cd(int argc, char *argv[])
 		return;
 	}
 
-	rl_printf("Command not supported\n");
+	bt_shell_printf("Command not supported\n");
 }
 
 static void list_folder_reply(DBusMessage *message, void *user_data)
@@ -1088,7 +1013,7 @@ static void list_folder_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to ListFolder: %s\n", error.name);
+		bt_shell_printf("Failed to ListFolder: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1111,11 +1036,11 @@ static void ftp_ls(GDBusProxy *proxy, int argc, char *argv[])
 	if (g_dbus_proxy_method_call(proxy, "ListFolder", NULL,
 						list_folder_reply, NULL,
 						NULL) == FALSE) {
-		rl_printf("Failed to ls\n");
+		bt_shell_printf("Failed to ls\n");
 		return;
 	}
 
-	rl_printf("Attempting to ListFolder\n");
+	bt_shell_printf("Attempting to ListFolder\n");
 }
 
 static void parse_list_reply(DBusMessage *message)
@@ -1152,7 +1077,7 @@ static void list_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to List: %s\n", error.name);
+		bt_shell_printf("Failed to List: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1181,7 +1106,7 @@ static void search_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to Search: %s\n", error.name);
+		bt_shell_printf("Failed to Search: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1215,11 +1140,11 @@ static void pbap_search(GDBusProxy *proxy, int argc, char *argv[])
 	if (g_dbus_proxy_method_call(proxy, "Search", search_setup,
 					search_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to Search\n");
+		bt_shell_printf("Failed to Search\n");
 		return;
 	}
 
-	rl_printf("Attempting to Search\n");
+	bt_shell_printf("Attempting to Search\n");
 }
 
 static void list_folders_reply(DBusMessage *message, void *user_data)
@@ -1230,7 +1155,7 @@ static void list_folders_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to ListFolders: %s\n", error.name);
+		bt_shell_printf("Failed to ListFolders: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1270,7 +1195,7 @@ static void list_messages_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to ListFolders: %s\n", error.name);
+		bt_shell_printf("Failed to ListFolders: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1289,7 +1214,7 @@ static void list_messages_reply(DBusMessage *message, void *user_data)
 
 		dbus_message_iter_recurse(&array, &entry);
 		dbus_message_iter_get_basic(&entry, &obj);
-		rl_printf("\t%s\n", obj);
+		bt_shell_printf("\t%s\n", obj);
 		dbus_message_iter_next(&array);
 	}
 }
@@ -1318,11 +1243,11 @@ static void pbap_list(GDBusProxy *proxy, int argc, char *argv[])
 {
 	if (g_dbus_proxy_method_call(proxy, "List", list_setup, list_reply,
 						NULL, NULL) == FALSE) {
-		rl_printf("Failed to List\n");
+		bt_shell_printf("Failed to List\n");
 		return;
 	}
 
-	rl_printf("Attempting to List\n");
+	bt_shell_printf("Attempting to List\n");
 }
 
 static void get_size_reply(DBusMessage *message, void *user_data)
@@ -1334,7 +1259,7 @@ static void get_size_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to GetSize: %s\n", error.name);
+		bt_shell_printf("Failed to GetSize: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1350,11 +1275,11 @@ static void pbap_get_size(GDBusProxy *proxy, int argc, char *argv[])
 {
 	if (g_dbus_proxy_method_call(proxy, "GetSize", NULL, get_size_reply,
 						proxy, NULL) == FALSE) {
-		rl_printf("Failed to GetSize\n");
+		bt_shell_printf("Failed to GetSize\n");
 		return;
 	}
 
-	rl_printf("Attempting to GetSize\n");
+	bt_shell_printf("Attempting to GetSize\n");
 }
 
 static void pbap_ls(GDBusProxy *proxy, int argc, char *argv[])
@@ -1375,11 +1300,11 @@ static void map_ls_messages(GDBusProxy *proxy, int argc, char *argv[])
 	if (g_dbus_proxy_method_call(proxy, "ListMessages", list_messages_setup,
 					list_messages_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to ListMessages\n");
+		bt_shell_printf("Failed to ListMessages\n");
 		return;
 	}
 
-	rl_printf("Attempting to ListMessages\n");
+	bt_shell_printf("Attempting to ListMessages\n");
 }
 
 static void map_ls(GDBusProxy *proxy, int argc, char *argv[])
@@ -1392,11 +1317,11 @@ static void map_ls(GDBusProxy *proxy, int argc, char *argv[])
 	if (g_dbus_proxy_method_call(proxy, "ListFolders", list_folders_setup,
 						list_folders_reply, NULL,
 						NULL) == FALSE) {
-		rl_printf("Failed to ListFolders\n");
+		bt_shell_printf("Failed to ListFolders\n");
 		return;
 	}
 
-	rl_printf("Attempting to ListFolders\n");
+	bt_shell_printf("Attempting to ListFolders\n");
 }
 
 static void cmd_ls(int argc, char *argv[])
@@ -1424,7 +1349,7 @@ static void cmd_ls(int argc, char *argv[])
 		return;
 	}
 
-	rl_printf("Command not supported\n");
+	bt_shell_printf("Command not supported\n");
 }
 
 struct cp_args {
@@ -1481,12 +1406,12 @@ static void copy_file_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to CopyFile: %s\n", error.name);
+		bt_shell_printf("Failed to CopyFile: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("CopyFile successful\n");
+	bt_shell_printf("CopyFile successful\n");
 }
 
 static void ftp_copy(GDBusProxy *proxy, int argc, char *argv[])
@@ -1497,11 +1422,11 @@ static void ftp_copy(GDBusProxy *proxy, int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(proxy, "CopyFile", cp_setup,
 				copy_file_reply, args, cp_free) == FALSE) {
-		rl_printf("Failed to CopyFile\n");
+		bt_shell_printf("Failed to CopyFile\n");
 		return;
 	}
 
-	rl_printf("Attempting to CopyFile\n");
+	bt_shell_printf("Attempting to CopyFile\n");
 }
 
 static void get_file_reply(DBusMessage *message, void *user_data)
@@ -1512,7 +1437,7 @@ static void get_file_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to GetFile: %s\n", error.name);
+		bt_shell_printf("Failed to GetFile: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1541,11 +1466,11 @@ static void ftp_get(GDBusProxy *proxy, int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(proxy, "GetFile", get_file_setup,
 				get_file_reply, args, cp_free) == FALSE) {
-		rl_printf("Failed to GetFile\n");
+		bt_shell_printf("Failed to GetFile\n");
 		return;
 	}
 
-	rl_printf("Attempting to GetFile\n");
+	bt_shell_printf("Attempting to GetFile\n");
 }
 
 static void put_file_reply(DBusMessage *message, void *user_data)
@@ -1556,7 +1481,7 @@ static void put_file_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to PutFile: %s\n", error.name);
+		bt_shell_printf("Failed to PutFile: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1571,7 +1496,7 @@ static void ftp_put(GDBusProxy *proxy, int argc, char *argv[])
 	struct cp_args *args;
 
 	if (rindex(argv[2], ':') != NULL) {
-		rl_printf("Invalid target file argument\n");
+		bt_shell_printf("Invalid target file argument\n");
 		return;
 	}
 
@@ -1579,25 +1504,15 @@ static void ftp_put(GDBusProxy *proxy, int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(proxy, "PutFile", cp_setup, put_file_reply,
 						args, cp_free) == FALSE) {
-		rl_printf("Failed to PutFile\n");
+		bt_shell_printf("Failed to PutFile\n");
 		return;
 	}
 
-	rl_printf("Attempting to PutFile\n");
+	bt_shell_printf("Attempting to PutFile\n");
 }
 
 static void ftp_cp(GDBusProxy *proxy, int argc, char *argv[])
 {
-	if (argc < 2) {
-		rl_printf("Missing source file argument\n");
-		return;
-	}
-
-	if (argc < 3) {
-		rl_printf("Missing target file argument\n");
-		return;
-	}
-
 	if (rindex(argv[1], ':') == NULL)
 		return ftp_get(proxy, argc, argv);
 
@@ -1611,13 +1526,13 @@ static void pull_all_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to PullAll: %s\n", error.name);
+		bt_shell_printf("Failed to PullAll: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
 
-	rl_printf("PullAll successful\n");
+	bt_shell_printf("PullAll successful\n");
 }
 
 static void pull_all_setup(DBusMessageIter *iter, void *user_data)
@@ -1642,11 +1557,11 @@ static void pbap_pull_all(GDBusProxy *proxy, int argc, char *argv[])
 	if (g_dbus_proxy_method_call(proxy, "PullAll", pull_all_setup,
 					pull_all_reply, g_strdup(argv[2]),
 					g_free) == FALSE) {
-		rl_printf("Failed to PullAll\n");
+		bt_shell_printf("Failed to PullAll\n");
 		return;
 	}
 
-	rl_printf("Attempting to PullAll\n");
+	bt_shell_printf("Attempting to PullAll\n");
 }
 
 static void pull_reply(DBusMessage *message, void *user_data)
@@ -1656,13 +1571,13 @@ static void pull_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to Pull: %s\n", error.name);
+		bt_shell_printf("Failed to Pull: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
 
-	rl_printf("Pull successful\n");
+	bt_shell_printf("Pull successful\n");
 }
 
 static void pull_setup(DBusMessageIter *iter, void *user_data)
@@ -1691,25 +1606,15 @@ static void pbap_pull(GDBusProxy *proxy, int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(proxy, "Pull", pull_setup, pull_reply,
 						args, cp_free) == FALSE) {
-		rl_printf("Failed to Pull\n");
+		bt_shell_printf("Failed to Pull\n");
 		return;
 	}
 
-	rl_printf("Attempting to Pull\n");
+	bt_shell_printf("Attempting to Pull\n");
 }
 
 static void pbap_cp(GDBusProxy *proxy, int argc, char *argv[])
 {
-	if (argc < 2) {
-		rl_printf("Missing source file argument\n");
-		return;
-	}
-
-	if (argc < 3) {
-		rl_printf("Missing target file argument\n");
-		return;
-	}
-
 	if (strcmp(argv[1], "*") == 0 || strcmp(argv[1], "*.vcf") == 0)
 		return pbap_pull_all(proxy, argc, argv);
 
@@ -1724,7 +1629,7 @@ static void get_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to Get: %s\n", error.name);
+		bt_shell_printf("Failed to Get: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1747,29 +1652,19 @@ static void map_cp(GDBusProxy *proxy, int argc, char *argv[])
 {
 	GDBusProxy *obj;
 
-	if (argc < 2) {
-		rl_printf("Missing message argument\n");
-		return;
-	}
-
 	obj = find_message(argv[1]);
 	if (obj == NULL) {
-		rl_printf("Invalid message argument\n");
-		return;
-	}
-
-	if (argc < 3) {
-		rl_printf("Missing target file argument\n");
+		bt_shell_printf("Invalid message argument\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(obj, "Get", get_setup, get_reply,
 					g_strdup(argv[2]), g_free) == FALSE) {
-		rl_printf("Failed to Get\n");
+		bt_shell_printf("Failed to Get\n");
 		return;
 	}
 
-	rl_printf("Attempting to Get\n");
+	bt_shell_printf("Attempting to Get\n");
 }
 
 static void cmd_cp(int argc, char *argv[])
@@ -1798,7 +1693,7 @@ static void cmd_cp(int argc, char *argv[])
 		return;
 	}
 
-	rl_printf("Command not supported\n");
+	bt_shell_printf("Command not supported\n");
 }
 
 static void move_file_reply(DBusMessage *message, void *user_data)
@@ -1808,12 +1703,12 @@ static void move_file_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to MoveFile: %s\n", error.name);
+		bt_shell_printf("Failed to MoveFile: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("MoveFile successful\n");
+	bt_shell_printf("MoveFile successful\n");
 }
 
 static void cmd_mv(int argc, char *argv[])
@@ -1824,19 +1719,9 @@ static void cmd_mv(int argc, char *argv[])
 	if (!check_default_session())
 		return;
 
-	if (argc < 2) {
-		rl_printf("Missing source file argument\n");
-		return;
-	}
-
-	if (argc < 3) {
-		rl_printf("Missing target file argument\n");
-		return;
-	}
-
 	proxy = find_ftp(g_dbus_proxy_get_path(default_session));
 	if (proxy == NULL) {
-		rl_printf("Command not supported\n");
+		bt_shell_printf("Command not supported\n");
 		return;
 	}
 
@@ -1844,11 +1729,11 @@ static void cmd_mv(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(proxy, "MoveFile", cp_setup,
 				move_file_reply, args, cp_free) == FALSE) {
-		rl_printf("Failed to MoveFile\n");
+		bt_shell_printf("Failed to MoveFile\n");
 		return;
 	}
 
-	rl_printf("Attempting to MoveFile\n");
+	bt_shell_printf("Attempting to MoveFile\n");
 }
 
 static void delete_reply(DBusMessage *message, void *user_data)
@@ -1858,12 +1743,12 @@ static void delete_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to Delete: %s\n", error.name);
+		bt_shell_printf("Failed to Delete: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Delete successful\n");
+	bt_shell_printf("Delete successful\n");
 }
 
 static void delete_setup(DBusMessageIter *iter, void *user_data)
@@ -1875,27 +1760,22 @@ static void delete_setup(DBusMessageIter *iter, void *user_data)
 
 static void ftp_rm(GDBusProxy *proxy, int argc, char *argv[])
 {
-	if (argc < 2) {
-		rl_printf("Missing file argument\n");
-		return;
-	}
-
 	if (g_dbus_proxy_method_call(proxy, "Delete", delete_setup,
 					delete_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to Delete\n");
+		bt_shell_printf("Failed to Delete\n");
 		return;
 	}
 
-	rl_printf("Attempting to Delete\n");
+	bt_shell_printf("Attempting to Delete\n");
 }
 
 static void set_delete_reply(const DBusError *error, void *user_data)
 {
 	if (dbus_error_is_set(error))
-		rl_printf("Failed to set Deleted: %s\n", error->name);
+		bt_shell_printf("Failed to set Deleted: %s\n", error->name);
 	else
-		rl_printf("Set Deleted successful\n");
+		bt_shell_printf("Set Deleted successful\n");
 }
 
 static void map_rm(GDBusProxy *proxy, int argc, char *argv[])
@@ -1903,25 +1783,20 @@ static void map_rm(GDBusProxy *proxy, int argc, char *argv[])
 	GDBusProxy *msg;
 	dbus_bool_t value = TRUE;
 
-	if (argc < 2) {
-		rl_printf("Missing message argument\n");
-		return;
-	}
-
 	msg = find_message(argv[1]);
 	if (msg == NULL) {
-		rl_printf("Invalid message argument\n");
+		bt_shell_printf("Invalid message argument\n");
 		return;
 	}
 
 	if (g_dbus_proxy_set_property_basic(msg, "Deleted", DBUS_TYPE_BOOLEAN,
 						&value, set_delete_reply,
 						NULL, NULL) == FALSE) {
-		rl_printf("Failed to set Deleted\n");
+		bt_shell_printf("Failed to set Deleted\n");
 		return;
 	}
 
-	rl_printf("Attempting to set Deleted\n");
+	bt_shell_printf("Attempting to set Deleted\n");
 }
 
 static void cmd_rm(int argc, char *argv[])
@@ -1943,7 +1818,7 @@ static void cmd_rm(int argc, char *argv[])
 		return;
 	}
 
-	rl_printf("Command not supported\n");
+	bt_shell_printf("Command not supported\n");
 }
 
 static void create_folder_reply(DBusMessage *message, void *user_data)
@@ -1953,12 +1828,12 @@ static void create_folder_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to CreateFolder: %s\n", error.name);
+		bt_shell_printf("Failed to CreateFolder: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("CreateFolder successful\n");
+	bt_shell_printf("CreateFolder successful\n");
 }
 
 static void create_folder_setup(DBusMessageIter *iter, void *user_data)
@@ -1975,33 +1850,25 @@ static void cmd_mkdir(int argc, char *argv[])
 	if (!check_default_session())
 		return;
 
-	if (argc < 2) {
-		rl_printf("Missing folder argument\n");
-		return;
-	}
-
 	proxy = find_ftp(g_dbus_proxy_get_path(default_session));
 	if (proxy == NULL) {
-		rl_printf("Command not supported\n");
+		bt_shell_printf("Command not supported\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "CreateFolder", create_folder_setup,
 					create_folder_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to CreateFolder\n");
+		bt_shell_printf("Failed to CreateFolder\n");
 		return;
 	}
 
-	rl_printf("Attempting to CreateFolder\n");
+	bt_shell_printf("Attempting to CreateFolder\n");
 }
 
-static const struct {
-	const char *cmd;
-	const char *arg;
-	void (*func) (int argc, char *argv[]);
-	const char *desc;
-} cmd_table[] = {
+static const struct bt_shell_menu main_menu = {
+	.name = "main",
+	.entries = {
 	{ "connect",      "<dev> [uuid]", cmd_connect, "Connect session" },
 	{ "disconnect",   "[session]", cmd_disconnect, "Disconnect session" },
 	{ "list",         NULL,       cmd_list, "List available sessions" },
@@ -2022,221 +1889,9 @@ static const struct {
 				"Move source file to destination file" },
 	{ "rm",          "<file>",    cmd_rm, "Delete file" },
 	{ "mkdir",       "<folder>",    cmd_mkdir, "Create folder" },
-	{ "quit",         NULL,       cmd_quit, "Quit program" },
-	{ "exit",         NULL,       cmd_quit },
-	{ "help" },
-	{}
-};
-
-static char *cmd_generator(const char *text, int state)
-{
-	static int index, len;
-	const char *cmd;
-
-	if (!state) {
-		index = 0;
-		len = strlen(text);
-	}
-
-	while ((cmd = cmd_table[index].cmd)) {
-		index++;
-
-		if (!strncmp(cmd, text, len))
-			return strdup(cmd);
-	}
-
-	return NULL;
-}
-
-static char **cmd_completion(const char *text, int start, int end)
-{
-	char **matches = NULL;
-
-	if (start == 0) {
-		rl_completion_display_matches_hook = NULL;
-		matches = rl_completion_matches(text, cmd_generator);
-	}
-
-	if (!matches)
-		rl_attempted_completion_over = 1;
-
-	return matches;
-}
-
-static void rl_handler(char *input)
-{
-	wordexp_t w;
-	int argc;
-	char **argv;
-	int i;
-
-	if (!input) {
-		rl_insert_text("quit");
-		rl_redisplay();
-		rl_crlf();
-		g_main_loop_quit(main_loop);
-		return;
-	}
-
-	if (!strlen(input))
-		goto done;
-
-	if (history_search(input, -1))
-		add_history(input);
-
-	if (wordexp(input, &w, WRDE_NOCMD))
-		goto done;
-
-	if (w.we_wordc == 0)
-		goto free_we;
-
-	argv = w.we_wordv;
-	argc = w.we_wordc;
-
-	for (i = 0; cmd_table[i].cmd; i++) {
-		if (strcmp(argv[0], cmd_table[i].cmd))
-			continue;
-
-		if (cmd_table[i].func) {
-			cmd_table[i].func(argc, argv);
-			goto free_we;
-		}
-	}
-
-	if (strcmp(argv[0], "help")) {
-		printf("Invalid command\n");
-		goto free_we;
-	}
-
-	printf("Available commands:\n");
-
-	for (i = 0; cmd_table[i].cmd; i++) {
-		if (cmd_table[i].desc)
-			printf("  %s %-*s %s\n", cmd_table[i].cmd,
-					(int)(25 - strlen(cmd_table[i].cmd)),
-					cmd_table[i].arg ? : "",
-					cmd_table[i].desc ? : "");
-	}
-
-free_we:
-	wordfree(&w);
-done:
-	free(input);
-}
-
-static gboolean option_version = FALSE;
-
-static GOptionEntry options[] = {
-	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
-				"Show version information and exit" },
-	{ NULL },
+	{} },
 };
 
-static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
-							gpointer user_data)
-{
-	static unsigned int __terminated = 0;
-	struct signalfd_siginfo si;
-	ssize_t result;
-	int fd;
-
-	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		g_main_loop_quit(main_loop);
-		return FALSE;
-	}
-
-	fd = g_io_channel_unix_get_fd(channel);
-
-	result = read(fd, &si, sizeof(si));
-	if (result != sizeof(si))
-		return FALSE;
-
-	switch (si.ssi_signo) {
-	case SIGINT:
-		rl_replace_line("", 0);
-		rl_crlf();
-		rl_on_new_line();
-		rl_redisplay();
-		break;
-	case SIGTERM:
-		if (__terminated == 0) {
-			rl_replace_line("", 0);
-			rl_crlf();
-			g_main_loop_quit(main_loop);
-		}
-
-		__terminated = 1;
-		break;
-	}
-
-	return TRUE;
-}
-
-static guint setup_signalfd(void)
-{
-	GIOChannel *channel;
-	guint source;
-	sigset_t mask;
-	int fd;
-
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
-		perror("Failed to set signal mask");
-		return 0;
-	}
-
-	fd = signalfd(-1, &mask, 0);
-	if (fd < 0) {
-		perror("Failed to create signal descriptor");
-		return 0;
-	}
-
-	channel = g_io_channel_unix_new(fd);
-
-	g_io_channel_set_close_on_unref(channel, TRUE);
-	g_io_channel_set_encoding(channel, NULL, NULL);
-	g_io_channel_set_buffered(channel, FALSE);
-
-	source = g_io_add_watch(channel,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				signal_handler, NULL);
-
-	g_io_channel_unref(channel);
-
-	return source;
-}
-
-static gboolean input_handler(GIOChannel *channel, GIOCondition condition,
-							gpointer user_data)
-{
-	if (condition & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
-		g_main_loop_quit(main_loop);
-		return FALSE;
-	}
-
-	rl_callback_read_char();
-	return TRUE;
-}
-
-static guint setup_standard_input(void)
-{
-	GIOChannel *channel;
-	guint source;
-
-	channel = g_io_channel_unix_new(fileno(stdin));
-
-	source = g_io_add_watch(channel,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				input_handler, NULL);
-
-	g_io_channel_unref(channel);
-
-	return source;
-}
-
 static void client_added(GDBusProxy *proxy)
 {
 	if (client == NULL)
@@ -2267,16 +1922,17 @@ static void print_transferred(struct transfer_data *data, const char *str,
 	data->transferred = valu64;
 
 	if (data->size == 0) {
-		rl_printf("%sTransferred: %" PRIu64 " (@%" PRIu64 "KB/s)\n",
-						str, valu64, speed / 1000);
+		bt_shell_printf("%sTransferred: %" PRIu64 " (@%" PRIu64
+				"KB/s)\n", str, valu64, speed / 1000);
 		return;
 	}
 
 	seconds = (data->size - data->transferred) / speed;
 	minutes = seconds / 60;
 	seconds %= 60;
-	rl_printf("%sTransferred: %" PRIu64 " (@%" PRIu64 "KB/s %02u:%02u)\n",
-				str, valu64, speed / 1000, minutes, seconds);
+	bt_shell_printf("%sTransferred: %" PRIu64 " (@%" PRIu64
+			"KB/s %02u:%02u)\n", str, valu64, speed / 1000,
+			minutes, seconds);
 }
 
 static void transfer_property_changed(GDBusProxy *proxy, const char *name,
@@ -2495,43 +2151,15 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 
 int main(int argc, char *argv[])
 {
-	GOptionContext *context;
-	GError *error = NULL;
 	GDBusClient *client;
-	guint signal, input;
-
-	context = g_option_context_new(NULL);
-	g_option_context_add_main_entries(context, options, NULL);
 
-	if (g_option_context_parse(context, &argc, &argv, &error) == FALSE) {
-		if (error != NULL) {
-			g_printerr("%s\n", error->message);
-			g_error_free(error);
-		} else
-			g_printerr("An unknown error occurred\n");
-		exit(1);
-	}
-
-	g_option_context_free(context);
+	bt_shell_init(&argc, &argv, NULL);
+	bt_shell_set_menu(&main_menu);
+	bt_shell_set_prompt(PROMPT_OFF);
+	bt_shell_attach(fileno(stdin));
 
-	if (option_version == TRUE) {
-		printf("%s\n", VERSION);
-		exit(0);
-	}
-
-	main_loop = g_main_loop_new(NULL, FALSE);
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
 
-	rl_attempted_completion_function = cmd_completion;
-
-	rl_erase_empty_line = 1;
-	rl_callback_handler_install(NULL, rl_handler);
-
-	rl_set_prompt(PROMPT_OFF);
-	rl_redisplay();
-
-	input = setup_standard_input();
-	signal = setup_signalfd();
 	client = g_dbus_client_new(dbus_conn, "org.bluez.obex",
 							"/org/bluez/obex");
 
@@ -2541,17 +2169,11 @@ int main(int argc, char *argv[])
 	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
 							property_changed, NULL);
 
-	g_main_loop_run(main_loop);
+	bt_shell_run();
 
 	g_dbus_client_unref(client);
-	g_source_remove(signal);
-	g_source_remove(input);
-
-	rl_message("");
-	rl_callback_handler_remove();
 
 	dbus_connection_unref(dbus_conn);
-	g_main_loop_unref(main_loop);
 
 	return 0;
 }
-- 
2.13.6


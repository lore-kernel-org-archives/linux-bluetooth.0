Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] tools/bluetooth-player: Use bt_shell helpers
Date: Tue,  5 Dec 2017 16:33:27 -0200
Message-Id: <20171205183327.853-4-luiz.dentz@gmail.com>
In-Reply-To: <20171205183327.853-1-luiz.dentz@gmail.com>
References: <20171205183327.853-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bluetooth-player use bt_shell to manage the menus and
command handling.
---
 Makefile.tools           |   4 +-
 tools/bluetooth-player.c | 473 +++++++++++------------------------------------
 2 files changed, 111 insertions(+), 366 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 1cf19035d..8074a536d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -389,9 +389,9 @@ tools_obex_server_tool_SOURCES = $(gobex_sources) $(btio_sources) \
 						tools/obex-server-tool.c
 tools_obex_server_tool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
-tools_bluetooth_player_SOURCES = tools/bluetooth-player.c \
-				client/display.h client/display.c
+tools_bluetooth_player_SOURCES = tools/bluetooth-player.c
 tools_bluetooth_player_LDADD = gdbus/libgdbus-internal.la \
+				src/libshared-glib.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ -lreadline
 
 tools_obexctl_SOURCES = tools/obexctl.c
diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index c95b7497f..2a8cc49c3 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -30,15 +30,12 @@
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
-#include <signal.h>
-#include <sys/signalfd.h>
+#include <string.h>
 
-#include <readline/readline.h>
-#include <readline/history.h>
 #include <glib.h>
 
 #include "gdbus/gdbus.h"
-#include "client/display.h"
+#include "src/shared/shell.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -61,18 +58,12 @@ static GSList *items = NULL;
 
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
+	bt_shell_set_prompt(PROMPT_OFF);
 }
 
 static void cmd_quit(int argc, char *argv[])
@@ -83,7 +74,7 @@ static void cmd_quit(int argc, char *argv[])
 static bool check_default_player(void)
 {
 	if (!default_player) {
-		rl_printf("No default player available\n");
+		bt_shell_printf("No default player available\n");
 		return FALSE;
 	}
 
@@ -97,12 +88,12 @@ static void play_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to play: %s\n", error.name);
+		bt_shell_printf("Failed to play: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Play successful\n");
+	bt_shell_printf("Play successful\n");
 }
 
 static GDBusProxy *find_item(const char *path)
@@ -125,17 +116,17 @@ static void cmd_play_item(int argc, char *argv[])
 
 	proxy = find_item(argv[1]);
 	if (proxy == NULL) {
-		rl_printf("Item %s not available\n", argv[1]);
+		bt_shell_printf("Item %s not available\n", argv[1]);
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "Play", NULL, play_reply,
 							NULL, NULL) == FALSE) {
-		rl_printf("Failed to play\n");
+		bt_shell_printf("Failed to play\n");
 		return;
 	}
 
-	rl_printf("Attempting to play %s\n", argv[1]);
+	bt_shell_printf("Attempting to play %s\n", argv[1]);
 }
 
 static void cmd_play(int argc, char *argv[])
@@ -148,11 +139,11 @@ static void cmd_play(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(default_player, "Play", NULL, play_reply,
 							NULL, NULL) == FALSE) {
-		rl_printf("Failed to play\n");
+		bt_shell_printf("Failed to play\n");
 		return;
 	}
 
-	rl_printf("Attempting to play\n");
+	bt_shell_printf("Attempting to play\n");
 }
 
 static void pause_reply(DBusMessage *message, void *user_data)
@@ -162,12 +153,12 @@ static void pause_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to pause: %s\n", error.name);
+		bt_shell_printf("Failed to pause: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Pause successful\n");
+	bt_shell_printf("Pause successful\n");
 }
 
 static void cmd_pause(int argc, char *argv[])
@@ -177,11 +168,11 @@ static void cmd_pause(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(default_player, "Pause", NULL,
 					pause_reply, NULL, NULL) == FALSE) {
-		rl_printf("Failed to play\n");
+		bt_shell_printf("Failed to play\n");
 		return;
 	}
 
-	rl_printf("Attempting to pause\n");
+	bt_shell_printf("Attempting to pause\n");
 }
 
 static void stop_reply(DBusMessage *message, void *user_data)
@@ -191,12 +182,12 @@ static void stop_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to stop: %s\n", error.name);
+		bt_shell_printf("Failed to stop: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Stop successful\n");
+	bt_shell_printf("Stop successful\n");
 }
 
 static void cmd_stop(int argc, char *argv[])
@@ -206,11 +197,11 @@ static void cmd_stop(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(default_player, "Stop", NULL, stop_reply,
 							NULL, NULL) == FALSE) {
-		rl_printf("Failed to stop\n");
+		bt_shell_printf("Failed to stop\n");
 		return;
 	}
 
-	rl_printf("Attempting to stop\n");
+	bt_shell_printf("Attempting to stop\n");
 }
 
 static void next_reply(DBusMessage *message, void *user_data)
@@ -220,12 +211,12 @@ static void next_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to jump to next: %s\n", error.name);
+		bt_shell_printf("Failed to jump to next: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Next successful\n");
+	bt_shell_printf("Next successful\n");
 }
 
 static void cmd_next(int argc, char *argv[])
@@ -235,11 +226,11 @@ static void cmd_next(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(default_player, "Next", NULL, next_reply,
 							NULL, NULL) == FALSE) {
-		rl_printf("Failed to jump to next\n");
+		bt_shell_printf("Failed to jump to next\n");
 		return;
 	}
 
-	rl_printf("Attempting to jump to next\n");
+	bt_shell_printf("Attempting to jump to next\n");
 }
 
 static void previous_reply(DBusMessage *message, void *user_data)
@@ -249,12 +240,12 @@ static void previous_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to jump to previous: %s\n", error.name);
+		bt_shell_printf("Failed to jump to previous: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Previous successful\n");
+	bt_shell_printf("Previous successful\n");
 }
 
 static void cmd_previous(int argc, char *argv[])
@@ -264,11 +255,11 @@ static void cmd_previous(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(default_player, "Previous", NULL,
 					previous_reply, NULL, NULL) == FALSE) {
-		rl_printf("Failed to jump to previous\n");
+		bt_shell_printf("Failed to jump to previous\n");
 		return;
 	}
 
-	rl_printf("Attempting to jump to previous\n");
+	bt_shell_printf("Attempting to jump to previous\n");
 }
 
 static void fast_forward_reply(DBusMessage *message, void *user_data)
@@ -278,12 +269,12 @@ static void fast_forward_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to fast forward: %s\n", error.name);
+		bt_shell_printf("Failed to fast forward: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("FastForward successful\n");
+	bt_shell_printf("FastForward successful\n");
 }
 
 static void cmd_fast_forward(int argc, char *argv[])
@@ -293,11 +284,11 @@ static void cmd_fast_forward(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(default_player, "FastForward", NULL,
 				fast_forward_reply, NULL, NULL) == FALSE) {
-		rl_printf("Failed to jump to previous\n");
+		bt_shell_printf("Failed to jump to previous\n");
 		return;
 	}
 
-	rl_printf("Fast forward playback\n");
+	bt_shell_printf("Fast forward playback\n");
 }
 
 static void rewind_reply(DBusMessage *message, void *user_data)
@@ -307,12 +298,12 @@ static void rewind_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to rewind: %s\n", error.name);
+		bt_shell_printf("Failed to rewind: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Rewind successful\n");
+	bt_shell_printf("Rewind successful\n");
 }
 
 static void cmd_rewind(int argc, char *argv[])
@@ -322,11 +313,11 @@ static void cmd_rewind(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(default_player, "Rewind", NULL,
 					rewind_reply, NULL, NULL) == FALSE) {
-		rl_printf("Failed to rewind\n");
+		bt_shell_printf("Failed to rewind\n");
 		return;
 	}
 
-	rl_printf("Rewind playback\n");
+	bt_shell_printf("Rewind playback\n");
 }
 
 static void generic_callback(const DBusError *error, void *user_data)
@@ -334,9 +325,9 @@ static void generic_callback(const DBusError *error, void *user_data)
 	char *str = user_data;
 
 	if (dbus_error_is_set(error))
-		rl_printf("Failed to set %s: %s\n", str, error->name);
+		bt_shell_printf("Failed to set %s: %s\n", str, error->name);
 	else
-		rl_printf("Changing %s succeeded\n", str);
+		bt_shell_printf("Changing %s succeeded\n", str);
 }
 
 static void cmd_equalizer(int argc, char *argv[])
@@ -348,12 +339,12 @@ static void cmd_equalizer(int argc, char *argv[])
 		return;
 
 	if (argc < 2) {
-		rl_printf("Missing on/off argument\n");
+		bt_shell_printf("Missing on/off argument\n");
 		return;
 	}
 
 	if (!g_dbus_proxy_get_property(default_player, "Equalizer", &iter)) {
-		rl_printf("Operation not supported\n");
+		bt_shell_printf("Operation not supported\n");
 		return;
 	}
 
@@ -363,12 +354,12 @@ static void cmd_equalizer(int argc, char *argv[])
 						DBUS_TYPE_STRING, &value,
 						generic_callback, value,
 						g_free) == FALSE) {
-		rl_printf("Failed to setting equalizer\n");
+		bt_shell_printf("Failed to setting equalizer\n");
 		g_free(value);
 		return;
 	}
 
-	rl_printf("Attempting to set equalizer\n");
+	bt_shell_printf("Attempting to set equalizer\n");
 }
 
 static void cmd_repeat(int argc, char *argv[])
@@ -380,12 +371,12 @@ static void cmd_repeat(int argc, char *argv[])
 		return;
 
 	if (argc < 2) {
-		rl_printf("Missing mode argument\n");
+		bt_shell_printf("Missing mode argument\n");
 		return;
 	}
 
 	if (!g_dbus_proxy_get_property(default_player, "Repeat", &iter)) {
-		rl_printf("Operation not supported\n");
+		bt_shell_printf("Operation not supported\n");
 		return;
 	}
 
@@ -395,12 +386,12 @@ static void cmd_repeat(int argc, char *argv[])
 						DBUS_TYPE_STRING, &value,
 						generic_callback, value,
 						g_free) == FALSE) {
-		rl_printf("Failed to set repeat\n");
+		bt_shell_printf("Failed to set repeat\n");
 		g_free(value);
 		return;
 	}
 
-	rl_printf("Attempting to set repeat\n");
+	bt_shell_printf("Attempting to set repeat\n");
 }
 
 static void cmd_shuffle(int argc, char *argv[])
@@ -412,12 +403,12 @@ static void cmd_shuffle(int argc, char *argv[])
 		return;
 
 	if (argc < 2) {
-		rl_printf("Missing mode argument\n");
+		bt_shell_printf("Missing mode argument\n");
 		return;
 	}
 
 	if (!g_dbus_proxy_get_property(default_player, "Shuffle", &iter)) {
-		rl_printf("Operation not supported\n");
+		bt_shell_printf("Operation not supported\n");
 		return;
 	}
 
@@ -427,12 +418,12 @@ static void cmd_shuffle(int argc, char *argv[])
 						DBUS_TYPE_STRING, &value,
 						generic_callback, value,
 						g_free) == FALSE) {
-		rl_printf("Failed to set shuffle\n");
+		bt_shell_printf("Failed to set shuffle\n");
 		g_free(value);
 		return;
 	}
 
-	rl_printf("Attempting to set shuffle\n");
+	bt_shell_printf("Attempting to set shuffle\n");
 }
 
 static void cmd_scan(int argc, char *argv[])
@@ -444,12 +435,12 @@ static void cmd_scan(int argc, char *argv[])
 		return;
 
 	if (argc < 2) {
-		rl_printf("Missing mode argument\n");
+		bt_shell_printf("Missing mode argument\n");
 		return;
 	}
 
 	if (!g_dbus_proxy_get_property(default_player, "Shuffle", &iter)) {
-		rl_printf("Operation not supported\n");
+		bt_shell_printf("Operation not supported\n");
 		return;
 	}
 
@@ -459,12 +450,12 @@ static void cmd_scan(int argc, char *argv[])
 						DBUS_TYPE_STRING, &value,
 						generic_callback, value,
 						g_free) == FALSE) {
-		rl_printf("Failed to set scan\n");
+		bt_shell_printf("Failed to set scan\n");
 		g_free(value);
 		return;
 	}
 
-	rl_printf("Attempting to set scan\n");
+	bt_shell_printf("Attempting to set scan\n");
 }
 
 static char *proxy_description(GDBusProxy *proxy, const char *title,
@@ -487,7 +478,7 @@ static void print_player(GDBusProxy *proxy, const char *description)
 
 	str = proxy_description(proxy, "Player", description);
 
-	rl_printf("%s%s\n", str, default_player == proxy ? "[default]" : "");
+	bt_shell_printf("%s%s\n", str, default_player == proxy ? "[default]" : "");
 
 	g_free(str);
 }
@@ -527,35 +518,35 @@ static void print_iter(const char *label, const char *name,
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
 	case DBUS_TYPE_UINT32:
 		dbus_message_iter_get_basic(iter, &valu32);
-		rl_printf("%s%s: 0x%06x\n", label, name, valu32);
+		bt_shell_printf("%s%s: 0x%06x\n", label, name, valu32);
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
@@ -576,7 +567,7 @@ static void print_iter(const char *label, const char *name,
 		print_iter(label, valstr, &subiter);
 		break;
 	default:
-		rl_printf("%s%s has unsupported type\n", label, name);
+		bt_shell_printf("%s%s has unsupported type\n", label, name);
 		break;
 	}
 }
@@ -610,17 +601,17 @@ static void cmd_show_item(int argc, char *argv[])
 	GDBusProxy *proxy;
 
 	if (argc < 2) {
-		rl_printf("Missing item address argument\n");
+		bt_shell_printf("Missing item address argument\n");
 		return;
 	}
 
 	proxy = find_item(argv[1]);
 	if (!proxy) {
-		rl_printf("Item %s not available\n", argv[1]);
+		bt_shell_printf("Item %s not available\n", argv[1]);
 		return;
 	}
 
-	rl_printf("Item %s\n", g_dbus_proxy_get_path(proxy));
+	bt_shell_printf("Item %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(proxy, "Player");
 	print_property(proxy, "Name");
@@ -646,12 +637,12 @@ static void cmd_show(int argc, char *argv[])
 	} else {
 		proxy = find_player(argv[1]);
 		if (!proxy) {
-			rl_printf("Player %s not available\n", argv[1]);
+			bt_shell_printf("Player %s not available\n", argv[1]);
 			return;
 		}
 	}
 
-	rl_printf("Player %s\n", g_dbus_proxy_get_path(proxy));
+	bt_shell_printf("Player %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(proxy, "Name");
 	print_property(proxy, "Repeat");
@@ -666,7 +657,7 @@ static void cmd_show(int argc, char *argv[])
 	if (folder == NULL)
 		return;
 
-	rl_printf("Folder %s\n", g_dbus_proxy_get_path(proxy));
+	bt_shell_printf("Folder %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(folder, "Name");
 	print_property(folder, "NumberOfItems");
@@ -680,7 +671,7 @@ static void cmd_show(int argc, char *argv[])
 	if (item == NULL)
 		return;
 
-	rl_printf("Playlist %s\n", path);
+	bt_shell_printf("Playlist %s\n", path);
 
 	print_property(item, "Name");
 }
@@ -690,13 +681,13 @@ static void cmd_select(int argc, char *argv[])
 	GDBusProxy *proxy;
 
 	if (argc < 2) {
-		rl_printf("Missing player address argument\n");
+		bt_shell_printf("Missing player address argument\n");
 		return;
 	}
 
 	proxy = find_player(argv[1]);
 	if (proxy == NULL) {
-		rl_printf("Player %s not available\n", argv[1]);
+		bt_shell_printf("Player %s not available\n", argv[1]);
 		return;
 	}
 
@@ -714,12 +705,12 @@ static void change_folder_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to change folder: %s\n", error.name);
+		bt_shell_printf("Failed to change folder: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("ChangeFolder successful\n");
+	bt_shell_printf("ChangeFolder successful\n");
 }
 
 static void change_folder_setup(DBusMessageIter *iter, void *user_data)
@@ -734,12 +725,12 @@ static void cmd_change_folder(int argc, char *argv[])
 	GDBusProxy *proxy;
 
 	if (argc < 2) {
-		rl_printf("Missing item argument\n");
+		bt_shell_printf("Missing item argument\n");
 		return;
 	}
 
 	if (dbus_validate_path(argv[1], NULL) == FALSE) {
-		rl_printf("Not a valid path\n");
+		bt_shell_printf("Not a valid path\n");
 		return;
 	}
 
@@ -748,17 +739,17 @@ static void cmd_change_folder(int argc, char *argv[])
 
 	proxy = find_folder(g_dbus_proxy_get_path(default_player));
 	if (proxy == NULL) {
-		rl_printf("Operation not supported\n");
+		bt_shell_printf("Operation not supported\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "ChangeFolder", change_folder_setup,
 				change_folder_reply, argv[1], NULL) == FALSE) {
-		rl_printf("Failed to change current folder\n");
+		bt_shell_printf("Failed to change current folder\n");
 		return;
 	}
 
-	rl_printf("Attempting to change folder\n");
+	bt_shell_printf("Attempting to change folder\n");
 }
 
 static void append_variant(DBusMessageIter *iter, int type, void *val)
@@ -832,12 +823,12 @@ static void list_items_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to list items: %s\n", error.name);
+		bt_shell_printf("Failed to list items: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("ListItems successful\n");
+	bt_shell_printf("ListItems successful\n");
 }
 
 static void cmd_list_items(int argc, char *argv[])
@@ -850,7 +841,7 @@ static void cmd_list_items(int argc, char *argv[])
 
 	proxy = find_folder(g_dbus_proxy_get_path(default_player));
 	if (proxy == NULL) {
-		rl_printf("Operation not supported\n");
+		bt_shell_printf("Operation not supported\n");
 		return;
 	}
 
@@ -864,7 +855,7 @@ static void cmd_list_items(int argc, char *argv[])
 	errno = 0;
 	args->start = strtol(argv[1], NULL, 10);
 	if (errno != 0) {
-		rl_printf("%s(%d)\n", strerror(errno), errno);
+		bt_shell_printf("%s(%d)\n", strerror(errno), errno);
 		g_free(args);
 		return;
 	}
@@ -875,7 +866,7 @@ static void cmd_list_items(int argc, char *argv[])
 	errno = 0;
 	args->end = strtol(argv[2], NULL, 10);
 	if (errno != 0) {
-		rl_printf("%s(%d)\n", strerror(errno), errno);
+		bt_shell_printf("%s(%d)\n", strerror(errno), errno);
 		g_free(args);
 		return;
 	}
@@ -883,12 +874,12 @@ static void cmd_list_items(int argc, char *argv[])
 done:
 	if (g_dbus_proxy_method_call(proxy, "ListItems", list_items_setup,
 				list_items_reply, args, g_free) == FALSE) {
-		rl_printf("Failed to change current folder\n");
+		bt_shell_printf("Failed to change current folder\n");
 		g_free(args);
 		return;
 	}
 
-	rl_printf("Attempting to list items\n");
+	bt_shell_printf("Attempting to list items\n");
 }
 
 static void search_setup(DBusMessageIter *iter, void *user_data)
@@ -915,12 +906,12 @@ static void search_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to search: %s\n", error.name);
+		bt_shell_printf("Failed to search: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Search successful\n");
+	bt_shell_printf("Search successful\n");
 }
 
 static void cmd_search(int argc, char *argv[])
@@ -929,7 +920,7 @@ static void cmd_search(int argc, char *argv[])
 	char *string;
 
 	if (argc < 2) {
-		rl_printf("Missing string argument\n");
+		bt_shell_printf("Missing string argument\n");
 		return;
 	}
 
@@ -938,7 +929,7 @@ static void cmd_search(int argc, char *argv[])
 
 	proxy = find_folder(g_dbus_proxy_get_path(default_player));
 	if (proxy == NULL) {
-		rl_printf("Operation not supported\n");
+		bt_shell_printf("Operation not supported\n");
 		return;
 	}
 
@@ -946,12 +937,12 @@ static void cmd_search(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(proxy, "Search", search_setup,
 				search_reply, string, g_free) == FALSE) {
-		rl_printf("Failed to search\n");
+		bt_shell_printf("Failed to search\n");
 		g_free(string);
 		return;
 	}
 
-	rl_printf("Attempting to search\n");
+	bt_shell_printf("Attempting to search\n");
 }
 
 static void add_to_nowplaying_reply(DBusMessage *message, void *user_data)
@@ -961,12 +952,12 @@ static void add_to_nowplaying_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to queue: %s\n", error.name);
+		bt_shell_printf("Failed to queue: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("AddToNowPlaying successful\n");
+	bt_shell_printf("AddToNowPlaying successful\n");
 }
 
 static void cmd_queue(int argc, char *argv[])
@@ -974,32 +965,29 @@ static void cmd_queue(int argc, char *argv[])
 	GDBusProxy *proxy;
 
 	if (argc < 2) {
-		rl_printf("Missing item address argument\n");
+		bt_shell_printf("Missing item address argument\n");
 		return;
 	}
 
 	proxy = find_item(argv[1]);
 	if (proxy == NULL) {
-		rl_printf("Item %s not available\n", argv[1]);
+		bt_shell_printf("Item %s not available\n", argv[1]);
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "AddtoNowPlaying", NULL,
 					add_to_nowplaying_reply, NULL,
 					NULL) == FALSE) {
-		rl_printf("Failed to play\n");
+		bt_shell_printf("Failed to play\n");
 		return;
 	}
 
-	rl_printf("Attempting to queue %s\n", argv[1]);
+	bt_shell_printf("Attempting to queue %s\n", argv[1]);
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
 	{ "list",         NULL,       cmd_list, "List available players" },
 	{ "show",         "[player]", cmd_show, "Player information" },
 	{ "select",       "<player>", cmd_select, "Select default player" },
@@ -1030,218 +1018,9 @@ static const struct {
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
 	{ "help" },
-	{}
+	{} },
 };
 
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
-	int argc;
-	char **argv = NULL;
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
-	g_strstrip(input);
-
-	if (history_search(input, -1))
-		add_history(input);
-
-	argv = g_strsplit(input, " ", -1);
-	if (argv == NULL)
-		goto done;
-
-	for (argc = 0; argv[argc];)
-		argc++;
-
-	if (argc == 0)
-		goto done;
-
-	for (i = 0; cmd_table[i].cmd; i++) {
-		if (strcmp(argv[0], cmd_table[i].cmd))
-			continue;
-
-		if (cmd_table[i].func) {
-			cmd_table[i].func(argc, argv);
-			goto done;
-		}
-	}
-
-	if (strcmp(argv[0], "help")) {
-		printf("Invalid command\n");
-		goto done;
-	}
-
-	printf("Available commands:\n");
-
-	for (i = 0; cmd_table[i].cmd; i++) {
-		if (cmd_table[i].desc)
-			printf("\t%s %s\t%s\n", cmd_table[i].cmd,
-						cmd_table[i].arg ? : "    ",
-						cmd_table[i].desc);
-	}
-
-done:
-	g_strfreev(argv);
-	free(input);
-}
-
-static gboolean option_version = FALSE;
-
-static GOptionEntry options[] = {
-	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
-				"Show version information and exit" },
-	{ NULL },
-};
-
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
 static void player_added(GDBusProxy *proxy)
 {
 	players = g_slist_append(players, proxy);
@@ -1258,7 +1037,7 @@ static void print_folder(GDBusProxy *proxy, const char *description)
 
 	path = g_dbus_proxy_get_path(proxy);
 
-	rl_printf("%s%s%sFolder %s\n", description ? "[" : "",
+	bt_shell_printf("%s%s%sFolder %s\n", description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
 					path);
@@ -1283,7 +1062,7 @@ static void print_item(GDBusProxy *proxy, const char *description)
 	else
 		name = "<unknown>";
 
-	rl_printf("%s%s%sItem %s %s\n", description ? "[" : "",
+	bt_shell_printf("%s%s%sItem %s %s\n", description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
 					path, name);
@@ -1395,43 +1174,15 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 
 int main(int argc, char *argv[])
 {
-	GOptionContext *context;
-	GError *error = NULL;
 	GDBusClient *client;
-	guint signal, input;
-
-	context = g_option_context_new(NULL);
-	g_option_context_add_main_entries(context, options, NULL);
-
-	if (g_option_context_parse(context, &argc, &argv, &error) == FALSE) {
-		if (error != NULL) {
-			g_printerr("%s\n", error->message);
-			g_error_free(error);
-		} else
-			g_printerr("An unknown error occurred\n");
-		exit(1);
-	}
 
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
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 
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
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
 
 	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
@@ -1440,17 +1191,11 @@ int main(int argc, char *argv[])
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


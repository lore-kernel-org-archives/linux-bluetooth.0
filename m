Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/14] client/bluetooth-player: Add show command
Date: Fri, 31 May 2013 13:55:48 +0300
Message-Id: <1369997749-8663-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
References: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add support for show command which can be used to show player
information
---
 client/bluetooth-player.c | 181 +++++++++++++++++++++++++++++-----------------
 1 file changed, 116 insertions(+), 65 deletions(-)

diff --git a/client/bluetooth-player.c b/client/bluetooth-player.c
index 7cfaa17..3e25bba 100644
--- a/client/bluetooth-player.c
+++ b/client/bluetooth-player.c
@@ -323,6 +323,121 @@ static void cmd_list(int argc, char *arg[])
 	}
 }
 
+static GDBusProxy *find_player(const char *path)
+{
+	GSList *l;
+
+	for (l = players; l; l = g_slist_next(l)) {
+		GDBusProxy *proxy = l->data;
+
+		if (strcmp(path, g_dbus_proxy_get_path(proxy)) == 0)
+			return proxy;
+	}
+
+	return NULL;
+}
+
+static void print_iter(const char *label, const char *name,
+						DBusMessageIter *iter)
+{
+	dbus_bool_t valbool;
+	dbus_uint32_t valu32;
+	dbus_uint16_t valu16;
+	dbus_int16_t vals16;
+	const char *valstr;
+	DBusMessageIter subiter;
+
+	if (iter == NULL) {
+		rl_printf("%s%s is nil\n", label, name);
+		return;
+	}
+
+	switch (dbus_message_iter_get_arg_type(iter)) {
+	case DBUS_TYPE_INVALID:
+		rl_printf("%s%s is invalid\n", label, name);
+		break;
+	case DBUS_TYPE_STRING:
+	case DBUS_TYPE_OBJECT_PATH:
+		dbus_message_iter_get_basic(iter, &valstr);
+		rl_printf("%s%s: %s\n", label, name, valstr);
+		break;
+	case DBUS_TYPE_BOOLEAN:
+		dbus_message_iter_get_basic(iter, &valbool);
+		rl_printf("%s%s: %s\n", label, name,
+					valbool == TRUE ? "yes" : "no");
+		break;
+	case DBUS_TYPE_UINT32:
+		dbus_message_iter_get_basic(iter, &valu32);
+		rl_printf("%s%s: 0x%06x\n", label, name, valu32);
+		break;
+	case DBUS_TYPE_UINT16:
+		dbus_message_iter_get_basic(iter, &valu16);
+		rl_printf("%s%s: 0x%04x\n", label, name, valu16);
+		break;
+	case DBUS_TYPE_INT16:
+		dbus_message_iter_get_basic(iter, &vals16);
+		rl_printf("%s%s: %d\n", label, name, vals16);
+		break;
+	case DBUS_TYPE_VARIANT:
+		dbus_message_iter_recurse(iter, &subiter);
+		print_iter(label, name, &subiter);
+		break;
+	case DBUS_TYPE_ARRAY:
+		dbus_message_iter_recurse(iter, &subiter);
+		while (dbus_message_iter_get_arg_type(&subiter) !=
+							DBUS_TYPE_INVALID) {
+			print_iter(label, name, &subiter);
+			dbus_message_iter_next(&subiter);
+		}
+		break;
+	case DBUS_TYPE_DICT_ENTRY:
+		dbus_message_iter_recurse(iter, &subiter);
+		dbus_message_iter_get_basic(&subiter, &valstr);
+		dbus_message_iter_next(&subiter);
+		print_iter(label, valstr, &subiter);
+		break;
+	default:
+		rl_printf("%s%s has unsupported type\n", label, name);
+		break;
+	}
+}
+
+static void print_property(GDBusProxy *proxy, const char *name)
+{
+	DBusMessageIter iter;
+
+	if (g_dbus_proxy_get_property(proxy, name, &iter) == FALSE)
+		return;
+
+	print_iter("\t", name, &iter);
+}
+
+static void cmd_show(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (argc < 2) {
+		if (check_default_player() == FALSE)
+			return;
+
+		proxy = default_player;
+	} else {
+		proxy = find_player(argv[1]);
+		if (!proxy) {
+			rl_printf("Player %s not available\n", argv[1]);
+			return;
+		}
+	}
+
+	print_property(proxy, "Name");
+	print_property(proxy, "Equalizer");
+	print_property(proxy, "Shuffle");
+	print_property(proxy, "Scan");
+	print_property(proxy, "Status");
+	print_property(proxy, "Position");
+	print_property(proxy, "Track");
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
@@ -330,6 +445,7 @@ static const struct {
 	const char *desc;
 } cmd_table[] = {
 	{ "list",         NULL,       cmd_list, "List available players" },
+	{ "show",         "[player]", cmd_show, "Player information" },
 	{ "play",         NULL,       cmd_play, "Start playback" },
 	{ "pause",        NULL,       cmd_pause, "Pause playback" },
 	{ "stop",         NULL,       cmd_stop, "Stop playback" },
@@ -590,71 +706,6 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		player_removed(proxy);
 }
 
-static void print_iter(const char *label, const char *name,
-						DBusMessageIter *iter)
-{
-	dbus_bool_t valbool;
-	dbus_uint32_t valu32;
-	dbus_uint16_t valu16;
-	dbus_int16_t vals16;
-	const char *valstr;
-	DBusMessageIter subiter;
-
-	if (iter == NULL) {
-		rl_printf("%s%s is nil\n", label, name);
-		return;
-	}
-
-	switch (dbus_message_iter_get_arg_type(iter)) {
-	case DBUS_TYPE_INVALID:
-		rl_printf("%s%s is invalid\n", label, name);
-		break;
-	case DBUS_TYPE_STRING:
-	case DBUS_TYPE_OBJECT_PATH:
-		dbus_message_iter_get_basic(iter, &valstr);
-		rl_printf("%s%s: %s\n", label, name, valstr);
-		break;
-	case DBUS_TYPE_BOOLEAN:
-		dbus_message_iter_get_basic(iter, &valbool);
-		rl_printf("%s%s: %s\n", label, name,
-					valbool == TRUE ? "yes" : "no");
-		break;
-	case DBUS_TYPE_UINT32:
-		dbus_message_iter_get_basic(iter, &valu32);
-		rl_printf("%s%s: 0x%06x\n", label, name, valu32);
-		break;
-	case DBUS_TYPE_UINT16:
-		dbus_message_iter_get_basic(iter, &valu16);
-		rl_printf("%s%s: 0x%04x\n", label, name, valu16);
-		break;
-	case DBUS_TYPE_INT16:
-		dbus_message_iter_get_basic(iter, &vals16);
-		rl_printf("%s%s: %d\n", label, name, vals16);
-		break;
-	case DBUS_TYPE_VARIANT:
-		dbus_message_iter_recurse(iter, &subiter);
-		print_iter(label, name, &subiter);
-		break;
-	case DBUS_TYPE_ARRAY:
-		dbus_message_iter_recurse(iter, &subiter);
-		while (dbus_message_iter_get_arg_type(&subiter) !=
-							DBUS_TYPE_INVALID) {
-			print_iter(label, name, &subiter);
-			dbus_message_iter_next(&subiter);
-		}
-		break;
-	case DBUS_TYPE_DICT_ENTRY:
-		dbus_message_iter_recurse(iter, &subiter);
-		dbus_message_iter_get_basic(&subiter, &valstr);
-		dbus_message_iter_next(&subiter);
-		print_iter(label, valstr, &subiter);
-		break;
-	default:
-		rl_printf("%s%s has unsupported type\n", label, name);
-		break;
-	}
-}
-
 static void property_changed(GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data)
 {
-- 
1.8.1.4


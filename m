Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/14] client/bluetooth-player: Add proxy handling for org.bluez.MediaPlayer1
Date: Fri, 31 May 2013 13:55:38 +0300
Message-Id: <1369997749-8663-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
References: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds proxy handling for org.bluez.MediaPlayer1 so changes to the
proxy are printed in the output.
---
 client/bluetooth-player.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/client/bluetooth-player.c b/client/bluetooth-player.c
index 687c649..6525cf3 100644
--- a/client/bluetooth-player.c
+++ b/client/bluetooth-player.c
@@ -47,8 +47,12 @@
 #define PROMPT_ON	COLOR_BLUE "[bluetooth]" COLOR_OFF "# "
 #define PROMPT_OFF	"[bluetooth]# "
 
+#define BLUEZ_MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
+
 static GMainLoop *main_loop;
 static DBusConnection *dbus_conn;
+static GDBusProxy *default_player;
+static GSList *players = NULL;
 
 static void connect_handler(DBusConnection *connection, void *user_data)
 {
@@ -289,6 +293,132 @@ static guint setup_standard_input(void)
 	return source;
 }
 
+static char *player_description(GDBusProxy *proxy, const char *description)
+{
+	const char *path;
+
+	path = g_dbus_proxy_get_path(proxy);
+
+	return g_strdup_printf("%s%s%sPlayer %s ",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					path);
+}
+
+static void print_player(GDBusProxy *proxy, const char *description)
+{
+	char *str;
+
+	str = player_description(proxy, description);
+
+	rl_printf("%s%s\n", str, default_player == proxy ? "[default]" : "");
+
+	g_free(str);
+}
+
+static void player_added(GDBusProxy *proxy)
+{
+	players = g_slist_append(players, proxy);
+
+	if (default_player == NULL)
+		default_player = proxy;
+
+	print_player(proxy, COLORED_NEW);
+}
+
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE))
+		player_added(proxy);
+}
+
+static void player_removed(GDBusProxy *proxy)
+{
+	print_player(proxy, COLORED_DEL);
+
+	if (default_player == proxy)
+		default_player = NULL;
+
+	players = g_slist_remove(players, proxy);
+}
+
+static void proxy_removed(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE))
+		player_removed(proxy);
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
+	default:
+		rl_printf("%s%s has unsupported type\n", label, name);
+		break;
+	}
+}
+
+static void property_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE)) {
+		char *str;
+
+		str = player_description(proxy, COLORED_CHG);
+		print_iter(str, name, iter);
+		g_free(str);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
@@ -333,6 +463,9 @@ int main(int argc, char *argv[])
 	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
 	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
 
+	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
+							property_changed, NULL);
+
 	g_main_loop_run(main_loop);
 
 	g_dbus_client_unref(client);
-- 
1.8.1.4


Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6 v2] tools: Add volume support for mpris-player
Date: Thu, 24 Jan 2013 11:58:03 +0200
Message-Id: <1359021484-6958-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359021484-6958-1-git-send-email-luiz.dentz@gmail.com>
References: <1359021484-6958-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses MediaTransport1 to track the Volume changes.
---
 tools/mpris-player.c | 187 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 178 insertions(+), 9 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index c8377ec..5903ca1 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -43,6 +43,7 @@
 #define BLUEZ_ADAPTER_INTERFACE "org.bluez.Adapter1"
 #define BLUEZ_MEDIA_INTERFACE "org.bluez.Media1"
 #define BLUEZ_MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
+#define BLUEZ_MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
 #define MPRIS_BUS_NAME "org.mpris.MediaPlayer2."
 #define MPRIS_INTERFACE "org.mpris.MediaPlayer2"
 #define MPRIS_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
@@ -55,6 +56,7 @@ static DBusConnection *sys = NULL;
 static DBusConnection *session = NULL;
 static GDBusClient *client = NULL;
 static GSList *players = NULL;
+static GSList *transports = NULL;
 
 struct player {
 	char *name;
@@ -62,6 +64,7 @@ struct player {
 	DBusConnection *conn;
 	GDBusProxy *proxy;
 	GDBusProxy *device;
+	GDBusProxy *transport;
 };
 
 typedef int (* parse_metadata_func) (DBusMessageIter *iter, const char *key,
@@ -793,6 +796,9 @@ static void player_free(void *data)
 	g_dbus_proxy_unref(player->device);
 	g_dbus_proxy_unref(player->proxy);
 
+	if (player->transport)
+		g_dbus_proxy_unref(player->transport);
+
 	g_free(player->name);
 	g_free(player->bus_name);
 	g_free(player);
@@ -1277,6 +1283,30 @@ static gboolean get_enable(const GDBusPropertyTable *property,
 }
 
 
+static gboolean get_volume(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct player *player = data;
+	double value = 0.0;
+	uint16_t volume;
+	DBusMessageIter var;
+
+	if (player->transport == NULL)
+		goto done;
+
+	if (!g_dbus_proxy_get_property(player->transport, "Volume", &var))
+		goto done;
+
+	dbus_message_iter_get_basic(&var, &volume);
+
+	value = (double) volume / 127;
+
+done:
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_DOUBLE, &value);
+
+	return TRUE;
+}
+
 static const GDBusMethodTable player_methods[] = {
 	{ GDBUS_ASYNC_METHOD("PlayPause", NULL, NULL, player_toggle) },
 	{ GDBUS_ASYNC_METHOD("Play", NULL, NULL, player_play) },
@@ -1301,7 +1331,7 @@ static const GDBusPropertyTable player_properties[] = {
 	{ "Shuffle", "b", get_shuffle, set_shuffle, shuffle_exists },
 	{ "Position", "x", get_position, NULL, position_exists },
 	{ "Metadata", "a{sv}", get_track, NULL, track_exists },
-	{ "Volume", "d", get_double, NULL, NULL },
+	{ "Volume", "d", get_volume, NULL, NULL },
 	{ "CanGoNext", "b", get_enable, NULL, NULL },
 	{ "CanGoPrevious", "b", get_enable, NULL, NULL },
 	{ "CanPlay", "b", get_enable, NULL, NULL },
@@ -1355,12 +1385,33 @@ static char *mpris_busname(char *name)
 				g_strcanon(name, A_Z a_z _0_9, '_'), NULL);
 }
 
+static GDBusProxy *find_transport_by_path(const char *path)
+{
+	GSList *l;
+
+	for (l = transports; l; l = l->next) {
+		GDBusProxy *transport = l->data;
+		DBusMessageIter iter;
+		const char *value;
+
+		if (!g_dbus_proxy_get_property(transport, "Device", &iter))
+			continue;
+
+		dbus_message_iter_get_basic(&iter, &value);
+
+		if (strcmp(path, value) == 0)
+			return transport;
+	}
+
+	return NULL;
+}
+
 static void register_player(GDBusProxy *proxy)
 {
 	struct player *player;
 	DBusMessageIter iter;
 	const char *path, *name;
-	GDBusProxy *device;
+	GDBusProxy *device, *transport;
 
 	if (!g_dbus_proxy_get_property(proxy, "Device", &iter))
 		return;
@@ -1416,6 +1467,10 @@ static void register_player(GDBusProxy *proxy)
 		goto fail;
 	}
 
+	transport = find_transport_by_path(path);
+	if (transport)
+		player->transport = g_dbus_proxy_ref(transport);
+
 	return;
 
 fail:
@@ -1423,6 +1478,47 @@ fail:
 	player_free(player);
 }
 
+static struct player *find_player_by_device(const char *device)
+{
+	GSList *l;
+
+	for (l = players; l; l = l->next) {
+		struct player *player = l->data;
+		const char *path = g_dbus_proxy_get_path(player->device);
+
+		if (g_strcmp0(device, path) == 0)
+			return player;
+	}
+
+	return NULL;
+}
+
+static void register_transport(GDBusProxy *proxy)
+{
+	struct player *player;
+	DBusMessageIter iter;
+	const char *path;
+
+	if (g_slist_find(transports, proxy) != NULL)
+		return;
+
+	if (!g_dbus_proxy_get_property(proxy, "Volume", &iter))
+		return;
+
+	if (!g_dbus_proxy_get_property(proxy, "Device", &iter))
+		return;
+
+	dbus_message_iter_get_basic(&iter, &path);
+
+	transports = g_slist_append(transports, proxy);
+
+	player = find_player_by_device(path);
+	if (player == NULL || player->transport != NULL)
+		return;
+
+	player->transport = g_dbus_proxy_ref(proxy);
+}
+
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -1441,6 +1537,10 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		printf("Bluetooth Player %s found\n",
 						g_dbus_proxy_get_path(proxy));
 		register_player(proxy);
+	} else if (!strcmp(interface, BLUEZ_MEDIA_TRANSPORT_INTERFACE)) {
+		printf("Bluetooth Transport %s found\n",
+						g_dbus_proxy_get_path(proxy));
+		register_transport(proxy);
 	}
 }
 
@@ -1466,6 +1566,37 @@ static struct player *find_player(GDBusProxy *proxy)
 	return NULL;
 }
 
+static struct player *find_player_by_transport(GDBusProxy *proxy)
+{
+	GSList *l;
+
+	for (l = players; l; l = l->next) {
+		struct player *player = l->data;
+
+		if (player->transport == proxy)
+			return player;
+	}
+
+	return NULL;
+}
+
+static void unregister_transport(GDBusProxy *proxy)
+{
+	struct player *player;
+
+	if (g_slist_find(transports, proxy) == NULL)
+		return;
+
+	transports = g_slist_remove(transports, proxy);
+
+	player = find_player_by_transport(proxy);
+	if (player == NULL)
+		return;
+
+	g_dbus_proxy_unref(player->transport);
+	player->transport = NULL;
+}
+
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -1491,6 +1622,10 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		printf("Bluetooth Player %s removed\n",
 						g_dbus_proxy_get_path(proxy));
 		unregister_player(player);
+	} else if (strcmp(interface, BLUEZ_MEDIA_TRANSPORT_INTERFACE) == 0) {
+		printf("Bluetooth Transport %s removed\n",
+						g_dbus_proxy_get_path(proxy));
+		unregister_transport(proxy);
 	}
 }
 
@@ -1510,16 +1645,11 @@ static const char *property_to_mpris(const char *property)
 	return NULL;
 }
 
-static void property_changed(GDBusProxy *proxy, const char *name,
+static void player_property_changed(GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data)
 {
 	struct player *player;
-	const char *interface, *property;
-
-	interface = g_dbus_proxy_get_interface(proxy);
-
-	if (strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE) != 0)
-		return;
+	const char *property;
 
 	player = find_player(proxy);
 	if (player == NULL)
@@ -1534,6 +1664,45 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 						property);
 }
 
+static void transport_property_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct player *player;
+	DBusMessageIter var;
+	const char *path;
+
+	if (strcasecmp(name, "Volume") != 0)
+		return;
+
+	if (!g_dbus_proxy_get_property(proxy, "Device", &var))
+		return;
+
+	dbus_message_iter_get_basic(&var, &path);
+
+	player = find_player_by_device(path);
+	if (player == NULL)
+		return;
+
+	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_PLAYER_INTERFACE,
+						name);
+}
+
+static void property_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE) == 0)
+		return player_property_changed(proxy, name, iter, user_data);
+
+	if (strcmp(interface, BLUEZ_MEDIA_TRANSPORT_INTERFACE) == 0)
+		return transport_property_changed(proxy, name, iter,
+								user_data);
+}
+
 int main(int argc, char *argv[])
 {
 	guint owner_watch, properties_watch;
-- 
1.8.1


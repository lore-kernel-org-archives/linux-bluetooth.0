Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/14] tools: Add support for MPRIS TrackList.TrackAdded signal to mpris-player
Date: Wed, 15 May 2013 18:31:36 +0300
Message-Id: <1368631906-15951-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
References: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/mpris-player.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 3fa9cd6..d4e6d14 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1690,6 +1690,12 @@ static const GDBusMethodTable tracklist_methods[] = {
 	{ },
 };
 
+static const GDBusSignalTable tracklist_signals[] = {
+	{ GDBUS_SIGNAL("TrackAdded", GDBUS_ARGS({"metadata", "a{sv}"},
+						{"after", "o"})) },
+	{ }
+};
+
 static void append_path(gpointer data, gpointer user_data)
 {
 	GDBusProxy *proxy = data;
@@ -1813,7 +1819,7 @@ static void register_tracklist(struct player *player, const char *playlist)
 	if (!g_dbus_register_interface(player->conn, MPRIS_PLAYER_PATH,
 						MPRIS_TRACKLIST_INTERFACE,
 						tracklist_methods,
-						NULL,
+						tracklist_signals,
 						tracklist_properties,
 						player, NULL)) {
 		fprintf(stderr, "Could not register interface %s",
@@ -1973,6 +1979,10 @@ static void register_item(struct player *player, GDBusProxy *proxy)
 {
 	struct tracklist *tracklist;
 	const char *path;
+	DBusMessage *signal;
+	DBusMessageIter iter, args, metadata;
+	GSList *l;
+	GDBusProxy *after;
 
 	tracklist = player->tracklist;
 	if (tracklist == NULL)
@@ -1983,11 +1993,46 @@ static void register_item(struct player *player, GDBusProxy *proxy)
 				!g_str_has_prefix(path, tracklist->playlist))
 		return;
 
+	l = g_slist_last(tracklist->items);
 	tracklist->items = g_slist_append(tracklist->items, proxy);
 
 	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
 						MPRIS_TRACKLIST_INTERFACE,
 						"Tracks");
+
+	if (l == NULL)
+		return;
+
+	signal = dbus_message_new_signal(MPRIS_PLAYER_PATH,
+					MPRIS_TRACKLIST_INTERFACE,
+					"TrackAdded");
+	if (!signal) {
+		fprintf(stderr, "Unable to allocate new %s.TrackAdded signal",
+						MPRIS_TRACKLIST_INTERFACE);
+		return;
+	}
+
+	dbus_message_iter_init_append(signal, &args);
+
+	if (!g_dbus_proxy_get_property(proxy, "Metadata", &iter)) {
+		dbus_message_unref(signal);
+		return;
+	}
+
+	dbus_message_iter_open_container(&args, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
+
+	parse_metadata(&iter, &metadata, parse_track_entry);
+
+	dbus_message_iter_close_container(&args, &metadata);
+
+	after = l->data;
+	path = g_dbus_proxy_get_path(after);
+	dbus_message_iter_append_basic(&args, DBUS_TYPE_OBJECT_PATH, &path);
+
+	g_dbus_send_message(player->conn, signal);
 }
 
 static void proxy_added(GDBusProxy *proxy, void *user_data)
-- 
1.8.1.4


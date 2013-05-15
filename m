Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/14] tools: Add support for MPRIS TrackList.TrackMetadataChanged signal to mpris-player
Date: Wed, 15 May 2013 18:31:38 +0300
Message-Id: <1368631906-15951-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
References: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/mpris-player.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 79d815b..681bb09 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1694,6 +1694,8 @@ static const GDBusSignalTable tracklist_signals[] = {
 	{ GDBUS_SIGNAL("TrackAdded", GDBUS_ARGS({"metadata", "a{sv}"},
 						{"after", "o"})) },
 	{ GDBUS_SIGNAL("TrackRemoved", GDBUS_ARGS({"track", "o"})) },
+	{ GDBUS_SIGNAL("TrackMetadataChanged", GDBUS_ARGS({"track", "o"},
+						{"metadata", "a{sv}"})) },
 	{ }
 };
 
@@ -2281,6 +2283,41 @@ static void transport_property_changed(GDBusProxy *proxy, const char *name,
 						name);
 }
 
+static void item_property_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct player *player;
+	DBusMessage *signal;
+	DBusMessageIter args;
+	const char *path;
+
+	path = g_dbus_proxy_get_path(proxy);
+
+	player = find_player_by_item(path);
+	if (player == NULL)
+		return;
+
+	if (strcasecmp(name, "Metadata") != 0)
+		return;
+
+	signal = dbus_message_new_signal(MPRIS_PLAYER_PATH,
+					MPRIS_TRACKLIST_INTERFACE,
+					"TrackMetadataChanged");
+	if (!signal) {
+		fprintf(stderr, "Unable to allocate new %s.TrackAdded signal",
+						MPRIS_TRACKLIST_INTERFACE);
+		return;
+	}
+
+	dbus_message_iter_init_append(signal, &args);
+
+	dbus_message_iter_append_basic(&args, DBUS_TYPE_OBJECT_PATH, &path);
+
+	append_iter(&args, iter);
+
+	g_dbus_send_message(player->conn, signal);
+}
+
 static void property_changed(GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -2294,6 +2331,9 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 	if (strcmp(interface, BLUEZ_MEDIA_TRANSPORT_INTERFACE) == 0)
 		return transport_property_changed(proxy, name, iter,
 								user_data);
+
+	if (strcmp(interface, BLUEZ_MEDIA_ITEM_INTERFACE) == 0)
+		return item_property_changed(proxy, name, iter, user_data);
 }
 
 int main(int argc, char *argv[])
-- 
1.8.1.4


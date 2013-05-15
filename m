Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/14] tools: Add support for MPRIS TrackList.TrackRemoved signal to mpris-player
Date: Wed, 15 May 2013 18:31:37 +0300
Message-Id: <1368631906-15951-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
References: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/mpris-player.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index d4e6d14..79d815b 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1693,6 +1693,7 @@ static const GDBusMethodTable tracklist_methods[] = {
 static const GDBusSignalTable tracklist_signals[] = {
 	{ GDBUS_SIGNAL("TrackAdded", GDBUS_ARGS({"metadata", "a{sv}"},
 						{"after", "o"})) },
+	{ GDBUS_SIGNAL("TrackRemoved", GDBUS_ARGS({"track", "o"})) },
 	{ }
 };
 
@@ -2135,16 +2136,21 @@ static void unregister_item(struct player *player, GDBusProxy *proxy)
 	if (tracklist == NULL)
 		return;
 
-	path = g_dbus_proxy_get_path(proxy);
-	if (g_str_equal(path, tracklist->playlist) ||
-				!g_str_has_prefix(path, tracklist->playlist))
+	if (g_slist_find(tracklist->items, proxy) == NULL)
 		return;
 
+	path = g_dbus_proxy_get_path(proxy);
+
 	tracklist->items = g_slist_remove(tracklist->items, proxy);
 
 	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
 						MPRIS_TRACKLIST_INTERFACE,
 						"Tracks");
+
+	g_dbus_emit_signal(player->conn, MPRIS_PLAYER_PATH,
+				MPRIS_TRACKLIST_INTERFACE, "TrackRemoved",
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
 }
 
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
-- 
1.8.1.4


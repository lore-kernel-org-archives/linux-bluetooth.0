Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] tools: Convert player's properties changed signals to MPRIS
Date: Mon, 21 Jan 2013 17:21:55 +0200
Message-Id: <1358781718-386-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1358781718-386-1-git-send-email-luiz.dentz@gmail.com>
References: <1358781718-386-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Thsi convert properties changed signals from org.bluez.MediaPlayer1 to
org.mpris.MediaPlayer2.Player interface.
---
 tools/mpris-player.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 8e2d85f..31da384 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1443,6 +1443,46 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	}
 }
 
+static const char *property_to_mpris(const char *property)
+{
+	if (strcasecmp(property, "Repeat") == 0)
+		return "LoopStatus";
+	else if (strcasecmp(property, "Shuffle") == 0)
+		return "Shuffle";
+	else if (strcasecmp(property, "Status") == 0)
+		return "PlaybackStatus";
+	else if (strcasecmp(property, "Position") == 0)
+		return "Position";
+	else if (strcasecmp(property, "Track") == 0)
+		return "Metadata";
+
+	return NULL;
+}
+
+static void property_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct player *player;
+	const char *interface, *property;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE) != 0)
+		return;
+
+	player = find_player(proxy);
+	if (player == NULL)
+		return;
+
+	property = property_to_mpris(name);
+	if (property == NULL)
+		return;
+
+	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_PLAYER_INTERFACE,
+						property);
+}
+
 int main(int argc, char *argv[])
 {
 	guint owner_watch, properties_watch;
@@ -1498,7 +1538,7 @@ int main(int argc, char *argv[])
 	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
 
 	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
-								NULL, NULL);
+						property_changed, NULL);
 
 	g_main_loop_run(main_loop);
 
-- 
1.8.0.2


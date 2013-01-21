Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] tools: Make mpris-player to export org.mpris.MediaPlayer2
Date: Mon, 21 Jan 2013 17:21:56 +0200
Message-Id: <1358781718-386-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1358781718-386-1-git-send-email-luiz.dentz@gmail.com>
References: <1358781718-386-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for org.mpris.MediaPlayer2 interface whic is also
mandatory accourding to MPRIS spec.
---
 tools/mpris-player.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 31da384..232e3c0 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -44,6 +44,7 @@
 #define BLUEZ_MEDIA_INTERFACE "org.bluez.Media1"
 #define BLUEZ_MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
 #define MPRIS_BUS_NAME "org.mpris.MediaPlayer2."
+#define MPRIS_INTERFACE "org.mpris.MediaPlayer2"
 #define MPRIS_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
 #define MPRIS_PLAYER_PATH "/org/mpris/MediaPlayer2"
 #define ERROR_INTERFACE "org.mpris.MediaPlayer2.Error"
@@ -1275,6 +1276,7 @@ static gboolean get_enable(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+
 static const GDBusMethodTable player_methods[] = {
 	{ GDBUS_ASYNC_METHOD("PlayPause", NULL, NULL, player_toggle) },
 	{ GDBUS_ASYNC_METHOD("Play", NULL, NULL, player_play) },
@@ -1309,6 +1311,40 @@ static const GDBusPropertyTable player_properties[] = {
 	{ }
 };
 
+static gboolean get_disable(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	dbus_bool_t value = FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static gboolean get_name(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct player *player = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &player->name);
+
+	return TRUE;
+}
+
+static const GDBusMethodTable mpris_methods[] = {
+	{ }
+};
+
+static const GDBusPropertyTable mpris_properties[] = {
+	{ "CanQuit", "b", get_disable, NULL, NULL },
+	{ "Fullscreen", "b", get_disable, NULL, NULL },
+	{ "CanSetFullscreen", "b", get_disable, NULL, NULL },
+	{ "CanRaise", "b", get_disable, NULL, NULL },
+	{ "HasTrackList", "b", get_disable, NULL, NULL },
+	{ "Identity", "s", get_name, NULL, NULL },
+	{ }
+};
+
 static char *mpris_busname(const char *name)
 {
 	char *bus_name;
@@ -1355,6 +1391,17 @@ static void register_player(GDBusProxy *proxy)
 	}
 
 	if (!g_dbus_register_interface(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_INTERFACE,
+						mpris_methods,
+						NULL,
+						mpris_properties,
+						player, NULL)) {
+		fprintf(stderr, "Could not register interface %s",
+						MPRIS_INTERFACE);
+		goto fail;
+	}
+
+	if (!g_dbus_register_interface(player->conn, MPRIS_PLAYER_PATH,
 						MPRIS_PLAYER_INTERFACE,
 						player_methods,
 						player_signals,
-- 
1.8.0.2


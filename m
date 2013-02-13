Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] tools: Track transport state if player status is not supported
Date: Wed, 13 Feb 2013 14:07:18 +0200
Message-Id: <1360757238-8988-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes PlayPause method to work properly even if remote device
supports only AVRCP 1.0.
---
 tools/mpris-player.c | 73 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 4dbde90..8809f2c 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -851,17 +851,48 @@ static void player_control(struct player *player, DBusMessage *msg,
 						p, pending_call_free);
 }
 
+static const char *status_to_playback(const char *status)
+{
+	if (strcasecmp(status, "playing") == 0)
+		return "Playing";
+	else if (strcasecmp(status, "paused") == 0)
+		return "Paused";
+	else
+		return "Stopped";
+}
+
+static const char *player_get_status(struct player *player)
+{
+	const char *status;
+	DBusMessageIter value;
+
+	if (g_dbus_proxy_get_property(player->proxy, "Status", &value)) {
+		dbus_message_iter_get_basic(&value, &status);
+		return status_to_playback(status);
+	}
+
+	if (player->transport == NULL)
+		goto done;
+
+	if (!g_dbus_proxy_get_property(player->transport, "State", &value))
+		goto done;
+
+	dbus_message_iter_get_basic(&value, &status);
+
+	if (strcasecmp(status, "active") == 0)
+		return "Playing";
+
+done:
+	return "Stopped";
+}
+
 static DBusMessage *player_toggle(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	struct player *player = data;
-	DBusMessageIter value;
 	const char *status;
 
-	if (!g_dbus_proxy_get_property(player->proxy, "Status", &value))
-		return FALSE;
-
-	dbus_message_iter_get_basic(&value, &status);
+	status = player_get_status(player);
 
 	if (strcasecmp(status, "Playing") == 0)
 		player_control(player, msg, "Pause");
@@ -923,35 +954,18 @@ static DBusMessage *player_previous(DBusConnection *conn, DBusMessage *msg,
 
 static gboolean status_exists(const GDBusPropertyTable *property, void *data)
 {
-	DBusMessageIter iter;
 	struct player *player = data;
 
-	return g_dbus_proxy_get_property(player->proxy, "Status", &iter);
-}
-
-static const char *status_to_playback(const char *status)
-{
-	if (strcasecmp(status, "playing") == 0)
-		return "Playing";
-	else if (strcasecmp(status, "paused") == 0)
-		return "Paused";
-	else
-		return "Stopped";
+	return player_get_status(player) != NULL;
 }
 
 static gboolean get_status(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct player *player = data;
-	DBusMessageIter value;
 	const char *status;
 
-	if (!g_dbus_proxy_get_property(player->proxy, "Status", &value))
-		return FALSE;
-
-	dbus_message_iter_get_basic(&value, &status);
-
-	status = status_to_playback(status);
+	status = player_get_status(player);
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &status);
 
@@ -1689,7 +1703,7 @@ static void transport_property_changed(GDBusProxy *proxy, const char *name,
 	DBusMessageIter var;
 	const char *path;
 
-	if (strcasecmp(name, "Volume") != 0)
+	if (strcasecmp(name, "Volume") != 0 && strcasecmp(name, "State") != 0)
 		return;
 
 	if (!g_dbus_proxy_get_property(proxy, "Device", &var))
@@ -1701,6 +1715,15 @@ static void transport_property_changed(GDBusProxy *proxy, const char *name,
 	if (player == NULL)
 		return;
 
+	if (strcasecmp(name, "State") == 0) {
+		if (!g_dbus_proxy_get_property(player->proxy, "Status", &var))
+			g_dbus_emit_property_changed(player->conn,
+						MPRIS_PLAYER_PATH,
+						MPRIS_PLAYER_INTERFACE,
+						"PlaybackStatus");
+		return;
+	}
+
 	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
 						MPRIS_PLAYER_INTERFACE,
 						name);
-- 
1.8.1.2


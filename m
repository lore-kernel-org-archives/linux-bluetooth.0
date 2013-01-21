Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] tools: Add support for setting Shuffle and LoopStatus to mpris-player
Date: Mon, 21 Jan 2013 17:21:54 +0200
Message-Id: <1358781718-386-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1358781718-386-1-git-send-email-luiz.dentz@gmail.com>
References: <1358781718-386-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add write support for Shuffle and LoopStatus properties of
org.mpris.MediaPlayer2.Player interface.
---
 tools/mpris-player.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 1871ae9..8e2d85f 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -992,6 +992,58 @@ static gboolean get_repeat(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static const char *loopstatus_to_repeat(const char *value)
+{
+	if (strcasecmp(value, "None") == 0)
+		return "off";
+	else if (strcasecmp(value, "Track") == 0)
+		return "singletrack";
+	else if (strcasecmp(value, "Playlist") == 0)
+		return "alltracks";
+
+	return NULL;
+}
+
+static void property_result(const DBusError *err, void *user_data)
+{
+	GDBusPendingPropertySet id = GPOINTER_TO_UINT(user_data);
+
+	if (!dbus_error_is_set(err))
+		return g_dbus_pending_property_success(id);
+
+	g_dbus_pending_property_error(id, err->name, err->message);
+}
+
+static void set_repeat(const GDBusPropertyTable *property,
+			DBusMessageIter *iter, GDBusPendingPropertySet id,
+			void *data)
+{
+	struct player *player = data;
+	const char *value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	value = loopstatus_to_repeat(value);
+	if (value == NULL) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	g_dbus_proxy_set_property_basic(player->proxy, "Repeat",
+					DBUS_TYPE_STRING, value,
+					property_result, GUINT_TO_POINTER(id),
+					NULL);
+}
+
 static gboolean get_double(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1030,6 +1082,30 @@ static gboolean get_shuffle(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static void set_shuffle(const GDBusPropertyTable *property,
+			DBusMessageIter *iter, GDBusPendingPropertySet id,
+			void *data)
+{
+	struct player *player = data;
+	dbus_bool_t shuffle;
+	const char *value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_get_basic(iter, &shuffle);
+	value = shuffle ? "alltracks" : "off";
+
+	g_dbus_proxy_set_property_basic(player->proxy, "Shuffle",
+					DBUS_TYPE_STRING, value,
+					property_result, GUINT_TO_POINTER(id),
+					NULL);
+}
+
 static gboolean position_exists(const GDBusPropertyTable *property, void *data)
 {
 	DBusMessageIter iter;
@@ -1216,11 +1292,11 @@ static const GDBusSignalTable player_signals[] = {
 
 static const GDBusPropertyTable player_properties[] = {
 	{ "PlaybackStatus", "s", get_status, NULL, status_exists },
-	{ "LoopStatus", "s", get_repeat, NULL, repeat_exists },
+	{ "LoopStatus", "s", get_repeat, set_repeat, repeat_exists },
 	{ "Rate", "d", get_double, NULL, NULL },
 	{ "MinimumRate", "d", get_double, NULL, NULL },
 	{ "MaximumRate", "d", get_double, NULL, NULL },
-	{ "Shuffle", "b", get_shuffle, NULL, shuffle_exists },
+	{ "Shuffle", "b", get_shuffle, set_shuffle, shuffle_exists },
 	{ "Position", "x", get_position, NULL, position_exists },
 	{ "Metadata", "a{sv}", get_track, NULL, track_exists },
 	{ "Volume", "d", get_double, NULL, NULL },
-- 
1.8.0.2


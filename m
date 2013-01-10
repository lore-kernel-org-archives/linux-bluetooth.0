Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/13] player: Remove GetTrack and TrackChanged
Date: Thu, 10 Jan 2013 15:24:29 +0200
Message-Id: <1357824283-19233-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357824283-19233-1-git-send-email-luiz.dentz@gmail.com>
References: <1357824283-19233-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This turn track metadata into a property called "Track" of MediaPlayer1
---
 profiles/audio/player.c | 81 +++++++++++++++----------------------------------
 1 file changed, 25 insertions(+), 56 deletions(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index bffb506..9add1b8 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -82,33 +82,6 @@ static void append_metadata(void *key, void *value, void *user_data)
 	dict_append_entry(dict, key, DBUS_TYPE_STRING, &value);
 }
 
-static DBusMessage *media_player_get_track(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	struct media_player *mp = data;
-	DBusMessage *reply;
-	DBusMessageIter iter, dict;
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-					DBUS_TYPE_STRING_AS_STRING
-					DBUS_TYPE_VARIANT_AS_STRING
-					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
-					&dict);
-
-	g_hash_table_foreach(mp->track, append_metadata, &dict);
-
-	dbus_message_iter_close_container(&iter, &dict);
-
-	return reply;
-}
-
 static struct pending_req *find_pending(struct media_player *mp,
 							const char *key)
 {
@@ -249,16 +222,31 @@ static void set_setting(const GDBusPropertyTable *property,
 	player_set_setting(mp, id, property->name, value);
 }
 
+static gboolean get_track(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_player *mp = data;
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	g_hash_table_foreach(mp->track, append_metadata, &dict);
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	return TRUE;
+}
+
 static const GDBusMethodTable media_player_methods[] = {
-	{ GDBUS_EXPERIMENTAL_METHOD("GetTrack",
-			NULL, GDBUS_ARGS({ "metadata", "a{sv}" }),
-			media_player_get_track) },
 	{ }
 };
 
 static const GDBusSignalTable media_player_signals[] = {
-	{ GDBUS_EXPERIMENTAL_SIGNAL("TrackChanged",
-			GDBUS_ARGS({ "metadata", "a{sv}" })) },
 	{ }
 };
 
@@ -275,6 +263,8 @@ static const GDBusPropertyTable media_player_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Scan", "s", get_setting, set_setting, setting_exists,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Track", "a{sv}", get_track, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
@@ -427,33 +417,12 @@ void media_player_set_status(struct media_player *mp, const char *status)
 static gboolean process_metadata_changed(void *user_data)
 {
 	struct media_player *mp = user_data;
-	DBusMessage *signal;
-	DBusMessageIter iter, dict;
 
 	mp->process_id = 0;
 
-	signal = dbus_message_new_signal(mp->path, MEDIA_PLAYER_INTERFACE,
-							"TrackChanged");
-	if (signal == NULL) {
-		error("Unable to allocate TrackChanged signal");
-		return FALSE;
-	}
-
-	dbus_message_iter_init_append(signal, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-					DBUS_TYPE_STRING_AS_STRING
-					DBUS_TYPE_VARIANT_AS_STRING
-					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
-					&dict);
-
-
-	g_hash_table_foreach(mp->track, append_metadata, &dict);
-
-	dbus_message_iter_close_container(&iter, &dict);
-
-	g_dbus_send_message(btd_get_dbus_connection(), signal);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					mp->path, MEDIA_PLAYER_INTERFACE,
+					"Track");
 
 	return FALSE;
 }
-- 
1.8.0.1


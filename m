Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/13 v2] media: Adapt RegisterPlayer to changes in MediaPlayer1
Date: Thu, 10 Jan 2013 15:37:12 +0200
Message-Id: <1357825038-21970-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
References: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for Track being a property and the removal of
GetTrack and TrackChanged.
---
 profiles/audio/media.c | 199 +++++++++++++++++++++----------------------------
 1 file changed, 85 insertions(+), 114 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 00aa2f4..b184f01 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1181,99 +1181,6 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 	return TRUE;
 }
 
-static gboolean set_player_property(struct media_player *mp, const char *key,
-							DBusMessageIter *entry)
-{
-	DBusMessageIter var;
-	const char *value, *curval;
-	GList *settings;
-
-	if (dbus_message_iter_get_arg_type(entry) != DBUS_TYPE_VARIANT)
-		return FALSE;
-
-	dbus_message_iter_recurse(entry, &var);
-
-	if (strcasecmp(key, "Status") == 0)
-		return set_status(mp, &var);
-
-	if (strcasecmp(key, "Position") == 0)
-		return set_position(mp, &var);
-
-	if (dbus_message_iter_get_arg_type(&var) != DBUS_TYPE_STRING)
-		return FALSE;
-
-	dbus_message_iter_get_basic(&var, &value);
-
-	curval = g_hash_table_lookup(mp->settings, key);
-	if (g_strcmp0(curval, value) == 0)
-		return TRUE;
-
-	DBG("%s=%s", key, value);
-
-	g_hash_table_replace(mp->settings, g_strdup(key), g_strdup(value));
-
-	settings = list_settings(mp);
-
-	avrcp_player_event(mp->player, AVRCP_EVENT_SETTINGS_CHANGED, settings);
-
-	g_list_free(settings);
-
-	return TRUE;
-}
-
-static gboolean parse_player_properties(struct media_player *mp,
-							DBusMessageIter *iter)
-{
-	DBusMessageIter dict;
-	int ctype;
-
-	ctype = dbus_message_iter_get_arg_type(iter);
-	if (ctype != DBUS_TYPE_ARRAY)
-		return FALSE;
-
-	dbus_message_iter_recurse(iter, &dict);
-
-	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
-							DBUS_TYPE_INVALID) {
-		DBusMessageIter entry;
-		const char *key;
-
-		if (ctype != DBUS_TYPE_DICT_ENTRY)
-			return FALSE;
-
-		dbus_message_iter_recurse(&dict, &entry);
-		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
-			return FALSE;
-
-		dbus_message_iter_get_basic(&entry, &key);
-		dbus_message_iter_next(&entry);
-
-		if (set_player_property(mp, key, &entry) == FALSE)
-			return FALSE;
-
-		dbus_message_iter_next(&dict);
-	}
-
-	return TRUE;
-}
-
-static gboolean properties_changed(DBusConnection *connection, DBusMessage *msg,
-							void *user_data)
-{
-	struct media_player *mp = user_data;
-	DBusMessageIter iter;
-
-	DBG("sender=%s path=%s", mp->sender, mp->path);
-
-	dbus_message_iter_init(msg, &iter);
-
-	dbus_message_iter_next(&iter);
-
-	parse_player_properties(mp, &iter);
-
-	return TRUE;
-}
-
 static gboolean parse_player_metadata(struct media_player *mp,
 							DBusMessageIter *iter)
 {
@@ -1346,7 +1253,7 @@ static gboolean parse_player_metadata(struct media_player *mp,
 
 			dbus_message_iter_get_basic(&var, &num);
 			mp->duration = num;
-		} else if (strcasecmp(key, "Track") == 0) {
+		} else if (strcasecmp(key, "TrackNumber") == 0) {
 			if (type != DBUS_TYPE_UINT32)
 				goto parse_error;
 
@@ -1400,7 +1307,86 @@ parse_error:
 	return FALSE;
 }
 
-static gboolean track_changed(DBusConnection *connection, DBusMessage *msg,
+static gboolean set_player_property(struct media_player *mp, const char *key,
+							DBusMessageIter *entry)
+{
+	DBusMessageIter var;
+	const char *value, *curval;
+	GList *settings;
+
+	if (dbus_message_iter_get_arg_type(entry) != DBUS_TYPE_VARIANT)
+		return FALSE;
+
+	dbus_message_iter_recurse(entry, &var);
+
+	if (strcasecmp(key, "Status") == 0)
+		return set_status(mp, &var);
+
+	if (strcasecmp(key, "Position") == 0)
+		return set_position(mp, &var);
+
+	if (strcasecmp(key, "Track") == 0)
+		return parse_player_metadata(mp, &var);
+
+	if (dbus_message_iter_get_arg_type(&var) != DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&var, &value);
+
+	curval = g_hash_table_lookup(mp->settings, key);
+	if (g_strcmp0(curval, value) == 0)
+		return TRUE;
+
+	DBG("%s=%s", key, value);
+
+	g_hash_table_replace(mp->settings, g_strdup(key), g_strdup(value));
+
+	settings = list_settings(mp);
+
+	avrcp_player_event(mp->player, AVRCP_EVENT_SETTINGS_CHANGED, settings);
+
+	g_list_free(settings);
+
+	return TRUE;
+}
+
+static gboolean parse_player_properties(struct media_player *mp,
+							DBusMessageIter *iter)
+{
+	DBusMessageIter dict;
+	int ctype;
+
+	ctype = dbus_message_iter_get_arg_type(iter);
+	if (ctype != DBUS_TYPE_ARRAY)
+		return FALSE;
+
+	dbus_message_iter_recurse(iter, &dict);
+
+	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
+							DBUS_TYPE_INVALID) {
+		DBusMessageIter entry;
+		const char *key;
+
+		if (ctype != DBUS_TYPE_DICT_ENTRY)
+			return FALSE;
+
+		dbus_message_iter_recurse(&dict, &entry);
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
+			return FALSE;
+
+		dbus_message_iter_get_basic(&entry, &key);
+		dbus_message_iter_next(&entry);
+
+		if (set_player_property(mp, key, &entry) == FALSE)
+			return FALSE;
+
+		dbus_message_iter_next(&dict);
+	}
+
+	return TRUE;
+}
+
+static gboolean properties_changed(DBusConnection *connection, DBusMessage *msg,
 							void *user_data)
 {
 	struct media_player *mp = user_data;
@@ -1410,11 +1396,9 @@ static gboolean track_changed(DBusConnection *connection, DBusMessage *msg,
 
 	dbus_message_iter_init(msg, &iter);
 
-	if (parse_player_metadata(mp, &iter) == FALSE) {
-		error("Unexpected signature in %s.%s signal",
-					dbus_message_get_interface(msg),
-					dbus_message_get_member(msg));
-	}
+	dbus_message_iter_next(&iter);
+
+	parse_player_properties(mp, &iter);
 
 	return TRUE;
 }
@@ -1440,11 +1424,6 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 						path, MEDIA_PLAYER_INTERFACE,
 						properties_changed,
 						mp, NULL);
-	mp->track_watch = g_dbus_add_signal_watch(conn, sender,
-						path, MEDIA_PLAYER_INTERFACE,
-						"TrackChanged",
-						track_changed,
-						mp, NULL);
 	mp->player = avrcp_register_player(adapter->btd_adapter, &player_cb,
 							mp, media_player_free);
 	if (!mp->player) {
@@ -1499,13 +1478,6 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
-	dbus_message_iter_next(&args);
-
-	if (parse_player_metadata(mp, &args) == FALSE) {
-		media_player_destroy(mp);
-		return btd_error_invalid_args(msg);
-	}
-
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
@@ -1539,8 +1511,7 @@ static const GDBusMethodTable media_methods[] = {
 	{ GDBUS_METHOD("UnregisterEndpoint",
 		GDBUS_ARGS({ "endpoint", "o" }), NULL, unregister_endpoint) },
 	{ GDBUS_EXPERIMENTAL_METHOD("RegisterPlayer",
-		GDBUS_ARGS({ "player", "o" }, { "properties", "a{sv}" },
-						{ "metadata", "a{sv}" }),
+		GDBUS_ARGS({ "player", "o" }, { "properties", "a{sv}" }),
 		NULL, register_player) },
 	{ GDBUS_EXPERIMENTAL_METHOD("UnregisterPlayer",
 		GDBUS_ARGS({ "player", "o" }), NULL, unregister_player) },
-- 
1.8.0.1


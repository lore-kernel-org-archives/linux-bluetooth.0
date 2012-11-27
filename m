Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] audio: Convert controller MediaPlayer interface to use D-Bus Properties
Date: Tue, 27 Nov 2012 14:51:21 +0200
Message-Id: <1354020685-17028-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1354020685-17028-1-git-send-email-luiz.dentz@gmail.com>
References: <1354020685-17028-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/player.c | 222 +++++++++++++++++++++++-------------------------
 1 file changed, 106 insertions(+), 116 deletions(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index e83b761..34b1f20 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -50,7 +50,7 @@ struct player_callback {
 };
 
 struct pending_req {
-	DBusMessage *msg;
+	GDBusPendingPropertySet id;
 	const char *key;
 	const char *value;
 };
@@ -67,13 +67,6 @@ struct media_player {
 	GSList			*pending;
 };
 
-static void append_settings(void *key, void *value, void *user_data)
-{
-	DBusMessageIter *dict = user_data;
-
-	dict_append_entry(dict, key, DBUS_TYPE_STRING, &value);
-}
-
 static void append_metadata(void *key, void *value, void *user_data)
 {
 	DBusMessageIter *dict = user_data;
@@ -89,39 +82,6 @@ static void append_metadata(void *key, void *value, void *user_data)
 	dict_append_entry(dict, key, DBUS_TYPE_STRING, &value);
 }
 
-static DBusMessage *media_player_get_properties(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	struct media_player *mp = data;
-	DBusMessage *reply;
-	DBusMessageIter iter, dict;
-	uint32_t position;
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
-	position = media_player_get_position(mp);
-	dict_append_entry(&dict, "Position", DBUS_TYPE_UINT32, &position);
-
-	dict_append_entry(&dict, "Status", DBUS_TYPE_STRING, &mp->status);
-
-	g_hash_table_foreach(mp->settings, append_settings, &dict);
-
-	dbus_message_iter_close_container(&iter, &dict);
-
-	return reply;
-}
-
 static DBusMessage *media_player_get_track(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -164,111 +124,142 @@ static struct pending_req *find_pending(struct media_player *mp,
 	return NULL;
 }
 
-static struct pending_req *pending_new(DBusMessage *msg, const char *key,
-							const char *value)
+static struct pending_req *pending_new(GDBusPendingPropertySet id,
+					const char *key, const char *value)
 {
 	struct pending_req *p;
 
 	p = g_new0(struct pending_req, 1);
-	p->msg = dbus_message_ref(msg);
+	p->id = id;
 	p->key = key;
 	p->value = value;
 
 	return p;
 }
 
-static DBusMessage *player_set_setting(struct media_player *mp,
-					DBusMessage *msg, const char *key,
-					const char *value)
+static gboolean get_position(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
-	struct player_callback *cb = mp->cb;
-	struct pending_req *p;
+	struct media_player *mp = data;
 
-	if (cb == NULL || cb->cbs->set_setting == NULL)
-		return btd_error_not_supported(msg);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &mp->position);
 
-	p = find_pending(mp, key);
-	if (p != NULL)
-		return btd_error_in_progress(msg);
+	return TRUE;
+}
 
-	if (!cb->cbs->set_setting(mp, key, value, cb->user_data))
-		return btd_error_invalid_args(msg);
+static gboolean status_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct media_player *mp = data;
+
+	return mp->status != NULL;
+}
 
-	p = pending_new(msg, key, value);
+static gboolean get_status(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_player *mp = data;
 
-	mp->pending = g_slist_append(mp->pending, p);
+	if (mp->status == NULL)
+		return FALSE;
 
-	return NULL;
+	DBG("%s", mp->status);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &mp->status);
+
+	return TRUE;
 }
 
-static DBusMessage *media_player_set_property(DBusConnection *conn,
-						DBusMessage *msg, void *data)
+static gboolean setting_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_player *mp = data;
-	DBusMessageIter iter;
-	DBusMessageIter var;
-	const char *key, *value, *curval;
 
-	if (!dbus_message_iter_init(msg, &iter))
-		return btd_error_invalid_args(msg);
+	return g_hash_table_contains(mp->settings, property->name);
+}
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return btd_error_invalid_args(msg);
+static gboolean get_setting(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_player *mp = data;
+	const char *value;
 
-	dbus_message_iter_get_basic(&iter, &key);
-	dbus_message_iter_next(&iter);
+	value = g_hash_table_lookup(mp->settings, property->name);
+	if (value == NULL)
+		return FALSE;
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
-		return btd_error_invalid_args(msg);
+	DBG("%s %s", property->name, value);
 
-	dbus_message_iter_recurse(&iter, &var);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &value);
 
-	if (dbus_message_iter_get_arg_type(&var) != DBUS_TYPE_STRING)
-		return btd_error_invalid_args(msg);
+	return TRUE;
+}
 
-	dbus_message_iter_get_basic(&var, &value);
+static void player_set_setting(struct media_player *mp,
+					GDBusPendingPropertySet id,
+					const char *key, const char *value)
+{
+	struct player_callback *cb = mp->cb;
+	struct pending_req *p;
 
-	if (g_strcmp0(key, "Equalizer") != 0 &&
-				g_strcmp0(key, "Repeat") != 0 &&
-				g_strcmp0(key, "Shuffle") != 0 &&
-				g_strcmp0(key, "Scan") != 0)
-		return btd_error_invalid_args(msg);
+	if (cb == NULL || cb->cbs->set_setting == NULL)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".NotSupported",
+					"Operation is not supported");
 
-	curval = g_hash_table_lookup(mp->settings, key);
-	if (g_strcmp0(curval, value) == 0)
-		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	p = find_pending(mp, key);
+	if (p != NULL)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InProgress",
+					"Operation already in progress");
 
-	return player_set_setting(mp, msg, key, value);
+	if (!cb->cbs->set_setting(mp, key, value, cb->user_data))
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+
+	p = pending_new(id, key, value);
+
+	mp->pending = g_slist_append(mp->pending, p);
+}
+
+static void set_setting(const GDBusPropertyTable *property,
+			DBusMessageIter *iter, GDBusPendingPropertySet id,
+			void *data)
+{
+	struct media_player *mp = data;
+	const char *value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	player_set_setting(mp, id, property->name, value);
 }
 
 static const GDBusMethodTable media_player_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			media_player_get_properties) },
 	{ GDBUS_METHOD("GetTrack",
 			NULL, GDBUS_ARGS({ "metadata", "a{sv}" }),
 			media_player_get_track) },
-	{ GDBUS_ASYNC_METHOD("SetProperty",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" }),
-			NULL, media_player_set_property) },
 	{ }
 };
 
 static const GDBusSignalTable media_player_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ GDBUS_SIGNAL("TrackChanged",
 			GDBUS_ARGS({ "metadata", "a{sv}" })) },
 	{ }
 };
 
-static void pending_free(void *data)
-{
-	struct pending_req *p = data;
-
-	dbus_message_unref(p->msg);
-	g_free(p);
-}
+static const GDBusPropertyTable media_player_properties[] = {
+	{ "Position", "u", get_position },
+	{ "Status", "s", get_status, NULL, status_exists },
+	{ "Equalizer", "s", get_setting, set_setting, setting_exists },
+	{ "Repeat", "s", get_setting, set_setting, setting_exists },
+	{ "Shuffle", "s", get_setting, set_setting, setting_exists },
+	{ "Scan", "s", get_setting, set_setting, setting_exists },
+	{ }
+};
 
 void media_player_destroy(struct media_player *mp)
 {
@@ -286,7 +277,7 @@ void media_player_destroy(struct media_player *mp)
 	if (mp->process_id > 0)
 		g_source_remove(mp->process_id);
 
-	g_slist_free_full(mp->pending, pending_free);
+	g_slist_free_full(mp->pending, g_free);
 
 	g_timer_destroy(mp->progress);
 	g_free(mp->cb);
@@ -311,7 +302,7 @@ struct media_player *media_player_controller_create(const char *path)
 					mp->path, MEDIA_PLAYER_INTERFACE,
 					media_player_methods,
 					media_player_signals,
-					NULL, mp, NULL)) {
+					media_player_properties, mp, NULL)) {
 		error("D-Bus failed to register %s path", mp->path);
 		media_player_destroy(mp);
 		return NULL;
@@ -345,8 +336,8 @@ void media_player_set_position(struct media_player *mp, uint32_t position)
 	mp->position = position;
 	g_timer_start(mp->progress);
 
-	emit_property_changed(mp->path, MEDIA_PLAYER_INTERFACE, "Position",
-					DBUS_TYPE_UINT32, &mp->position);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
+					MEDIA_PLAYER_INTERFACE, "Position");
 }
 
 void media_player_set_setting(struct media_player *mp, const char *key,
@@ -354,7 +345,6 @@ void media_player_set_setting(struct media_player *mp, const char *key,
 {
 	char *curval;
 	struct pending_req *p;
-	DBusMessage *reply;
 
 	DBG("%s: %s", key, value);
 
@@ -363,7 +353,8 @@ void media_player_set_setting(struct media_player *mp, const char *key,
 		if (p == NULL)
 			return;
 
-		reply = btd_error_failed(p->msg, value);
+		g_dbus_pending_property_error(p->id, ERROR_INTERFACE ".Failed",
+									value);
 		goto send;
 	}
 
@@ -372,9 +363,8 @@ void media_player_set_setting(struct media_player *mp, const char *key,
 		goto done;
 
 	g_hash_table_replace(mp->settings, g_strdup(key), g_strdup(value));
-
-	emit_property_changed(mp->path, MEDIA_PLAYER_INTERFACE, key,
-					DBUS_TYPE_STRING, &value);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
+					MEDIA_PLAYER_INTERFACE, key);
 
 done:
 	p = find_pending(mp, key);
@@ -382,15 +372,15 @@ done:
 		return;
 
 	if (strcasecmp(value, p->value) == 0)
-		reply = g_dbus_create_reply(p->msg, DBUS_TYPE_INVALID);
+		g_dbus_pending_property_success(p->id);
 	else
-		reply = btd_error_not_supported(p->msg);
+		g_dbus_pending_property_error(p->id,
+					ERROR_INTERFACE ".NotSupported",
+					"Operation is not supported");
 
 send:
-	g_dbus_send_message(btd_get_dbus_connection(), reply);
-
 	mp->pending = g_slist_remove(mp->pending, p);
-	pending_free(p);
+	g_free(p);
 
 	return;
 }
@@ -410,8 +400,8 @@ void media_player_set_status(struct media_player *mp, const char *status)
 	g_free(mp->status);
 	mp->status = g_strdup(status);
 
-	emit_property_changed(mp->path, MEDIA_PLAYER_INTERFACE, "Status",
-					DBUS_TYPE_STRING, &status);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
+					MEDIA_PLAYER_INTERFACE, "Status");
 
 	mp->position = media_player_get_position(mp);
 	g_timer_start(mp->progress);
-- 
1.7.11.7


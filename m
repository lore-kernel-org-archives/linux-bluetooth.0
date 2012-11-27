Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] media: Convert target MediaPlayer interface to use D-Bus Properties
Date: Tue, 27 Nov 2012 14:51:22 +0200
Message-Id: <1354020685-17028-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1354020685-17028-1-git-send-email-luiz.dentz@gmail.com>
References: <1354020685-17028-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/media.c | 100 ++++++++++++++++++++++---------------------------
 1 file changed, 45 insertions(+), 55 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 588d61e..f2fba7b 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -96,7 +96,7 @@ struct media_player {
 	GHashTable		*settings;	/* Player settings */
 	GHashTable		*track;		/* Player current track */
 	guint			watch;
-	guint			property_watch;
+	guint			properties_watch;
 	guint			track_watch;
 	char			*status;
 	uint32_t		position;
@@ -916,7 +916,7 @@ static void media_player_free(gpointer data)
 	}
 
 	g_dbus_remove_watch(conn, mp->watch);
-	g_dbus_remove_watch(conn, mp->property_watch);
+	g_dbus_remove_watch(conn, mp->properties_watch);
 	g_dbus_remove_watch(conn, mp->track_watch);
 
 	if (mp->track)
@@ -980,6 +980,7 @@ static const char *get_setting(const char *key, void *user_data)
 static int set_setting(const char *key, const char *value, void *user_data)
 {
 	struct media_player *mp = user_data;
+	const char *iface = MEDIA_PLAYER_INTERFACE;
 	DBusMessage *msg;
 	DBusMessageIter iter, var;
 
@@ -989,14 +990,14 @@ static int set_setting(const char *key, const char *value, void *user_data)
 		return -EINVAL;
 
 	msg = dbus_message_new_method_call(mp->sender, mp->path,
-						MEDIA_PLAYER_INTERFACE,
-						"SetProperty");
+					DBUS_INTERFACE_PROPERTIES, "Set");
 	if (msg == NULL) {
 		error("Couldn't allocate D-Bus message");
 		return -ENOMEM;
 	}
 
 	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &iface);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &key);
 
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT,
@@ -1218,29 +1219,55 @@ static gboolean set_player_property(struct media_player *mp, const char *key,
 	return TRUE;
 }
 
-static gboolean property_changed(DBusConnection *connection, DBusMessage *msg,
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
 	DBusMessageIter iter;
-	const char *property;
 
 	DBG("sender=%s path=%s", mp->sender, mp->path);
 
 	dbus_message_iter_init(msg, &iter);
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
-		error("Unexpected signature in %s.%s signal",
-					dbus_message_get_interface(msg),
-					dbus_message_get_member(msg));
-		return TRUE;
-	}
-
-	dbus_message_iter_get_basic(&iter, &property);
-
 	dbus_message_iter_next(&iter);
 
-	set_player_property(mp, property, &iter);
+	parse_player_properties(mp, &iter);
 
 	return TRUE;
 }
@@ -1407,10 +1434,9 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 	mp->watch = g_dbus_add_disconnect_watch(conn, sender,
 						media_player_exit, mp,
 						NULL);
-	mp->property_watch = g_dbus_add_signal_watch(conn, sender,
+	mp->properties_watch = g_dbus_add_properties_watch(conn, sender,
 						path, MEDIA_PLAYER_INTERFACE,
-						"PropertyChanged",
-						property_changed,
+						properties_changed,
 						mp, NULL);
 	mp->track_watch = g_dbus_add_signal_watch(conn, sender,
 						path, MEDIA_PLAYER_INTERFACE,
@@ -1439,42 +1465,6 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 	return mp;
 }
 
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
 static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
-- 
1.7.11.7


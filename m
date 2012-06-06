Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 07/13] media: Add support for local changing addressed player
Date: Wed, 6 Jun 2012 18:06:05 +0200
Message-ID: <1338998771-18683-7-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is possibility to register more than one player. This patch
allows to change currently selected player from the list of previously
registered players.

This patch extends Media interface for Addressed Player procedure and
adds Default Dummy Player to avoid confusion with AVRCP 1.3
devices.
---
 audio/media.c |  146 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 2 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 5010ea5..3455496 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -54,6 +54,8 @@
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint"
 #define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer"
 
+#define DUMMY_PLAYER "/dummy"
+
 #define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
 
 struct media_adapter {
@@ -62,6 +64,7 @@ struct media_adapter {
 	DBusConnection		*conn;		/* Adapter connection */
 	GSList			*endpoints;	/* Endpoints list */
 	GSList			*players;	/* Players list */
+	struct media_player	*addressed;	/* Addressed Player */
 };
 
 struct endpoint_request {
@@ -102,6 +105,7 @@ struct media_player {
 	uint8_t			status;
 	uint32_t		position;
 	uint8_t			volume;
+	uint16_t		id;
 	GTimer			*timer;
 };
 
@@ -115,6 +119,11 @@ struct metadata_value {
 
 static GSList *adapters = NULL;
 
+static struct media_player *media_player_create(struct media_adapter *adapter,
+						const char *sender,
+						const char *path,
+						int *err);
+
 static void endpoint_request_free(struct endpoint_request *request)
 {
 	if (request->call)
@@ -961,6 +970,25 @@ static struct media_player *media_adapter_find_player(
 	return NULL;
 }
 
+static struct media_player *media_adapter_find_player_by_id(
+						struct media_adapter *adapter,
+						const char *sender,
+						uint16_t player_id) {
+	GSList *l;
+
+	for (l = adapter->players; l; l = l->next) {
+		struct media_player *mp = l->data;
+
+		if (sender && g_strcmp0(mp->sender, sender) != 0)
+			continue;
+
+		if (player_id == mp->id)
+			return mp;
+	}
+
+	return NULL;
+}
+
 static void release_player(struct media_player *mp)
 {
 	DBusMessage *msg;
@@ -1370,6 +1398,51 @@ static void set_volume(uint8_t volume, struct audio_device *dev, void *user_data
 	}
 }
 
+static void media_update_players(struct media_adapter *adapter)
+{
+	char **players;
+	int i;
+	GSList *l;
+	struct media_player *mp = NULL;
+
+	players = g_new0(char *, g_slist_length(adapter->players) + 1);
+	for (i = 0, l = adapter->players; l; l = l->next, i++) {
+		mp = l->data;
+		players[i] = mp->path;
+	}
+
+	emit_array_property_changed(adapter->conn, adapter->path,
+					MEDIA_INTERFACE, "Players",
+					DBUS_TYPE_OBJECT_PATH, &players, i);
+	g_free(players);
+}
+
+static gboolean media_set_addressed_player(struct media_adapter *adapter,
+					    const char *sender, const char *path,
+					    gboolean local)
+{
+	struct media_player *mp;
+
+	if (adapter->addressed &&
+		g_strcmp0(path, adapter->addressed->path) == 0)
+		return FALSE;
+
+	mp = media_adapter_find_player(adapter, NULL, path);
+	if (!mp && g_strcmp0(path, DUMMY_PLAYER) == 0)
+		mp = media_player_create(adapter, NULL, DUMMY_PLAYER, NULL);
+
+	if (!mp)
+		return FALSE;
+
+	if (adapter->addressed &&
+		g_strcmp0(adapter->addressed->path, DUMMY_PLAYER) == 0)
+		media_player_remove(adapter->addressed);
+
+	adapter->addressed = mp;
+
+	return TRUE;
+}
+
 static struct avrcp_player_cb player_cb = {
 	.get_setting = get_setting,
 	.set_setting = set_setting,
@@ -1673,6 +1746,17 @@ static gboolean track_changed(DBusConnection *connection, DBusMessage *msg,
 	return TRUE;
 }
 
+/* Need at least one free id to avoid infinite loop */
+static uint16_t get_free_player_id(struct media_adapter *adapter,
+						const char *sender)
+{
+	static uint16_t last_id = 0;
+
+	while (media_adapter_find_player_by_id(adapter, sender, last_id++));
+
+	return last_id - 1;
+}
+
 static struct media_player *media_player_create(struct media_adapter *adapter,
 						const char *sender,
 						const char *path,
@@ -1680,6 +1764,12 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 {
 	struct media_player *mp;
 
+	if (g_slist_length(adapter->players) >= UINT16_MAX) {
+		if (err)
+			*err = -EINVAL;
+		return NULL;
+	}
+
 	mp = g_new0(struct media_player, 1);
 	mp->adapter = adapter;
 	mp->sender = g_strdup(sender);
@@ -1709,10 +1799,11 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 	}
 
 	mp->settings = g_hash_table_new(g_direct_hash, g_direct_equal);
+	mp->id = get_free_player_id(adapter, sender);
 
 	adapter->players = g_slist_append(adapter->players, mp);
 
-	info("Player registered: sender=%s path=%s", sender, path);
+	info("Player registered: sender=%s path=%s id=%d", sender, path, mp->id);
 
 	if (err)
 		*err = 0;
@@ -1762,7 +1853,8 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 	struct media_adapter *adapter = data;
 	struct media_player *mp;
 	DBusMessageIter args;
-	const char *sender, *path;
+	const char *sender;
+	char *path;
 	int err;
 
 	sender = dbus_message_get_sender(msg);
@@ -1772,6 +1864,8 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 	dbus_message_iter_get_basic(&args, &path);
 	dbus_message_iter_next(&args);
 
+	DBG("Registering player sender=%s path=%s", sender, path);
+
 	if (media_adapter_find_player(adapter, sender, path) != NULL)
 		return btd_error_already_exists(msg);
 
@@ -1795,6 +1889,11 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
+	if (g_strcmp0(adapter->addressed->path, DUMMY_PLAYER) == 0)
+		media_set_addressed_player(adapter, sender, path, TRUE);
+
+	media_update_players(adapter);
+
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
@@ -1812,12 +1911,19 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 
 	sender = dbus_message_get_sender(msg);
 
+	DBG("Unregistering player sender=%s path=%s", sender, path);
+
 	player = media_adapter_find_player(adapter, sender, path);
 	if (player == NULL)
 		return btd_error_does_not_exist(msg);
 
 	media_player_remove(player);
 
+	if (g_strcmp0(adapter->addressed->path, path) == 0)
+		media_set_addressed_player(adapter, sender, DUMMY_PLAYER, TRUE);
+
+	media_update_players(adapter);
+
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
@@ -1825,9 +1931,12 @@ static DBusMessage *get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct media_adapter *adapter = data;
+	const char *property;
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
+	char **players;
+	int i;
 	GSList *l;
 
 	reply = dbus_message_new_method_return(msg);
@@ -1841,6 +1950,21 @@ static DBusMessage *get_properties(DBusConnection *conn,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
+	/* Players */
+	players = g_new0(char *, g_slist_length(adapter->players) + 1);
+	for (i = 0, l = adapter->players; l; l = l->next, i++) {
+		struct media_player *mp = l->data;
+
+		players[i] = mp->path;
+	}
+	dict_append_array(&dict, "Players", DBUS_TYPE_OBJECT_PATH,
+								&players, i);
+	g_free(players);
+
+	/* AddressedPlayer */
+	property = adapter->addressed->path;
+	dict_append_entry(&dict, "AddressedPlayer", DBUS_TYPE_OBJECT_PATH, &property);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
@@ -1853,6 +1977,9 @@ static DBusMessage *set_property(DBusConnection *conn,
 	DBusMessageIter iter;
 	DBusMessageIter sub;
 	const char *property;
+	const char *sender;
+
+	sender = dbus_message_get_sender(msg);
 
 	if (!dbus_message_iter_init(msg, &iter))
 		return btd_error_invalid_args(msg);
@@ -1867,6 +1994,19 @@ static DBusMessage *set_property(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 	dbus_message_iter_recurse(&iter, &sub);
 
+	if (g_str_equal("AddressedPlayer", property)) {
+		const char *path;
+
+		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_OBJECT_PATH)
+			return btd_error_invalid_args(msg);
+		dbus_message_iter_get_basic(&sub, &path);
+
+		if (!media_set_addressed_player(adapter, sender, path, TRUE))
+		    return btd_error_invalid_args(msg);
+
+		return dbus_message_new_method_return(msg);
+	}
+
 	return btd_error_invalid_args(msg);
 }
 
@@ -1913,6 +2053,8 @@ int media_register(DBusConnection *conn, const char *path, const bdaddr_t *src)
 	adapter->conn = dbus_connection_ref(conn);
 	bacpy(&adapter->src, src);
 	adapter->path = g_strdup(path);
+	adapter->addressed = NULL;
+	media_set_addressed_player(adapter, NULL, DUMMY_PLAYER, TRUE);
 
 	if (!g_dbus_register_interface(conn, path, MEDIA_INTERFACE,
 					media_methods, NULL, NULL,
-- 
on behalf of ST-Ericsson


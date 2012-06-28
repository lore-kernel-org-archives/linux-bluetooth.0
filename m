Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mobi>,
	<johan.hedberg@gmail.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v3 10/14] media: Add support for changing addressed player
Date: Thu, 28 Jun 2012 12:22:35 +0200
Message-ID: <1340878959-1343-10-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1340878959-1343-1-git-send-email-michal.labedzki@tieto.com>
References: <1340878959-1343-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is possibility to register more than one player. This patch
allows to change currently selected player to one the list of
previously registered players. If there are no any registered players
add Dummy Player for compatibility with AVRCP 1.3 device or
AVRCP 1.4 without MultiplePlayer feature.
---
 audio/media.c |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index f3cca25..ce5822a 100644
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
 
@@ -961,6 +965,25 @@ static struct media_player *media_adapter_find_player(
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
@@ -1673,6 +1696,17 @@ static gboolean track_changed(DBusConnection *connection, DBusMessage *msg,
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
@@ -1680,6 +1714,12 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
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
@@ -1709,10 +1749,11 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 	}
 
 	mp->settings = g_hash_table_new(g_direct_hash, g_direct_equal);
+	mp->id = get_free_player_id(adapter, sender);
 
 	adapter->players = g_slist_append(adapter->players, mp);
 
-	info("Player registered: sender=%s path=%s", sender, path);
+	info("Player registered: sender=%s path=%s id=%d", sender, path, mp->id);
 
 	if (err)
 		*err = 0;
@@ -1720,6 +1761,57 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 	return mp;
 }
 
+static gboolean media_set_addressed_player(struct media_adapter *adapter,
+					    const char *sender, const char *path,
+					    gboolean local)
+{
+	struct media_player *mp;
+	struct metadata_value *value;
+
+	if (adapter->addressed &&
+		g_strcmp0(path, adapter->addressed->path) == 0)
+		return FALSE;
+
+	mp = media_adapter_find_player(adapter, NULL, path);
+	if (!mp && g_strcmp0(path, DUMMY_PLAYER) == 0) {
+		mp = media_player_create(adapter, NULL, DUMMY_PLAYER, NULL);
+		if (!mp)
+			return FALSE;
+
+		mp->position = 0;
+		mp->track = g_hash_table_new_full(g_direct_hash, g_direct_equal, NULL,
+							metadata_value_free);
+		value = g_new0(struct metadata_value, 1);
+		value->type = DBUS_TYPE_STRING;
+		value->value.str = g_strdup("no player");
+		g_hash_table_replace(mp->track, GUINT_TO_POINTER(AVRCP_MEDIA_ATTRIBUTE_TITLE), value);
+
+		g_hash_table_replace(mp->settings,
+					GUINT_TO_POINTER(AVRCP_ATTRIBUTE_EQUALIZER),
+					GUINT_TO_POINTER(AVRCP_EQUALIZER_OFF));
+		g_hash_table_replace(mp->settings,
+					GUINT_TO_POINTER(AVRCP_ATTRIBUTE_REPEAT_MODE),
+					GUINT_TO_POINTER(AVRCP_REPEAT_MODE_OFF));
+		g_hash_table_replace(mp->settings,
+					GUINT_TO_POINTER(AVRCP_ATTRIBUTE_SHUFFLE),
+					GUINT_TO_POINTER(AVRCP_SHUFFLE_OFF));
+		g_hash_table_replace(mp->settings,
+					GUINT_TO_POINTER(AVRCP_ATTRIBUTE_SCAN),
+					GUINT_TO_POINTER(AVRCP_SCAN_OFF));
+	}
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
 static gboolean parse_player_properties(struct media_player *mp,
 							DBusMessageIter *iter)
 {
@@ -1762,7 +1854,8 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 	struct media_adapter *adapter = data;
 	struct media_player *mp;
 	DBusMessageIter args;
-	const char *sender, *path;
+	const char *sender;
+	char *path;
 	int err;
 
 	sender = dbus_message_get_sender(msg);
@@ -1772,6 +1865,8 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 	dbus_message_iter_get_basic(&args, &path);
 	dbus_message_iter_next(&args);
 
+	DBG("Registering player sender=%s path=%s", sender, path);
+
 	if (media_adapter_find_player(adapter, sender, path) != NULL)
 		return btd_error_already_exists(msg);
 
@@ -1797,6 +1892,9 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 
 	avrcp_event(avrcp_get_session(mp->player), AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
 
+	if (g_strcmp0(adapter->addressed->path, DUMMY_PLAYER) == 0)
+		media_set_addressed_player(adapter, sender, path, TRUE);
+
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
@@ -1814,6 +1912,8 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 
 	sender = dbus_message_get_sender(msg);
 
+	DBG("Unregistering player sender=%s path=%s", sender, path);
+
 	player = media_adapter_find_player(adapter, sender, path);
 	if (player == NULL)
 		return btd_error_does_not_exist(msg);
@@ -1821,6 +1921,9 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 	avrcp_event(avrcp_get_session(player->player), AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
 	media_player_remove(player);
 
+	if (g_strcmp0(adapter->addressed->path, path) == 0)
+		media_set_addressed_player(adapter, sender, DUMMY_PLAYER, TRUE);
+
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
@@ -1862,6 +1965,8 @@ int media_register(DBusConnection *conn, const char *path, const bdaddr_t *src)
 	adapter->conn = dbus_connection_ref(conn);
 	bacpy(&adapter->src, src);
 	adapter->path = g_strdup(path);
+	adapter->addressed = NULL;
+	media_set_addressed_player(adapter, NULL, DUMMY_PLAYER, TRUE);
 
 	if (!g_dbus_register_interface(conn, path, MEDIA_INTERFACE,
 					media_methods, NULL, NULL,
-- 
on behalf of ST-Ericsson


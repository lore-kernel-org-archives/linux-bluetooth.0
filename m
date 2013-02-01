Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] AVRCP: Set addressed player as browsed player
Date: Thu, 31 Jan 2013 21:58:37 -0600
Message-Id: <1359691117-13847-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359691117-13847-1-git-send-email-luiz.dentz@gmail.com>
References: <1359691117-13847-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This send SetBrowsedPlayer after getting the player details.
---
 profiles/audio/avrcp.c  |  73 +++++++++++++++++++++++--
 profiles/audio/player.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/player.h |   2 +
 3 files changed, 209 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index d1eb8ce..00eeea1 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -99,6 +99,7 @@
 #define AVRCP_REQUEST_CONTINUING	0x40
 #define AVRCP_ABORT_CONTINUING		0x41
 #define AVRCP_SET_ABSOLUTE_VOLUME	0x50
+#define AVRCP_SET_BROWSED_PLAYER	0x70
 #define AVRCP_GET_FOLDER_ITEMS		0x71
 #define AVRCP_GENERAL_REJECT		0xA0
 
@@ -1912,6 +1913,68 @@ static const char *subtype_to_string(uint32_t subtype)
 	return "None";
 }
 
+static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
+						uint8_t *operands,
+						size_t operand_count,
+						void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct media_player *mp = player->user_data;
+	uint32_t items;
+	char **folders, *path;
+	uint8_t depth, count;
+	int i;
+
+	if (operands[3] != AVRCP_STATUS_SUCCESS || operand_count < 13)
+		return FALSE;
+
+	player->uid_counter = bt_get_be16(&operands[4]);
+
+	items = bt_get_be32(&operands[6]);
+
+	depth = operands[13];
+
+	folders = g_new0(char *, depth + 1);
+
+	for (i = 14, count = 0; count < depth; count++) {
+		char *part;
+		uint8_t len;
+
+		len = operands[i++];
+		part = g_memdup(&operands[i], len);
+		i += len;
+		folders[count] = part;
+	}
+
+	path = g_build_pathv("/", folders);
+	g_strfreev(folders);
+
+	media_player_set_folder(mp, path, items);
+
+	g_free(path);
+
+	return FALSE;
+}
+
+static void avrcp_set_browsed_player(struct avrcp *session,
+						struct avrcp_player *player)
+{
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 2];
+	struct avrcp_browsing_header *pdu = (void *) buf;
+	uint16_t id;
+
+	memset(buf, 0, sizeof(buf));
+
+	pdu->pdu_id = AVRCP_SET_BROWSED_PLAYER;
+	id = htons(player->id);
+	memcpy(pdu->params, &id, 2);
+	pdu->param_len = htons(2);
+
+	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
+				avrcp_set_browsed_player_rsp, session);
+}
+
 static void avrcp_parse_media_player_item(struct avrcp *session,
 					uint8_t *operands, uint16_t len)
 {
@@ -1950,12 +2013,12 @@ static void avrcp_parse_media_player_item(struct avrcp *session,
 
 	media_player_set_features(mp, features);
 
-	if (operands[26] == 0)
-		return;
-
-	memcpy(name, &operands[27], operands[26]);
+	if (operands[26] != 0) {
+		memcpy(name, &operands[27], operands[26]);
+		media_player_set_name(mp, name);
+	}
 
-	media_player_set_name(mp, name);
+	avrcp_set_browsed_player(session, player);
 }
 
 static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index b4efa70..2f4ea83 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -43,6 +43,7 @@
 #include "error.h"
 
 #define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
+#define MEDIA_FOLDER_INTERFACE "org.bluez.MediaFolder1"
 
 struct player_callback {
 	const struct media_player_callback *cbs;
@@ -55,12 +56,18 @@ struct pending_req {
 	const char *value;
 };
 
+struct media_folder {
+	char			*name;		/* Folder name */
+	uint32_t		items;		/* Number of items */
+};
+
 struct media_player {
 	char			*device;	/* Device path */
 	char			*name;		/* Player name */
 	char			*type;		/* Player type */
 	char			*subtype;	/* Player subtype */
 	uint64_t		features[2];	/* Player features */
+	struct media_folder	*folder;	/* Player currenct folder */
 	char			*path;		/* Player object path */
 	GHashTable		*settings;	/* Player settings */
 	GHashTable		*track;		/* Player current track */
@@ -505,6 +512,104 @@ static const GDBusPropertyTable media_player_properties[] = {
 	{ }
 };
 
+static DBusMessage *media_folder_search(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return btd_error_failed(msg, strerror(ENOTSUP));
+}
+
+static DBusMessage *media_folder_list_items(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return btd_error_failed(msg, strerror(ENOTSUP));
+}
+
+
+static DBusMessage *media_folder_change_folder(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return btd_error_failed(msg, strerror(ENOTSUP));
+}
+
+static gboolean folder_name_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct media_player *mp = data;
+
+	if (mp->folder == NULL)
+		return FALSE;
+
+	return mp->folder->name != NULL;
+}
+
+static gboolean get_folder_name(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_player *mp = data;
+
+	if (mp->folder == NULL || mp->folder->name == NULL)
+		return FALSE;
+
+	DBG("%s", mp->folder->name);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+							&mp->folder->name);
+
+	return TRUE;
+}
+
+static gboolean items_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct media_player *mp = data;
+
+	return mp->folder != NULL;
+}
+
+static gboolean get_items(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_player *mp = data;
+
+	if (mp->folder == NULL)
+		return FALSE;
+
+	DBG("%u", mp->folder->items);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
+							&mp->folder->items);
+
+	return TRUE;
+}
+
+static const GDBusMethodTable media_folder_methods[] = {
+	{ GDBUS_EXPERIMENTAL_METHOD("Search",
+			GDBUS_ARGS({ "string", "s" }, { "filter", "a{sv}" }),
+			GDBUS_ARGS({ "folder", "o" }),
+			media_folder_search) },
+	{ GDBUS_EXPERIMENTAL_METHOD("ListItems",
+			GDBUS_ARGS({ "filter", "a{sv}" }),
+			GDBUS_ARGS({ "items", "a{oa{sv}}" }),
+			media_folder_list_items) },
+	{ GDBUS_EXPERIMENTAL_METHOD("ChangeFolder",
+			GDBUS_ARGS({ "folder", "o" }), NULL,
+			media_folder_change_folder) },
+	{ }
+};
+
+static const GDBusPropertyTable media_folder_properties[] = {
+	{ "Name", "s", get_folder_name, NULL, folder_name_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "NumberOfItems", "u", get_items, NULL, items_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ }
+};
+
+static void media_folder_destroy(struct media_folder *folder)
+{
+	g_free(folder->name);
+	g_free(folder);
+}
+
 void media_player_destroy(struct media_player *mp)
 {
 	DBG("%s", mp->path);
@@ -521,6 +626,13 @@ void media_player_destroy(struct media_player *mp)
 	if (mp->process_id > 0)
 		g_source_remove(mp->process_id);
 
+	if (mp->folder) {
+		g_dbus_unregister_interface(btd_get_dbus_connection(),
+						mp->path,
+						MEDIA_FOLDER_INTERFACE);
+		media_folder_destroy(mp->folder);
+	}
+
 	g_slist_free_full(mp->pending, g_free);
 
 	g_timer_destroy(mp->progress);
@@ -730,6 +842,33 @@ void media_player_set_name(struct media_player *mp, const char *name)
 					"Name");
 }
 
+void media_player_set_folder(struct media_player *mp, const char *path,
+								uint32_t items)
+{
+	struct media_folder *folder;
+
+	DBG("%s items %u", path, items);
+
+	if (mp->folder != NULL)
+		media_folder_destroy(mp->folder);
+
+	folder = g_new0(struct media_folder, 1);
+	folder->name = g_strdup(path);
+	folder->items = items;
+	mp->folder = folder;
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					mp->path, MEDIA_FOLDER_INTERFACE,
+					media_folder_methods,
+					NULL,
+					media_folder_properties, mp, NULL)) {
+		error("D-Bus failed to register %s on %s path",
+					MEDIA_FOLDER_INTERFACE, mp->path);
+		media_folder_destroy(mp->folder);
+		mp->folder = NULL;
+	}
+}
+
 void media_player_set_features(struct media_player *mp, uint64_t *features)
 {
 	DBG("0x%08zx %08zx", features[0], features[1]);
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index b546ba7..1ac9800 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -51,6 +51,8 @@ void media_player_set_type(struct media_player *mp, const char *type);
 void media_player_set_subtype(struct media_player *mp, const char *subtype);
 void media_player_set_features(struct media_player *mp, uint64_t *features);
 void media_player_set_name(struct media_player *mp, const char *name);
+void media_player_set_folder(struct media_player *mp, const char *path,
+								uint32_t items);
 
 void media_player_set_callbacks(struct media_player *mp,
 				const struct media_player_callback *cbs,
-- 
1.8.1


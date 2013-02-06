Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] AVRCP: Parse browsing and searching features bits
Date: Wed,  6 Feb 2013 10:10:21 +0200
Message-Id: <1360138224-29118-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1360138224-29118-1-git-send-email-luiz.dentz@gmail.com>
References: <1360138224-29118-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This parses browsing and searching features bits and set the respective
property.
---
 profiles/audio/avrcp.c  | 18 ++++++++----
 profiles/audio/player.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++-
 profiles/audio/player.h |  2 ++
 3 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5967180..cabe2ee 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1976,6 +1976,18 @@ static void avrcp_set_browsed_player(struct avrcp *session,
 				avrcp_set_browsed_player_rsp, session);
 }
 
+static void avrcp_player_parse_features(struct avrcp_player *player,
+							uint8_t *features)
+{
+	struct media_player *mp = player->user_data;
+
+	if (features[7] & 0x08)
+		media_player_set_browsable(mp, true);
+
+	if (features[7] & 0x10)
+		media_player_set_searchable(mp, true);
+}
+
 static void avrcp_parse_media_player_item(struct avrcp *session,
 					uint8_t *operands, uint16_t len)
 {
@@ -1984,7 +1996,6 @@ static void avrcp_parse_media_player_item(struct avrcp *session,
 	uint16_t id;
 	uint32_t subtype;
 	const char *curval, *strval;
-	uint64_t features[2];
 	char name[255];
 
 	if (len < 28)
@@ -2009,10 +2020,7 @@ static void avrcp_parse_media_player_item(struct avrcp *session,
 		avrcp_get_play_status(session);
 	}
 
-	features[0] = bt_get_be64(&operands[8]);
-	features[1] = bt_get_be64(&operands[16]);
-
-	media_player_set_features(mp, features);
+	avrcp_player_parse_features(player, &operands[8]);
 
 	if (operands[26] != 0) {
 		memcpy(name, &operands[27], operands[26]);
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index f875ee7..c75354b 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -67,7 +67,9 @@ struct media_player {
 	char			*name;		/* Player name */
 	char			*type;		/* Player type */
 	char			*subtype;	/* Player subtype */
-	uint64_t		features[2];	/* Player features */
+	dbus_bool_t		browsable;	/* Player browsing feature */
+	dbus_bool_t		searchable;	/* Player searching feature */
+	uint8_t			*features;	/* Player features */
 	struct media_folder	*folder;	/* Player currenct folder */
 	char			*path;		/* Player object path */
 	GHashTable		*settings;	/* Player settings */
@@ -350,6 +352,59 @@ static gboolean get_subtype(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean browsable_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct media_player *mp = data;
+
+	if (mp->browsable != FALSE && mp->browsable != TRUE)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean get_browsable(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_player *mp = data;
+
+	if (mp->browsable != FALSE && mp->browsable != TRUE)
+		return FALSE;
+
+	DBG("%s", mp->browsable ? "true" : "false");
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+							&mp->browsable);
+
+	return TRUE;
+}
+
+static gboolean searchable_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct media_player *mp = data;
+
+	if (mp->searchable != FALSE && mp->searchable != TRUE)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean get_searchable(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_player *mp = data;
+
+	if (mp->searchable != FALSE && mp->searchable != TRUE)
+		return FALSE;
+
+	DBG("%s", mp->searchable ? "true" : "false");
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+							&mp->searchable);
+
+	return TRUE;
+}
+
 static DBusMessage *media_player_play(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -510,6 +565,10 @@ static const GDBusPropertyTable media_player_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Device", "s", get_device, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Browsable", "b", get_browsable, NULL, browsable_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Searchable", "b", get_searchable, NULL, searchable_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
@@ -659,6 +718,8 @@ struct media_player *media_player_controller_create(const char *path)
 	mp->track = g_hash_table_new_full(g_str_hash, g_str_equal,
 							g_free, g_free);
 	mp->progress = g_timer_new();
+	mp->browsable = -1;
+	mp->searchable = -1;
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					mp->path, MEDIA_PLAYER_INTERFACE,
@@ -843,6 +904,20 @@ void media_player_set_name(struct media_player *mp, const char *name)
 					"Name");
 }
 
+void media_player_set_browsable(struct media_player *mp, bool enabled)
+{
+	DBG("%s", enabled ? "true" : "false");
+
+	mp->browsable = enabled;
+}
+
+void media_player_set_searchable(struct media_player *mp, bool enabled)
+{
+	DBG("%s", enabled ? "true" : "false");
+
+	mp->searchable = enabled;
+}
+
 void media_player_set_folder(struct media_player *mp, const char *path,
 								uint32_t items)
 {
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 1ac9800..e9a7d1c 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -51,6 +51,8 @@ void media_player_set_type(struct media_player *mp, const char *type);
 void media_player_set_subtype(struct media_player *mp, const char *subtype);
 void media_player_set_features(struct media_player *mp, uint64_t *features);
 void media_player_set_name(struct media_player *mp, const char *name);
+void media_player_set_browsable(struct media_player *mp, bool enabled);
+void media_player_set_searchable(struct media_player *mp, bool enabled);
 void media_player_set_folder(struct media_player *mp, const char *path,
 								uint32_t items);
 
-- 
1.8.1


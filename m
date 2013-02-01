Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] AVRCP: Get player list if supported
Date: Thu, 31 Jan 2013 21:58:35 -0600
Message-Id: <1359691117-13847-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359691117-13847-1-git-send-email-luiz.dentz@gmail.com>
References: <1359691117-13847-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If addressed player changed is supported get the list of players
---
 profiles/audio/avrcp.c  | 147 ++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/player.c | 119 +++++++++++++++++++++++++++++++++++++++
 profiles/audio/player.h |   4 ++
 3 files changed, 270 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 8187ddf..793b5cf 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -99,6 +99,7 @@
 #define AVRCP_REQUEST_CONTINUING	0x40
 #define AVRCP_ABORT_CONTINUING		0x41
 #define AVRCP_SET_ABSOLUTE_VOLUME	0x50
+#define AVRCP_GET_FOLDER_ITEMS		0x71
 #define AVRCP_GENERAL_REJECT		0xA0
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
@@ -1859,6 +1860,151 @@ static void avrcp_get_element_attributes(struct avrcp *session)
 					session);
 }
 
+static const char *type_to_string(uint8_t type)
+{
+	switch (type & 0x0F) {
+	case 0x01:
+		return "Audio";
+	case 0x02:
+		return "Video";
+	case 0x03:
+		return "Audio, Video";
+	case 0x04:
+		return "Audio Broadcasting";
+	case 0x05:
+		return "Audio, Audio Broadcasting";
+	case 0x06:
+		return "Video, Audio Broadcasting";
+	case 0x07:
+		return "Audio, Video, Audio Broadcasting";
+	case 0x08:
+		return "Video Broadcasting";
+	case 0x09:
+		return "Audio, Video Broadcasting";
+	case 0x0A:
+		return "Video, Video Broadcasting";
+	case 0x0B:
+		return "Audio, Video, Video Broadcasting";
+	case 0x0C:
+		return "Audio Broadcasting, Video Broadcasting";
+	case 0x0D:
+		return "Audio, Audio Broadcasting, Video Broadcasting";
+	case 0x0E:
+		return "Video, Audio Broadcasting, Video Broadcasting";
+	case 0x0F:
+		return "Audio, Video, Audio Broadcasting, Video Broadcasting";
+	}
+
+	return "None";
+}
+
+static const char *subtype_to_string(uint32_t subtype)
+{
+	switch (subtype & 0x03) {
+	case 0x01:
+		return "Audio Book";
+	case 0x02:
+		return "Podcast";
+	case 0x03:
+		return "Audio Book, Podcast";
+	}
+
+	return "None";
+}
+
+static void avrcp_parse_media_player_item(struct avrcp *session,
+					uint8_t *operands, uint16_t len)
+{
+	struct avrcp_player *player = session->player;
+	struct media_player *mp = player->user_data;
+	uint16_t id;
+	uint32_t subtype;
+	const char *curval, *strval;
+	uint64_t features[2];
+	char name[255];
+
+	if (len < 28)
+		return;
+
+	id = bt_get_be16(&operands[0]);
+
+	if (player->id != id)
+		return;
+
+	media_player_set_type(mp, type_to_string(operands[2]));
+
+	subtype = bt_get_be32(&operands[3]);
+
+	media_player_set_subtype(mp, subtype_to_string(subtype));
+
+	curval = media_player_get_status(mp);
+	strval = status_to_string(operands[7]);
+
+	if (g_strcmp0(curval, strval) != 0) {
+		media_player_set_status(mp, strval);
+		avrcp_get_play_status(session);
+	}
+
+	features[0] = bt_get_be64(&operands[8]);
+	features[1] = bt_get_be64(&operands[16]);
+
+	media_player_set_features(mp, features);
+
+	if (operands[26] == 0)
+		return;
+
+	memcpy(name, &operands[27], operands[26]);
+
+	media_player_set_name(mp, name);
+}
+
+static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
+						uint8_t *operands,
+						size_t operand_count,
+						void *user_data)
+{
+	struct avrcp *session = user_data;
+	uint16_t count;
+	int i;
+
+	if (operands[3] != AVRCP_STATUS_SUCCESS || operand_count < 5)
+		return FALSE;
+
+	count = bt_get_be16(&operands[6]);
+
+	for (i = 8; count; count--) {
+		uint8_t type;
+		uint16_t len;
+
+		type = operands[i++];
+		len = bt_get_be16(&operands[i]);
+		i += 2;
+
+		if (type != 0x01) {
+			i += len;
+			continue;
+		}
+
+		avrcp_parse_media_player_item(session, &operands[i], len);
+	}
+
+	return FALSE;
+}
+
+static void avrcp_get_media_player_list(struct avrcp *session)
+{
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 10];
+	struct avrcp_browsing_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	pdu->pdu_id = AVRCP_GET_FOLDER_ITEMS;
+	pdu->param_len = htons(10);
+
+	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
+				avrcp_get_media_player_list_rsp, session);
+}
+
 static gboolean avrcp_handle_event(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
@@ -1944,6 +2090,7 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 
 		player->id = id;
 		player->uid_counter = bt_get_be16(&pdu->params[3]);
+		avrcp_get_media_player_list(session);
 		break;
 	}
 
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index fb750fd..b4efa70 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -57,6 +57,10 @@ struct pending_req {
 
 struct media_player {
 	char			*device;	/* Device path */
+	char			*name;		/* Player name */
+	char			*type;		/* Player type */
+	char			*subtype;	/* Player subtype */
+	uint64_t		features[2];	/* Player features */
 	char			*path;		/* Player object path */
 	GHashTable		*settings;	/* Player settings */
 	GHashTable		*track;		/* Player current track */
@@ -272,6 +276,72 @@ static gboolean get_device(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean name_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct media_player *mp = data;
+
+	return mp->name != NULL;
+}
+
+static gboolean get_name(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_player *mp = data;
+
+	if (mp->name == NULL)
+		return FALSE;
+
+	DBG("%s", mp->name);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &mp->name);
+
+	return TRUE;
+}
+
+static gboolean type_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct media_player *mp = data;
+
+	return mp->type != NULL;
+}
+
+static gboolean get_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_player *mp = data;
+
+	if (mp->type == NULL)
+		return FALSE;
+
+	DBG("%s", mp->type);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &mp->type);
+
+	return TRUE;
+}
+
+static gboolean subtype_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct media_player *mp = data;
+
+	return mp->subtype != NULL;
+}
+
+static gboolean get_subtype(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_player *mp = data;
+
+	if (mp->subtype == NULL)
+		return FALSE;
+
+	DBG("%s", mp->subtype);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &mp->subtype);
+
+	return TRUE;
+}
+
 static DBusMessage *media_player_play(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -410,6 +480,12 @@ static const GDBusSignalTable media_player_signals[] = {
 };
 
 static const GDBusPropertyTable media_player_properties[] = {
+	{ "Name", "s", get_name, NULL, name_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Type", "s", get_type, NULL, type_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Subtype", "s", get_subtype, NULL, subtype_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Position", "u", get_position, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Status", "s", get_status, NULL, status_exists,
@@ -452,6 +528,9 @@ void media_player_destroy(struct media_player *mp)
 	g_free(mp->status);
 	g_free(mp->path);
 	g_free(mp->device);
+	g_free(mp->subtype);
+	g_free(mp->type);
+	g_free(mp->name);
 	g_free(mp);
 }
 
@@ -618,6 +697,46 @@ void media_player_set_metadata(struct media_player *mp, const char *key,
 	g_hash_table_replace(mp->track, g_strdup(key), value);
 }
 
+void media_player_set_type(struct media_player *mp, const char *type)
+{
+	DBG("%s", type);
+
+	mp->type = g_strdup(type);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					mp->path, MEDIA_PLAYER_INTERFACE,
+					"Type");
+}
+
+void media_player_set_subtype(struct media_player *mp, const char *subtype)
+{
+	DBG("%s", subtype);
+
+	mp->subtype = g_strdup(subtype);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					mp->path, MEDIA_PLAYER_INTERFACE,
+					"Subtype");
+}
+
+void media_player_set_name(struct media_player *mp, const char *name)
+{
+	DBG("%s", name);
+
+	mp->name = g_strdup(name);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					mp->path, MEDIA_PLAYER_INTERFACE,
+					"Name");
+}
+
+void media_player_set_features(struct media_player *mp, uint64_t *features)
+{
+	DBG("0x%08zx %08zx", features[0], features[1]);
+
+	memcpy(features, mp->features, sizeof(mp->features));
+}
+
 void media_player_set_callbacks(struct media_player *mp,
 				const struct media_player_callback *cbs,
 				void *user_data)
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index fec1d06..b546ba7 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -47,6 +47,10 @@ const char *media_player_get_status(struct media_player *mp);
 void media_player_set_status(struct media_player *mp, const char *status);
 void media_player_set_metadata(struct media_player *mp, const char *key,
 						void *data, size_t len);
+void media_player_set_type(struct media_player *mp, const char *type);
+void media_player_set_subtype(struct media_player *mp, const char *subtype);
+void media_player_set_features(struct media_player *mp, uint64_t *features);
+void media_player_set_name(struct media_player *mp, const char *name);
 
 void media_player_set_callbacks(struct media_player *mp,
 				const struct media_player_callback *cbs,
-- 
1.8.1


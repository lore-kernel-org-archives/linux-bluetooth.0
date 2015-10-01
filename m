Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  1/2] audio/avrcp: Add support for Set Browsed Player
Date: Thu, 01 Oct 2015 17:18:59 +0530
Message-id: <1443700140-3905-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support added to handle SetBrowsedPlayer cmd in AVRCP TG role.
Added a new player callback get_playlist to retrieve available
playlists on org.moris.MediPlayer2.Playlists interface.

btmon:
      AVCTP Browsing: Response: type 0x00 label 13 PID 0x110e
        AVRCP: SetBrowsedPlayer: len 0x000a
          Status: 0x04 (Success)
          UIDCounter: 0x0000 (0)
          Number of Items: 0x00000007 (7)
          CharsetID: 0x006a (UTF-8)
          Folder Depth: 0x00 (0)
---
 profiles/audio/avrcp.c | 71 ++++++++++++++++++++++++++++++++++++
 profiles/audio/avrcp.h |  4 +++
 profiles/audio/media.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 24deac5..b2198e3 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -207,6 +207,15 @@ struct player_item {
 	char name[0];
 } __attribute__ ((packed));
 
+struct avrcp_set_browsed_player_rsp {
+	uint8_t status;
+	uint16_t uid_counter;
+	uint32_t num_of_items;
+	uint16_t charset_id;
+	uint8_t	folder_depth;
+	uint8_t	data[0];
+} __attribute__ ((packed));
+
 struct avrcp_server {
 	struct btd_adapter *adapter;
 	uint32_t tg_record_id;
@@ -1873,6 +1882,67 @@ err_metadata:
 	return AVRCP_HEADER_LENGTH + 1;
 }
 
+static void avrcp_handle_set_browsed_player(struct avrcp *session,
+				struct avrcp_browsing_header *pdu,
+				uint8_t transaction)
+{
+	struct avrcp_player *player;
+	struct media_player *mp;
+	uint16_t len = ntohs(pdu->param_len);
+	uint16_t player_id = 0;
+	uint8_t status;
+
+	if (len < 1) {
+		status = AVRCP_STATUS_INVALID_PARAM;
+		goto failed;
+	}
+
+	player_id = bt_get_be16(&pdu->params[0]);
+	player = find_tg_player(session, player_id);
+
+	if (player) {
+		struct avrcp_set_browsed_player_rsp *resp;
+		uint32_t num_of_items = 0;
+
+		mp = player->user_data;
+		player->browsed = true;
+
+		resp = (struct avrcp_set_browsed_player_rsp *) pdu->params;
+
+		resp->status = AVRCP_STATUS_SUCCESS;
+		resp->uid_counter = htons(player_get_uid_counter(player));
+		resp->num_of_items = 0;
+		resp->charset_id = htons(AVRCP_CHARSET_UTF8);
+		resp->folder_depth = 0;
+		pdu->param_len = htons(sizeof(*resp));
+
+		if (!player->cb->get_playlists(0x0000, 0xFFFF,
+					"Alphabetical",
+					NULL,
+					&num_of_items, mp)) {
+			status = AVRCP_STATUS_INVALID_PARAM;
+			goto failed;
+		}
+
+		resp->num_of_items = htonl(num_of_items);
+
+		/*
+		 * MPRIS player returns a flat hierarchy playlist structure,
+		 * where the folder depth will always considered to be 0.
+		 */
+		resp->folder_depth = 0;
+	} else {
+		status = AVRCP_STATUS_INVALID_PLAYER_ID;
+		goto failed;
+	}
+
+	return;
+
+failed:
+	pdu->params[0] = status;
+	pdu->param_len = htons(1);
+}
+
 static void avrcp_handle_media_player_list(struct avrcp *session,
 				struct avrcp_browsing_header *pdu,
 				uint32_t start_item, uint32_t end_item)
@@ -1989,6 +2059,7 @@ static struct browsing_pdu_handler {
 							uint8_t transaction);
 } browsing_handlers[] = {
 		{ AVRCP_GET_FOLDER_ITEMS, avrcp_handle_get_folder_items },
+		{ AVRCP_SET_BROWSED_PLAYER, avrcp_handle_set_browsed_player},
 		{ },
 };
 
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 86d310c..87e591d 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -101,6 +101,10 @@ struct avrcp_player_cb {
 	bool (*pause) (void *user_data);
 	bool (*next) (void *user_data);
 	bool (*previous) (void *user_data);
+	int (*get_playlists) (uint32_t start, uint32_t end,
+					char *ordering, uint8_t *pdu,
+					uint32_t *num_of_items,
+					void *user_data);
 };
 
 int avrcp_set_volume(struct btd_device *dev, uint8_t volume, bool notify);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 69070bf..2835f93 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -58,6 +58,7 @@
 #define MEDIA_INTERFACE "org.bluez.Media1"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 #define MEDIA_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
+#define MEDIA_PLAYER_PLAYLIST_INTERFACE "org.mpris.MediaPlayer2.Playlists"
 
 #define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
 
@@ -115,6 +116,14 @@ struct media_player {
 	char			*name;
 };
 
+struct media_playlist {
+	char		*name;
+	char		*id;
+	char		*icon;
+	uint32_t	num_of_items;
+	uint8_t		data[0];
+} __attribute__ ((packed));
+
 static GSList *adapters = NULL;
 
 static void endpoint_request_free(struct endpoint_request *request)
@@ -1270,6 +1279,94 @@ static bool previous(void *user_data)
 
 	return media_player_send(mp, "Previous");
 }
+static int get_playlists(uint32_t start_index, uint32_t end_index,
+					char *ordering, uint8_t *pdu,
+					uint32_t *num_of_items,
+					void *user_data)
+{
+	struct media_player *mp = user_data;
+	struct media_playlist *playlist;
+	DBusMessage *msg;
+	DBusMessage *reply;
+	DBusMessageIter array_iter;
+	DBusMessageIter value;
+	DBusMessageIter struct_iter;
+	DBusError err;
+	gboolean reverse_order = FALSE;
+	int type;
+	uint32_t total_items = 0;
+	uint32_t max_count = (end_index - start_index);
+
+	msg = dbus_message_new_method_call(mp->sender, mp->path,
+				MEDIA_PLAYER_PLAYLIST_INTERFACE,
+				"GetPlaylists");
+
+	if (msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return -ENOMEM;
+	}
+
+	dbus_message_append_args(msg,
+			DBUS_TYPE_UINT32, &start_index,
+			DBUS_TYPE_UINT32, &max_count,
+			DBUS_TYPE_STRING, &ordering,
+			DBUS_TYPE_BOOLEAN, &reverse_order,
+			DBUS_TYPE_INVALID);
+
+	dbus_error_init(&err);
+
+	/* Make Dbus sync call to get available playlists */
+	reply = dbus_connection_send_with_reply_and_block(
+				btd_get_dbus_connection(), msg, -1, &err);
+
+	dbus_message_unref(msg);
+
+	if (!reply) {
+		if (dbus_error_is_set(&err)) {
+			error("%s", err.message);
+			dbus_error_free(&err);
+		}
+		return FALSE;
+	}
+
+	dbus_message_iter_init(reply, &array_iter);
+	type = dbus_message_iter_get_arg_type(&array_iter);
+
+	if (type != DBUS_TYPE_ARRAY)
+		goto done;
+
+	dbus_message_iter_recurse(&array_iter, &struct_iter);
+
+	while ((type = dbus_message_iter_get_arg_type(&struct_iter)) !=
+				DBUS_TYPE_INVALID) {
+		if (type != DBUS_TYPE_STRUCT)
+			goto done;
+
+		dbus_message_iter_recurse(&struct_iter, &value);
+
+		if (pdu != NULL) {
+			playlist = (struct media_playlist *) pdu;
+
+			dbus_message_iter_get_basic(&value, &playlist->id);
+
+			dbus_message_iter_next(&value);
+			dbus_message_iter_get_basic(&value, &playlist->name);
+
+			dbus_message_iter_next(&value);
+			dbus_message_iter_get_basic(&value, &playlist->icon);
+
+			/* TODO: Create Media folder with playlist info */
+		}
+
+		total_items++;
+		*num_of_items = total_items;
+
+		dbus_message_iter_next(&struct_iter);
+	}
+
+done:
+	return TRUE;
+}
 
 static struct avrcp_player_cb player_cb = {
 	.list_settings = list_settings,
@@ -1288,6 +1385,7 @@ static struct avrcp_player_cb player_cb = {
 	.pause = pause,
 	.next = next,
 	.previous = previous,
+	.get_playlists = get_playlists,
 };
 
 static void media_player_exit(DBusConnection *connection, void *user_data)
-- 
1.9.1


Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  3/3] audio/avrcp: Add support for SetBrowsedPlayer
Date: Tue, 06 Oct 2015 17:23:18 +0530
Message-id: <1444132398-3176-3-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1444132398-3176-1-git-send-email-bharat.panda@samsung.com>
References: <1444132398-3176-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support added to handle SetBrowsedPlayer command for TG role.

    AVCTP Browsing: Response: type 0x00 label 13 PID 0x110e
      AVRCP: SetBrowsedPlayer: len 0x000a
       Status: 0x04 (Success)
       UIDCounter: 0x0000 (0)
       Number of Items: 0x00000007 (7)
       CharsetID: 0x006a (UTF-8)
       Folder Depth: 0x00 (0)
---
 profiles/audio/avrcp.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++-
 profiles/audio/avrcp.h |  1 +
 profiles/audio/media.c |  7 ++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 44f8929..af40b59 100644
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
@@ -1873,6 +1882,54 @@ err_metadata:
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
+
+		mp = player->user_data;
+		player->browsed = true;
+
+		resp = (struct avrcp_set_browsed_player_rsp *) pdu->params;
+
+		resp->status = AVRCP_STATUS_SUCCESS;
+		resp->uid_counter = htons(player_get_uid_counter(player));
+		resp->num_of_items = htonl(player->cb->get_total_items(mp));
+		/*
+		 * MPRIS player returns a flat hierarchy playlist structure,
+		 * where the folder depth will always considered to be 0.
+		 */
+		resp->folder_depth = 0;
+		resp->charset_id = htons(AVRCP_CHARSET_UTF8);
+		pdu->param_len = htons(sizeof(*resp));
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
@@ -1912,7 +1969,6 @@ static void avrcp_handle_media_player_list(struct avrcp *session,
 		memcpy(&item->features, &features, sizeof(features));
 
 		item->charset = htons(AVRCP_CHARSET_UTF8);
-
 		name = player->cb->get_name(player->user_data);
 		namelen = strlen(name);
 		item->namelen = htons(namelen);
@@ -1989,6 +2045,7 @@ static struct browsing_pdu_handler {
 							uint8_t transaction);
 } browsing_handlers[] = {
 		{ AVRCP_GET_FOLDER_ITEMS, avrcp_handle_get_folder_items },
+		{ AVRCP_SET_BROWSED_PLAYER, avrcp_handle_set_browsed_player},
 		{ },
 };
 
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 86d310c..c09b910 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -101,6 +101,7 @@ struct avrcp_player_cb {
 	bool (*pause) (void *user_data);
 	bool (*next) (void *user_data);
 	bool (*previous) (void *user_data);
+	uint32_t (*get_total_items) (void *user_data);
 };
 
 int avrcp_set_volume(struct btd_device *dev, uint8_t volume, bool notify);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 2df0cb2..3196b3a 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1287,6 +1287,12 @@ static bool previous(void *user_data)
 	return media_player_send(mp, "Previous");
 }
 
+static uint32_t get_total_items(void *user_data)
+{
+	struct media_player *mp = user_data;
+
+	return mp->total_items;
+}
 
 static void playlist_reply(DBusPendingCall *call, void *user_data)
 {
@@ -1409,6 +1415,7 @@ static struct avrcp_player_cb player_cb = {
 	.pause = pause,
 	.next = next,
 	.previous = previous,
+	.get_total_items = get_total_items,
 };
 
 static void media_player_exit(DBusConnection *connection, void *user_data)
-- 
1.9.1


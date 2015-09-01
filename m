Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH v2] audio/avrcp: Add GetFolderItems support
Date: Tue, 01 Sep 2015 17:57:27 +0530
Message-id: <1441110447-27181-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support added to handle Get Folder Items browsing PDU
for media player scope in TG role.

e.g.
      AVCTP Browsing: Response: type 0x00 label 0 PID 0x110e
        AVRCP: GetFolderItems: len 0x0030
          Status: 0x04 (Success)
          UIDCounter: 0x0000 (0)
          NumOfItems: 0x0001 (1)
          Item: 0x01 (Media Player)
          Length: 0x0028 (40)
          PlayerID: 0x0000 (0)
          PlayerType: 0x0001 (Audio)
          PlayerSubType: 0x00000001 (Audio Book)
          PlayStatus: 0x01 (PLAYING)
          Features: 0x0000000000000007FFF0007000000000
          CharsetID: 0x006a (UTF-8)
          NameLength: 0x000c (12)
          Name: SimplePlayer
---
 profiles/audio/avrcp.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/avrcp.h |   1 +
 profiles/audio/media.c |   8 +++
 3 files changed, 161 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index d2b0065..e39b31a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -140,6 +140,11 @@
 #define AVRCP_CT_VERSION		0x0106
 #define AVRCP_TG_VERSION		0x0105
 
+#define AVRCP_SCOPE_MEDIA_PLAYER_LIST			0x00
+#define AVRCP_SCOPE_MEDIA_PLAYER_VFS			0x01
+#define AVRCP_SCOPE_SEARCH				0x02
+#define AVRCP_SCOPE_NOW_PLAYING			0x03
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
 struct avrcp_header {
@@ -178,6 +183,30 @@ struct avrcp_browsing_header {
 } __attribute__ ((packed));
 #define AVRCP_BROWSING_HEADER_LENGTH 3
 
+struct get_folder_items_rsp {
+	uint8_t status;
+	uint16_t uid_counter;
+	uint16_t num_items;
+	uint8_t data[0];
+} __attribute__ ((packed));
+
+struct folder_item {
+	uint8_t type;
+	uint16_t len;
+	uint8_t data[0];
+} __attribute__ ((packed));
+
+struct player_item {
+	uint16_t player_id;
+	uint8_t type;
+	uint32_t subtype;
+	uint8_t status;
+	uint8_t features[16];
+	uint16_t charset;
+	uint16_t namelen;
+	char name[0];
+} __attribute__ ((packed));
+
 struct avrcp_server {
 	struct btd_adapter *adapter;
 	uint32_t tg_record_id;
@@ -263,6 +292,18 @@ struct control_pdu_handler {
 static GSList *servers = NULL;
 static unsigned int avctp_id = 0;
 
+/* Default feature bit mask for media player
+ * supporting Play, Stop, Pause, Rewind, Record,
+ * fast forward, Forward, Backward, channel up/down/prev,
+ * volume up/down, help, power, exit, menu, Vendor Unique,
+ * Advanced Control Player, etc.
+ */
+static const uint8_t features[16] = {
+				0x00, 0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x07, 0xFF, 0xF0,
+				0x00, 0x70, 0x00, 0x00, 0x00,
+				0x00 };
+
 /* Company IDs supported by this device */
 static uint32_t company_ids[] = {
 	IEEEID_BTSIG,
@@ -1841,11 +1882,122 @@ err_metadata:
 	return AVRCP_HEADER_LENGTH + 1;
 }
 
+static void avrcp_handle_media_player_list(struct avrcp *session,
+				struct avrcp_browsing_header *pdu,
+				uint32_t start_item, uint32_t end_item)
+{
+	struct avrcp_player *player = session->target->player;
+	struct get_folder_items_rsp *rsp;
+	const char *name = NULL;
+	GSList *l;
+
+	rsp = (void *)pdu->params;
+	rsp->status = AVRCP_STATUS_SUCCESS;
+	rsp->uid_counter = htons(player_get_uid_counter(player));
+	rsp->num_items = 0;
+	pdu->param_len = sizeof(*rsp);
+
+	for (l = g_slist_nth(session->server->players, start_item);
+					l; l = g_slist_next(l)) {
+		struct avrcp_player *player = l->data;
+		struct folder_item *folder;
+		struct player_item *item;
+		uint16_t namelen;
+
+		if (rsp->num_items == (end_item - start_item) + 1)
+			break;
+
+		folder = (void *)&pdu->params[pdu->param_len];
+		folder->type = 0x01; /* Media Player */
+
+		pdu->param_len += sizeof(*folder);
+
+		item = (void *)folder->data;
+		item->player_id = htons(player->id);
+		item->type = 0x01; /* Audio */
+		item->subtype = htonl(0x01); /* Audio Book */
+		item->status = player_get_status(player);
+		/* Assign Default Feature Bit Mask */
+		memcpy(&item->features, &features, sizeof(features));
+
+		item->charset = htons(AVRCP_CHARSET_UTF8);
+
+		name = player->cb->get_sender(player->user_data);
+		namelen = strlen(name);
+		item->namelen = htons(namelen);
+		memcpy(item->name, name, namelen);
+
+		folder->len = htons(sizeof(*item) + namelen);
+		pdu->param_len += sizeof(*item) + namelen;
+		rsp->num_items++;
+	}
+
+	/* If no player could be found respond with an error */
+	if (!rsp->num_items)
+		goto failed;
+
+	rsp->num_items = htons(rsp->num_items);
+	pdu->param_len = htons(pdu->param_len);
+
+	return;
+
+failed:
+	pdu->params[0] = AVRCP_STATUS_OUT_OF_BOUNDS;
+	pdu->param_len = htons(1);
+}
+
+static void avrcp_handle_get_folder_items(struct avrcp *session,
+				struct avrcp_browsing_header *pdu,
+				uint8_t transaction)
+{
+	uint32_t start_item = 0;
+	uint32_t end_item = 0;
+	uint8_t scope;
+	uint8_t status = AVRCP_STATUS_SUCCESS;
+
+	if (!pdu || ntohs(pdu->param_len) < 10) {
+		status = AVRCP_STATUS_INVALID_PARAM;
+		goto failed;
+	}
+
+	scope = pdu->params[0];
+	start_item = bt_get_be32(&pdu->params[1]);
+	end_item = bt_get_be32(&pdu->params[5]);
+
+	DBG("scope 0x%02x start_item 0x%08x end_item 0x%08x", scope,
+				start_item, end_item);
+
+	if (end_item < start_item) {
+		status = AVRCP_STATUS_INVALID_PARAM;
+		goto failed;
+	}
+
+	switch (scope) {
+	case AVRCP_SCOPE_MEDIA_PLAYER_LIST:
+		avrcp_handle_media_player_list(session, pdu,
+						start_item, end_item);
+		break;
+	case AVRCP_SCOPE_MEDIA_PLAYER_VFS:
+	case AVRCP_SCOPE_SEARCH:
+	case AVRCP_SCOPE_NOW_PLAYING:
+	default:
+		status = AVRCP_STATUS_INVALID_PARAM;
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
 static struct browsing_pdu_handler {
 	uint8_t pdu_id;
 	void (*func) (struct avrcp *session, struct avrcp_browsing_header *pdu,
 							uint8_t transaction);
 } browsing_handlers[] = {
+		{ AVRCP_GET_FOLDER_ITEMS, avrcp_handle_get_folder_items },
 		{ },
 };
 
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index a9aeb1a..be54026 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -93,6 +93,7 @@ struct avrcp_player_cb {
 	const char *(*get_status) (void *user_data);
 	uint32_t (*get_position) (void *user_data);
 	uint32_t (*get_duration) (void *user_data);
+	const char *(*get_sender) (void *user_data);
 	void (*set_volume) (uint8_t volume, struct btd_device *dev,
 							void *user_data);
 	bool (*play) (void *user_data);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 6c25363..5819d42 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1014,6 +1014,13 @@ static const char *get_setting(const char *key, void *user_data)
 	return g_hash_table_lookup(mp->settings, key);
 }
 
+static const char *get_sender(void *user_data)
+{
+	struct media_player *mp = user_data;
+
+	return mp->name;
+}
+
 static void set_shuffle_setting(DBusMessageIter *iter, const char *value)
 {
 	const char *key = "Shuffle";
@@ -1274,6 +1281,7 @@ static struct avrcp_player_cb player_cb = {
 	.get_position = get_position,
 	.get_duration = get_duration,
 	.get_status = get_status,
+	.get_sender = get_sender,
 	.set_volume = set_volume,
 	.play = play,
 	.stop = stop,
-- 
1.9.1


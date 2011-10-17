Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 5/5] AVRCP: Implement RequestContinuingResponse PDU
Date: Mon, 17 Oct 2011 18:34:31 -0200
Message-Id: <1318883671-10932-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318883671-10932-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318883671-10932-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avrcp.c |  212 +++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 145 insertions(+), 67 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 585b095..75a8384 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -64,6 +64,12 @@
 #define E_PARAM_NOT_FOUND	0x02
 #define E_INTERNAL		0x03
 
+/* Packet types */
+#define AVRCP_PACKET_TYPE_SINGLE	0x00
+#define AVRCP_PACKET_TYPE_START		0x01
+#define AVRCP_PACKET_TYPE_CONTINUING	0x02
+#define AVRCP_PACKET_TYPE_END		0x03
+
 /* PDU types for metadata transfer */
 #define AVRCP_GET_CAPABILITIES		0x10
 #define AVRCP_LIST_PLAYER_ATTRIBUTES	0X11
@@ -77,6 +83,7 @@
 #define AVRCP_GET_ELEMENT_ATTRIBUTES	0x20
 #define AVRCP_GET_PLAY_STATUS		0x30
 #define AVRCP_REGISTER_NOTIFICATION	0x31
+#define AVRCP_REQUEST_CONTINUING	0x40
 #define AVRCP_ABORT_CONTINUING		0x41
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
@@ -398,76 +405,98 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 	return 0;
 }
 
-/*
- * Copy media_info field to a buffer, intended to be used in a response to
- * GetElementAttributes message.
- *
- * It assumes there's enough space in the buffer and on success it returns the
- * size written.
- *
- * If @param id is not valid, -EINVAL is returned. If there's no space left on
- * the buffer -ENOBUFS is returned.
- */
-static int player_get_media_attribute(struct avrcp_player *player,
+static uint16_t player_write_media_attribute(struct avrcp_player *player,
 						uint32_t id, uint8_t *buf,
-						uint16_t maxlen)
+						uint16_t *pos,
+						uint16_t *offset)
 {
-	struct media_info_elem {
-		uint32_t id;
-		uint16_t charset;
-		uint16_t len;
-		uint8_t val[];
-	};
-	struct media_info_elem *elem = (void *)buf;
 	uint16_t len;
+	uint16_t attr_len;
 	char valstr[20];
 	void *value;
 
-	if (maxlen < sizeof(struct media_info_elem))
-		return -ENOBUFS;
-
-	/* Subtract the size of elem header from the available space */
-	maxlen -= sizeof(struct media_info_elem);
-
-	DBG("Get media attribute: %u", id);
-
-	if (id == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
-			id > AVRCP_MEDIA_ATTRIBUTE_LAST)
-		return -ENOENT;
+	DBG("%u", id);
 
 	value = player->cb->get_metadata(id, player->user_data);
 	if (value == NULL) {
-		len = 0;
-		goto done;
+		*offset = 0;
+		return 0;
 	}
 
 	switch (id) {
-	case AVRCP_MEDIA_ATTRIBUTE_TITLE:
-	case AVRCP_MEDIA_ATTRIBUTE_ARTIST:
-	case AVRCP_MEDIA_ATTRIBUTE_ALBUM:
-	case AVRCP_MEDIA_ATTRIBUTE_GENRE:
-		len = strlen((char *) value);
-		if (len > maxlen)
-			return -ENOBUFS;
-		memcpy(elem->val, value, len);
-		break;
 	case AVRCP_MEDIA_ATTRIBUTE_TRACK:
 	case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
 	case AVRCP_MEDIA_ATTRIBUTE_DURATION:
 		snprintf(valstr, 20, "%u", GPOINTER_TO_UINT(value));
-		len = strlen(valstr);
-		if (len > maxlen)
-			return -ENOBUFS;
-		memcpy(elem->val, valstr, len);
+		value = valstr;
 		break;
 	}
 
-done:
-	elem->id = htonl(id);
-	elem->charset = htons(0x6A); /* Always use UTF-8 */
-	elem->len = htons(len);
+	attr_len = strlen(value);
+	value = ((char *) value) + *offset;
+	len = attr_len - *offset;
 
-	return sizeof(struct media_info_elem) + len;
+	if (len > AVRCP_PDU_MTU - *pos) {
+		len = AVRCP_PDU_MTU - *pos;
+		*offset += len;
+	} else {
+		*offset = 0;
+	}
+
+	memcpy(&buf[*pos], value, len);
+	*pos += len;
+
+	return attr_len;
+}
+
+static GList *player_fill_media_attribute(struct avrcp_player *player,
+					GList *attr_ids, uint8_t *buf,
+					uint16_t *pos, uint16_t *offset)
+{
+	struct media_attribute_header {
+		uint32_t id;
+		uint16_t charset;
+		uint16_t len;
+	} *hdr = NULL;
+	GList *l;
+
+	for (l = attr_ids; l != NULL; l = g_list_delete_link(l, l)) {
+		uint32_t attr = GPOINTER_TO_UINT(l->data);
+		uint16_t attr_len;
+
+		if (*offset == 0) {
+			if (*pos + sizeof(*hdr) >= AVRCP_PDU_MTU)
+				break;
+
+			hdr = (void *) &buf[*pos];
+			hdr->id = htonl(attr);
+			hdr->charset = htons(0x6A); /* Always use UTF-8 */
+			*pos += sizeof(*hdr);
+		}
+
+		attr_len = player_write_media_attribute(player, attr, buf,
+								pos, offset);
+
+		if (hdr != NULL)
+			hdr->len = htons(attr_len);
+
+		if (*offset > 0)
+			break;
+	}
+
+	return l;
+}
+
+static struct pending_pdu *pending_pdu_new(uint8_t pdu_id, GList *attr_ids,
+							unsigned int offset)
+{
+	struct pending_pdu *pending = g_new(struct pending_pdu, 1);
+
+	pending->pdu_id = pdu_id;
+	pending->attr_ids = attr_ids;
+	pending->offset = offset;
+
+	return pending;
 }
 
 static gboolean player_abort_pending_pdu(struct avrcp_player *player)
@@ -611,8 +640,8 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 	uint64_t *identifier = (uint64_t *) &pdu->params[0];
 	uint16_t pos;
 	uint8_t nattr;
-	int size;
-	GList *l, *attr_ids;
+	GList *attr_ids;
+	uint16_t offset;
 
 	if (len < 9 || *identifier != 0)
 		goto err;
@@ -628,12 +657,20 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 		 * title must be returned if there's a track selected.
 		 */
 		attr_ids = player->cb->list_metadata(player->user_data);
+		len = g_list_length(attr_ids);
 	} else {
 		unsigned int i;
 		uint32_t *attr = (uint32_t *) &pdu->params[9];
 
-		for (i = 0, attr_ids = NULL; i < nattr; i++, attr++) {
+		for (i = 0, len = 0, attr_ids = NULL; i < nattr; i++, attr++) {
 			uint32_t id = ntohl(bt_get_unaligned(attr));
+
+			/* Don't add invalid attributes */
+			if (id == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
+					id > AVRCP_MEDIA_ATTRIBUTE_LAST)
+				continue;
+
+			len++;
 			attr_ids = g_list_prepend(attr_ids,
 							GUINT_TO_POINTER(id));
 		}
@@ -641,24 +678,21 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 		attr_ids = g_list_reverse(attr_ids);
 	}
 
-	for (l = attr_ids, len = 0, pos = 1; l != NULL; l = l->next) {
-		uint32_t attr = GPOINTER_TO_UINT(l->data);
+	if (!len)
+		goto err;
 
-		size = player_get_media_attribute(player, attr,
-							&pdu->params[pos],
-							AVRCP_PDU_MTU - pos);
+	player_abort_pending_pdu(player);
+	pos = 1;
+	offset = 0;
+	attr_ids = player_fill_media_attribute(player, attr_ids, pdu->params,
+								&pos, &offset);
 
-		if (size >= 0) {
-			len++;
-			pos += size;
-		}
+	if (attr_ids != NULL) {
+		player->pending_pdu = pending_pdu_new(pdu->pdu_id, attr_ids,
+								offset);
+		pdu->packet_type = AVRCP_PACKET_TYPE_START;
 	}
 
-	g_list_free(attr_ids);
-
-	if (!len)
-		goto err;
-
 	pdu->params[0] = len;
 	pdu->params_len = htons(pos);
 
@@ -892,6 +926,46 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
+static uint8_t avrcp_handle_request_continuing(struct avrcp_player *player,
+						struct avrcp_header *pdu,
+						uint8_t transaction)
+{
+	uint16_t len = ntohs(pdu->params_len);
+	struct pending_pdu *pending;
+
+	if (len != 1 || player->pending_pdu == NULL)
+		goto err;
+
+	pending = player->pending_pdu;
+
+	if (pending->pdu_id != pdu->params[0])
+		goto err;
+
+
+	len = 0;
+	pending->attr_ids = player_fill_media_attribute(player,
+							pending->attr_ids,
+							pdu->params, &len,
+							&pending->offset);
+	pdu->pdu_id = pending->pdu_id;
+
+	if (pending->attr_ids == NULL) {
+		g_free(player->pending_pdu);
+		player->pending_pdu = NULL;
+		pdu->packet_type = AVRCP_PACKET_TYPE_END;
+	} else {
+		pdu->packet_type = AVRCP_PACKET_TYPE_CONTINUING;
+	}
+
+	pdu->params_len = htons(len);
+
+	return AVC_CTYPE_STABLE;
+err:
+	pdu->params_len = htons(1);
+	pdu->params[0] = E_INVALID_PARAM;
+	return AVC_CTYPE_REJECTED;
+}
+
 static uint8_t avrcp_handle_abort_continuing(struct avrcp_player *player,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
@@ -950,6 +1024,8 @@ static struct pdu_handler {
 					avrcp_handle_get_play_status },
 		{ AVRCP_REGISTER_NOTIFICATION, AVC_CTYPE_NOTIFY,
 					avrcp_handle_register_notification },
+		{ AVRCP_REQUEST_CONTINUING, AVC_CTYPE_CONTROL,
+					avrcp_handle_request_continuing },
 		{ AVRCP_ABORT_CONTINUING, AVC_CTYPE_CONTROL,
 					avrcp_handle_abort_continuing },
 		{ },
@@ -1000,6 +1076,8 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
 	*code = handler->func(player, pdu, transaction);
 
 	if (*code != AVC_CTYPE_REJECTED &&
+				pdu->pdu_id != AVRCP_GET_ELEMENT_ATTRIBUTES &&
+				pdu->pdu_id != AVRCP_REQUEST_CONTINUING &&
 				pdu->pdu_id != AVRCP_ABORT_CONTINUING)
 		player_abort_pending_pdu(player);
 
-- 
1.7.7


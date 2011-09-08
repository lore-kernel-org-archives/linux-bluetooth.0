Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 5/5] avrcp: implement pdu continuation request and abort
Date: Thu,  8 Sep 2011 20:14:50 -0300
Message-Id: <1315523690-11195-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1315523690-11195-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1315523690-11195-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GetElementAttributes is the only one that can possibly overflow the MTU
of AVC. When this command is received, if the response is larger than
the MTU split the messages and queue them for later processing.
---
 audio/control.c |  318 ++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 231 insertions(+), 87 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index c162a62..adb5113 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -128,6 +128,8 @@
 #define AVRCP_GET_ELEMENT_ATTRIBUTES	0x20
 #define AVRCP_GET_PLAY_STATUS		0x30
 #define AVRCP_REGISTER_NOTIFICATION	0x31
+#define AVRCP_REQUEST_CONTINUING	0x40
+#define AVRCP_ABORT_CONTINUING		0x41
 
 /* Notification events */
 #define AVRCP_EVENT_PLAYBACK_STATUS_CHANGED		0x01
@@ -300,6 +302,7 @@ struct media_player {
 
 	struct media_info mi;
 	GTimer *timer;
+	GQueue *pending_pdus;
 };
 
 struct control {
@@ -866,15 +869,17 @@ static void mp_set_playback_status(struct control *control, uint8_t status,
  * Copy media_info field to a buffer, intended to be used in a response to
  * GetElementAttributes message.
  *
- * It assumes there's enough space in the buffer and on success it returns the
- * size written.
+ * If there isn't enough space in the buffer, the available space is filled,
+ * the remainder (both header and value) is allocated in @param remainder and
+ * its size is written to remainder_len.
  *
- * If @param id is not valid, -EINVAL is returned. If there's no such media
- * attribute, -ENOENT is returned.
+ * On success, it returns the size written. Otherwise it returns -EINVAL if
+ * @param id is not valid or -ENOENT if there's no such media attribute.
  */
 static int mp_get_media_attribute(struct media_player *mp,
-						uint32_t id, uint8_t *buf,
-						uint16_t maxlen)
+					uint32_t id, uint8_t *buf,
+					uint16_t maxlen, uint8_t **remainder,
+					int *remainder_len)
 {
 	struct media_info_elem {
 		uint32_t id;
@@ -883,102 +888,105 @@ static int mp_get_media_attribute(struct media_player *mp,
 		uint8_t val[];
 	};
 	const struct media_info *mi = &mp->mi;
-	struct media_info_elem *elem = (void *)buf;
+	struct media_info_elem *elem;
 	uint16_t len;
 	char valstr[20];
+	char *valp;
+	int ret;
 
-	if (maxlen < sizeof(struct media_info_elem))
-		return -ENOBUFS;
+	assert(remainder != NULL);
+	assert(remainder_len != NULL);
 
-	/* Subtract the size of elem header from the available space */
-	maxlen -= sizeof(struct media_info_elem);
+	DBG("id=%u buf=%p maxlen=%u", id, buf, maxlen);
 
 	switch (id) {
 	case MEDIA_INFO_TITLE:
-		if (mi->title == NULL) {
-			len = 0;
-			break;
-		}
+		valp = mi->title;
 
-		len = strlen(mi->title);
-		if (len > maxlen)
-			return -ENOBUFS;
+		if (mi->title == NULL)
+			len = 0;
 
-		memcpy(elem->val, mi->title, len);
 		break;
 	case MEDIA_INFO_ARTIST:
 		if (mi->artist == NULL)
 			return -ENOENT;
 
-		len = strlen(mi->artist);
-		if (len > maxlen)
-			return -ENOBUFS;
-
-		memcpy(elem->val, mi->artist, len);
+		valp = mi->artist;
 		break;
 	case MEDIA_INFO_ALBUM:
 		if (mi->album == NULL)
 			return -ENOENT;
 
-		len = strlen(mi->album);
-		if (len > maxlen)
-			return -ENOBUFS;
-
-		memcpy(elem->val, mi->album, len);
+		valp = mi->album;
 		break;
 	case MEDIA_INFO_GENRE:
 		if (mi->genre == NULL)
 			return -ENOENT;
 
-		len = strlen(mi->genre);
-		if (len > maxlen)
-			return -ENOBUFS;
-
-		memcpy(elem->val, mi->genre, len);
+		valp = mi->genre;
 		break;
-
 	case MEDIA_INFO_TRACK:
 		if (!mi->track)
 			return -ENOENT;
 
 		snprintf(valstr, 20, "%u", mi->track);
-		len = strlen(valstr);
-		if (len > maxlen)
-			return -ENOBUFS;
-
-		memcpy(elem->val, valstr, len);
+		valp = valstr;
 		break;
 	case MEDIA_INFO_N_TRACKS:
 		if (!mi->ntracks)
 			return -ENOENT;
 
 		snprintf(valstr, 20, "%u", mi->ntracks);
-		len = strlen(valstr);
-		if (len > maxlen)
-			return -ENOBUFS;
-
-		memcpy(elem->val, valstr, len);
+		valp = valstr;
 		break;
 	case MEDIA_INFO_PLAYING_TIME:
 		if (mi->track_len == 0xFFFFFFFF)
 			return -ENOENT;
 
 		snprintf(valstr, 20, "%u", mi->track_len);
-		len = strlen(valstr);
-		if (len > maxlen)
-			return -ENOBUFS;
-
-		memcpy(elem->val, valstr, len);
+		valp = valstr;
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	if (valp)
+		len = strlen(valp);
+
+	if (maxlen < sizeof(struct media_info_elem)) {
+		/*
+		 * There isn't space even for the header: put both header and
+		 * value in remainder.
+		 */
+		*remainder_len = sizeof(struct media_info_elem) + len;
+		elem = g_malloc(*remainder_len);
+		*remainder = (uint8_t *) elem;
+		memcpy(elem->val, valp, len);
+		ret = 0;
+	} else {
+		/* Put at least header on current PDU */
+		elem = (struct media_info_elem *) buf;
+		maxlen -= sizeof(struct media_info_elem);
+
+		if (maxlen < len) {
+			/* Split value between current PDU and remainder. */
+			memcpy(elem->val, valp, maxlen);
+			*remainder_len = len - maxlen;
+			*remainder = g_memdup(valp + maxlen, *remainder_len);
+			ret = sizeof(struct media_info_elem) + maxlen;
+		} else {
+			/* Header and value fit in current PDU */
+			memcpy(elem->val, valp, len);
+			*remainder = NULL;
+			ret = sizeof(struct media_info_elem) + len;
+		}
+	}
+
 	elem->id = htonl(id);
 	elem->charset = htons(0x6A); /* Always use UTF-8 */
 	elem->len = htons(len);
 
-	return sizeof(struct media_info_elem) + len;
+	return ret;
 }
 
 static void mp_set_attribute(struct media_player *mp,
@@ -1130,69 +1138,122 @@ err:
 	return -EINVAL;
 }
 
+static struct avrcp_spec_avc_pdu *avrcp_split_pdu(struct media_player *mp,
+					struct avrcp_spec_avc_pdu *last_pdu,
+					uint8_t *remainder, int remainder_len,
+					uint16_t *pos)
+{
+	struct avrcp_spec_avc_pdu *pdu = last_pdu;
+	uint16_t len;
+
+	assert(remainder != NULL);
+	assert(pos != NULL);
+
+	if (!mp->pending_pdus)
+		mp->pending_pdus = g_queue_new();
+
+	for (len = *pos; remainder_len; remainder_len -= len) {
+		/* Close last pdu - keep host endiannes */
+		pdu->params_len = len;
+
+		/* Create a new PDU */
+		pdu = g_malloc(AVRCP_PDU_MTU + AVRCP_SPECAVCPDU_HEADER_LENGTH);
+
+		memcpy(pdu, last_pdu, sizeof(struct avrcp_spec_avc_pdu));
+		g_queue_push_tail(mp->pending_pdus, pdu);
+
+		if (remainder_len > AVRCP_PDU_MTU)
+			len = AVRCP_PDU_MTU;
+		else
+			len = remainder_len;
+
+		memcpy(&pdu->params[0], remainder, len);
+	}
+
+	*pos = len;
+
+	return pdu;
+}
+
 static int avrcp_handle_get_element_attributes(struct control *control,
-						struct avrcp_spec_avc_pdu *pdu)
+					struct avrcp_spec_avc_pdu *first_pdu)
 {
-	uint16_t len = ntohs(pdu->params_len);
+	struct avrcp_spec_avc_pdu *pdu = first_pdu;
+	struct media_player *mp = control->mp;
 	uint64_t *identifier = (void *) &pdu->params[0];
+	uint32_t attr_ids[MEDIA_INFO_LAST];
+	uint16_t len = ntohs(pdu->params_len);
 	uint16_t pos;
 	uint8_t nattr;
-	int size;
 	unsigned int i;
 
-	if (len < 8 || *identifier != 0 || !control->mp)
+	if (len < 8 || *identifier != 0 || !mp)
 		goto err;
 
-	len = 0;
-	pos = 1; /* Keep track of current position in reponse */
 	nattr = pdu->params[8];
 
+	DBG("nattr=%u", nattr);
 
-	if (!nattr) {
-		/*
-		 * Return all available information, at least
-		 * title must be returned.
-		 */
-		for (i = 1; i < MEDIA_INFO_LAST; i++) {
-			size = mp_get_media_attribute(control->mp, i,
-					&pdu->params[pos], AVRCP_PDU_MTU - pos);
-
+	/* Copy the requested attribute ids to our private vector */
+	if (nattr) {
+		uint32_t *attr = (uint32_t *) &pdu->params[9];
 
-			if (size > 0) {
-				len++;
-				pos += size;
-			}
+		if (nattr > MEDIA_INFO_LAST) {
+			error("Got number of attributes %u > %u",
+						nattr, MEDIA_INFO_LAST);
+			nattr = MEDIA_INFO_LAST;
 		}
+
+		for (i = 0; attr < (uint32_t *)&pdu->params[9] +
+						nattr * sizeof(uint32_t);
+						attr++, i++)
+			attr_ids[i] = ntohl(*attr);
 	} else {
-		uint32_t *attr_ids;
+		nattr = MEDIA_INFO_LAST - 1;
 
-		attr_ids = g_memdup(&pdu->params[9], sizeof(uint32_t) * nattr);
+		for (i = 1; i < MEDIA_INFO_LAST; i++)
+			attr_ids[i - 1] = i;
+	}
 
-		for (i = 0; i < nattr; i++) {
-			uint32_t attr = ntohl(attr_ids[i]);
+	for (i = 0, len = 0, pos = 1; i < nattr; i++) {
+		uint8_t *remainder;
+		int size, remainder_len;
 
-			size = mp_get_media_attribute(control->mp, attr,
-							&pdu->params[pos],
-							AVRCP_PDU_MTU - pos);
+		size = mp_get_media_attribute(control->mp, attr_ids[i],
+						&pdu->params[pos],
+						AVRCP_PDU_MTU - pos,
+						&remainder, &remainder_len);
 
-			if (size > 0) {
-				len++;
-				pos += size;
-			}
+		if (size < 0)
+			continue;
+
+		pos += size;
+		len++;
+
+		if (remainder) {
+			pdu = avrcp_split_pdu(control->mp, pdu, remainder,
+							remainder_len, &pos);
+			g_free(remainder);
 		}
+	}
 
-		g_free(attr_ids);
+	if (!len)
+		goto err;
+
+	/* Close last pdu - keep host endiannes */
+	pdu->params_len = pos;
 
-		if (!len)
-			goto err;
+	if (first_pdu != pdu) {
+		first_pdu->packet_type = AVCTP_PACKET_START;
+		pos = first_pdu->params_len;
 	}
 
-	pdu->params[0] = len;
-	pdu->params_len = htons(pos);
+	first_pdu->params[0] = len;
+	first_pdu->params_len = htons(first_pdu->params_len);
 
 	return pos;
 err:
-	pdu->params[0] = E_INVALID_PARAM;
+	first_pdu->params[0] = E_INVALID_PARAM;
 	return -EINVAL;
 }
 
@@ -1421,6 +1482,56 @@ err:
 	return -EINVAL;
 }
 
+static void cancel_pending_pdus(struct media_player *mp)
+{
+	struct avrcp_spec_avc_pdu *pdu;
+
+	if (!mp || !mp->pending_pdus)
+		return;
+
+	DBG("%u PDUs cancelled.", g_queue_get_length(mp->pending_pdus));
+
+	while ((pdu = g_queue_pop_head(mp->pending_pdus)))
+		g_free(pdu);
+
+	g_queue_free(mp->pending_pdus);
+	mp->pending_pdus = NULL;
+}
+
+static int avrcp_handle_request_continuing(struct control *control,
+						struct avrcp_spec_avc_pdu *pdu)
+{
+	struct media_player *mp = control->mp;
+	struct avrcp_spec_avc_pdu *saved_pdu;
+	int len;
+
+	if (!mp || !mp->pending_pdus) {
+		pdu->params[0] = E_INVALID_PARAM;
+		return -EINVAL;
+	}
+
+	DBG("");
+
+	saved_pdu = g_queue_pop_head(mp->pending_pdus);
+
+	len = saved_pdu->params_len;
+	memcpy(pdu, saved_pdu, sizeof(struct avrcp_spec_avc_pdu) + len);
+	pdu->params_len = htons(len);
+
+	g_free(saved_pdu);
+
+	/* Mark the pdu as the last one and destroy queue */
+	if (g_queue_is_empty(mp->pending_pdus)) {
+		pdu->packet_type = AVCTP_PACKET_END;
+		g_queue_free(mp->pending_pdus);
+		mp->pending_pdus = NULL;
+	} else {
+		pdu->packet_type = AVCTP_PACKET_CONTINUE;
+	}
+
+	return len;
+}
+
 /* handle vendordep pdu inside an avctp packet */
 static int handle_vendordep_pdu(struct control *control,
 					struct avctp_header *avctp,
@@ -1446,6 +1557,10 @@ static int handle_vendordep_pdu(struct control *control,
 		goto err_metadata;
 	}
 
+	/* We have to cancel pending pdus before processing new message */
+	if (pdu->pdu_id != AVRCP_REQUEST_CONTINUING)
+		cancel_pending_pdus(control->mp);
+
 	switch (pdu->pdu_id) {
 	case AVRCP_GET_CAPABILITIES:
 		if (avrcp->code != CTYPE_STATUS) {
@@ -1601,6 +1716,34 @@ static int handle_vendordep_pdu(struct control *control,
 		avrcp->code = CTYPE_INTERIM;
 
 		break;
+	case AVRCP_REQUEST_CONTINUING:
+		/*
+		 * This case is special as it's the only one that does not
+		 * cancel pending pdus, but instead it returns one of them.
+		 * All the others will break the switch, but this returns
+		 * directly.
+		 */
+
+		len = avrcp_handle_request_continuing(control, pdu);
+
+		if (len < 0)
+			goto err_metadata;
+
+		avrcp->code = CTYPE_STABLE;
+
+		return AVRCP_HEADER_LENGTH + AVRCP_SPECAVCPDU_HEADER_LENGTH
+								+ len;
+	case AVRCP_ABORT_CONTINUING:
+		if (avrcp->code != CTYPE_CONTROL) {
+			pdu->params[0] = E_INVALID_COMMAND;
+			goto err_metadata;
+		}
+
+		pdu->params_len = 0;
+		avrcp->code = CTYPE_STABLE;
+		len = 0;
+
+		break;
 	default:
 		/* Invalid pdu_id */
 		pdu->params[0] = E_INVALID_COMMAND;
@@ -2537,6 +2680,7 @@ static void mp_path_unregister(void *data)
 	DBG("Unregistered interface %s on path %s",
 		MEDIA_PLAYER_INTERFACE, dev->path);
 
+	cancel_pending_pdus(mp);
 	g_timer_destroy(mp->timer);
 	g_free(mp);
 	control->mp = NULL;
-- 
1.7.6.1


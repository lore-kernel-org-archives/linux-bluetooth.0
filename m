Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 4/5] avrcp: limit avrcp packet size to the MTU of AV/C
Date: Thu,  8 Sep 2011 20:14:49 -0300
Message-Id: <1315523690-11195-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1315523690-11195-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1315523690-11195-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AVRCP is an extension of AV/C spec which has a limit of 512 bytes. The
only place where it can exceed this value is in the response to
GetElementAttributes command.

Now we simply don't add the attributes that would overflow the available
buffer space.
---
 audio/control.c |   51 +++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 0a333db..c162a62 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -266,6 +266,10 @@ struct avrcp_spec_avc_pdu {
 #error "Unknown byte order"
 #endif
 
+#define AVC_MTU			512
+#define AVRCP_PDU_MTU		(AVC_MTU - AVRCP_HEADER_LENGTH \
+					- AVRCP_SPECAVCPDU_HEADER_LENGTH)
+
 struct avctp_state_callback {
 	avctp_state_cb cb;
 	void *user_data;
@@ -869,7 +873,8 @@ static void mp_set_playback_status(struct control *control, uint8_t status,
  * attribute, -ENOENT is returned.
  */
 static int mp_get_media_attribute(struct media_player *mp,
-						uint32_t id, uint8_t *buf)
+						uint32_t id, uint8_t *buf,
+						uint16_t maxlen)
 {
 	struct media_info_elem {
 		uint32_t id;
@@ -882,21 +887,33 @@ static int mp_get_media_attribute(struct media_player *mp,
 	uint16_t len;
 	char valstr[20];
 
+	if (maxlen < sizeof(struct media_info_elem))
+		return -ENOBUFS;
+
+	/* Subtract the size of elem header from the available space */
+	maxlen -= sizeof(struct media_info_elem);
+
 	switch (id) {
 	case MEDIA_INFO_TITLE:
-		if (mi->title) {
-			len = strlen(mi->title);
-			memcpy(elem->val, mi->title, len);
-		} else {
+		if (mi->title == NULL) {
 			len = 0;
+			break;
 		}
 
+		len = strlen(mi->title);
+		if (len > maxlen)
+			return -ENOBUFS;
+
+		memcpy(elem->val, mi->title, len);
 		break;
 	case MEDIA_INFO_ARTIST:
 		if (mi->artist == NULL)
 			return -ENOENT;
 
 		len = strlen(mi->artist);
+		if (len > maxlen)
+			return -ENOBUFS;
+
 		memcpy(elem->val, mi->artist, len);
 		break;
 	case MEDIA_INFO_ALBUM:
@@ -904,6 +921,9 @@ static int mp_get_media_attribute(struct media_player *mp,
 			return -ENOENT;
 
 		len = strlen(mi->album);
+		if (len > maxlen)
+			return -ENOBUFS;
+
 		memcpy(elem->val, mi->album, len);
 		break;
 	case MEDIA_INFO_GENRE:
@@ -911,6 +931,9 @@ static int mp_get_media_attribute(struct media_player *mp,
 			return -ENOENT;
 
 		len = strlen(mi->genre);
+		if (len > maxlen)
+			return -ENOBUFS;
+
 		memcpy(elem->val, mi->genre, len);
 		break;
 
@@ -920,6 +943,9 @@ static int mp_get_media_attribute(struct media_player *mp,
 
 		snprintf(valstr, 20, "%u", mi->track);
 		len = strlen(valstr);
+		if (len > maxlen)
+			return -ENOBUFS;
+
 		memcpy(elem->val, valstr, len);
 		break;
 	case MEDIA_INFO_N_TRACKS:
@@ -928,6 +954,9 @@ static int mp_get_media_attribute(struct media_player *mp,
 
 		snprintf(valstr, 20, "%u", mi->ntracks);
 		len = strlen(valstr);
+		if (len > maxlen)
+			return -ENOBUFS;
+
 		memcpy(elem->val, valstr, len);
 		break;
 	case MEDIA_INFO_PLAYING_TIME:
@@ -936,6 +965,9 @@ static int mp_get_media_attribute(struct media_player *mp,
 
 		snprintf(valstr, 20, "%u", mi->track_len);
 		len = strlen(valstr);
+		if (len > maxlen)
+			return -ENOBUFS;
+
 		memcpy(elem->val, valstr, len);
 		break;
 	default:
@@ -1115,8 +1147,6 @@ static int avrcp_handle_get_element_attributes(struct control *control,
 	pos = 1; /* Keep track of current position in reponse */
 	nattr = pdu->params[8];
 
-	if (!control->mp)
-		goto done;
 
 	if (!nattr) {
 		/*
@@ -1125,7 +1155,8 @@ static int avrcp_handle_get_element_attributes(struct control *control,
 		 */
 		for (i = 1; i < MEDIA_INFO_LAST; i++) {
 			size = mp_get_media_attribute(control->mp, i,
-							&pdu->params[pos]);
+					&pdu->params[pos], AVRCP_PDU_MTU - pos);
+
 
 			if (size > 0) {
 				len++;
@@ -1141,7 +1172,8 @@ static int avrcp_handle_get_element_attributes(struct control *control,
 			uint32_t attr = ntohl(attr_ids[i]);
 
 			size = mp_get_media_attribute(control->mp, attr,
-							&pdu->params[pos]);
+							&pdu->params[pos],
+							AVRCP_PDU_MTU - pos);
 
 			if (size > 0) {
 				len++;
@@ -1155,7 +1187,6 @@ static int avrcp_handle_get_element_attributes(struct control *control,
 			goto err;
 	}
 
-done:
 	pdu->params[0] = len;
 	pdu->params_len = htons(pos);
 
-- 
1.7.6.1


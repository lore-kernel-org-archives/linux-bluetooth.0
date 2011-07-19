Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 16/19] avrcp: handle GetElementAttributes pdu
Date: Tue, 19 Jul 2011 16:49:27 -0300
Message-Id: <1311104970-18600-17-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |  162 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 162 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 88efdb5..d37848e 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -123,6 +123,7 @@
 #define AVRCP_GET_PLAYER_VALUE_TEXT	0x16
 #define AVRCP_DISPLAYABLE_CHARSET	0x17
 #define AVRCP_CT_BATTERY_STATUS		0x18
+#define AVRCP_GET_ELEMENT_ATTRIBUTES	0x20
 #define AVRCP_GET_PLAY_STATUS		0x30
 #define AVRCP_REGISTER_NOTIFICATION	0x31
 
@@ -195,6 +196,16 @@ enum play_status {
 	PLAY_STATUS_ERROR =		0xFF
 };
 
+enum media_info_id {
+	MEDIA_INFO_TITLE =		1,
+	MEDIA_INFO_ARTIST =		2,
+	MEDIA_INFO_ALBUM =		3,
+	MEDIA_INFO_TRACK =		4,
+	MEDIA_INFO_N_TRACKS =		5,
+	MEDIA_INFO_GENRE =		6,
+	MEDIA_INFO_CURRENT_POSITION =	7,
+};
+
 static DBusConnection *connection = NULL;
 
 static GSList *servers = NULL;
@@ -655,6 +666,95 @@ static const char *battery_status_to_string(enum battery_status status)
 	return NULL;
 }
 
+/*
+ * Copy media_info field to a buffer, intended to be used in a response to
+ * GetElementAttributes message.
+ *
+ * It assumes there's enough space in the buffer and returns the size written.
+ * If there's an error, nothing is written and -EINVAL is returned.
+ */
+static int media_info_get_elem(struct control *control, uint32_t id,
+							uint8_t *buf)
+{
+	struct media_info_elem {
+		uint32_t id;
+		uint16_t charset;
+		uint16_t len;
+		uint8_t val[];
+	};
+	struct media_info_elem *elem = (void *)buf;
+	struct media_info *mi = &control->mi;
+	uint16_t len;
+	char valstr[20];
+
+	switch (id) {
+	case (MEDIA_INFO_TITLE):
+		if (mi->title) {
+			len = strlen(mi->title);
+			memcpy(elem->val, mi->title, len);
+		} else {
+			len = 0;
+		}
+
+		break;
+	case (MEDIA_INFO_ARTIST):
+		if (mi->artist == NULL)
+			return -ENOENT;
+
+		len = strlen(mi->artist);
+		memcpy(elem->val, mi->artist, len);
+		break;
+	case (MEDIA_INFO_ALBUM):
+		if (mi->album == NULL)
+			return -ENOENT;
+
+		len = strlen(mi->album);
+		memcpy(elem->val, mi->album, len);
+		break;
+	case (MEDIA_INFO_GENRE):
+		if (mi->genre == NULL)
+			return -ENOENT;
+
+		len = strlen(mi->genre);
+		memcpy(elem->val, mi->genre, len);
+		break;
+
+	case (MEDIA_INFO_TRACK):
+		if (!mi->track)
+			return -ENOENT;
+
+		snprintf(valstr, 20, "%u", mi->track);
+		len = strlen(valstr);
+		memcpy(elem->val, valstr, len);
+		break;
+	case (MEDIA_INFO_N_TRACKS):
+		if (!mi->ntracks)
+			return -ENOENT;
+
+		snprintf(valstr, 20, "%u", mi->ntracks);
+		len = strlen(valstr);
+		memcpy(elem->val, valstr, len);
+		break;
+	case (MEDIA_INFO_CURRENT_POSITION):
+		if (mi->current_position == 0xFFFFFFFF)
+			return -ENOENT;
+
+		snprintf(valstr, 20, "%u", mi->current_position);
+		len = strlen(valstr);
+		memcpy(elem->val, valstr, len);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	elem->id = htonl(id);
+	elem->charset = htons(0x6A); /* Always use UTF-8 */
+	elem->len = htons(len);
+
+	return sizeof(struct media_info_elem) + len;
+}
+
+
 static void append_variant(DBusMessageIter *iter, int type, void *val)
 {
 	DBusMessageIter value;
@@ -800,6 +900,68 @@ static int handle_vendordep_pdu(struct control *control,
 
 		return AVRCP_HEADER_LENGTH +
 				AVRCP_SPECAVCPDU_HEADER_LENGTH + len + 1;
+	case AVRCP_GET_ELEMENT_ATTRIBUTES:
+		if (len > 8 && avrcp->code == CTYPE_STATUS) {
+			uint16_t pos = 1; /* keep track of position in resp */
+			uint8_t nattr = pdu->params[8];
+			uint64_t *identifier = (void *) &pdu->params[0];
+			int size;
+
+			if (*identifier != 0) {
+				pdu->params[0] = E_INVALID_PARAM;
+				goto err_metadata;
+			}
+
+			len = 0;
+
+			if (!nattr) {
+				/*
+				 * Return all available information, at least
+				 * title must be returned
+				 */
+				for (i = 1; i < MEDIA_INFO_CURRENT_POSITION;
+									i++) {
+					size = media_info_get_elem(control,
+							i, &pdu->params[pos]);
+
+					if (size > 0) {
+						len++;
+						pos += size;
+					}
+				}
+			} else {
+				uint32_t attr_ids[nattr];
+
+				memcpy(&attr_ids[0], &pdu->params[9],
+								nattr * 4);
+
+				for (i = 0; i < nattr; i++) {
+					uint32_t attr = ntohl(attr_ids[i]);
+
+					size = media_info_get_elem(control,
+						attr, &pdu->params[pos]);
+
+					if (size > 0) {
+						len++;
+						pos += size;
+					}
+				}
+
+				if (!len) {
+					pdu->params[0] = E_INVALID_PARAM;
+					goto err_metadata;
+				}
+			}
+
+			avrcp->code = CTYPE_STABLE;
+			pdu->params[0] = len;
+			pdu->params_len = htons(pos);
+
+			return AVRCP_HEADER_LENGTH +
+				AVRCP_SPECAVCPDU_HEADER_LENGTH + pos;
+		}
+
+		break;
 	case AVRCP_GET_CURRENT_PLAYER_VALUE:
 		if (len > 1 && pdu->params[0] == len - 1 &&
 						avrcp->code == CTYPE_STATUS) {
-- 
1.7.6


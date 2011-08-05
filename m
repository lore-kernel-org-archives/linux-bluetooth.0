Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 18/23] avrcp: handle GetElementAttributes pdu
Date: Fri,  5 Aug 2011 15:15:27 -0300
Message-Id: <1312568132-21112-18-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Example responses for PTS test TC_TG_MDI_BV_04_C:

> ACL data: handle 11 flags 0x02 dlen 26
    L2CAP(d): cid 0x0042 len 22 [psm 23]
      AVCTP: Command : pt 0x00 transaction 2 pid 0x110e
        AV/C: Status: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetElementAttributes: pt 0x00 len 0x0009
            Identifier: 0x0 (PLAYING)
            AttributeCount: 0x00
< ACL data: handle 11 flags 0x02 dlen 70
    L2CAP(d): cid 0x0042 len 66 [psm 23]
      AVCTP: Response : pt 0x00 transaction 2 pid 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetElementAttributes: pt 0x00 len 0x0035
            AttributeCount: 0x03
            Attribute: 0x00000001 (Title)
            CharsetID: 0x006a (UTF-8)
            AttributeValueLength: 0x0012
            AttributeValue: Walking on the Sun
            Attribute: 0x00000002 (Artist)
            CharsetID: 0x006a (UTF-8)
            AttributeValueLength: 0x0005
            AttributeValue: Lucas
            Attribute: 0x00000007 (Progress)
            CharsetID: 0x006a (UTF-8)
            AttributeValueLength: 0x0005
            AttributeValue: 32029

And TC_TG_MDI_BV_05_C:

> ACL data: handle 11 flags 0x02 dlen 30
    L2CAP(d): cid 0x0043 len 26 [psm 23]
      AVCTP: Command : pt 0x00 transaction 2 pid 0x110e
        AV/C: Status: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetElementAttributes: pt 0x00 len 0x000d
            Identifier: 0x0 (PLAYING)
            AttributeCount: 0x01
            Attribute: 0x00000001 (Title)
< ACL data: handle 11 flags 0x02 dlen 44
    L2CAP(d): cid 0x0043 len 40 [psm 23]
      AVCTP: Response : pt 0x00 transaction 2 pid 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetElementAttributes: pt 0x00 len 0x001b
            AttributeCount: 0x01
            Attribute: 0x00000001 (Title)
            CharsetID: 0x006a (UTF-8)
            AttributeValueLength: 0x0012
            AttributeValue: Walking on the Sun
---
 audio/control.c |  187 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 187 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index f627861..40d47f5 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -123,6 +123,7 @@
 #define AVRCP_GET_PLAYER_VALUE_TEXT	0x16
 #define AVRCP_DISPLAYABLE_CHARSET	0x17
 #define AVRCP_CT_BATTERY_STATUS		0x18
+#define AVRCP_GET_ELEMENT_ATTRIBUTES	0x20
 #define AVRCP_GET_PLAY_STATUS		0x30
 #define AVRCP_REGISTER_NOTIFICATION	0x31
 
@@ -184,6 +185,16 @@ enum battery_status {
 	BATTERY_STATUS_FULL_CHARGE =	4,
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
@@ -744,6 +755,103 @@ static void mp_set_playback_status(struct control *control, uint8_t status,
 	mp->status = status;
 }
 
+/*
+ * Copy media_info field to a buffer, intended to be used in a response to
+ * GetElementAttributes message.
+ *
+ * It assumes there's enough space in the buffer and on success it returns the
+ * size written.
+ *
+ * If @param id is not valid, -EINVAL is returned. If there's no such media
+ * attribute, -ENOENT is returned.
+ */
+static int mp_get_media_attribute(struct media_player *mp,
+						uint32_t id, uint8_t *buf)
+{
+	struct media_info_elem {
+		uint32_t id;
+		uint16_t charset;
+		uint16_t len;
+		uint8_t val[];
+	};
+	const struct media_info *mi = &mp->mi;
+	struct media_info_elem *elem = (void *)buf;
+	uint16_t len;
+	char valstr[20];
+
+	switch (id) {
+	case MEDIA_INFO_TITLE:
+		if (mi->title) {
+			len = strlen(mi->title);
+			memcpy(elem->val, mi->title, len);
+		} else {
+			len = 0;
+		}
+
+		break;
+	case MEDIA_INFO_ARTIST:
+		if (mi->artist == NULL)
+			return -ENOENT;
+
+		len = strlen(mi->artist);
+		memcpy(elem->val, mi->artist, len);
+		break;
+	case MEDIA_INFO_ALBUM:
+		if (mi->album == NULL)
+			return -ENOENT;
+
+		len = strlen(mi->album);
+		memcpy(elem->val, mi->album, len);
+		break;
+	case MEDIA_INFO_GENRE:
+		if (mi->genre == NULL)
+			return -ENOENT;
+
+		len = strlen(mi->genre);
+		memcpy(elem->val, mi->genre, len);
+		break;
+
+	case MEDIA_INFO_TRACK:
+		if (!mi->track)
+			return -ENOENT;
+
+		snprintf(valstr, 20, "%u", mi->track);
+		len = strlen(valstr);
+		memcpy(elem->val, valstr, len);
+		break;
+	case MEDIA_INFO_N_TRACKS:
+		if (!mi->ntracks)
+			return -ENOENT;
+
+		snprintf(valstr, 20, "%u", mi->ntracks);
+		len = strlen(valstr);
+		memcpy(elem->val, valstr, len);
+		break;
+	case MEDIA_INFO_CURRENT_POSITION:
+		if (mi->elapsed != 0xFFFFFFFF) {
+			uint32_t elapsed;
+
+			mp_get_playback_status(mp, NULL, &elapsed, NULL);
+
+			snprintf(valstr, 20, "%u", elapsed);
+			len = strlen(valstr);
+			memcpy(elem->val, valstr, len);
+		} else {
+			return -ENOENT;
+		}
+
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
 static void mp_set_attribute(struct media_player *mp,
 						uint8_t attr, uint8_t val)
 {
@@ -930,6 +1038,72 @@ err:
 	return -EINVAL;
 }
 
+static int avrcp_handle_get_element_attributes(struct control *control,
+						struct avrcp_spec_avc_pdu *pdu)
+{
+	uint16_t len = ntohs(pdu->params_len);
+	uint64_t *identifier = (void *) &pdu->params[0];
+	uint16_t pos;
+	uint8_t nattr;
+	int size;
+	unsigned int i;
+
+	if (len < 8 || *identifier != 0 || !control->mp)
+		goto err;
+
+	len = 0;
+	pos = 1; /* Keep track of current position in reponse */
+	nattr = pdu->params[8];
+
+	if (!control->mp)
+		goto done;
+
+	if (!nattr) {
+		/*
+		 * Return all available information, at least
+		 * title must be returned.
+		 */
+		for (i = 1; i <= MEDIA_INFO_CURRENT_POSITION; i++) {
+			size = mp_get_media_attribute(control->mp, i,
+							&pdu->params[pos]);
+
+			if (size > 0) {
+				len++;
+				pos += size;
+			}
+		}
+	} else {
+		uint32_t attr_ids[nattr];
+
+		/* save a copy of requested attributes */
+		memcpy(&attr_ids[0], &pdu->params[9], nattr * 4);
+
+		for (i = 0; i < nattr; i++) {
+			uint32_t attr = ntohl(attr_ids[i]);
+
+			size = mp_get_media_attribute(control->mp, attr,
+							&pdu->params[pos]);
+
+			if (size > 0) {
+				len++;
+				pos += size;
+			}
+		}
+
+		if (!len)
+			goto err;
+	}
+
+done:
+	pdu->params[0] = len;
+	pdu->params_len = htons(pos);
+
+	return pos;
+err:
+	pdu->params[0] = E_INVALID_PARAM;
+	return -EINVAL;
+}
+
 static int avrcp_handle_get_current_player_value(struct control *control,
 						struct avrcp_spec_avc_pdu *pdu)
 {
@@ -1219,6 +1393,19 @@ static int handle_vendordep_pdu(struct control *control,
 		avrcp->code = CTYPE_STABLE;
 
 		break;
+	case AVRCP_GET_ELEMENT_ATTRIBUTES:
+		if (avrcp->code != CTYPE_STATUS) {
+			pdu->params[0] = E_INVALID_COMMAND;
+			goto err_metadata;
+		}
+
+		len = avrcp_handle_get_element_attributes(control, pdu);
+		if (len < 0)
+			goto err_metadata;
+
+		avrcp->code = CTYPE_STABLE;
+
+		break;
 	case AVRCP_GET_CURRENT_PLAYER_VALUE:
 		if (avrcp->code != CTYPE_STATUS) {
 			pdu->params[0] = E_INVALID_COMMAND;
-- 
1.7.6


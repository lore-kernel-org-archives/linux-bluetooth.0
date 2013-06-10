Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/15] AVRCP: Fix sending invalid attributes when responding to GetElementAttributes
Date: Mon, 10 Jun 2013 13:37:07 +0300
Message-Id: <1370860630-30359-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
References: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The list returned by media.c contains the attributes in string format not
the binary format which cause us to send wrong/reserved attributes as can
be observed bellow:

> ACL data: handle 12 flags 0x02 dlen 58
    L2CAP(d): cid 0x0041 len 54 [psm 23]
      AVCTP Control: Response : pt 0x00 transaction 14 pid 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetElementAttributes: pt Single len 0x0029
            AttributeCount: 0x05
            Attribute: 0x00df9490 (Reserved)
            CharsetID: 0x006a (UTF-8)
            AttributeValueLength: 0x0000
            AttributeValue:
            Attribute: 0x00e0e880 (Reserved)
            CharsetID: 0x006a (UTF-8)
            AttributeValueLength: 0x0000
            AttributeValue:
            Attribute: 0x00e07b00 (Reserved)
            CharsetID: 0x006a (UTF-8)
            AttributeValueLength: 0x0000
            AttributeValue:
            Attribute: 0x00e16bc0 (Reserved)
            CharsetID: 0x006a (UTF-8)
            AttributeValueLength: 0x0000
            AttributeValue:
            Attribute: 0x00e07bc0 (Reserved)
            CharsetID: 0x006a (UTF-8)
            AttributeValueLength: 0x0000
            AttributeValue:
---
 profiles/audio/avrcp.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index f439ab3..7eaadf4 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -977,13 +977,43 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
+static uint32_t str_to_metadata(const char *str)
+{
+	if (strcasecmp(str, "Title") == 0)
+		return AVRCP_MEDIA_ATTRIBUTE_TITLE;
+	else if (strcasecmp(str, "Artist") == 0)
+		return AVRCP_MEDIA_ATTRIBUTE_ARTIST;
+	else if (strcasecmp(str, "Album") == 0)
+		return AVRCP_MEDIA_ATTRIBUTE_ALBUM;
+	else if (strcasecmp(str, "Genre") == 0)
+		return AVRCP_MEDIA_ATTRIBUTE_GENRE;
+	else if (strcasecmp(str, "TrackNumber") == 0)
+		return AVRCP_MEDIA_ATTRIBUTE_TRACK;
+	else if (strcasecmp(str, "NumberOfTracks") == 0)
+		return AVRCP_MEDIA_ATTRIBUTE_N_TRACKS;
+	else if (strcasecmp(str, "Duration") == 0)
+		return AVRCP_MEDIA_ATTRIBUTE_DURATION;
+
+	return 0;
+}
+
 static GList *player_list_metadata(struct avrcp_player *player)
 {
-	if (player != NULL)
-		return player->cb->list_metadata(player->user_data);
+	GList *l, *attrs = NULL;
 
-	return g_list_prepend(NULL,
+	if (player == NULL)
+		return g_list_prepend(NULL,
 				GUINT_TO_POINTER(AVRCP_MEDIA_ATTRIBUTE_TITLE));
+
+	l = player->cb->list_metadata(player->user_data);
+	for (; l; l = l->next) {
+		const char *key = l->data;
+
+		attrs = g_list_append(attrs,
+					GUINT_TO_POINTER(str_to_metadata(key)));
+	}
+
+	return attrs;
 }
 
 static uint8_t avrcp_handle_get_element_attributes(struct avrcp *session,
@@ -2123,8 +2153,7 @@ static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
 	}
 
 	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 4) {
-		if (pdu->params[0] == AVRCP_STATUS_PLAYER_NOT_BROWSABLE)
-			avrcp_get_element_attributes(session);
+		avrcp_get_element_attributes(session);
 		return FALSE;
 	}
 
-- 
1.8.1.4


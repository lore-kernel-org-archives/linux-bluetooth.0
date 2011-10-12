Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 11/12] Refactor to share code
Date: Wed, 12 Oct 2011 12:11:21 -0300
Message-Id: <1318432282-25002-11-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Refactor code when we are 'listing selected attributes' to share code
with 'listing all attributes'. This way we always keep the list of
attributes in a GList, and call player_get_media_attribute() in only one
place.
---
 audio/avrcp.c |   55 ++++++++++++++++++++++---------------------------------
 1 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 4e3ef97..ac7c8d4 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -591,11 +591,11 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 						uint8_t transaction)
 {
 	uint16_t len = ntohs(pdu->params_len);
-	uint64_t *identifier = (void *) &pdu->params[0];
+	uint64_t *identifier = (uint64_t *) &pdu->params[0];
 	uint16_t pos;
 	uint8_t nattr;
 	int size;
-	unsigned int i;
+	GList *l, *attr_ids;
 
 	if (len < 9 || *identifier != 0)
 		goto err;
@@ -605,53 +605,42 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 	if (len < nattr * sizeof(uint32_t) + 1)
 		goto err;
 
-	len = 0;
-	pos = 1; /* Keep track of current position in reponse */
-
 	if (!nattr) {
 		/*
 		 * Return all available information, at least
 		 * title must be returned if there's a track selected.
 		 */
-		GList *l, *attr_ids = player->cb->list_metadata(player->user_data);
-
-		for (l = attr_ids; l != NULL; l = l->next) {
-			uint32_t attr = GPOINTER_TO_UINT(l->data);
-
-			size = player_get_media_attribute(player, attr,
-							&pdu->params[pos],
-							AVRCP_PDU_MTU - pos);
+		attr_ids = player->cb->list_metadata(player->user_data);
+	} else {
+		unsigned int i;
+		uint32_t *attr = (uint32_t *) &pdu->params[9];
 
-			if (size > 0) {
-				len++;
-				pos += size;
-			}
+		for (i = 0, attr_ids = NULL; i < nattr; i++, attr++) {
+			uint32_t id = ntohl(bt_get_unaligned(attr));
+			attr_ids = g_list_prepend(attr_ids,
+							GUINT_TO_POINTER(id));
 		}
 
-		g_list_free(attr_ids);
-	} else {
-		uint32_t *attr_ids;
-
-		attr_ids = g_memdup(&pdu->params[9], sizeof(uint32_t) * nattr);
+		attr_ids = g_list_reverse(attr_ids);
+	}
 
-		for (i = 0; i < nattr; i++) {
-			uint32_t attr = ntohl(attr_ids[i]);
+	for (l = attr_ids, len = 0, pos = 1; l != NULL; l = l->next) {
+		uint32_t attr = GPOINTER_TO_UINT(l->data);
 
-			size = player_get_media_attribute(player, attr,
+		size = player_get_media_attribute(player, attr,
 							&pdu->params[pos],
 							AVRCP_PDU_MTU - pos);
 
-			if (size > 0) {
-				len++;
-				pos += size;
-			}
+		if (size >= 0) {
+			len++;
+			pos += size;
 		}
+	}
 
-		g_free(attr_ids);
+	g_list_free(attr_ids);
 
-		if (!len)
-			goto err;
-	}
+	if (!len)
+		goto err;
 
 	pdu->params[0] = len;
 	pdu->params_len = htons(pos);
-- 
1.7.7


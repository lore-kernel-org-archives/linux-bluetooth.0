Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 10/12] AVRCP: Only return available metadata attributes
Date: Wed, 12 Oct 2011 12:11:20 -0300
Message-Id: <1318432282-25002-10-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When remote side requests all available metadata (i.e. it gives number
attributes equals to 0) do not return zero-length strings for
unavailable items. The only exception is title, that must be always present.
---
 audio/avrcp.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 8b46650..4e3ef97 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -611,10 +611,14 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 	if (!nattr) {
 		/*
 		 * Return all available information, at least
-		 * title must be returned.
+		 * title must be returned if there's a track selected.
 		 */
-		for (i = 1; i < AVRCP_MEDIA_ATTRIBUTE_LAST; i++) {
-			size = player_get_media_attribute(player, i,
+		GList *l, *attr_ids = player->cb->list_metadata(player->user_data);
+
+		for (l = attr_ids; l != NULL; l = l->next) {
+			uint32_t attr = GPOINTER_TO_UINT(l->data);
+
+			size = player_get_media_attribute(player, attr,
 							&pdu->params[pos],
 							AVRCP_PDU_MTU - pos);
 
@@ -623,6 +627,8 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 				pos += size;
 			}
 		}
+
+		g_list_free(attr_ids);
 	} else {
 		uint32_t *attr_ids;
 
-- 
1.7.7


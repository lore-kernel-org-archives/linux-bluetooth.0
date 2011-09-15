Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: David Stockwell <dstockwell@frequency-one.com>
Subject: [PATCH 3/5] avrcp: use LAST element on media_info_id enum
Date: Thu, 15 Sep 2011 01:21:35 -0300
Message-Id: <1316060497-4068-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1316060497-4068-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1316060497-4068-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: David Stockwell <dstockwell@frequency-one.com>

---
 audio/avrcp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 783ba02..f7f3924 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -142,6 +142,7 @@ enum media_info_id {
 	MEDIA_INFO_N_TRACKS =		5,
 	MEDIA_INFO_GENRE =		6,
 	MEDIA_INFO_CURRENT_POSITION =	7,
+	MEDIA_INFO_LAST
 };
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
@@ -890,7 +891,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct media_player *mp,
 		 * Return all available information, at least
 		 * title must be returned.
 		 */
-		for (i = 1; i <= MEDIA_INFO_CURRENT_POSITION; i++) {
+		for (i = 1; i < MEDIA_INFO_LAST; i++) {
 			size = mp_get_media_attribute(mp, i,
 							&pdu->params[pos]);
 
-- 
1.7.6.1


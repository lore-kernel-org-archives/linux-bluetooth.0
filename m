Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: David Stockwell <dstockwell@frequency-one.com>
Subject: [PATCH 1/5] avrcp: use LAST element on media_info_id enum
Date: Thu,  8 Sep 2011 20:14:46 -0300
Message-Id: <1315523690-11195-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1315523690-11195-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1315523690-11195-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: David Stockwell <dstockwell@frequency-one.com>

---
 audio/control.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 9990b06..8857737 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -195,6 +195,7 @@ enum media_info_id {
 	MEDIA_INFO_N_TRACKS =		5,
 	MEDIA_INFO_GENRE =		6,
 	MEDIA_INFO_CURRENT_POSITION =	7,
+	MEDIA_INFO_LAST
 };
 
 static DBusConnection *connection = NULL;
@@ -1109,7 +1110,7 @@ static int avrcp_handle_get_element_attributes(struct control *control,
 		 * Return all available information, at least
 		 * title must be returned.
 		 */
-		for (i = 1; i <= MEDIA_INFO_CURRENT_POSITION; i++) {
+		for (i = 1; i < MEDIA_INFO_LAST; i++) {
 			size = mp_get_media_attribute(control->mp, i,
 							&pdu->params[pos]);
 
-- 
1.7.6.1


Return-Path: <cyrus@holtmann.org>
From: David Stockwell <dstockwell@frequency-one.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] AVRCP: Corrected metadata: Playing Time
Date: Sat, 20 Aug 2011 17:53:32 -0500
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201108201753.32608.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Metadata item #7 should return total playing time of the track (TrackDuration) 
in msec, not current position within the track.

Signed-off-by: David Stockwell <dstockwell@frequency-one.com>
---
 audio/control.c |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 4e10cac..047e6ac 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -196,7 +196,7 @@ enum media_info_id {
 	MEDIA_INFO_TRACK =		4,
 	MEDIA_INFO_N_TRACKS =		5,
 	MEDIA_INFO_GENRE =		6,
-	MEDIA_INFO_CURRENT_POSITION =	7,
+	MEDIA_INFO_PLAYING_TIME =	7,
 };
 
 static DBusConnection *connection = NULL;
@@ -979,19 +979,13 @@ static int mp_get_media_attribute(struct media_player 
*mp,
 		len = strlen(valstr);
 		memcpy(elem->val, valstr, len);
 		break;
-	case MEDIA_INFO_CURRENT_POSITION:
-		if (mi->elapsed != 0xFFFFFFFF) {
-			uint32_t elapsed;
-
-			mp_get_playback_status(mp, NULL, &elapsed, NULL);
-
-			snprintf(valstr, 20, "%u", elapsed);
-			len = strlen(valstr);
-			memcpy(elem->val, valstr, len);
-		} else {
+	case MEDIA_INFO_PLAYING_TIME:
+		if (!mi->track_len)
 			return -ENOENT;
-		}
-
+			
+		snprintf(valstr, 20, "%u", mi->track_len);
+		len = strlen(valstr);
+		memcpy(elem->val, valstr, len);
 		break;
 	default:
 		return -EINVAL;
@@ -1179,7 +1173,7 @@ static int avrcp_handle_get_element_attributes(struct 
control *control,
 		 * Return all available information, at least
 		 * title must be returned.
 		 */
-		for (i = 1; i <= MEDIA_INFO_CURRENT_POSITION; i++) {
+		for (i = 1; i <= MEDIA_INFO_PLAYING_TIME; i++) {
 			size = mp_get_media_attribute(control->mp, i,
 							&pdu->params[pos]);
 
-- 
1.7.3.4


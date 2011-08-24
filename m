Return-Path: <cyrus@holtmann.org>
From: David Stockwell <dstockwell@frequency-one.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] AVRCP: Metadata item #7 should return TrackDuration
Date: Tue, 23 Aug 2011 22:25:08 -0500
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201108232225.08328.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Metadata item #7 should return TrackDuration

Should be total playing time of the track (TrackDuration)
in msec, not current position within track.
---
 audio/control.c |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index be95c19..dd2930c 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -194,7 +194,8 @@ enum media_info_id {
 	MEDIA_INFO_TRACK =		4,
 	MEDIA_INFO_N_TRACKS =		5,
 	MEDIA_INFO_GENRE =		6,
-	MEDIA_INFO_CURRENT_POSITION =	7,
+	MEDIA_INFO_PLAYING_TIME =	7,
+	MEDIA_INFO_LAST = MEDIA_INFO_PLAYING_TIME,
 };
 
 static DBusConnection *connection = NULL;
@@ -928,19 +929,13 @@ static int mp_get_media_attribute(struct media_player 
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
 
+		snprintf(valstr, 20, "%u", mi->track_len);
+		len = strlen(valstr);
+		memcpy(elem->val, valstr, len);
 		break;
 	default:
 		return -EINVAL;
@@ -1126,7 +1121,7 @@ static int avrcp_handle_get_element_attributes(struct 
control *control,
 		 * Return all available information, at least
 		 * title must be returned.
 		 */
-		for (i = 1; i <= MEDIA_INFO_CURRENT_POSITION; i++) {
+		for (i = 1; i <= MEDIA_INFO_LAST; i++) {
 			size = mp_get_media_attribute(control->mp, i,
 							&pdu->params[pos]);
 
-- 
1.7.3.4


Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: David Stockwell <dstockwell@frequency-one.com>
Subject: [PATCH 4/5] avrcp: fix handling of metadata item 0x7
Date: Thu, 15 Sep 2011 01:21:36 -0300
Message-Id: <1316060497-4068-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1316060497-4068-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1316060497-4068-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: David Stockwell <dstockwell@frequency-one.com>

Metadata field number 0x7 should be the total playing time of the track
(TrackDuration) in msec, not current position within track.
---
 audio/avrcp.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index f7f3924..835249b 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -141,7 +141,7 @@ enum media_info_id {
 	MEDIA_INFO_TRACK =		4,
 	MEDIA_INFO_N_TRACKS =		5,
 	MEDIA_INFO_GENRE =		6,
-	MEDIA_INFO_CURRENT_POSITION =	7,
+	MEDIA_INFO_PLAYING_TIME =	7,
 	MEDIA_INFO_LAST
 };
 
@@ -690,19 +690,13 @@ static int mp_get_media_attribute(struct media_player *mp,
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
+		if (mi->track_len == 0xFFFFFFFF)
 			return -ENOENT;
-		}
 
+		snprintf(valstr, 20, "%u", mi->track_len);
+		len = strlen(valstr);
+		memcpy(elem->val, valstr, len);
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.6.1


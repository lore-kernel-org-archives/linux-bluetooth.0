Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/2] AVRCP: return empty string instead of rejecting
Date: Wed, 28 Sep 2011 19:35:56 -0300
Message-Id: <1317249357-1362-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If media attribute is not available for a certain media file, return an
empty string instead of rejecting the request. The spec is not so clear
if only the title should be handled as an empty string when not present,
but this is the only alternative to rejecting the request.

IOP tests showed that some CT devices don't like reject messages: they
never ask for an attribute again if they previously received a REJECTED
message for that attribute. They consider REJECTED as "TG doesn't
implement it these optional attributes" as opposed to what we had
before, "this attribute is currently not available".
---
 audio/avrcp.c |   41 +++++++++++++++++++----------------------
 1 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index ba04a12..e7b0d1b 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -678,46 +678,43 @@ static int mp_get_media_attribute(struct media_player *mp,
 		valp = mi->title;
 		break;
 	case MEDIA_INFO_ARTIST:
-		if (mi->artist == NULL)
-			return -ENOENT;
-
 		valp = mi->artist;
 		break;
 	case MEDIA_INFO_ALBUM:
-		if (mi->album == NULL)
-			return -ENOENT;
-
 		valp = mi->album;
 		break;
 	case MEDIA_INFO_GENRE:
-		if (mi->genre == NULL)
-			return -ENOENT;
-
 		valp = mi->genre;
 		break;
 	case MEDIA_INFO_TRACK:
-		if (!mi->track)
-			return -ENOENT;
+		if (mi->track) {
+			snprintf(valstr, 20, "%u", mi->track);
+			valp = valstr;
+		} else {
+			valp = NULL;
+		}
 
-		snprintf(valstr, 20, "%u", mi->track);
-		valp = valstr;
 		break;
 	case MEDIA_INFO_N_TRACKS:
-		if (!mi->ntracks)
-			return -ENOENT;
+		if (mi->ntracks) {
+			snprintf(valstr, 20, "%u", mi->ntracks);
+			valp = valstr;
+		} else {
+			valp = NULL;
+		}
 
-		snprintf(valstr, 20, "%u", mi->ntracks);
-		valp = valstr;
 		break;
 	case MEDIA_INFO_PLAYING_TIME:
-		if (mi->track_len == 0xFFFFFFFF)
-			return -ENOENT;
+		if (mi->track_len == 0xFFFFFFFF) {
+			snprintf(valstr, 20, "%u", mi->track_len);
+			valp = valstr;
+		} else {
+			valp = NULL;
+		}
 
-		snprintf(valstr, 20, "%u", mi->track_len);
-		valp = valstr;
 		break;
 	default:
-		return -EINVAL;
+		return -ENOENT;
 	}
 
 	if (valp) {
-- 
1.7.6.4


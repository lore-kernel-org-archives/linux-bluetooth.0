Return-Path: <cyrus@holtmann.org>
From: s.nageshmurt@samsung.com
To: linux-bluetooth@vger.kernel.org
Cc: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
Subject: [PATCH 1/1] audio/media: Parse total number of tracks metadata
Date: Fri, 21 Nov 2014 11:09:28 +0530
Message-id: <1416548368-30935-1-git-send-email-s.nageshmurt@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sagar Nageshmurthy <s.nageshmurt@samsung.com>

Currently Bluez ignores NumberOfTracks metadata. Hence parse totalTracks
key to update NumberOfTracks info.
---
 profiles/audio/media.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index ef7b910..66b75b3 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1505,6 +1505,9 @@ static gboolean parse_player_metadata(struct media_player *mp,
 		} else if (strcasecmp(key, "mpris:length") == 0) {
 			if (!parse_int64_metadata(mp, "Duration", &var))
 				return FALSE;
+		} else if (strcasecmp(key, "xesam:totalTracks") == 0) {
+			if (!parse_int32_metadata(mp, "NumberOfTracks", &var))
+				return FALSE;
 		} else if (strcasecmp(key, "xesam:trackNumber") == 0) {
 			if (!parse_int32_metadata(mp, "TrackNumber", &var))
 				return FALSE;
-- 
1.7.9.5


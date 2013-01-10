Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/13 v2] player: Fix documentation to use TrackNumber in track metadata
Date: Thu, 10 Jan 2013 15:37:09 +0200
Message-Id: <1357825038-21970-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
References: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Using Track key inside a Track property would be pointless, despite the
documentation and code where also inconsistent.
---
 doc/media-api.txt       | 2 +-
 profiles/audio/avrcp.c  | 2 +-
 profiles/audio/player.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index ae4b0dd..abf5ff9 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -272,7 +272,7 @@ Properties	string Equalizer [readwrite]
 
 					Number of tracks in total
 
-				uint32 Number:
+				uint32 TrackNumber:
 
 					Track number
 
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 9ca5a3a..3366b48 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -649,7 +649,7 @@ static const char *metadata_to_str(uint32_t id)
 	case AVRCP_MEDIA_ATTRIBUTE_GENRE:
 		return "Genre";
 	case AVRCP_MEDIA_ATTRIBUTE_TRACK:
-		return "Track";
+		return "TrackNumber";
 	case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
 		return "NumberOfTracks";
 	case AVRCP_MEDIA_ATTRIBUTE_DURATION:
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 2e5c386..880745d 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -72,7 +72,7 @@ static void append_metadata(void *key, void *value, void *user_data)
 	DBusMessageIter *dict = user_data;
 
 	if (strcasecmp((char *) key, "Duration") == 0 ||
-			strcasecmp((char *) key, "Track") == 0 ||
+			strcasecmp((char *) key, "TrackNumber") == 0 ||
 			strcasecmp((char *) key, "NumberOfTracks") == 0)  {
 		uint32_t num = atoi(value);
 		dict_append_entry(dict, key, DBUS_TYPE_UINT32, &num);
-- 
1.8.0.1


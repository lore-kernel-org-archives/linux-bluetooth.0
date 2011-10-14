Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/5] AVRCP: respond with UINT32_MAX if duration is not available
Date: Fri, 14 Oct 2011 18:28:30 -0300
Message-Id: <1318627712-9725-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318627712-9725-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318627712-9725-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Section 5.4.1 of AVRCP 1.3 spec says:

	If TG does not support SongLength And SongPosition on TG, then TG shall
	return 0xFFFFFFFF.

SongPosition is always available, but song length depends on user to
provied it.
---
 audio/avrcp.c     |    2 +-
 doc/media-api.txt |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 8b48e83..1b55e33 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -808,7 +808,7 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp_player *player,
 						AVRCP_MEDIA_ATTRIBUTE_DURATION,
 						player->user_data));
 
-	duration = htonl(duration);
+	duration = duration ? htonl(duration) : UINT32_MAX;
 	position = htonl(position);
 
 	memcpy(&pdu->params[0], &duration, 4);
diff --git a/doc/media-api.txt b/doc/media-api.txt
index b8dcdbd..204f33e 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -114,7 +114,9 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 
 				uint32 Duration:
 
-					Track duration in milliseconds
+					Track duration in milliseconds. If it's
+					set to 0 or left blank, it will be
+					treated as not available.
 
 			Possible Errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.NotSupported
-- 
1.7.7


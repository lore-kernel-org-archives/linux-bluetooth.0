Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/2] AVRCP: do not allow CT to set a property not supported
Date: Thu,  6 Oct 2011 08:49:45 -0300
Message-Id: <1317901785-1757-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1317901785-1757-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1317901785-1757-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If player never set a property, it means it doesn't support it. Doesn't
allow the remote side to set it and send a REJECTED response.
---
 audio/media.c     |    3 +++
 doc/media-api.txt |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 9057d70..8d7b65b 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1126,6 +1126,9 @@ static int set_setting(uint8_t attr, uint8_t val, void *user_data)
 	if (property == NULL || value == NULL)
 		return -EINVAL;
 
+	if (!g_hash_table_lookup(mp->settings, GUINT_TO_POINTER(attr)))
+		return -EINVAL;
+
 	msg = dbus_message_new_method_call(mp->sender, mp->path,
 						MEDIA_PLAYER_INTERFACE,
 						"SetProperty");
diff --git a/doc/media-api.txt b/doc/media-api.txt
index af4cfa0..7dc7661 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -133,7 +133,7 @@ Object path	freely definable
 Methods		void SetProperty(string property, variant value)
 
 			Changes the value of the specified property. Only
-			properties that are listed a read-write can be changed.
+			properties that are listed as read-write can be changed.
 
 			On success this will emit a PropertyChanged signal.
 
-- 
1.7.7


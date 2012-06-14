Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] audio: Remove remaining references to Socket
Date: Thu, 14 Jun 2012 16:41:10 +0300
Message-Id: <1339681270-24425-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1339681270-24425-1-git-send-email-luiz.dentz@gmail.com>
References: <1339681270-24425-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 audio/audio.conf |    2 +-
 audio/manager.c  |    5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/audio/audio.conf b/audio/audio.conf
index 290c36f..393cf85 100644
--- a/audio/audio.conf
+++ b/audio/audio.conf
@@ -9,7 +9,7 @@
 
 # If we want to disable support for specific services
 # Defaults to supporting all implemented services
-#Disable=Gateway,Source,Socket
+#Disable=Gateway,Source
 
 # SCO routing. Either PCM or HCI (in which case audio is routed to/from ALSA)
 # Defaults to HCI
diff --git a/audio/manager.c b/audio/manager.c
index faa48de..c242094 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -113,7 +113,6 @@ static struct enabled_interfaces enabled = {
 	.sink		= TRUE,
 	.source		= FALSE,
 	.control	= TRUE,
-	.socket		= FALSE,
 	.media		= TRUE,
 };
 
@@ -1182,8 +1181,6 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 			enabled.source = TRUE;
 		else if (g_str_equal(list[i], "Control"))
 			enabled.control = TRUE;
-		else if (g_str_equal(list[i], "Socket"))
-			enabled.socket = TRUE;
 		else if (g_str_equal(list[i], "Media"))
 			enabled.media = TRUE;
 
@@ -1203,8 +1200,6 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 			enabled.source = FALSE;
 		else if (g_str_equal(list[i], "Control"))
 			enabled.control = FALSE;
-		else if (g_str_equal(list[i], "Socket"))
-			enabled.socket = FALSE;
 		else if (g_str_equal(list[i], "Media"))
 			enabled.media = FALSE;
 	}
-- 
1.7.10.2


Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5 v2] audio: Remove remaining references to Socket
Date: Mon, 25 Jun 2012 12:06:19 +0300
Message-Id: <1340615179-368-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1340615179-368-1-git-send-email-luiz.dentz@gmail.com>
References: <1340615179-368-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 audio/audio.conf |    2 +-
 audio/manager.c  |    5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/audio/audio.conf b/audio/audio.conf
index 05ecfd7..7ad6dc0 100644
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
index 3eefac6..b7e8c8a 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -112,7 +112,6 @@ static struct enabled_interfaces enabled = {
 	.sink		= TRUE,
 	.source		= FALSE,
 	.control	= TRUE,
-	.socket		= FALSE,
 	.media		= TRUE,
 };
 
@@ -1181,8 +1180,6 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 			enabled.source = TRUE;
 		else if (g_str_equal(list[i], "Control"))
 			enabled.control = TRUE;
-		else if (g_str_equal(list[i], "Socket"))
-			enabled.socket = TRUE;
 		else if (g_str_equal(list[i], "Media"))
 			enabled.media = TRUE;
 
@@ -1202,8 +1199,6 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
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


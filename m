Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Fix A2DP Sink/Source recognition
Date: Fri, 18 May 2012 17:54:11 +0900
Message-id: <1337331254-30749-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 audio/a2dp.c     |    8 ++++----
 audio/audio.conf |    2 +-
 audio/manager.c  |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index cc8f139..145dcf6 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1406,9 +1406,9 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 		g_clear_error(&err);
 	} else {
 		if (strstr(str, "Sink"))
-			source = TRUE;
-		if (strstr(str, "Source"))
 			sink = TRUE;
+		if (strstr(str, "Source"))
+			source = TRUE;
 		if (strstr(str, "Socket"))
 			socket = TRUE;
 		g_free(str);
@@ -1421,9 +1421,9 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 		g_clear_error(&err);
 	} else {
 		if (strstr(str, "Sink"))
-			source = FALSE;
-		if (strstr(str, "Source"))
 			sink = FALSE;
+		if (strstr(str, "Source"))
+			source = FALSE;
 		if (strstr(str, "Socket"))
 			socket = FALSE;
 		g_free(str);
diff --git a/audio/audio.conf b/audio/audio.conf
index fd6092a..1abdab9 100644
--- a/audio/audio.conf
+++ b/audio/audio.conf
@@ -9,7 +9,7 @@
 
 # If we want to disable support for specific services
 # Defaults to supporting all implemented services
-#Disable=Gateway,Source,Socket
+#Disable=Gateway,Sink,Socket
 
 # SCO routing. Either PCM or HCI (in which case audio is routed to/from ALSA)
 # Defaults to HCI
diff --git a/audio/manager.c b/audio/manager.c
index 9c7d0d3..9e5c71c 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -114,8 +114,8 @@ static struct enabled_interfaces enabled = {
 	.hfp		= TRUE,
 	.headset	= TRUE,
 	.gateway	= FALSE,
-	.sink		= TRUE,
-	.source		= FALSE,
+	.sink		= FALSE,
+	.source		= TRUE,
 	.control	= TRUE,
 	.socket		= FALSE,
 	.media		= TRUE,
-- 
1.7.9.5


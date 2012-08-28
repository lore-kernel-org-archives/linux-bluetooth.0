Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] audio: remove redundant Media API option
Date: Tue, 28 Aug 2012 19:24:52 +0900
Message-id: <1346149495-9363-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

BlueZ supports only Media API. So option handler's are useless.
---
 audio/audio.conf |    2 +-
 audio/manager.c  |   12 ++----------
 audio/manager.h  |    2 --
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/audio/audio.conf b/audio/audio.conf
index 662647c..d1c57d3 100644
--- a/audio/audio.conf
+++ b/audio/audio.conf
@@ -8,7 +8,7 @@
 #Master=true
 
 # If we want to disable support for specific services
-# Defaults to supporting the services: HFP, Headset, Sink, Control and Media
+# Defaults to supporting the services: HFP, Headset, Sink, Control
 #Disable=Gateway,Source
 
 # SCO routing. Either PCM or HCI (in which case audio is routed to/from ALSA)
diff --git a/audio/manager.c b/audio/manager.c
index 999124d..6411707 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -112,7 +112,6 @@ static struct enabled_interfaces enabled = {
 	.sink		= TRUE,
 	.source		= FALSE,
 	.control	= TRUE,
-	.media		= TRUE,
 };
 
 static struct audio_adapter *find_adapter(GSList *list,
@@ -1180,9 +1179,6 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 			enabled.source = TRUE;
 		else if (g_str_equal(list[i], "Control"))
 			enabled.control = TRUE;
-		else if (g_str_equal(list[i], "Media"))
-			enabled.media = TRUE;
-
 	}
 	g_strfreev(list);
 
@@ -1199,8 +1195,6 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 			enabled.source = FALSE;
 		else if (g_str_equal(list[i], "Control"))
 			enabled.control = FALSE;
-		else if (g_str_equal(list[i], "Media"))
-			enabled.media = FALSE;
 	}
 	g_strfreev(list);
 
@@ -1231,8 +1225,7 @@ proceed:
 	if (enabled.control)
 		btd_register_adapter_driver(&avrcp_server_driver);
 
-	if (enabled.media)
-		btd_register_adapter_driver(&media_server_driver);
+	btd_register_adapter_driver(&media_server_driver);
 
 	if (enabled.headset)
 		btd_register_adapter_driver(&headset_server_driver);
@@ -1264,8 +1257,7 @@ void audio_manager_exit(void)
 		config = NULL;
 	}
 
-	if (enabled.media)
-		btd_unregister_adapter_driver(&media_server_driver);
+	btd_unregister_adapter_driver(&media_server_driver);
 
 	if (enabled.headset)
 		btd_unregister_adapter_driver(&headset_server_driver);
diff --git a/audio/manager.h b/audio/manager.h
index f1d3021..3c8b1e0 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -29,8 +29,6 @@ struct enabled_interfaces {
 	gboolean sink;
 	gboolean source;
 	gboolean control;
-	gboolean socket;
-	gboolean media;
 	gboolean media_player;
 };
 
-- 
1.7.9.5


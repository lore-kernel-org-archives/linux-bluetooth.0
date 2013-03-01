Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] audio: Remove profile enabling/disabling logic
Date: Fri,  1 Mar 2013 14:26:11 +0200
Message-Id: <1362140773-13672-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This should be handle by the core for all profiles
---
 profiles/audio/audio.conf |  4 ---
 profiles/audio/manager.c  | 62 ++++++-----------------------------------------
 2 files changed, 8 insertions(+), 58 deletions(-)

diff --git a/profiles/audio/audio.conf b/profiles/audio/audio.conf
index f556610..067b3fc 100644
--- a/profiles/audio/audio.conf
+++ b/profiles/audio/audio.conf
@@ -6,7 +6,3 @@
 
 # Switch to master role for incoming connections (defaults to true)
 #Master=true
-
-# If we want to disable support for specific services
-# Defaults to supporting the services: Sink, Control
-#Disable=Source
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 934227e..42a2b58 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -70,12 +70,6 @@
 static GKeyFile *config = NULL;
 static GSList *devices = NULL;
 
-static struct enabled_interfaces enabled = {
-	.sink		= TRUE,
-	.source		= FALSE,
-	.control	= TRUE,
-};
-
 static struct audio_device *get_audio_dev(struct btd_device *device)
 {
 	return manager_get_audio_device(device, TRUE);
@@ -410,47 +404,12 @@ void audio_control_disconnected(struct btd_device *dev, int err)
 
 int audio_manager_init(GKeyFile *conf)
 {
-	char **list;
-	int i;
-
-	if (!conf)
-		goto proceed;
-
-	config = conf;
-
-	list = g_key_file_get_string_list(config, "General", "Enable",
-						NULL, NULL);
-	for (i = 0; list && list[i] != NULL; i++) {
-		if (g_str_equal(list[i], "Sink"))
-			enabled.sink = TRUE;
-		else if (g_str_equal(list[i], "Source"))
-			enabled.source = TRUE;
-		else if (g_str_equal(list[i], "Control"))
-			enabled.control = TRUE;
-	}
-	g_strfreev(list);
-
-	list = g_key_file_get_string_list(config, "General", "Disable",
-						NULL, NULL);
-	for (i = 0; list && list[i] != NULL; i++) {
-		if (g_str_equal(list[i], "Sink"))
-			enabled.sink = FALSE;
-		else if (g_str_equal(list[i], "Source"))
-			enabled.source = FALSE;
-		else if (g_str_equal(list[i], "Control"))
-			enabled.control = FALSE;
-	}
-	g_strfreev(list);
+	if (conf)
+		config = conf;
 
-proceed:
-	if (enabled.source)
-		btd_profile_register(&a2dp_source_profile);
-
-	if (enabled.sink)
-		btd_profile_register(&a2dp_sink_profile);
-
-	if (enabled.control)
-		btd_profile_register(&avrcp_profile);
+	btd_profile_register(&a2dp_source_profile);
+	btd_profile_register(&a2dp_sink_profile);
+	btd_profile_register(&avrcp_profile);
 
 	btd_register_adapter_driver(&media_driver);
 
@@ -464,14 +423,9 @@ void audio_manager_exit(void)
 		config = NULL;
 	}
 
-	if (enabled.source)
-		btd_profile_unregister(&a2dp_source_profile);
-
-	if (enabled.sink)
-		btd_profile_unregister(&a2dp_sink_profile);
-
-	if (enabled.control)
-		btd_profile_unregister(&avrcp_profile);
+	btd_profile_unregister(&a2dp_source_profile);
+	btd_profile_unregister(&a2dp_sink_profile);
+	btd_profile_unregister(&avrcp_profile);
 
 	btd_unregister_adapter_driver(&media_driver);
 }
-- 
1.8.1.2


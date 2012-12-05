Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] audio: Remove left over of HFP removal
Date: Wed, 05 Dec 2012 19:16:34 +0900
Message-id: <1354702595-5040-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/audio.conf |   21 ++-------------------
 profiles/audio/manager.c  |   10 ----------
 2 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/profiles/audio/audio.conf b/profiles/audio/audio.conf
index 6bf4482..12b9c55 100644
--- a/profiles/audio/audio.conf
+++ b/profiles/audio/audio.conf
@@ -8,12 +8,8 @@
 #Master=true
 
 # If we want to disable support for specific services
-# Defaults to supporting the services: HFP, Headset, Sink, Control
-#Disable=Gateway,Source
-
-# SCO routing. Either PCM or HCI (in which case audio is routed to/from ALSA)
-# Defaults to HCI
-#SCORouting=PCM
+# Defaults to supporting the services: Sink, Control
+#Disable=Source
 
 # Automatically connect both A2DP and HFP/HSP profiles for incoming
 # connections. Some headsets that support both profiles will only connect the
@@ -21,16 +17,3 @@
 # idea.
 #AutoConnect=true
 
-# Headset interface specific options (i.e. options which affect how the audio
-# service interacts with remote headset devices)
-[Headset]
-
-# Maximum number of connected HSP/HFP devices per adapter. Defaults to 1
-MaxConnected=1
-
-# Set to true to enable use of fast connectable mode (faster page scanning)
-# for HFP when incoming call starts. Default settings are restored after
-# call is answered or rejected. Page scan interval is much shorter and page
-# scan type changed to interlaced. Such allows faster connection initiated
-# by a headset.
-FastConnectable=false
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 714489a..4e0c631 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -81,7 +81,6 @@ struct profile_req {
 };
 
 static gboolean auto_connect = TRUE;
-static int max_connected_headsets = 1;
 static GKeyFile *config = NULL;
 static GSList *adapters = NULL;
 static GSList *devices = NULL;
@@ -619,15 +618,6 @@ int audio_manager_init(GKeyFile *conf)
 	} else
 		auto_connect = b;
 
-	err = NULL;
-	i = g_key_file_get_integer(config, "Headset", "MaxConnected",
-					&err);
-	if (err) {
-		DBG("audio.conf: %s", err->message);
-		g_clear_error(&err);
-	} else
-		max_connected_headsets = i;
-
 proceed:
 	if (enabled.source)
 		btd_profile_register(&a2dp_source_profile);
-- 
1.7.9.5


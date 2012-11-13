Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/13] audio: Remove HFP option from audio.conf
Date: Tue, 13 Nov 2012 15:21:07 +0200
Message-Id: <1352812880-7306-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
References: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It is not in use anymore
---
 audio/audio.conf | 4 ----
 audio/manager.c  | 8 --------
 audio/manager.h  | 1 -
 3 files changed, 13 deletions(-)

diff --git a/audio/audio.conf b/audio/audio.conf
index d1c57d3..6bf4482 100644
--- a/audio/audio.conf
+++ b/audio/audio.conf
@@ -25,10 +25,6 @@
 # service interacts with remote headset devices)
 [Headset]
 
-# Set to true to support HFP, false means only HSP is supported
-# Defaults to true
-HFP=true
-
 # Maximum number of connected HSP/HFP devices per adapter. Defaults to 1
 MaxConnected=1
 
diff --git a/audio/manager.c b/audio/manager.c
index 26dde60..e949509 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -90,7 +90,6 @@ static GSList *adapters = NULL;
 static GSList *devices = NULL;
 
 static struct enabled_interfaces enabled = {
-	.hfp		= TRUE,
 	.gateway	= FALSE,
 	.sink		= TRUE,
 	.source		= FALSE,
@@ -674,13 +673,6 @@ int audio_manager_init(GKeyFile *conf, gboolean *enable_sco)
 	} else
 		auto_connect = b;
 
-	b = g_key_file_get_boolean(config, "Headset", "HFP",
-					&err);
-	if (err)
-		g_clear_error(&err);
-	else
-		enabled.hfp = b;
-
 	err = NULL;
 	i = g_key_file_get_integer(config, "Headset", "MaxConnected",
 					&err);
diff --git a/audio/manager.h b/audio/manager.h
index 08d814f..8fb208c 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -23,7 +23,6 @@
  */
 
 struct enabled_interfaces {
-	gboolean hfp;
 	gboolean headset;
 	gboolean gateway;
 	gboolean sink;
-- 
1.7.11.7


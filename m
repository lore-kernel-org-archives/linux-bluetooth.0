Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] audio: Remove left over of HFP removal
Date: Wed, 05 Dec 2012 11:27:56 +0900
Message-id: <1354674477-25835-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 profiles/audio/main.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/profiles/audio/main.c b/profiles/audio/main.c
index ce060fc..c5d1426 100644
--- a/profiles/audio/main.c
+++ b/profiles/audio/main.c
@@ -44,8 +44,6 @@
 #include "device.h"
 #include "manager.h"
 
-static GIOChannel *sco_server = NULL;
-
 static GKeyFile *load_config_file(const char *file)
 {
 	GError *err = NULL;
@@ -81,12 +79,6 @@ static int audio_init(void)
 
 static void audio_exit(void)
 {
-	if (sco_server) {
-		g_io_channel_shutdown(sco_server, TRUE, NULL);
-		g_io_channel_unref(sco_server);
-		sco_server = NULL;
-	}
-
 	audio_manager_exit();
 }
 
-- 
1.7.9.5


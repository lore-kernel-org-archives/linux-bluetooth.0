Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio: enable Media API by default
Date: Sun, 20 Nov 2011 20:09:07 +0200
Message-Id: <1321812547-21105-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces unix socket IPC which is considered deprecated and will
eventually be removed.
---
 audio/manager.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 3f167da..07273f4 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -118,8 +118,8 @@ static struct enabled_interfaces enabled = {
 	.sink		= TRUE,
 	.source		= FALSE,
 	.control	= TRUE,
-	.socket		= TRUE,
-	.media		= FALSE,
+	.socket		= FALSE,
+	.media		= TRUE,
 };
 
 static struct audio_adapter *find_adapter(GSList *list,
-- 
1.7.7.1


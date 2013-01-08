Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] audio: Remove unused struct audio_adapter
Date: Tue, 08 Jan 2013 17:07:48 +0530
Message-id: <1357645069-30841-4-git-send-email-s.syam@samsung.com>
In-reply-to: <1357645069-30841-1-git-send-email-s.syam@samsung.com>
References: <1357645069-30841-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/manager.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index dc20712..f0df8ed 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -67,12 +67,6 @@
 #include "manager.h"
 #include "sdpd.h"
 
-struct audio_adapter {
-	struct btd_adapter *btd_adapter;
-	gboolean powered;
-	gint ref;
-};
-
 static GKeyFile *config = NULL;
 static GSList *devices = NULL;
 
-- 
1.7.9.5


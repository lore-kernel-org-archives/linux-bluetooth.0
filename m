Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] audio: Remove unused enum values
Date: Tue, 28 Aug 2012 19:24:53 +0900
Message-id: <1346149495-9363-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1346149495-9363-1-git-send-email-chanyeol.park@samsung.com>
References: <1346149495-9363-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 audio/manager.c |   17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 6411707..7634a68 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -69,23 +69,6 @@
 #include "sdpd.h"
 #include "telephony.h"
 
-typedef enum {
-	HEADSET	= 1 << 0,
-	GATEWAY	= 1 << 1,
-	SINK	= 1 << 2,
-	SOURCE	= 1 << 3,
-	CONTROL	= 1 << 4,
-	TARGET	= 1 << 5,
-	INVALID	= 1 << 6
-} audio_service_type;
-
-typedef enum {
-		GENERIC_AUDIO = 0,
-		ADVANCED_AUDIO,
-		AV_REMOTE,
-		GET_RECORDS
-} audio_sdp_state_t;
-
 struct audio_adapter {
 	struct btd_adapter *btd_adapter;
 	gboolean powered;
-- 
1.7.9.5


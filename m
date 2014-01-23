Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/2] android/hal-audio: Don't try to unregister endpoints on handler exit
Date: Thu, 23 Jan 2014 16:22:28 +0100
Message-Id: <1390490548-19697-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1390490548-19697-1-git-send-email-szymon.janc@tieto.com>
References: <1390490548-19697-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

audio_sk is already closed at this point so just cleanup any leftovers
in enpoints states.
---
 android/hal-audio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 52f8894..6104183 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -1378,7 +1378,8 @@ static void *ipc_handler(void *data)
 		}
 	}
 
-	unregister_endpoints();
+	/* audio_sk is closed at this point, just cleanup endpoints states */
+	memset(audio_endpoints, 0, sizeof(audio_endpoints));
 
 	info("Closing Audio IPC thread");
 	return NULL;
-- 
1.8.3.2


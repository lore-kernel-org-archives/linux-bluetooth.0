Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] android/hal-audio: Use hal-utils helpers for unaligned access
Date: Fri, 26 Sep 2014 15:42:18 +0200
Message-Id: <1411738938-29524-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411738938-29524-1-git-send-email-szymon.janc@tieto.com>
References: <1411738938-29524-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 1bbc073..e70351e 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -35,7 +35,7 @@
 #include "hal-log.h"
 #include "hal-msg.h"
 #include "hal-audio.h"
-#include "src/shared/util.h"
+#include "hal-utils.h"
 
 #define FIXED_A2DP_PLAYBACK_LATENCY_MS 25
 
@@ -588,10 +588,10 @@ static void downmix_to_mono(struct a2dp_stream_out *out, const uint8_t *buffer,
 	frames = bytes / (2 * sizeof(int16_t));
 
 	for (i = 0; i < frames; i++) {
-		int16_t l = le16_to_cpu(get_unaligned(&input[i * 2]));
-		int16_t r = le16_to_cpu(get_unaligned(&input[i * 2 + 1]));
+		int16_t l = get_le16(&input[i * 2]);
+		int16_t r = get_le16(&input[i * 2 + 1]);
 
-		put_unaligned(cpu_to_le16((l + r) / 2), &output[i]);
+		put_le16((l + r) / 2, &output[i]);
 	}
 }
 
-- 
1.9.1


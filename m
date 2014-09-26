Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/5] android/hal-sco: Use hal-utils helpers for unaligned access
Date: Fri, 26 Sep 2014 15:42:17 +0200
Message-Id: <1411738938-29524-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411738938-29524-1-git-send-email-szymon.janc@tieto.com>
References: <1411738938-29524-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-sco.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 8cb7a7c..91a3baf 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -29,7 +29,7 @@
 #include <hardware/hardware.h>
 #include <audio_utils/resampler.h>
 
-#include "../src/shared/util.h"
+#include "hal-utils.h"
 #include "sco-msg.h"
 #include "ipc-common.h"
 #include "hal-log.h"
@@ -311,10 +311,10 @@ static void downmix_to_mono(struct sco_stream_out *out, const uint8_t *buffer,
 	size_t i;
 
 	for (i = 0; i < frame_num; i++) {
-		int16_t l = le16_to_cpu(get_unaligned(&input[i * 2]));
-		int16_t r = le16_to_cpu(get_unaligned(&input[i * 2 + 1]));
+		int16_t l = get_le16(&input[i * 2]);
+		int16_t r = get_le16(&input[i * 2 + 1]);
 
-		put_unaligned(cpu_to_le16((l + r) >> 1), &output[i]);
+		put_le16((l + r) / 2, &output[i]);
 	}
 }
 
-- 
1.9.1


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/13] android/hal-audio: Fix compilation errors with musl
Date: Fri, 19 Sep 2014 16:10:06 +0200
Message-Id: <1411135816-18966-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
References: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  CC       android/android_audio_a2dp_default_la-hal-audio-sbc.lo
android/hal-audio-sbc.c: In function 'sbc_codec_init':
android/hal-audio-sbc.c:269:2: error: implicit declaration of function
    'calloc' [-Werror=implicit-function-declaration]
  sbc_data = calloc(sizeof(struct sbc_data), 1);
  ^
android/hal-audio-sbc.c:269:13: error: incompatible implicit
    declaration of built-in function 'calloc' [-Werror]
  sbc_data = calloc(sizeof(struct sbc_data), 1);
             ^
android/hal-audio-sbc.c: In function 'sbc_cleanup':
android/hal-audio-sbc.c:291:2: error: implicit declaration of function
   'free' [-Werror=implicit-function-declaration]
  free(codec_data);
  ^
android/hal-audio-sbc.c:291:2: error: incompatible implicit declaration
    of built-in function 'free' [-Werror]
cc1: all warnings being treated as errors
---
 android/hal-audio-sbc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/hal-audio-sbc.c b/android/hal-audio-sbc.c
index 0c31035..7ad3a6a 100644
--- a/android/hal-audio-sbc.c
+++ b/android/hal-audio-sbc.c
@@ -18,6 +18,7 @@
 #include <stdbool.h>
 #include <string.h>
 #include <malloc.h>
+#include <stdlib.h>
 
 #include <sbc/sbc.h>
 #include "audio-msg.h"
-- 
1.9.3


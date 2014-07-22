Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/client: Rearrange headers include
Date: Tue, 22 Jul 2014 10:42:53 +0300
Message-Id: <1406014973-14498-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Streamline headers include for if-audio HAL client
---
 android/client/if-audio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 6a48025..f3f87fb 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -15,11 +15,12 @@
  *
  */
 
+#include <pthread.h>
+#include <unistd.h>
+#include <math.h>
+
 #include "if-main.h"
 #include "../hal-utils.h"
-#include "pthread.h"
-#include "unistd.h"
-#include <math.h>
 
 audio_hw_device_t *if_audio = NULL;
 static struct audio_stream_out *stream_out = NULL;
-- 
1.9.1


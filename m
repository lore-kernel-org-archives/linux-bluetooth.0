Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tools: Rearrange headers include
Date: Mon, 21 Jul 2014 14:05:16 +0300
Message-Id: <1405940716-9853-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-sco.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index 456c529..4919fd9 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -15,13 +15,13 @@
  *
  */
 
-#include "../src/shared/util.h"
+#include <pthread.h>
+#include <unistd.h>
+#include <math.h>
 
+#include "../src/shared/util.h"
 #include "if-main.h"
 #include "../hal-utils.h"
-#include "pthread.h"
-#include "unistd.h"
-#include <math.h>
 
 audio_hw_device_t *if_audio_sco = NULL;
 static struct audio_stream_out *stream_out = NULL;
-- 
1.9.1


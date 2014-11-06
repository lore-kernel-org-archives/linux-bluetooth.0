Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 11/15] android/hardware: Update audio_effect.h header
Date: Thu,  6 Nov 2014 17:05:56 +0200
Message-Id: <1415286360-26268-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hardware/audio_effect.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/hardware/audio_effect.h b/android/hardware/audio_effect.h
index 857a300..ee48e4c 100644
--- a/android/hardware/audio_effect.h
+++ b/android/hardware/audio_effect.h
@@ -24,8 +24,11 @@
 #include <sys/cdefs.h>
 #include <sys/types.h>
 
+#include <cutils/bitops.h>
+
 #include <system/audio.h>
 
+
 __BEGIN_DECLS
 
 
@@ -812,7 +815,7 @@ typedef struct buffer_config_s {
     uint32_t   samplingRate;    // sampling rate
     uint32_t   channels;        // channel mask (see audio_channel_mask_t in audio.h)
     buffer_provider_t bufferProvider;   // buffer provider
-    uint8_t    format;          // Audio format  (see see audio_format_t in audio.h)
+    uint8_t    format;          // Audio format (see audio_format_t in audio.h)
     uint8_t    accessMode;      // read/write or accumulate in buffer (effect_buffer_access_e)
     uint16_t   mask;            // indicates which of the above fields is valid
 } buffer_config_t;
-- 
1.9.1


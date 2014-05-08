Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 09/12] audio/haltest: Make audio_stream static
Date: Thu,  8 May 2014 11:01:40 +0300
Message-Id: <1399536103-19052-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index ede8533..6a48025 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -22,7 +22,7 @@
 #include <math.h>
 
 audio_hw_device_t *if_audio = NULL;
-struct audio_stream_out *stream_out = NULL;
+static struct audio_stream_out *stream_out = NULL;
 
 static size_t buffer_size = 0;
 static pthread_t play_thread = 0;
-- 
1.8.3.2


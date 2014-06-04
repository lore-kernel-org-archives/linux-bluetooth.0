Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 23/28] android/hal-sco: Choose buffer size
Date: Wed,  4 Jun 2014 17:17:54 +0300
Message-Id: <1401891479-11965-23-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For 8k choose buffer size 576 which is multiple from 48 and 64.
---
 android/hal-sco.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 5b05601..fe0d98c 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -40,7 +40,7 @@
 
 #define OUT_BUFFER_SIZE			2560
 #define OUT_STREAM_FRAMES		2560
-#define IN_STREAM_FRAMES		/* 5292 */ 5120
+#define IN_STREAM_FRAMES		5292
 
 #define SOCKET_POLL_TIMEOUT_MS		500
 
@@ -490,6 +490,10 @@ static size_t out_get_buffer_size(const struct audio_stream *stream)
 	size_t size = audio_stream_frame_size(&out->stream.common) *
 							out->cfg.frame_num;
 
+	/* buffer size without resampling */
+	if (out->cfg.rate == AUDIO_STREAM_SCO_RATE)
+		size = 576 * 2;
+
 	DBG("buf size %zd", size);
 
 	return size;
@@ -836,6 +840,10 @@ static size_t in_get_buffer_size(const struct audio_stream *stream)
 	size_t size = audio_stream_frame_size(&in->stream.common) *
 							in->cfg.frame_num;
 
+	/* buffer size without resampling */
+	if (in->cfg.rate == AUDIO_STREAM_SCO_RATE)
+		size = 576;
+
 	DBG("buf size %zd", size);
 
 	return size;
-- 
1.8.3.2


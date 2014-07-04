Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 23/32] android/hal-sco: Choose buffer size
Date: Fri,  4 Jul 2014 16:47:08 +0300
Message-Id: <1404481637-900-24-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For 8k choose buffer size 576 which is multiple from 48 and 64.
---
 android/hal-sco.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 9bf9a19..ff85210 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -40,7 +40,7 @@
 
 #define OUT_BUFFER_SIZE			2560
 #define OUT_STREAM_FRAMES		2560
-#define IN_STREAM_FRAMES		/* 5292 */ 5120
+#define IN_STREAM_FRAMES		5292
 
 #define SOCKET_POLL_TIMEOUT_MS		500
 
@@ -492,6 +492,10 @@ static size_t out_get_buffer_size(const struct audio_stream *stream)
 	size_t size = audio_stream_frame_size(&out->stream.common) *
 							out->cfg.frame_num;
 
+	/* buffer size without resampling */
+	if (out->cfg.rate == AUDIO_STREAM_SCO_RATE)
+		size = 576 * 2;
+
 	DBG("buf size %zd", size);
 
 	return size;
@@ -838,6 +842,10 @@ static size_t in_get_buffer_size(const struct audio_stream *stream)
 	size_t size = audio_stream_frame_size(&in->stream.common) *
 							in->cfg.frame_num;
 
+	/* buffer size without resampling */
+	if (in->cfg.rate == AUDIO_STREAM_SCO_RATE)
+		size = 576;
+
 	DBG("buf size %zd", size);
 
 	return size;
-- 
1.9.1


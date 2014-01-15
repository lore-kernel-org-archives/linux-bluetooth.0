Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 10/11] android/hal-audio: Fix AudioFlinger crash
Date: Wed, 15 Jan 2014 19:03:56 +0100
Message-ID: <1389809037-11575-11-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389809037-11575-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389809037-11575-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need to return some valid values for buffer size and latency so
AudioFlinger does not crash. For now just use some dummy values until
codec implementation is in place.
---
 android/hal-audio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 3c2dcb2..58f48bb 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -622,7 +622,7 @@ static int out_set_sample_rate(struct audio_stream *stream, uint32_t rate)
 static size_t out_get_buffer_size(const struct audio_stream *stream)
 {
 	DBG("");
-	return -ENOSYS;
+	return 20 * 512;
 }
 
 static uint32_t out_get_channels(const struct audio_stream *stream)
@@ -729,7 +729,7 @@ static char *out_get_parameters(const struct audio_stream *stream,
 static uint32_t out_get_latency(const struct audio_stream_out *stream)
 {
 	DBG("");
-	return -ENOSYS;
+	return 0;
 }
 
 static int out_set_volume(struct audio_stream_out *stream, float left,
-- 
1.8.5.2


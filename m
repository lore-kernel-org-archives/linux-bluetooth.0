Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 13/21] android/hal-sco: Choose buffer size
Date: Fri, 18 Jul 2014 12:48:12 +0300
Message-Id: <1405676900-17703-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For 8k choose buffer size 576 which is multiple from 48 and 64.
---
 android/hal-sco.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 2c1aeed..05dbddb 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
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


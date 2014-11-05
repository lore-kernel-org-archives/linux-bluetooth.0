Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] android/hal-sco: Remove deprecated API usage
Date: Wed,  5 Nov 2014 10:41:17 +0200
Message-Id: <1415176882-12397-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415176882-12397-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415176882-12397-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Instead of deprecated functions use new ones. Fixes deprecation warnings
during build.
---
 android/hal-sco.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index d9c9a68..ca3022e 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -438,7 +438,11 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 								size_t bytes)
 {
 	struct sco_stream_out *out = (struct sco_stream_out *) stream;
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	size_t frame_num = bytes / audio_stream_out_frame_size(stream);
+#else
 	size_t frame_num = bytes / audio_stream_frame_size(&out->stream.common);
+#endif
 	size_t output_frame_num = frame_num;
 	void *send_buf = out->downmix_buf;
 	size_t total;
@@ -507,8 +511,13 @@ static int out_set_sample_rate(struct audio_stream *stream, uint32_t rate)
 static size_t out_get_buffer_size(const struct audio_stream *stream)
 {
 	struct sco_stream_out *out = (struct sco_stream_out *) stream;
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	size_t size = audio_stream_out_frame_size(&out->stream) *
+							out->cfg.frame_num;
+#else
 	size_t size = audio_stream_frame_size(&out->stream.common) *
 							out->cfg.frame_num;
+#endif
 
 	/* buffer size without resampling */
 	if (out->cfg.rate == AUDIO_STREAM_SCO_RATE)
@@ -880,8 +889,13 @@ static int in_set_sample_rate(struct audio_stream *stream, uint32_t rate)
 static size_t in_get_buffer_size(const struct audio_stream *stream)
 {
 	struct sco_stream_in *in = (struct sco_stream_in *) stream;
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	size_t size = audio_stream_in_frame_size(&in->stream) *
+							in->cfg.frame_num;
+#else
 	size_t size = audio_stream_frame_size(&in->stream.common) *
 							in->cfg.frame_num;
+#endif
 
 	/* buffer size without resampling */
 	if (in->cfg.rate == AUDIO_STREAM_SCO_RATE)
@@ -1024,7 +1038,11 @@ static ssize_t in_read(struct audio_stream_in *stream, void *buffer,
 								size_t bytes)
 {
 	struct sco_stream_in *in = (struct sco_stream_in *) stream;
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	size_t frame_size = audio_stream_in_frame_size(&in->stream);
+#else
 	size_t frame_size = audio_stream_frame_size(&stream->common);
+#endif
 	size_t frame_num = bytes / frame_size;
 	size_t input_frame_num = frame_num;
 	void *read_buf = buffer;
-- 
1.9.1


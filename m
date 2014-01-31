Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] android/hal-audio: Fix style issues
Date: Fri, 31 Jan 2014 16:18:49 +0200
Message-Id: <1391177929-31416-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1391177929-31416-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391177929-31416-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-audio.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index dfe8b68..f2d072e 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -136,7 +136,7 @@ struct sbc_data {
 };
 
 static inline void timespec_diff(struct timespec *a, struct timespec *b,
-					struct timespec *res)
+							struct timespec *res)
 {
 	res->tv_sec = a->tv_sec - b->tv_sec;
 	res->tv_nsec = a->tv_nsec - b->tv_nsec;
@@ -149,14 +149,14 @@ static inline void timespec_diff(struct timespec *a, struct timespec *b,
 
 static int sbc_get_presets(struct audio_preset *preset, size_t *len);
 static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
-				void **codec_data);
+							void **codec_data);
 static int sbc_cleanup(void *codec_data);
 static int sbc_get_config(void *codec_data, struct audio_input_config *config);
 static size_t sbc_get_buffer_size(void *codec_data);
 static size_t sbc_get_mediapacket_duration(void *codec_data);
 static void sbc_resume(void *codec_data);
 static ssize_t sbc_write_data(void *codec_data, const void *buffer,
-					size_t bytes, int fd);
+							size_t bytes, int fd);
 
 struct audio_codec {
 	uint8_t type;
@@ -172,7 +172,7 @@ struct audio_codec {
 	size_t (*get_mediapacket_duration) (void *codec_data);
 	void (*resume) (void *codec_data);
 	ssize_t (*write_data) (void *codec_data, const void *buffer,
-				size_t bytes, int fd);
+							size_t bytes, int fd);
 };
 
 static const struct audio_codec audio_codecs[] = {
@@ -299,7 +299,7 @@ static void sbc_init_encoder(struct sbc_data *sbc_data)
 }
 
 static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
-				void **codec_data)
+							void **codec_data)
 {
 	struct sbc_data *sbc_data;
 	size_t hdr_len = sizeof(struct media_packet);
@@ -443,7 +443,7 @@ static int write_media_packet(int fd, struct sbc_data *sbc_data,
 }
 
 static ssize_t sbc_write_data(void *codec_data, const void *buffer,
-				size_t bytes, int fd)
+							size_t bytes, int fd)
 {
 	struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
 	size_t consumed = 0;
@@ -695,7 +695,7 @@ static int ipc_close_cmd(uint8_t endpoint_id)
 }
 
 static int ipc_open_stream_cmd(uint8_t endpoint_id, uint16_t *mtu, int *fd,
-					struct audio_preset **caps)
+						struct audio_preset **caps)
 {
 	char buf[BLUEZ_AUDIO_MTU];
 	struct audio_cmd_open_stream cmd;
@@ -736,7 +736,7 @@ static int ipc_close_stream_cmd(uint8_t endpoint_id)
 	cmd.id = endpoint_id;
 
 	result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_CLOSE_STREAM,
-				sizeof(cmd), &cmd, NULL, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	return result;
 }
@@ -751,7 +751,7 @@ static int ipc_resume_stream_cmd(uint8_t endpoint_id)
 	cmd.id = endpoint_id;
 
 	result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_RESUME_STREAM,
-				sizeof(cmd), &cmd, NULL, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	return result;
 }
@@ -766,7 +766,7 @@ static int ipc_suspend_stream_cmd(uint8_t endpoint_id)
 	cmd.id = endpoint_id;
 
 	result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_SUSPEND_STREAM,
-				sizeof(cmd), &cmd, NULL, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	return result;
 }
@@ -834,7 +834,7 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 	}
 
 	return out->ep->codec->write_data(out->ep->codec_data, buffer,
-						bytes, out->ep->fd);
+							bytes, out->ep->fd);
 }
 
 static uint32_t out_get_sample_rate(const struct audio_stream *stream)
@@ -1170,7 +1170,7 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	out->ep = &audio_endpoints[0];
 
 	if (ipc_open_stream_cmd(out->ep->id, &mtu, &fd, &preset) !=
-			AUDIO_STATUS_SUCCESS)
+							AUDIO_STATUS_SUCCESS)
 		goto fail;
 
 	if (!preset || fd < 0)
@@ -1188,7 +1188,7 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	codec->get_config(out->ep->codec_data, &out->cfg);
 
 	DBG("rate=%d channels=%d format=%d", out->cfg.rate,
-			out->cfg.channels, out->cfg.format);
+					out->cfg.channels, out->cfg.format);
 
 	free(preset);
 
@@ -1215,7 +1215,6 @@ static void audio_close_output_stream(struct audio_hw_device *dev,
 	DBG("");
 
 	ipc_close_stream_cmd(ep->id);
-
 	if (ep->fd >= 0) {
 		close(ep->fd);
 		ep->fd = -1;
@@ -1240,7 +1239,7 @@ static int audio_set_parameters(struct audio_hw_device *dev,
 		return 0;
 
 	return out->stream.common.set_parameters((struct audio_stream *) out,
-							kvpairs);
+								kvpairs);
 }
 
 static char *audio_get_parameters(const struct audio_hw_device *dev,
-- 
1.8.3.2


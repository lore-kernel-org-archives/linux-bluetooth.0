Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 5/9] android/hal-audio: Calculate SBC stream parameters
Date: Mon, 20 Jan 2014 15:58:59 +0100
Message-ID: <1390229943-29609-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1390229943-29609-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390229943-29609-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds necessary calculations for SBC stream parameters.

Both input and output buffers are expected to have exact amount of
data to fill single media packet (based on transport channel MTU).

Frame duration will be used to synchronize input and output streams.
---
 android/hal-audio.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 97 insertions(+), 6 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 8e932ef..22dff53 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -46,6 +46,66 @@ static pthread_t ipc_th = 0;
 static pthread_mutex_t close_mutex = PTHREAD_MUTEX_INITIALIZER;
 static pthread_mutex_t sk_mutex = PTHREAD_MUTEX_INITIALIZER;
 
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+
+struct rtp_header {
+	unsigned cc:4;
+	unsigned x:1;
+	unsigned p:1;
+	unsigned v:2;
+
+	unsigned pt:7;
+	unsigned m:1;
+
+	uint16_t sequence_number;
+	uint32_t timestamp;
+	uint32_t ssrc;
+	uint32_t csrc[0];
+} __attribute__ ((packed));
+
+struct rtp_payload {
+	unsigned frame_count:4;
+	unsigned rfa0:1;
+	unsigned is_last_fragment:1;
+	unsigned is_first_fragment:1;
+	unsigned is_fragmented:1;
+} __attribute__ ((packed));
+
+#elif __BYTE_ORDER == __BIG_ENDIAN
+
+struct rtp_header {
+	unsigned v:2;
+	unsigned p:1;
+	unsigned x:1;
+	unsigned cc:4;
+
+	unsigned m:1;
+	unsigned pt:7;
+
+	uint16_t sequence_number;
+	uint32_t timestamp;
+	uint32_t ssrc;
+	uint32_t csrc[0];
+} __attribute__ ((packed));
+
+struct rtp_payload {
+	unsigned is_fragmented:1;
+	unsigned is_first_fragment:1;
+	unsigned is_last_fragment:1;
+	unsigned rfa0:1;
+	unsigned frame_count:4;
+} __attribute__ ((packed));
+
+#else
+#error "Unknown byte order"
+#endif
+
+struct media_packet {
+	struct rtp_header hdr;
+	struct rtp_payload payload;
+	uint8_t data[0];
+};
+
 struct audio_input_config {
 	uint32_t rate;
 	uint32_t channels;
@@ -56,10 +116,19 @@ struct sbc_data {
 	a2dp_sbc_t sbc;
 
 	sbc_t enc;
+
+	size_t in_frame_len;
+	size_t in_buf_size;
+
+	size_t out_buf_size;
+	uint8_t *out_buf;
+
+	unsigned frame_duration;
 };
 
 static int sbc_get_presets(struct audio_preset *preset, size_t *len);
-static int sbc_codec_init(struct audio_preset *preset, void **codec_data);
+static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
+				void **codec_data);
 static int sbc_cleanup(void *codec_data);
 static int sbc_get_config(void *codec_data,
 					struct audio_input_config *config);
@@ -69,7 +138,8 @@ struct audio_codec {
 
 	int (*get_presets) (struct audio_preset *preset, size_t *len);
 
-	int (*init) (struct audio_preset *preset, void **codec_data);
+	int (*init) (struct audio_preset *preset, uint16_t mtu,
+				void **codec_data);
 	int (*cleanup) (void *codec_data);
 	int (*get_config) (void *codec_data,
 					struct audio_input_config *config);
@@ -200,9 +270,14 @@ static void sbc_init_encoder(struct sbc_data *sbc_data)
 	out->bitpool = in->max_bitpool;
 }
 
-static int sbc_codec_init(struct audio_preset *preset, void **codec_data)
+static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
+				void **codec_data)
 {
 	struct sbc_data *sbc_data;
+	size_t hdr_len = sizeof(struct media_packet);
+	size_t in_frame_len;
+	size_t out_frame_len;
+	size_t num_frames;
 
 	DBG("");
 
@@ -217,6 +292,18 @@ static int sbc_codec_init(struct audio_preset *preset, void **codec_data)
 
 	sbc_init_encoder(sbc_data);
 
+	in_frame_len = sbc_get_codesize(&sbc_data->enc);
+	out_frame_len = sbc_get_frame_length(&sbc_data->enc);
+	num_frames = (mtu - hdr_len) / out_frame_len;
+
+	sbc_data->in_frame_len = in_frame_len;
+	sbc_data->in_buf_size = num_frames * in_frame_len;
+
+	sbc_data->out_buf_size = hdr_len + num_frames * out_frame_len;
+	sbc_data->out_buf = calloc(1, sbc_data->out_buf_size);
+
+	sbc_data->frame_duration = sbc_get_frame_duration(&sbc_data->enc);
+
 	*codec_data = sbc_data;
 
 	return AUDIO_STATUS_SUCCESS;
@@ -229,6 +316,7 @@ static int sbc_cleanup(void *codec_data)
 	DBG("");
 
 	sbc_finish(&sbc_data->enc);
+	free(sbc_data->out_buf);
 	free(codec_data);
 
 	return AUDIO_STATUS_SUCCESS;
@@ -460,7 +548,7 @@ static int ipc_close_cmd(uint8_t endpoint_id)
 	return result;
 }
 
-static int ipc_open_stream_cmd(uint8_t endpoint_id,
+static int ipc_open_stream_cmd(uint8_t endpoint_id, uint16_t *mtu,
 					struct audio_preset **caps)
 {
 	char buf[BLUEZ_AUDIO_MTU];
@@ -483,6 +571,7 @@ static int ipc_open_stream_cmd(uint8_t endpoint_id,
 	if (result == AUDIO_STATUS_SUCCESS) {
 		size_t buf_len = sizeof(struct audio_preset) +
 					rsp->preset[0].len;
+		*mtu = rsp->mtu;
 		*caps = malloc(buf_len);
 		memcpy(*caps, &rsp->preset, buf_len);
 	} else {
@@ -868,6 +957,7 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	struct a2dp_stream_out *out;
 	struct audio_preset *preset;
 	const struct audio_codec *codec;
+	uint16_t mtu;
 
 	out = calloc(1, sizeof(struct a2dp_stream_out));
 	if (!out)
@@ -895,7 +985,8 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	/* TODO: for now we always use endpoint 0 */
 	out->ep = &audio_endpoints[0];
 
-	if (ipc_open_stream_cmd(out->ep->id, &preset) != AUDIO_STATUS_SUCCESS)
+	if (ipc_open_stream_cmd(out->ep->id, &mtu, &preset) !=
+			AUDIO_STATUS_SUCCESS)
 		goto fail;
 
 	if (!preset)
@@ -903,7 +994,7 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 
 	codec = out->ep->codec;
 
-	codec->init(preset, &out->ep->codec_data);
+	codec->init(preset, mtu, &out->ep->codec_data);
 	codec->get_config(out->ep->codec_data, &out->cfg);
 
 	DBG("rate=%d channels=%d format=%d", out->cfg.rate,
-- 
1.8.5.2


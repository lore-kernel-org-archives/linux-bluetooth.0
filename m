Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 4/5] android/hal-audio: Use payload length for codec init
Date: Fri, 28 Feb 2014 19:01:19 +0100
Message-ID: <1393610480-5775-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1393610480-5775-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1393610480-5775-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It makes more sense to pass maximum payload length to codec since this
is actually used for calculations. MTU value is used only to allocate
proper buffer.
---
 android/hal-audio.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index b4d78ca..3a7b026 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -387,11 +387,10 @@ static void sbc_init_encoder(struct sbc_data *sbc_data)
 			in->min_bitpool, in->max_bitpool);
 }
 
-static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
+static int sbc_codec_init(struct audio_preset *preset, uint16_t payload_len,
 							void **codec_data)
 {
 	struct sbc_data *sbc_data;
-	size_t hdr_len = sizeof(struct media_packet);
 	size_t in_frame_len;
 	size_t out_frame_len;
 	size_t num_frames;
@@ -411,7 +410,7 @@ static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
 
 	in_frame_len = sbc_get_codesize(&sbc_data->enc);
 	out_frame_len = sbc_get_frame_length(&sbc_data->enc);
-	num_frames = (mtu - hdr_len) / out_frame_len;
+	num_frames = payload_len / out_frame_len;
 
 	sbc_data->in_frame_len = in_frame_len;
 	sbc_data->in_buf_size = num_frames * in_frame_len;
@@ -421,8 +420,8 @@ static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
 	sbc_data->frame_duration = sbc_get_frame_duration(&sbc_data->enc);
 	sbc_data->frames_per_packet = num_frames;
 
-	DBG("mtu=%u in_frame_len=%zu out_frame_len=%zu frames_per_packet=%zu",
-			mtu, in_frame_len, out_frame_len, num_frames);
+	DBG("in_frame_len=%zu out_frame_len=%zu frames_per_packet=%zu",
+				in_frame_len, out_frame_len, num_frames);
 
 	*codec_data = sbc_data;
 
@@ -885,6 +884,7 @@ static bool open_endpoint(struct audio_endpoint *ep,
 	struct audio_preset *preset;
 	const struct audio_codec *codec;
 	uint16_t mtu;
+	uint16_t payload_len;
 	int fd;
 
 	if (ipc_open_stream_cmd(ep->id, &mtu, &fd, &preset) !=
@@ -899,10 +899,14 @@ static bool open_endpoint(struct audio_endpoint *ep,
 		return false;
 	}
 
+	DBG("mtu=%u", mtu);
+
+	payload_len = mtu - sizeof(*ep->mp);
+
 	ep->fd = fd;
 
 	codec = ep->codec;
-	codec->init(preset, mtu, &ep->codec_data);
+	codec->init(preset, payload_len, &ep->codec_data);
 	codec->get_config(ep->codec_data, cfg);
 
 	ep->mp = calloc(mtu, 1);
@@ -910,7 +914,7 @@ static bool open_endpoint(struct audio_endpoint *ep,
 	ep->mp->hdr.pt = 1;
 	ep->mp->hdr.ssrc = htonl(1);
 
-	ep->mp_data_len = mtu - sizeof(*ep->mp);
+	ep->mp_data_len = payload_len;
 
 	free(preset);
 
-- 
1.8.5.4


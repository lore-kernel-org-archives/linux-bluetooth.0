Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 5/5] android/hal-audio-aptx: Add encoding
Date: Mon, 2 Jun 2014 13:20:11 +0200
Message-ID: <1401708011-12828-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401708011-12828-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401708011-12828-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio-aptx.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/android/hal-audio-aptx.c b/android/hal-audio-aptx.c
index 28db0f6..04e29f9 100644
--- a/android/hal-audio-aptx.c
+++ b/android/hal-audio-aptx.c
@@ -168,7 +168,15 @@ static bool aptx_codec_init(struct audio_preset *preset, uint16_t payload_len,
 
 	memcpy(&aptx_data->aptx, preset->data, preset->len);
 
-	/* TODO: initialize encoder */
+	aptx_data->enc = calloc(1, aptx_sizeof);
+	if (!aptx_data->enc) {
+		error("APTX: failed to create encoder");
+		free(aptx_data);
+		return false;
+	}
+
+	/* 1 = big-endian, this is what devices are using */
+	aptx_init(aptx_data->enc, 1);
 
 	*codec_data = aptx_data;
 
@@ -213,9 +221,30 @@ static ssize_t aptx_encode_mediapacket(void *codec_data, const uint8_t *buffer,
 					size_t len, struct media_packet *mp,
 					size_t mp_data_len, size_t *written)
 {
-	/* TODO: add encoding */
+	struct aptx_data *aptx_data = (struct aptx_data *) codec_data;
+	const int16_t *ptr = (const void *) buffer;
+	size_t bytes_in = 0;
+	size_t bytes_out = 0;
+
+	while ((len - bytes_in) >= 16 && (mp_data_len - bytes_out) >= 4) {
+		int pcm_l[4], pcm_r[4];
+		int i;
+
+		for (i = 0; i < 4; i++) {
+			pcm_l[i] = ptr[0];
+			pcm_r[i] = ptr[1];
+			ptr += 2;
+		}
+
+		aptx_encode(aptx_data->enc, pcm_l, pcm_r, &mp->data[bytes_out]);
+
+		bytes_in += 16;
+		bytes_out += 4;
+	}
+
+	*written = bytes_out;
 
-	return len;
+	return bytes_in;
 }
 
 static bool aptx_update_qos(void *codec_data, uint8_t op)
-- 
1.9.3


Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/2] android/hal-audio: Refactor error messages
Date: Fri, 24 Jan 2014 17:06:43 +0100
Message-ID: <1390579604-14748-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 8271647..974bedf 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -313,7 +313,7 @@ static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
 	DBG("");
 
 	if (preset->len != sizeof(a2dp_sbc_t)) {
-		DBG("preset size mismatch");
+		error("SBC: preset size mismatch");
 		return AUDIO_STATUS_FAILED;
 	}
 
@@ -422,8 +422,7 @@ static void write_media_packet(int fd, struct sbc_data *sbc_data,
 	ret = write(fd, mp, sizeof(*mp) + data_len);
 	if (ret < 0) {
 		int err = errno;
-		DBG("error writing data: %d (%s)", err,
-						strerror(err));
+		error("SBC: failed to write data: %d (%s)", err, strerror(err));
 	}
 
 	sbc_data->frames_sent += mp->payload.frame_count;
@@ -472,7 +471,7 @@ static ssize_t sbc_write_data(void *codec_data, const void *buffer,
 					&written);
 
 		if (ret < 0) {
-			DBG("failed to encode block");
+			error("SBC: failed to encode block");
 			break;
 		}
 
@@ -500,7 +499,7 @@ static ssize_t sbc_write_data(void *codec_data, const void *buffer,
 		 * if we did not, something went wrong but we can't really
 		 * handle this so this is just sanity check
 		 */
-		DBG("some data were not encoded");
+		error("SBC: failed to encode complete input buffer");
 	}
 
 	/* we always assume that all data was processed and sent */
@@ -828,12 +827,12 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 	}
 
 	if (out->audio_state != AUDIO_A2DP_STATE_STARTED) {
-		DBG("stream not started");
+		error("audio: stream not started");
 		return -1;
 	}
 
 	if (out->ep->fd < 0) {
-		DBG("no transport");
+		error("audio: no transport socket");
 		return -1;
 	}
 
@@ -857,7 +856,7 @@ static int out_set_sample_rate(struct audio_stream *stream, uint32_t rate)
 	DBG("");
 
 	if (rate != out->cfg.rate) {
-		DBG("cannot set sample rate to %d", rate);
+		warn("audio: cannot set sample rate to %d", rate);
 		return -1;
 	}
 
@@ -1182,6 +1181,7 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	return 0;
 
 fail:
+	error("audio: cannot open output stream");
 	free(out);
 	*stream_out = NULL;
 	return -EIO;
-- 
1.8.5.2


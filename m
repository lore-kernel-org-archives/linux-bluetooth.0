Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 05/28] android/hal-sco: Add SCO packet cache
Date: Wed,  4 Jun 2014 17:17:36 +0300
Message-Id: <1401891479-11965-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

SCO cached is used when Android writes with packet sizes which cannot
fit to 48 bytes SCO frames. Remaining frames are cached and written next
time Android perform out->write().
---
 android/hal-sco.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index ecf7a09..f3ccb0d 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -64,6 +64,9 @@ struct sco_stream_out {
 	int fd;
 
 	uint8_t *downmix_buf;
+	uint8_t *cache;
+	size_t cache_len;
+
 	size_t samples;
 	struct timespec start;
 
@@ -301,6 +304,7 @@ static bool write_data(struct sco_stream_out *out, const uint8_t *buffer,
 	size_t len, written = 0;
 	int ret;
 	uint16_t mtu = out->cfg.mtu;
+	uint8_t *p;
 	uint64_t audio_sent_us, audio_passed_us;
 
 	pfd.fd = out->fd;
@@ -320,6 +324,7 @@ static bool write_data(struct sco_stream_out *out, const uint8_t *buffer,
 			return false;
 		}
 
+		len = bytes - written > mtu ? mtu : bytes - written;
 
 		clock_gettime(CLOCK_REALTIME, &now);
 		/* Mark start of the stream */
@@ -341,12 +346,30 @@ static bool write_data(struct sco_stream_out *out, const uint8_t *buffer,
 			memcpy(&out->start, &now, sizeof(out->start));
 		}
 
+		if (out->cache_len) {
+			DBG("First packet cache_len %zd", out->cache_len);
+			memcpy(out->cache + out->cache_len, buffer,
+							mtu - out->cache_len);
+			p = out->cache;
+		}
 
-		len = bytes - written > mtu ? mtu : bytes - written;
+		if (bytes - written >= mtu)
+			p = (void *) buffer + written;
+		else {
+			memcpy(out->cache, buffer + written, bytes - written);
+			out->cache_len = bytes - written;
+			DBG("Last packet, cache %zd bytes", bytes - written);
+			written += bytes - written;
+			continue;
+		}
 
-		ret = write(out->fd, buffer + written, len);
+		ret = write(out->fd, p, len);
 		if (ret > 0) {
-			written += ret;
+			if (out->cache_len) {
+				written = mtu - out->cache_len;
+				out->cache_len = 0;
+			} else
+				written += ret;
 
 			out->samples += ret / 2;
 
@@ -604,6 +627,13 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 		return -ENOMEM;
 	}
 
+	out->cache = malloc(out->cfg.mtu);
+	if (!out->cache) {
+		free(out->downmix_buf);
+		free(out);
+		return -ENOMEM;
+	}
+
 	DBG("size %zd", out_get_buffer_size(&out->stream.common));
 
 	/* Channel numbers for resampler */
@@ -650,6 +680,7 @@ failed:
 	if (out->resampler)
 		release_resampler(out->resampler);
 
+	free(out->cache);
 	free(out->downmix_buf);
 	free(out);
 	stream_out = NULL;
@@ -674,6 +705,7 @@ static void sco_close_output_stream(struct audio_hw_device *dev,
 	if (out->resampler)
 		release_resampler(out->resampler);
 
+	free(out->cache);
 	free(out->downmix_buf);
 	free(out);
 	sco_dev->out = NULL;
-- 
1.8.3.2


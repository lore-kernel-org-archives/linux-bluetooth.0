Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 5/5] android/hal-audio: Provide better audio synchronization
Date: Fri, 28 Feb 2014 19:01:20 +0100
Message-ID: <1393610480-5775-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1393610480-5775-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1393610480-5775-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of waiting some fixed amount of useconds before next media
packet is encoded we use absolute time to wait precisely for a moment
when next packet is expected to be produced. This greatly improves flow
as is can compensate for time spent on encoding and writing data.
---
 android/hal-audio.c | 91 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 42 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 3a7b026..3ef058e 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -147,6 +147,27 @@ static inline void timespec_diff(struct timespec *a, struct timespec *b,
 	}
 }
 
+static void timespec_add(struct timespec *base, uint64_t time_us,
+							struct timespec *res)
+{
+	res->tv_sec = base->tv_sec + time_us / 1000000;
+	res->tv_nsec = base->tv_nsec + (time_us % 1000000) * 1000;
+
+	if (res->tv_nsec >= 1000000000) {
+		res->tv_sec++;
+		res->tv_nsec -= 1000000000;
+	}
+}
+
+#if defined(ANDROID)
+/* Bionic does not have clock_nanosleep() prototype in time.h even though
+ * it provides its implementation.
+ */
+extern int clock_nanosleep(clockid_t clock_id, int flags,
+					const struct timespec *request,
+					struct timespec *remain);
+#endif
+
 static int sbc_get_presets(struct audio_preset *preset, size_t *len);
 static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
 							void **codec_data);
@@ -480,45 +501,6 @@ static size_t sbc_get_mediapacket_duration(void *codec_data)
 	return sbc_data->frame_duration * sbc_data->frames_per_packet;
 }
 
-static int write_media_packet(struct a2dp_stream_out *out, size_t mp_data_len,
-							uint32_t input_samples)
-{
-	struct audio_endpoint *ep = out->ep;
-	struct media_packet *mp = ep->mp;
-	struct timespec cur;
-	struct timespec diff;
-	uint32_t expected_samples;
-	int ret;
-
-	while (true) {
-		ret = write(ep->fd, mp, sizeof(*mp) + mp_data_len);
-		if (ret >= 0)
-			break;
-
-		if (errno != EINTR)
-			return -errno;
-	}
-
-	clock_gettime(CLOCK_MONOTONIC, &cur);
-	timespec_diff(&cur, &ep->start, &diff);
-	expected_samples = (diff.tv_sec * 1000000ll + diff.tv_nsec / 1000ll) *
-						out->cfg.rate / 1000000ll;
-
-	/* AudioFlinger does not seem to provide any *working*
-	 * API to provide data in some interval and will just
-	 * send another buffer as soon as we process current
-	 * one. To prevent overflowing L2CAP socket, we need to
-	 * introduce some artificial delay here base on how many
-	 * audio frames were sent so far, i.e. if we're not
-	 * lagging behind audio stream, we can sleep for
-	 * duration of single media packet.
-	 */
-	if (ep->samples >= expected_samples)
-		usleep(input_samples * 1000000 / out->cfg.rate);
-
-	return ret;
-}
-
 static ssize_t sbc_encode_mediapacket(void *codec_data, const uint8_t *buffer,
 					size_t len, struct media_packet *mp,
 					size_t mp_data_len, size_t *written)
@@ -963,6 +945,25 @@ static bool write_data(struct a2dp_stream_out *out, const void *buffer,
 		ssize_t read;
 		uint32_t samples;
 		int ret;
+		uint64_t time_us;
+		struct timespec anchor;
+
+		time_us = ep->samples * 1000000ll / out->cfg.rate;
+
+		timespec_add(&ep->start, time_us, &anchor);
+
+		while (true) {
+			ret = clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME,
+								&anchor, NULL);
+
+			if (!ret)
+				break;
+
+			if (ret != EINTR) {
+				error("clock_nanosleep failed (%d)", ret);
+				return false;
+			}
+		}
 
 		read = ep->codec->encode_mediapacket(ep->codec_data,
 							buffer + consumed,
@@ -987,9 +988,15 @@ static bool write_data(struct a2dp_stream_out *out, const void *buffer,
 		samples = read / (2 * popcount(out->cfg.channels));
 		ep->samples += samples;
 
-		ret = write_media_packet(out, written, samples);
-		if (ret < 0)
-			return false;
+		while (true) {
+			ret = write(ep->fd, mp, sizeof(*mp) + written);
+
+			if (ret >= 0)
+				break;
+
+			if (errno != EINTR)
+				return false;
+		}
 	}
 
 done:
-- 
1.8.5.4


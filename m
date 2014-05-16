Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/3] android/hal-sco: Use nanosleep for SCO synchronization
Date: Fri, 16 May 2014 15:57:02 +0300
Message-Id: <1400245024-12533-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 56 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index ea9857e..fb7b4d4 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -64,6 +64,8 @@ struct sco_stream_out {
 	int fd;
 
 	uint8_t *downmix_buf;
+	size_t samples;
+	struct timespec start;
 
 	struct resampler_itfe *resampler;
 	int16_t *resample_buf;
@@ -277,6 +279,21 @@ static void downmix_to_mono(struct sco_stream_out *out, const uint8_t *buffer,
 	}
 }
 
+static uint64_t timespec_diff_us(struct timespec *a, struct timespec *b)
+{
+	struct timespec res;
+
+	res.tv_sec = a->tv_sec - b->tv_sec;
+	res.tv_nsec = a->tv_nsec - b->tv_nsec;
+
+	if (res.tv_nsec < 0) {
+		res.tv_sec--;
+		res.tv_nsec += 1000000000ll; /* 1sec */
+	}
+
+	return res.tv_sec * 1000000ll + res.tv_nsec / 1000ll;
+}
+
 static bool write_data(struct sco_stream_out *out, const uint8_t *buffer,
 								size_t bytes)
 {
@@ -284,13 +301,13 @@ static bool write_data(struct sco_stream_out *out, const uint8_t *buffer,
 	size_t len, written = 0;
 	int ret;
 	uint16_t mtu = /* out->cfg.mtu */ 48;
-	uint8_t read_buf[mtu];
-	bool do_write = false;
+	uint64_t audio_sent_us, audio_passed_us;
 
 	pfd.fd = out->fd;
 	pfd.events = POLLOUT | POLLIN | POLLHUP | POLLNVAL;
 
 	while (bytes > written) {
+		struct timespec now;
 
 		/* poll for sending */
 		if (poll(&pfd, 1, SOCKET_POLL_TIMEOUT_MS) == 0) {
@@ -303,27 +320,38 @@ static bool write_data(struct sco_stream_out *out, const uint8_t *buffer,
 			return false;
 		}
 
-		/* FIXME synchronize by time instead of read() */
-		if (pfd.revents & POLLIN) {
-			ret = read(out->fd, read_buf, mtu);
-			if (ret < 0) {
-				error("Error reading fd %d (%s)", out->fd,
-							strerror(errno));
-				return false;
-			}
 
-			do_write = true;
+		clock_gettime(CLOCK_REALTIME, &now);
+		/* Mark start of the stream */
+		if (!out->samples)
+			memcpy(&out->start, &now, sizeof(out->start));
+
+		audio_sent_us = out->samples * 1000000ll / AUDIO_STREAM_SCO_RATE;
+		audio_passed_us = timespec_diff_us(&now, &out->start);
+		if ((int) (audio_sent_us - audio_passed_us) > 1500) {
+			struct timespec timeout = {0,
+						(audio_sent_us -
+						 audio_passed_us) * 1000};
+			DBG("Sleeping for %d ms",
+					(int) (audio_sent_us - audio_passed_us));
+			nanosleep(&timeout, NULL);
+		} else if ((int)(audio_passed_us - audio_sent_us) > 50000) {
+			DBG("\n\nResync\n\n");
+			out->samples = 0;
+			memcpy(&out->start, &now, sizeof(out->start));
 		}
 
-		if (!do_write)
-			continue;
 
 		len = bytes - written > mtu ? mtu : bytes - written;
 
 		ret = write(out->fd, buffer + written, len);
 		if (ret > 0) {
 			written += ret;
-			do_write = false;
+
+			out->samples += ret / 2;
+
+			DBG("written %d samples %zd total %zd bytes",
+					ret, out->samples, written);
 			continue;
 		}
 
-- 
1.8.3.2


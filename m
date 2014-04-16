Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 3/6] android/hal-audio: Make audio socket non-blocking
Date: Thu, 17 Apr 2014 01:50:35 +0200
Message-Id: <1397692238-18642-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397692238-18642-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397692238-18642-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes writing to audio socket non-blocking since there's no
point in waiting indefinitely to write some data. Instead, we wait no
more than 500ms for socket to be ready and just skip packet otherwise.
---
 android/hal-audio.c | 191 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 130 insertions(+), 61 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 992fdf7..a261871 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -147,6 +147,27 @@ static void timespec_add(struct timespec *base, uint64_t time_us,
 	}
 }
 
+static void timespec_diff(struct timespec *a, struct timespec *b,
+							struct timespec *res)
+{
+	res->tv_sec = a->tv_sec - b->tv_sec;
+	res->tv_nsec = a->tv_nsec - b->tv_nsec;
+
+	if (res->tv_nsec < 0) {
+		res->tv_sec--;
+		res->tv_nsec += 1000000000; /* 1sec */
+	}
+}
+
+static uint64_t timespec_diff_us(struct timespec *a, struct timespec *b)
+{
+	struct timespec res;
+
+	timespec_diff(a, b, &res);
+
+	return res.tv_sec * 1000000ll + res.tv_nsec / 1000ll;
+}
+
 #if defined(ANDROID)
 /* Bionic does not have clock_nanosleep() prototype in time.h even though
  * it provides its implementation.
@@ -830,26 +851,6 @@ static void unregister_endpoints(void)
 	}
 }
 
-static int set_blocking(int fd)
-{
-	int flags;
-
-	flags = fcntl(fd, F_GETFL, 0);
-	if (flags < 0) {
-		int err = -errno;
-		error("fcntl(F_GETFL): %s (%d)", strerror(-err), -err);
-		return err;
-	}
-
-	if (fcntl(fd, F_SETFL, flags & ~O_NONBLOCK) < 0) {
-		int err = -errno;
-		error("fcntl(F_SETFL): %s (%d)", strerror(-err), -err);
-		return err;
-	}
-
-	return 0;
-}
-
 static bool open_endpoint(struct audio_endpoint *ep,
 						struct audio_input_config *cfg)
 {
@@ -863,9 +864,6 @@ static bool open_endpoint(struct audio_endpoint *ep,
 							AUDIO_STATUS_SUCCESS)
 		return false;
 
-	if (set_blocking(fd) < 0)
-		goto failed;
-
 	DBG("mtu=%u", mtu);
 
 	payload_len = mtu - sizeof(*ep->mp);
@@ -915,7 +913,6 @@ static bool resume_endpoint(struct audio_endpoint *ep)
 	if (ipc_resume_stream_cmd(ep->id) != AUDIO_STATUS_SUCCESS)
 		return false;
 
-	clock_gettime(CLOCK_MONOTONIC, &ep->start);
 	ep->samples = 0;
 
 	return true;
@@ -936,6 +933,64 @@ static void downmix_to_mono(struct a2dp_stream_out *out, const uint8_t *buffer,
 	}
 }
 
+static bool wait_for_endpoint(struct audio_endpoint *ep, bool *writable)
+{
+	int ret;
+
+	while (true) {
+		struct pollfd pollfd;
+
+		pollfd.fd = ep->fd;
+		pollfd.events = POLLOUT;
+		pollfd.revents = 0;
+
+		ret = poll(&pollfd, 1, 500);
+
+		if (ret >= 0) {
+			*writable = !!(pollfd.revents & POLLOUT);
+			break;
+		}
+
+		if (errno != EINTR) {
+			ret = errno;
+			error("poll failed (%d)", ret);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static bool write_to_endpoint(struct audio_endpoint *ep, size_t bytes)
+{
+	struct media_packet *mp = (struct media_packet *) ep->mp;
+	int ret;
+
+	while (true) {
+		ret = write(ep->fd, mp, sizeof(*mp) + bytes);
+
+		if (ret >= 0)
+			break;
+
+		/* this should not happen so let's issue warning, but do not
+		 * fail, we can try to write next packet
+		 */
+		if (errno == EAGAIN) {
+			ret = errno;
+			warn("write failed (%d)", ret);
+			break;
+		}
+
+		if (errno != EINTR) {
+			ret = errno;
+			error("write failed (%d)", ret);
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static bool write_data(struct a2dp_stream_out *out, const void *buffer,
 								size_t bytes)
 {
@@ -949,58 +1004,72 @@ static bool write_data(struct a2dp_stream_out *out, const void *buffer,
 		ssize_t read;
 		uint32_t samples;
 		int ret;
-		uint64_t time_us;
-		struct timespec anchor;
+		struct timespec current;
+		uint64_t audio_sent, audio_passed;
+		bool do_write = false;
 
-		time_us = ep->samples * 1000000ll / out->cfg.rate;
+		/* prepare media packet in advance so we don't waste time after
+		 * wakeup
+		 */
+		mp->hdr.sequence_number = htons(ep->seq++);
+		mp->hdr.timestamp = htonl(ep->samples);
+		read = ep->codec->encode_mediapacket(ep->codec_data,
+						buffer + consumed,
+						bytes - consumed, mp,
+						free_space, &written);
 
-		timespec_add(&ep->start, time_us, &anchor);
+		/* not much we can do here, let's just ignore remaining
+		 * data and continue
+		 */
+		if (read <= 0)
+			return true;
 
-		while (true) {
-			ret = clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME,
-								&anchor, NULL);
+		/* calculate where are we and where we should be */
+		clock_gettime(CLOCK_MONOTONIC, &current);
+		if (!ep->samples)
+			memcpy(&ep->start, &current, sizeof(ep->start));
+		audio_sent = ep->samples * 1000000ll / out->cfg.rate;
+		audio_passed = timespec_diff_us(&current, &ep->start);
 
-			if (!ret)
-				break;
+		/* if we're ahead of stream then wait for next write point */
+		if (audio_sent > audio_passed) {
+			struct timespec anchor;
 
-			if (ret != EINTR) {
-				error("clock_nanosleep failed (%d)", ret);
-				return false;
+			timespec_add(&ep->start, audio_sent, &anchor);
+
+			while (true) {
+				ret = clock_nanosleep(CLOCK_MONOTONIC,
+							TIMER_ABSTIME, &anchor,
+							NULL);
+
+				if (!ret)
+					break;
+
+				if (ret != EINTR) {
+					error("clock_nanosleep failed (%d)",
+									ret);
+					return false;
+				}
 			}
 		}
 
-		read = ep->codec->encode_mediapacket(ep->codec_data,
-							buffer + consumed,
-							bytes - consumed, mp,
-							free_space, &written);
-
-		/* This is non-fatal and we can just assume buffer was processed
-		 * properly and wait for next one.
+		/* wait some time for socket to be ready for write,
+		 * but we'll just skip writing data if timeout occurs
 		 */
-		if (read <= 0)
-			return true;
-
-		consumed += read;
+		if (!wait_for_endpoint(ep, &do_write))
+			return false;
 
-		mp->hdr.sequence_number = htons(ep->seq++);
-		mp->hdr.timestamp = htonl(ep->samples);
+		if (do_write)
+			if (!write_to_endpoint(ep, written))
+				return false;
 
 		/* AudioFlinger provides 16bit PCM, so sample size is 2 bytes
-		 * multipled by number of channels. Number of channels is simply
-		 * number of bits set in channels mask.
+		 * multiplied by number of channels. Number of channels is
+		 * simply number of bits set in channels mask.
 		 */
 		samples = read / (2 * popcount(out->cfg.channels));
 		ep->samples += samples;
-
-		while (true) {
-			ret = write(ep->fd, mp, sizeof(*mp) + written);
-
-			if (ret >= 0)
-				break;
-
-			if (errno != EINTR)
-				return false;
-		}
+		consumed += read;
 	}
 
 	return true;
-- 
1.9.2


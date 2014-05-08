Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 12/12] android/audio: Add write to SCO
Date: Thu,  8 May 2014 11:01:43 +0300
Message-Id: <1399536103-19052-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For synchronization interleave read() and write().
---
 android/hal-sco.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 1ce7f15..c5dd712 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -41,6 +41,8 @@
 #define OUT_BUFFER_SIZE			2560
 #define OUT_STREAM_FRAMES		2560
 
+#define SOCKET_POLL_TIMEOUT_MS		500
+
 static int listen_sk = -1;
 static int audio_sk = -1;
 
@@ -275,6 +277,74 @@ static void downmix_to_mono(struct hsp_stream_out *out, const uint8_t *buffer,
 	}
 }
 
+static bool write_data(struct hsp_stream_out *out, const uint8_t *buffer,
+								size_t bytes)
+{
+	struct pollfd pfd;
+	size_t len, written = 0;
+	int ret;
+	uint16_t mtu = /* out->cfg.mtu */ 48;
+	uint8_t read_buf[mtu];
+	bool do_write = false;
+
+	pfd.fd = out->fd;
+	pfd.events = POLLOUT | POLLIN | POLLHUP | POLLNVAL;
+
+	while (bytes > written) {
+
+		/* poll for sending */
+		if (poll(&pfd, 1, SOCKET_POLL_TIMEOUT_MS) == 0) {
+			DBG("timeout fd %d", out->fd);
+			return false;
+		}
+
+		if (pfd.revents & (POLLHUP | POLLNVAL)) {
+			error("error fd %d, events 0x%x", out->fd, pfd.revents);
+			return false;
+		}
+
+		if (pfd.revents & POLLIN) {
+			ret = read(out->fd, read_buf, mtu);
+			if (ret < 0) {
+				error("Error reading fd %d (%s)", out->fd,
+							strerror(errno));
+				return false;
+			}
+
+			do_write = true;
+		}
+
+		if (!do_write)
+			continue;
+
+		len = bytes - written > mtu ? mtu : bytes - written;
+
+		ret = write(out->fd, buffer + written, len);
+		if (ret > 0) {
+			written += ret;
+			do_write = false;
+			continue;
+		}
+
+		if (errno == EAGAIN) {
+			ret = errno;
+			warn("write failed (%d)", ret);
+			continue;
+		}
+
+		if (errno != EINTR) {
+			ret = errno;
+			error("write failed (%d) fd %d bytes %zd", ret, out->fd,
+									bytes);
+			return false;
+		}
+	}
+
+	DBG("written %zd bytes", bytes);
+
+	return true;
+}
+
 static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 								size_t bytes)
 {
@@ -320,6 +390,9 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 
 	DBG("total %zd", total);
 
+	if (!write_data(out, send_buf, total))
+		return -1;
+
 	return bytes;
 }
 
-- 
1.8.3.2


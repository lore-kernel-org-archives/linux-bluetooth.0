Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android/hal-audio: Simplify and fix locking
Date: Thu, 23 Jan 2014 15:21:25 +0100
Message-Id: <1390486886-12350-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix various issues with locking like missing unlock on
audio_ipc_cmd() return or accesing audio_sk without holding lock.
close_thread is removed to simplify code and shutdown on listen_sk is
used to indicate that that handler thread should stop.
---
 android/hal-audio.c | 68 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 4326ccd..11b0767 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -44,10 +44,8 @@ static const uint8_t a2dp_src_uuid[] = {
 
 static int listen_sk = -1;
 static int audio_sk = -1;
-static bool close_thread = false;
 
 static pthread_t ipc_th = 0;
-static pthread_mutex_t close_mutex = PTHREAD_MUTEX_INITIALIZER;
 static pthread_mutex_t sk_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
@@ -487,14 +485,6 @@ static ssize_t sbc_write_data(void *codec_data, const void *buffer,
 	return bytes;
 }
 
-static void audio_ipc_cleanup(void)
-{
-	if (audio_sk >= 0) {
-		shutdown(audio_sk, SHUT_RDWR);
-		audio_sk = -1;
-	}
-}
-
 static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 			void *param, size_t *rsp_len, void *rsp, int *fd)
 {
@@ -506,6 +496,8 @@ static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 	struct hal_status s;
 	size_t s_len = sizeof(s);
 
+	pthread_mutex_lock(&sk_mutex);
+
 	if (audio_sk < 0) {
 		error("audio: Invalid cmd socket passed to audio_ipc_cmd");
 		goto failed;
@@ -533,12 +525,9 @@ static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 	msg.msg_iov = iv;
 	msg.msg_iovlen = 2;
 
-	pthread_mutex_lock(&sk_mutex);
-
 	ret = sendmsg(audio_sk, &msg, 0);
 	if (ret < 0) {
 		error("audio: Sending command failed:%s", strerror(errno));
-		pthread_mutex_unlock(&sk_mutex);
 		goto failed;
 	}
 
@@ -570,12 +559,9 @@ static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 	if (ret < 0) {
 		error("audio: Receiving command response failed:%s",
 							strerror(errno));
-		pthread_mutex_unlock(&sk_mutex);
 		goto failed;
 	}
 
-	pthread_mutex_unlock(&sk_mutex);
-
 	if (ret < (ssize_t) sizeof(cmd)) {
 		error("audio: Too small response received(%zd bytes)", ret);
 		goto failed;
@@ -611,9 +597,13 @@ static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 			goto failed;
 		}
 
+		pthread_mutex_unlock(&sk_mutex);
+
 		return s->code;
 	}
 
+	pthread_mutex_unlock(&sk_mutex);
+
 	/* Receive auxiliary data in msg */
 	if (fd) {
 		struct cmsghdr *cmsg;
@@ -638,7 +628,8 @@ static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 failed:
 	/* Some serious issue happen on IPC - recover */
 	shutdown(audio_sk, SHUT_RDWR);
-	audio_sk = -1;
+	pthread_mutex_unlock(&sk_mutex);
+
 	return AUDIO_STATUS_FAILED;
 }
 
@@ -1311,10 +1302,8 @@ static int audio_close(hw_device_t *device)
 
 	DBG("");
 
-	pthread_mutex_lock(&close_mutex);
-	audio_ipc_cleanup();
-	close_thread = true;
-	pthread_mutex_unlock(&close_mutex);
+	shutdown(listen_sk, SHUT_RDWR);
+	shutdown(audio_sk, SHUT_RDWR);
 
 	pthread_join(ipc_th, NULL);
 
@@ -1329,19 +1318,31 @@ static void *ipc_handler(void *data)
 {
 	bool done = false;
 	struct pollfd pfd;
+	int sk;
 
 	DBG("");
 
 	while (!done) {
 		DBG("Waiting for connection ...");
-		audio_sk = accept(listen_sk, NULL, NULL);
-		if (audio_sk < 0) {
+
+		sk = accept(listen_sk, NULL, NULL);
+		if (sk < 0) {
 			int err = errno;
-			error("audio: Failed to accept socket: %d (%s)", err,
-								strerror(err));
-			continue;
+
+			if (err == EINTR)
+				continue;
+
+			if (err != ECONNABORTED && err != EINVAL)
+				error("audio: Failed to accept socket: %d (%s)",
+							err, strerror(err));
+
+			break;
 		}
 
+		pthread_mutex_lock(&sk_mutex);
+		audio_sk = sk;
+		pthread_mutex_unlock(&sk_mutex);
+
 		DBG("Audio IPC: Connected");
 
 		if (register_endpoints() != AUDIO_STATUS_SUCCESS) {
@@ -1349,7 +1350,12 @@ static void *ipc_handler(void *data)
 
 			unregister_endpoints();
 
+			pthread_mutex_lock(&sk_mutex);
 			shutdown(audio_sk, SHUT_RDWR);
+			close(audio_sk);
+			audio_sk = -1;
+			pthread_mutex_unlock(&sk_mutex);
+
 			continue;
 		}
 
@@ -1362,14 +1368,12 @@ static void *ipc_handler(void *data)
 
 		if (pfd.revents & (POLLHUP | POLLERR | POLLNVAL)) {
 			info("Audio HAL: Socket closed");
+
+			pthread_mutex_lock(&sk_mutex);
+			close(audio_sk);
 			audio_sk = -1;
+			pthread_mutex_unlock(&sk_mutex);
 		}
-
-		/*Check if audio_dev is closed */
-		pthread_mutex_lock(&close_mutex);
-		done = close_thread;
-		close_thread = false;
-		pthread_mutex_unlock(&close_mutex);
 	}
 
 	unregister_endpoints();
-- 
1.8.3.2


Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 4/7] android/audio: Trivial function move
Date: Fri, 10 Jan 2014 02:24:25 +0100
Message-ID: <1389317068-12540-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just moves create_listening_audio_ipc() closer to audio_open()

---
 android/hal-audio.c | 87 +++++++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index b0e0b1d..0b345ed 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -417,6 +417,50 @@ static int audio_close(hw_device_t *device)
 	return 0;
 }
 
+static void *ipc_handler(void *data)
+{
+	bool done = false;
+	struct pollfd pfd;
+
+	DBG("");
+
+	while (!done) {
+		DBG("Waiting for audio_ipc connection ...");
+		audio_sk = accept(listen_sk, NULL, NULL);
+		if (audio_sk < 0) {
+			int err = errno;
+			error("audio: Failed to accept socket: %d (%s)", err,
+								strerror(err));
+			continue;
+		}
+
+		DBG("Audio IPC: Connected");
+
+		/* TODO: Register ENDPOINT here */
+
+		memset(&pfd, 0, sizeof(pfd));
+		pfd.fd = audio_sk;
+		pfd.events = POLLHUP | POLLERR | POLLNVAL;
+
+		/* Check if socket is still alive. Empty while loop.*/
+		while (poll(&pfd, 1, -1) < 0 && errno == EINTR);
+
+		if (pfd.revents & (POLLHUP | POLLERR | POLLNVAL)) {
+			info("Audio HAL: Socket closed");
+			audio_sk = -1;
+		}
+
+		/*Check if audio_dev is closed */
+		pthread_mutex_lock(&close_mutex);
+		done = close_thread;
+		close_thread = false;
+		pthread_mutex_unlock(&close_mutex);
+	}
+
+	info("Closing bluetooth_watcher thread");
+	return NULL;
+}
+
 static int create_listening_audio_ipc(void)
 {
 	struct sockaddr_un addr;
@@ -461,49 +505,6 @@ failed:
 	return err;
 }
 
-static void *ipc_handler(void *data)
-{
-	bool done = false;
-	struct pollfd pfd;
-
-	DBG("");
-
-	while (!done) {
-		audio_sk = accept(listen_sk, NULL, NULL);
-		if (audio_sk < 0) {
-			int err = errno;
-			error("audio: Failed to accept socket: %d (%s)", err,
-								strerror(err));
-			continue;
-		}
-
-		DBG("Audio IPC: Connected");
-
-		/* TODO: Register ENDPOINT here */
-
-		memset(&pfd, 0, sizeof(pfd));
-		pfd.fd = audio_sk;
-		pfd.events = POLLHUP | POLLERR | POLLNVAL;
-
-		/* Check if socket is still alive. Empty while loop.*/
-		while (poll(&pfd, 1, -1) < 0 && errno == EINTR);
-
-		if (pfd.revents & (POLLHUP | POLLERR | POLLNVAL)) {
-			info("Audio HAL: Socket closed");
-			audio_sk = -1;
-		}
-
-		/*Check if audio_dev is closed */
-		pthread_mutex_lock(&close_mutex);
-		done = close_thread;
-		close_thread = false;
-		pthread_mutex_unlock(&close_mutex);
-	}
-
-	info("Closing bluetooth_watcher thread");
-	return NULL;
-}
-
 static int audio_open(const hw_module_t *module, const char *name,
 							hw_device_t **device)
 {
-- 
1.8.4


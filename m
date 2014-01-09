Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <szymon.janc@tieto.com>,
	<johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/4] android/audio: Prefix error log with "a2dp"
Date: Thu, 9 Jan 2014 12:45:53 +0100
Message-ID: <1389267956-2297-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1389267956-2297-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389267956-2297-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 59a8269..7a7c111 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -423,7 +423,8 @@ static bool create_audio_ipc(void)
 	sk = socket(PF_LOCAL, SOCK_SEQPACKET, 0);
 	if (sk < 0) {
 		err = errno;
-		error("Failed to create socket: %d (%s)", err, strerror(err));
+		error("a2dp: Failed to create socket: %d (%s)", err,
+								strerror(err));
 		return false;
 	}
 
@@ -435,13 +436,14 @@ static bool create_audio_ipc(void)
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		err = errno;
-		error("Failed to bind socket: %d (%s)", err, strerror(err));
+		error("a2dp: Failed to bind socket: %d (%s)", err,
+								strerror(err));
 		goto failed;
 	}
 
 	if (listen(sk, 1) < 0) {
 		err = errno;
-		error("Failed to listen on the socket: %d (%s)", err,
+		error("a2dp: Failed to listen on the socket: %d (%s)", err,
 								strerror(err));
 		goto failed;
 	}
@@ -449,7 +451,7 @@ static bool create_audio_ipc(void)
 	audio_sk = accept(sk, NULL, NULL);
 	if (audio_sk < 0) {
 		err = errno;
-		error("Failed to accept socket: %d (%s)", err, strerror(err));
+		error("a2dp: Failed to accept socket: %d (%s)", err, strerror(err));
 		goto failed;
 	}
 
@@ -470,7 +472,7 @@ static void *ipc_handler(void *data)
 
 	while (!done) {
 		if(!create_audio_ipc()) {
-			error("Failed to create listening socket");
+			error("a2dp: Failed to create listening socket");
 			sleep(1);
 			continue;
 		}
@@ -511,7 +513,7 @@ static int audio_open(const hw_module_t *module, const char *name,
 	DBG("");
 
 	if (strcmp(name, AUDIO_HARDWARE_INTERFACE)) {
-		error("interface %s not matching [%s]", name,
+		error("ad2p: interface %s not matching [%s]", name,
 						AUDIO_HARDWARE_INTERFACE);
 		return -EINVAL;
 	}
@@ -547,7 +549,7 @@ static int audio_open(const hw_module_t *module, const char *name,
 	err = pthread_create(&ipc_th, NULL, ipc_handler, NULL);
 	if (err < 0) {
 		ipc_th = 0;
-		error("Failed to start Audio IPC thread: %d (%s)",
+		error("a2dp: Failed to start Audio IPC thread: %d (%s)",
 							-err, strerror(-err));
 		return (-err);
 	}
-- 
1.8.4


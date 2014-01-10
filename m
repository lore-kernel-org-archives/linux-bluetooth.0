Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/7] android/audio: Prefix error log with "audio"
Date: Fri, 10 Jan 2014 02:24:22 +0100
Message-ID: <1389317068-12540-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 7d7e97e..4b48783 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -424,7 +424,8 @@ static bool create_audio_ipc(void)
 	sk = socket(PF_LOCAL, SOCK_SEQPACKET, 0);
 	if (sk < 0) {
 		err = errno;
-		error("Failed to create socket: %d (%s)", err, strerror(err));
+		error("audio: Failed to create socket: %d (%s)", err,
+								strerror(err));
 		return false;
 	}
 
@@ -436,13 +437,14 @@ static bool create_audio_ipc(void)
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		err = errno;
-		error("Failed to bind socket: %d (%s)", err, strerror(err));
+		error("audio: Failed to bind socket: %d (%s)", err,
+								strerror(err));
 		goto failed;
 	}
 
 	if (listen(sk, 1) < 0) {
 		err = errno;
-		error("Failed to listen on the socket: %d (%s)", err,
+		error("audio: Failed to listen on the socket: %d (%s)", err,
 								strerror(err));
 		goto failed;
 	}
@@ -450,7 +452,7 @@ static bool create_audio_ipc(void)
 	audio_sk = accept(sk, NULL, NULL);
 	if (audio_sk < 0) {
 		err = errno;
-		error("Failed to accept socket: %d (%s)", err, strerror(err));
+		error("audio: Failed to accept socket: %d (%s)", err, strerror(err));
 		goto failed;
 	}
 
@@ -471,7 +473,7 @@ static void *ipc_handler(void *data)
 
 	while (!done) {
 		if(!create_audio_ipc()) {
-			error("Failed to create listening socket");
+			error("audio: Failed to create listening socket");
 			sleep(1);
 			continue;
 		}
@@ -512,7 +514,7 @@ static int audio_open(const hw_module_t *module, const char *name,
 	DBG("");
 
 	if (strcmp(name, AUDIO_HARDWARE_INTERFACE)) {
-		error("interface %s not matching [%s]", name,
+		error("audio: interface %s not matching [%s]", name,
 						AUDIO_HARDWARE_INTERFACE);
 		return -EINVAL;
 	}
@@ -548,7 +550,7 @@ static int audio_open(const hw_module_t *module, const char *name,
 	err = pthread_create(&ipc_th, NULL, ipc_handler, NULL);
 	if (err < 0) {
 		ipc_th = 0;
-		error("Failed to start Audio IPC thread: %d (%s)",
+		error("audio: Failed to start Audio IPC thread: %d (%s)",
 							-err, strerror(-err));
 		return (-err);
 	}
-- 
1.8.4


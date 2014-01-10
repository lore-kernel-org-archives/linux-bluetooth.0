Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 3/7] android/audio: Refactor create_audio_ipc
Date: Fri, 10 Jan 2014 02:24:24 +0100
Message-ID: <1389317068-12540-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds creating listening audio ipc socket in AudioFlinger
context on audio_open() and moves accepting connection to ipc_th.

---
 android/hal-audio.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index c71b93c..b0e0b1d 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -32,6 +32,7 @@
 #include "audio-msg.h"
 #include "hal-log.h"
 
+static int listen_sk = -1;
 static int audio_sk = -1;
 static bool close_thread = false;
 
@@ -409,11 +410,14 @@ static int audio_close(hw_device_t *device)
 
 	pthread_join(ipc_th, NULL);
 
+	close(listen_sk);
+	listen_sk = -1;
+
 	free(a2dp_dev);
 	return 0;
 }
 
-static bool create_audio_ipc(void)
+static int create_listening_audio_ipc(void)
 {
 	struct sockaddr_un addr;
 	int err;
@@ -426,7 +430,7 @@ static bool create_audio_ipc(void)
 		err = errno;
 		error("audio: Failed to create socket: %d (%s)", err,
 								strerror(err));
-		return false;
+		return err;
 	}
 
 	memset(&addr, 0, sizeof(addr));
@@ -449,19 +453,12 @@ static bool create_audio_ipc(void)
 		goto failed;
 	}
 
-	audio_sk = accept(sk, NULL, NULL);
-	if (audio_sk < 0) {
-		err = errno;
-		error("audio: Failed to accept socket: %d (%s)", err, strerror(err));
-		goto failed;
-	}
-
-	close(sk);
-	return true;
+	listen_sk = sk;
+	return 0;
 
 failed:
 	close(sk);
-	return false;
+	return err;
 }
 
 static void *ipc_handler(void *data)
@@ -472,9 +469,11 @@ static void *ipc_handler(void *data)
 	DBG("");
 
 	while (!done) {
-		if(!create_audio_ipc()) {
-			error("audio: Failed to create listening socket");
-			sleep(1);
+		audio_sk = accept(listen_sk, NULL, NULL);
+		if (audio_sk < 0) {
+			int err = errno;
+			error("audio: Failed to accept socket: %d (%s)", err,
+								strerror(err));
 			continue;
 		}
 
@@ -519,6 +518,10 @@ static int audio_open(const hw_module_t *module, const char *name,
 		return -EINVAL;
 	}
 
+	err = create_listening_audio_ipc();
+	if (err)
+		return -err;
+
 	a2dp_dev = calloc(1, sizeof(struct a2dp_audio_dev));
 	if (!a2dp_dev)
 		return -ENOMEM;
-- 
1.8.4


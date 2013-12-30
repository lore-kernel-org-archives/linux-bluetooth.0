Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 9/9] android: Add hal_audio_ipc_init and hal_audio_ipc_cleanup
Date: Mon, 30 Dec 2013 14:34:15 +0200
Message-Id: <1388406855-8809-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1388406855-8809-1-git-send-email-luiz.dentz@gmail.com>
References: <1388406855-8809-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These function initialize the audio IPC in the HAL side.
---
 android/hal-audio.c |  9 +++++++++
 android/hal-ipc.c   | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-ipc.h   |  3 +++
 3 files changed, 68 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 7f4a3f2..2e7dcca 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -24,6 +24,7 @@
 #include <hardware/hardware.h>
 
 #include "hal-log.h"
+#include "hal-ipc.h"
 
 static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 								size_t bytes)
@@ -374,6 +375,9 @@ static int audio_dump(const audio_hw_device_t *device, int fd)
 static int audio_close(hw_device_t *device)
 {
 	DBG("");
+
+	hal_audio_ipc_cleanup();
+
 	free(device);
 	return 0;
 }
@@ -391,6 +395,11 @@ static int audio_open(const hw_module_t *module, const char *name,
 		return -EINVAL;
 	}
 
+	if (!hal_audio_ipc_init()) {
+		error("Unable to initialize audio IPC");
+		return -ENOTCONN;
+	}
+
 	audio = calloc(1, sizeof(struct audio_hw_device));
 	if (!audio)
 		return -ENOMEM;
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index b19704a..3a1fcc7 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -38,6 +38,7 @@
 
 static int cmd_sk = -1;
 static int notif_sk = -1;
+static int audio_sk = -1;
 
 static pthread_mutex_t cmd_sk_mutex = PTHREAD_MUTEX_INITIALIZER;
 
@@ -449,3 +450,58 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 
 	return BT_STATUS_SUCCESS;
 }
+
+bool hal_audio_ipc_init(void)
+{
+	struct sockaddr_un addr;
+	int sk;
+	int err;
+
+	sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
+	if (sk < 0) {
+		err = errno;
+		error("Failed to create socket: %d (%s)", err,
+							strerror(err));
+		return false;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+
+	memcpy(addr.sun_path, BLUEZ_AUDIO_SK_PATH, sizeof(BLUEZ_AUDIO_SK_PATH));
+
+	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		err = errno;
+		error("Failed to bind socket: %d (%s)", err, strerror(err));
+		close(sk);
+		return false;
+	}
+
+	if (listen(sk, 2) < 0) {
+		err = errno;
+		error("Failed to listen on socket: %d (%s)", err,
+								strerror(err));
+		close(sk);
+		return false;
+	}
+
+	audio_sk = accept_connection(sk);
+	if (audio_sk < 0) {
+		close(sk);
+		return false;
+	}
+
+	info("audio connected");
+
+	close(sk);
+
+	return true;
+}
+
+void hal_audio_ipc_cleanup(void)
+{
+	close(audio_sk);
+	audio_sk = -1;
+
+	shutdown(audio_sk, SHUT_RD);
+}
diff --git a/android/hal-ipc.h b/android/hal-ipc.h
index 2fbf30f..bd1682d 100644
--- a/android/hal-ipc.h
+++ b/android/hal-ipc.h
@@ -30,3 +30,6 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 void hal_ipc_register(uint8_t service, const struct hal_ipc_handler *handlers,
 								uint8_t size);
 void hal_ipc_unregister(uint8_t service);
+
+bool hal_audio_ipc_init(void);
+void hal_audio_ipc_cleanup(void);
-- 
1.8.4.2


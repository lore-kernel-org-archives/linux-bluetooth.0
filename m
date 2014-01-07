Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 03/10] android/ipc: Add audio_ipc_send_rsp and audio_ipc_send_rsp_full
Date: Tue,  7 Jan 2014 13:53:16 +0200
Message-Id: <1389095603-30504-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389095603-30504-1-git-send-email-luiz.dentz@gmail.com>
References: <1389095603-30504-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These functions can be used to respond to commands recieved over audio
IPC.
---
 android/audio-ipc.c | 23 +++++++++++++++++++++++
 android/audio-ipc.h |  3 +++
 android/audio-msg.h |  8 ++++++++
 android/ipc.c       |  2 +-
 android/ipc.h       |  2 ++
 5 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/android/audio-ipc.c b/android/audio-ipc.c
index 0c5433a..f4b55e3 100644
--- a/android/audio-ipc.c
+++ b/android/audio-ipc.c
@@ -123,3 +123,26 @@ void audio_ipc_unregister(void)
 	service.handler = NULL;
 	service.size = 0;
 }
+
+void audio_ipc_send_rsp(uint8_t opcode, uint8_t status)
+{
+	struct audio_status s;
+	int sk;
+
+	sk = g_io_channel_unix_get_fd(audio_io);
+
+	if (status == AUDIO_STATUS_SUCCESS) {
+		ipc_send(sk, AUDIO_SERVICE_ID, opcode, 0, NULL, -1);
+		return;
+	}
+
+	s.code = status;
+
+	ipc_send(sk, AUDIO_SERVICE_ID, AUDIO_OP_STATUS, sizeof(s), &s, -1);
+}
+
+void audio_ipc_send_rsp_full(uint8_t opcode, uint16_t len, void *param, int fd)
+{
+	ipc_send(g_io_channel_unix_get_fd(audio_io), AUDIO_SERVICE_ID, opcode,
+							len, param, fd);
+}
diff --git a/android/audio-ipc.h b/android/audio-ipc.h
index 1dfa245..0b5f216 100644
--- a/android/audio-ipc.h
+++ b/android/audio-ipc.h
@@ -26,3 +26,6 @@ void audio_ipc_cleanup(void);
 
 void audio_ipc_register(const struct ipc_handler *handlers, uint8_t size);
 void audio_ipc_unregister(void);
+
+void audio_ipc_send_rsp(uint8_t opcode, uint8_t status);
+void audio_ipc_send_rsp_full(uint8_t opcode, uint16_t len, void *param, int fd);
diff --git a/android/audio-msg.h b/android/audio-msg.h
index 1ec2520..ae8a168 100644
--- a/android/audio-msg.h
+++ b/android/audio-msg.h
@@ -26,3 +26,11 @@
 static const char BLUEZ_AUDIO_SK_PATH[] = "\0bluez_audio_socket";
 
 #define AUDIO_SERVICE_ID		0
+
+#define AUDIO_STATUS_SUCCESS		0x00
+#define AUDIO_STATUS_FAILED		0x01
+
+#define AUDIO_OP_STATUS			0x00
+struct audio_status {
+	uint8_t code;
+} __attribute__((packed));
diff --git a/android/ipc.c b/android/ipc.c
index 1499962..03bdc35 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -245,7 +245,7 @@ void ipc_cleanup(void)
 	}
 }
 
-static void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
+void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd)
 {
 	struct msghdr msg;
diff --git a/android/ipc.h b/android/ipc.h
index 7b8bdeb..b1cc5c5 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -43,6 +43,8 @@ void ipc_send_rsp_full(uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd);
 void ipc_send_notif(uint8_t service_id, uint8_t opcode,  uint16_t len,
 								void *param);
+void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
+							void *param, int fd);
 void ipc_register(uint8_t service, const struct ipc_handler *handlers,
 								uint8_t size);
 void ipc_unregister(uint8_t service);
-- 
1.8.4.2


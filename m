Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/10] android/ipc: Add audio_ipc_send_rsp and audio_ipc_send_rsp_full
Date: Tue, 31 Dec 2013 13:29:55 +0200
Message-Id: <1388489402-8919-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1388489402-8919-1-git-send-email-luiz.dentz@gmail.com>
References: <1388489402-8919-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These functions can be used to respond to commands recieved over audio
IPC.
---
 android/ipc.c | 24 ++++++++++++++++++++++++
 android/ipc.h |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/android/ipc.c b/android/ipc.c
index 751284f..d6cb126 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -381,6 +381,30 @@ void audio_ipc_cleanup(void)
 	}
 }
 
+void audio_ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status)
+{
+	struct hal_status s;
+	int sk;
+
+	sk = g_io_channel_unix_get_fd(audio_io);
+
+	if (status == HAL_STATUS_SUCCESS) {
+		ipc_send(sk, service_id, opcode, 0, NULL, -1);
+		return;
+	}
+
+	s.code = status;
+
+	ipc_send(sk, service_id, HAL_OP_STATUS, sizeof(s), &s, -1);
+}
+
+void audio_ipc_send_rsp_full(uint8_t service_id, uint8_t opcode, uint16_t len,
+							void *param, int fd)
+{
+	ipc_send(g_io_channel_unix_get_fd(audio_io), service_id, opcode, len,
+								param, fd);
+}
+
 void audio_ipc_register(uint8_t service, const struct ipc_handler *handlers,
 								uint8_t size)
 {
diff --git a/android/ipc.h b/android/ipc.h
index 44d5a5d..f224367 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -41,6 +41,10 @@ void ipc_unregister(uint8_t service);
 void audio_ipc_init(void);
 void audio_ipc_cleanup(void);
 
+void audio_ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status);
+void audio_ipc_send_rsp_full(uint8_t service_id, uint8_t opcode, uint16_t len,
+							void *param, int fd);
+
 void audio_ipc_register(uint8_t service, const struct ipc_handler *handlers,
 								uint8_t size);
 void audio_ipc_unregister(uint8_t service);
-- 
1.8.4.2


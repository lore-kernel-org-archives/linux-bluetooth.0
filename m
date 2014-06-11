Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/10] android/ipc: Add support for sending FD in notifications
Date: Wed, 11 Jun 2014 16:32:52 +0200
Message-Id: <1402497172-12436-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
References: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/ipc.c | 8 +++++++-
 android/ipc.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/android/ipc.c b/android/ipc.c
index fc58a1c..2e67428 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -404,11 +404,17 @@ void ipc_send_rsp_full(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
 void ipc_send_notif(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
 						uint16_t len, void *param)
 {
+	return ipc_send_notif_with_fd(ipc, service_id, opcode, len, param, -1);
+}
+
+void ipc_send_notif_with_fd(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
+					uint16_t len, void *param, int fd)
+{
 	if (!ipc || !ipc->notif_io)
 		return;
 
 	ipc_send(g_io_channel_unix_get_fd(ipc->notif_io), service_id, opcode,
-								len, param, -1);
+								len, param, fd);
 }
 
 void ipc_register(struct ipc *ipc, uint8_t service,
diff --git a/android/ipc.h b/android/ipc.h
index e97f0e6..fd2b985 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -42,6 +42,9 @@ void ipc_send_rsp_full(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
 					uint16_t len, void *param, int fd);
 void ipc_send_notif(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
 						uint16_t len, void *param);
+void ipc_send_notif_with_fd(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
+					uint16_t len, void *param, int fd);
+
 void ipc_register(struct ipc *ipc, uint8_t service,
 			const struct ipc_handler *handlers, uint8_t size);
 void ipc_unregister(struct ipc *ipc, uint8_t service);
-- 
1.9.1


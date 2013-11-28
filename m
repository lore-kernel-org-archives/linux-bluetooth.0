Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/10] android: Add ipc_send_rsp_full IPC helper
Date: Thu, 28 Nov 2013 15:15:26 +0100
Message-Id: <1385648130-12808-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
References: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be used to send non-empty reply using command socket.
---
 android/ipc.c | 6 ++++++
 android/ipc.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/android/ipc.c b/android/ipc.c
index d1a59d7..83c2221 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -110,6 +110,12 @@ void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status)
 	ipc_send(cmd_sk, service_id, HAL_OP_STATUS, sizeof(s), &s, -1);
 }
 
+void ipc_send_rsp_full(uint8_t service_id, uint8_t opcode, uint16_t len,
+							void *param, int fd)
+{
+	ipc_send(cmd_sk, service_id, opcode, len, param, fd);
+}
+
 void ipc_send_notif(uint8_t service_id, uint8_t opcode,  uint16_t len,
 								void *param)
 {
diff --git a/android/ipc.h b/android/ipc.h
index 1233bec..ce0e0b1 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -27,5 +27,7 @@ void ipc_cleanup(void);
 void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd);
 void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status);
+void ipc_send_rsp_full(uint8_t service_id, uint8_t opcode, uint16_t len,
+							void *param, int fd);
 void ipc_send_notif(uint8_t service_id, uint8_t opcode,  uint16_t len,
 								void *param);
-- 
1.8.3.2


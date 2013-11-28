Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/10] android: Add IPC helper for sending notifications
Date: Thu, 28 Nov 2013 15:15:24 +0100
Message-Id: <1385648130-12808-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
References: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will use notification socket passed on IPC init.
---
 android/ipc.c | 9 +++++++++
 android/ipc.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/android/ipc.c b/android/ipc.c
index 51734e3..d1a59d7 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -109,3 +109,12 @@ void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status)
 
 	ipc_send(cmd_sk, service_id, HAL_OP_STATUS, sizeof(s), &s, -1);
 }
+
+void ipc_send_notif(uint8_t service_id, uint8_t opcode,  uint16_t len,
+								void *param)
+{
+	if (notif_sk < 0)
+		return;
+
+	ipc_send(notif_sk, service_id, opcode, len, param, -1);
+}
diff --git a/android/ipc.h b/android/ipc.h
index 873f715..1233bec 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -27,3 +27,5 @@ void ipc_cleanup(void);
 void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd);
 void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status);
+void ipc_send_notif(uint8_t service_id, uint8_t opcode,  uint16_t len,
+								void *param);
-- 
1.8.3.2


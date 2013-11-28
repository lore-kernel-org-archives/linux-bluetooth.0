Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/10] android: Make ipc_send static
Date: Thu, 28 Nov 2013 15:15:28 +0100
Message-Id: <1385648130-12808-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
References: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It should not longer be used from outside of IPC code.
---
 android/ipc.c | 2 +-
 android/ipc.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/android/ipc.c b/android/ipc.c
index 83c2221..64b0db5 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -51,7 +51,7 @@ void ipc_cleanup(void)
 	notif_sk = -1;
 }
 
-void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
+static void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd)
 {
 	struct msghdr msg;
diff --git a/android/ipc.h b/android/ipc.h
index ce0e0b1..f66c9e0 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -24,8 +24,6 @@
 void ipc_init(int command_sk, int notification_sk);
 void ipc_cleanup(void);
 
-void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
-							void *param, int fd);
 void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status);
 void ipc_send_rsp_full(uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd);
-- 
1.8.3.2


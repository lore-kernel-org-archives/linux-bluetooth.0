Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/10] android/socket: Use ipc_send_rsp_full IPC helper
Date: Thu, 28 Nov 2013 15:15:27 +0100
Message-Id: <1385648130-12808-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
References: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use command reply helper for sending reply with file descriptor.
---
 android/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index c2212d9..6a5f4e8 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -909,7 +909,7 @@ void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 		if (fd < 0)
 			break;
 
-		ipc_send(sk, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
+		ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
 
 		if (close(fd) < 0)
 			error("close() fd %d failed: %s", fd, strerror(errno));
@@ -920,7 +920,7 @@ void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 		if (fd < 0)
 			break;
 
-		ipc_send(sk, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
+		ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
 
 		if (close(fd) < 0)
 			error("close() fd %d failed: %s", fd, strerror(errno));
-- 
1.8.3.2


Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv8 05/15] android/socket: Close file descriptor after sending
Date: Mon, 25 Nov 2013 11:44:48 +0200
Message-Id: <1385372698-16212-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385372698-16212-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385372698-16212-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index f9a6587..9f8c535 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -607,6 +607,7 @@ void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 			break;
 
 		ipc_send(sk, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
+		close(fd);
 		return;
 	case HAL_OP_SOCK_CONNECT:
 		fd = handle_connect(buf);
@@ -614,6 +615,7 @@ void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 			break;
 
 		ipc_send(sk, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
+		close(fd);
 		return;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
-- 
1.8.3.2


Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 14/19] android/socket: Close file descriptor after sending
Date: Tue, 19 Nov 2013 15:30:04 +0200
Message-Id: <1384867809-18135-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index ee2df1b..d2588cc 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -576,6 +576,7 @@ void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 			break;
 
 		ipc_send(sk, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
+		close(fd);
 		return;
 	case HAL_OP_SOCK_CONNECT:
 		fd = handle_connect(buf);
@@ -583,6 +584,7 @@ void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 			break;
 
 		ipc_send(sk, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
+		close(fd);
 		return;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
-- 
1.7.10.4


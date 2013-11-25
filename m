Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv9 17/21] android/socket: Add error printing possible close() failure
Date: Mon, 25 Nov 2013 15:08:53 +0200
Message-Id: <1385384937-29858-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385384937-29858-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385384937-29858-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 11358e3..db47667 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -96,10 +96,15 @@ static void cleanup_rfsock(struct rfcomm_sock *rfsock)
 	DBG("rfsock: %p fd %d real_sock %d chan %u",
 		rfsock, rfsock->fd, rfsock->real_sock, rfsock->channel);
 
-	if (rfsock->fd > 0)
-		close(rfsock->fd);
-	if (rfsock->real_sock > 0)
-		close(rfsock->real_sock);
+	if (rfsock->fd >= 0)
+		if (close(rfsock->fd) < 0)
+			error("close() fd %d failed: %s", rfsock->fd,
+							strerror(errno));
+
+	if (rfsock->real_sock >= 0)
+		if (close(rfsock->real_sock) < 0)
+			error("close() fd %d: failed: %s", rfsock->real_sock,
+							strerror(errno));
 
 	if (rfsock->rfcomm_watch > 0)
 		if (!g_source_remove(rfsock->rfcomm_watch))
@@ -891,7 +896,10 @@ void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 			break;
 
 		ipc_send(sk, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
-		close(fd);
+
+		if (close(fd) < 0)
+			error("close() fd %d failed: %s", fd, strerror(errno));
+
 		return;
 	case HAL_OP_SOCK_CONNECT:
 		fd = handle_connect(buf);
@@ -899,7 +907,10 @@ void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 			break;
 
 		ipc_send(sk, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
-		close(fd);
+
+		if (close(fd) < 0)
+			error("close() fd %d failed: %s", fd, strerror(errno));
+
 		return;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
-- 
1.8.3.2


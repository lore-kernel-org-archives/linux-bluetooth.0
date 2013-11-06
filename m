Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 11/14] android: Remove not needed buf len from Socket service functions
Date: Wed, 6 Nov 2013 15:09:27 +0100
Message-ID: <1383746970-25906-12-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Message correctness is verified upon reception and handling functions
can simply make assumption that data in buffer is correct.
---
 android/main.c   | 3 +--
 android/socket.c | 3 +--
 android/socket.h | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/android/main.c b/android/main.c
index 08bba4e..9cc3e1d 100644
--- a/android/main.c
+++ b/android/main.c
@@ -255,8 +255,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		bt_hid_handle_cmd(hal_cmd_io, msg->opcode, msg->payload);
 		break;
 	case HAL_SERVICE_ID_SOCK:
-		bt_sock_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
-								msg->len);
+		bt_sock_handle_cmd(hal_cmd_io, msg->opcode, msg->payload);
 		break;
 	case HAL_SERVICE_ID_A2DP:
 		bt_a2dp_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
diff --git a/android/socket.c b/android/socket.c
index e32be46..b9c556f 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -50,8 +50,7 @@ static int handle_connect(void *buf)
 	return -1;
 }
 
-void bt_sock_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-							uint16_t len)
+void bt_sock_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf)
 {
 	int fd;
 
diff --git a/android/socket.h b/android/socket.h
index 2b3b940..69cfc58 100644
--- a/android/socket.h
+++ b/android/socket.h
@@ -21,8 +21,7 @@
  *
  */
 
-void bt_sock_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-						uint16_t len);
+void bt_sock_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf);
 
 bool bt_socket_register(GIOChannel *io, const bdaddr_t *addr);
 void bt_socket_unregister(void);
-- 
1.8.4.2


Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 2/5] android: Initial implementation of socket interface
Date: Mon, 28 Oct 2013 13:30:06 +0100
Message-ID: <1382963409-1012-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1382963409-1012-1-git-send-email-marcin.kraglak@tieto.com>
References: <1382963409-1012-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add stub implementation of socket interace on daemon side.
---
 android/main.c   |  4 ++++
 android/socket.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 android/socket.h |  3 +++
 3 files changed, 49 insertions(+)

diff --git a/android/main.c b/android/main.c
index 6ff30a9..2b40621 100644
--- a/android/main.c
+++ b/android/main.c
@@ -213,6 +213,10 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		bt_hid_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
 								msg->len);
 		break;
+	case HAL_SERVICE_ID_SOCK:
+		bt_sock_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
+								msg->len);
+		break;
 	default:
 		ipc_send_rsp(hal_cmd_io, msg->service_id, HAL_STATUS_FAILED);
 		break;
diff --git a/android/socket.c b/android/socket.c
index 22d2acb..39709cd 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -26,8 +26,50 @@
 
 #include "lib/bluetooth.h"
 #include "log.h"
+#include "hal-msg.h"
+#include "hal-ipc.h"
+#include "ipc.h"
 #include "socket.h"
 
+
+static int handle_listen(void *buf)
+{
+	return -1;
+}
+
+static int handle_connect(void *buf)
+{
+	return -1;
+}
+
+void bt_sock_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
+							uint16_t len)
+{
+	int fd;
+
+	switch (opcode) {
+	case HAL_OP_SOCK_LISTEN:
+		fd = handle_listen(buf);
+		if (fd < 0)
+			break;
+
+		ipc_send(io, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
+		return;
+	case HAL_OP_SOCK_CONNECT:
+		fd = handle_connect(buf);
+		if (fd < 0)
+			break;
+
+		ipc_send(io, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
+		return;
+	default:
+		DBG("Unhandled command, opcode 0x%x", opcode);
+		break;
+	}
+
+	ipc_send_rsp(io, HAL_SERVICE_ID_SOCK, HAL_STATUS_FAILED);
+}
+
 bool bt_socket_register(GIOChannel *io, const bdaddr_t *addr)
 {
 	DBG("");
diff --git a/android/socket.h b/android/socket.h
index b13e84c..2b3b940 100644
--- a/android/socket.h
+++ b/android/socket.h
@@ -21,5 +21,8 @@
  *
  */
 
+void bt_sock_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
+						uint16_t len);
+
 bool bt_socket_register(GIOChannel *io, const bdaddr_t *addr);
 void bt_socket_unregister(void);
-- 
1.8.2.2


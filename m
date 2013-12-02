Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 9/9] android/socket: Use generic IPC message handling for commands
Date: Mon,  2 Dec 2013 13:20:48 +0100
Message-Id: <1385986848-8023-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
References: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handlers are registered on service register and unregistered on
unregister.
---
 android/socket.c | 102 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 49 insertions(+), 53 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 4f47861..76b40c8 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -650,15 +650,15 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 		rfsock_acc->rfcomm_watch);
 }
 
-static int handle_listen(void *buf)
+static void handle_listen(const void *buf, uint16_t len)
 {
-	struct hal_cmd_sock_listen *cmd = buf;
+	const struct hal_cmd_sock_listen *cmd = buf;
 	const struct profile_info *profile;
-	struct rfcomm_sock *rfsock;
+	struct rfcomm_sock *rfsock = NULL;
 	BtIOSecLevel sec_level;
 	GIOChannel *io;
 	GError *err = NULL;
-	int hal_fd;
+	int hal_fd = -1;
 	int chan;
 
 	DBG("");
@@ -666,11 +666,10 @@ static int handle_listen(void *buf)
 	profile = get_profile_by_uuid(cmd->uuid);
 	if (!profile) {
 		if (!cmd->channel)
-			return -1;
-		else {
-			chan = cmd->channel;
-			sec_level = BT_IO_SEC_MEDIUM;
-		}
+			goto failed;
+
+		chan = cmd->channel;
+		sec_level = BT_IO_SEC_MEDIUM;
 	} else {
 		chan = profile->channel;
 		sec_level = profile->sec_level;
@@ -680,7 +679,7 @@ static int handle_listen(void *buf)
 
 	rfsock = create_rfsock(-1, &hal_fd);
 	if (!rfsock)
-		return -1;
+		goto failed;
 
 	io = bt_io_listen(accept_cb, NULL, rfsock, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
@@ -690,8 +689,7 @@ static int handle_listen(void *buf)
 	if (!io) {
 		error("Failed listen: %s", err->message);
 		g_error_free(err);
-		cleanup_rfsock(rfsock);
-		return -1;
+		goto failed;
 	}
 
 	rfsock->real_sock = g_io_channel_unix_get_fd(io);
@@ -703,15 +701,27 @@ static int handle_listen(void *buf)
 
 	if (write(rfsock->fd, &chan, sizeof(chan)) != sizeof(chan)) {
 		error("Error sending RFCOMM channel");
-		cleanup_rfsock(rfsock);
-		return -1;
+		goto failed;
 	}
 
 	rfsock->service_handle = sdp_service_register(profile, cmd->name);
 
 	servers = g_list_append(servers, rfsock);
 
-	return hal_fd;
+	ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_LISTEN, 0, NULL,
+									hal_fd);
+	close(hal_fd);
+	return;
+
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_LISTEN,
+							HAL_STATUS_FAILED);
+
+	if (rfsock)
+		cleanup_rfsock(rfsock);
+
+	if (hal_fd >= 0)
+		close(hal_fd);
 }
 
 static bool sock_send_connect(struct rfcomm_sock *rfsock, bdaddr_t *bdaddr)
@@ -865,9 +875,9 @@ fail:
 	cleanup_rfsock(rfsock);
 }
 
-static int handle_connect(void *buf)
+static void handle_connect(const void *buf, uint16_t len)
 {
-	struct hal_cmd_sock_connect *cmd = buf;
+	const struct hal_cmd_sock_connect *cmd = buf;
 	struct rfcomm_sock *rfsock;
 	uuid_t uuid;
 	int hal_fd = -1;
@@ -876,7 +886,7 @@ static int handle_connect(void *buf)
 
 	rfsock = create_rfsock(-1, &hal_fd);
 	if (!rfsock)
-		return -1;
+		goto failed;
 
 	android2bdaddr(cmd->bdaddr, &rfsock->dst);
 
@@ -890,55 +900,41 @@ static int handle_connect(void *buf)
 					sdp_search_cb, rfsock, NULL) < 0) {
 		error("Failed to search SDP records");
 		cleanup_rfsock(rfsock);
-		return -1;
+		goto failed;
 	}
 
-	return hal_fd;
-}
-
-void bt_sock_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
-{
-	int fd;
-
-	switch (opcode) {
-	case HAL_OP_SOCK_LISTEN:
-		fd = handle_listen(buf);
-		if (fd < 0)
-			break;
-
-		ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
-
-		if (close(fd) < 0)
-			error("close() fd %d failed: %s", fd, strerror(errno));
-
-		return;
-	case HAL_OP_SOCK_CONNECT:
-		fd = handle_connect(buf);
-		if (fd < 0)
-			break;
-
-		ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
+	ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT, 0, NULL,
+									hal_fd);
+	close(hal_fd);
+	return;
 
-		if (close(fd) < 0)
-			error("close() fd %d failed: %s", fd, strerror(errno));
+failed:
+	ipc_send_rsp(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT,
+							HAL_STATUS_FAILED);
 
-		return;
-	default:
-		DBG("Unhandled command, opcode 0x%x", opcode);
-		break;
-	}
-
-	ipc_send_rsp(HAL_SERVICE_ID_SOCK, opcode, HAL_STATUS_FAILED);
+	if (hal_fd >= 0)
+		close(hal_fd);
 }
 
+static const struct ipc_handler cmd_handlers[] = {
+	/* HAL_OP_SOCK_LISTEN */
+	{ handle_listen, false, sizeof(struct hal_cmd_sock_listen) },
+	/* HAL_OP_SOCK_CONNECT */
+	{ handle_connect, false, sizeof(struct hal_cmd_sock_connect) },
+};
+
 void bt_socket_register(const bdaddr_t *addr)
 {
 	DBG("");
 
 	bacpy(&adapter_addr, addr);
+	ipc_register(HAL_SERVICE_ID_SOCK, cmd_handlers,
+				sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
 }
 
 void bt_socket_unregister(void)
 {
 	DBG("");
+
+	ipc_unregister(HAL_SERVICE_ID_SOCK);
 }
-- 
1.8.3.2


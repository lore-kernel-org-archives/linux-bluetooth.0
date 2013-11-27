Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 11/13] android/socket: Use generic IPC message handling for commands
Date: Wed, 27 Nov 2013 12:55:03 +0100
Message-Id: <1385553305-5807-12-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
References: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handlers are registered on service register and unregistered on
unregister.
---
 android/socket.c | 111 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 52 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 47338e7..ba97d8a 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -52,6 +52,7 @@
 
 #define SVC_HINT_OBEX 0x10
 
+static int command_sk = -1;
 static bdaddr_t adapter_addr;
 
 /* Simple list of RFCOMM server sockets */
@@ -655,15 +656,15 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
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
@@ -671,11 +672,10 @@ static int handle_listen(void *buf)
 	profile = get_profile_by_uuid(cmd->uuid);
 	if (!profile) {
 		if (!cmd->channel)
-			return -1;
-		else {
-			chan = cmd->channel;
-			sec_level = BT_IO_SEC_MEDIUM;
-		}
+			goto fail;
+
+		chan = cmd->channel;
+		sec_level = BT_IO_SEC_MEDIUM;
 	} else {
 		chan = profile->channel;
 		sec_level = profile->sec_level;
@@ -685,7 +685,7 @@ static int handle_listen(void *buf)
 
 	rfsock = create_rfsock(-1, &hal_fd);
 	if (!rfsock)
-		return -1;
+		goto fail;
 
 	io = bt_io_listen(accept_cb, NULL, rfsock, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
@@ -695,8 +695,7 @@ static int handle_listen(void *buf)
 	if (!io) {
 		error("Failed listen: %s", err->message);
 		g_error_free(err);
-		cleanup_rfsock(rfsock);
-		return -1;
+		goto fail;
 	}
 
 	rfsock->real_sock = g_io_channel_unix_get_fd(io);
@@ -711,13 +710,25 @@ static int handle_listen(void *buf)
 
 	if (write(rfsock->fd, &chan, sizeof(chan)) != sizeof(chan)) {
 		error("Error sending RFCOMM channel");
-		cleanup_rfsock(rfsock);
-		return -1;
+		goto fail;
 	}
 
 	rfsock->service_handle = sdp_service_register(profile, cmd->name);
 
-	return hal_fd;
+	ipc_send(command_sk, HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_LISTEN, 0, NULL,
+								hal_fd);
+	close(hal_fd);
+	return;
+
+fail:
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_LISTEN,
+							HAL_STATUS_FAILED);
+
+	if (rfsock)
+		cleanup_rfsock(rfsock);
+
+	if (hal_fd >= 0)
+		close(hal_fd);
 }
 
 static bool sock_send_connect(struct rfcomm_sock *rfsock, bdaddr_t *bdaddr)
@@ -868,9 +879,9 @@ fail:
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
@@ -893,57 +904,53 @@ static int handle_connect(void *buf)
 					sdp_search_cb, rfsock, NULL) < 0) {
 		error("Failed to search SDP records");
 		cleanup_rfsock(rfsock);
-		return -1;
+		goto fail;
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
-		ipc_send(sk, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
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
-		ipc_send(sk, HAL_SERVICE_ID_SOCK, opcode, 0, NULL, fd);
-
-		if (close(fd) < 0)
-			error("close() fd %d failed: %s", fd, strerror(errno));
+	ipc_send(command_sk, HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT, 0, NULL,
+								hal_fd);
+	close(hal_fd);
+	return;
 
-		return;
-	default:
-		DBG("Unhandled command, opcode 0x%x", opcode);
-		break;
-	}
+fail:
+	ipc_send_rsp(command_sk, HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT,
+							HAL_STATUS_FAILED);
 
-	ipc_send_rsp(sk, HAL_SERVICE_ID_SOCK, opcode, HAL_STATUS_FAILED);
+	if (hal_fd >= 0)
+		close(hal_fd);
 }
 
+static const struct ipc_handler cmd_handlers[] = {
+	{	/* HAL_OP_SOCK_LISTEN */
+		.handler = handle_listen,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_sock_listen)
+	},
+	{	/* HAL_OP_SOCK_CONNECT */
+		.handler = handle_connect,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_sock_connect)
+	},
+};
+
 bool bt_socket_register(int cmd_sk, int notif_sk, const bdaddr_t *addr)
 {
 	DBG("");
 
+	command_sk = cmd_sk;
 	bacpy(&adapter_addr, addr);
 
+	ipc_register(HAL_SERVICE_ID_SOCK, cmd_handlers,
+				sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
+
 	return true;
 }
 
 void bt_socket_unregister(void)
 {
 	DBG("");
+
+	command_sk = -1;
+
+	ipc_unregister(HAL_SERVICE_ID_SOCK);
 }
-- 
1.8.3.2


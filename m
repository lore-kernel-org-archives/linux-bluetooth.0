Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 02/11] android/socket: Refactor socket related symbol names
Date: Tue, 11 Feb 2014 17:58:12 +0100
Message-ID: <1392137901-3403-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes names of symbols related to various sockets to be
consistent and easier to follow in code.

Symbols related to actual BT (RFCOMM) socket are prefixed with "bt_".
Symbols related to local socket for Java comm are prefixed with "jv_".
Remote socket for Java comm is called "hal_sock".
---
 android/socket.c | 186 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 95 insertions(+), 91 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 1375625..107042e 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -71,12 +71,15 @@ GList *servers = NULL;
 GList *connections = NULL;
 
 struct rfcomm_sock {
-	int fd;		/* descriptor for communication with Java framework */
-	int real_sock;	/* real RFCOMM socket */
 	int channel;	/* RFCOMM channel */
 
-	guint rfcomm_watch;
-	guint stack_watch;
+	/* for socket to BT */
+	int bt_sock;
+	guint bt_watch;
+
+	/* for socket to HAL */
+	int jv_sock;
+	guint jv_watch;
 
 	bdaddr_t dst;
 	uint32_t service_handle;
@@ -92,13 +95,13 @@ static int rfsock_set_buffer(struct rfcomm_sock *rfsock)
 	socklen_t len = sizeof(int);
 	int rcv, snd, size, err;
 
-	err = getsockopt(rfsock->real_sock, SOL_SOCKET, SO_RCVBUF, &rcv, &len);
+	err = getsockopt(rfsock->bt_sock, SOL_SOCKET, SO_RCVBUF, &rcv, &len);
 	if (err < 0) {
 		error("getsockopt(SO_RCVBUF): %s", strerror(errno));
 		return -errno;
 	}
 
-	err = getsockopt(rfsock->real_sock, SOL_SOCKET, SO_SNDBUF, &snd, &len);
+	err = getsockopt(rfsock->bt_sock, SOL_SOCKET, SO_SNDBUF, &snd, &len);
 	if (err < 0) {
 		error("getsockopt(SO_SNDBUF): %s", strerror(errno));
 		return -errno;
@@ -118,25 +121,25 @@ static void cleanup_rfsock(gpointer data)
 {
 	struct rfcomm_sock *rfsock = data;
 
-	DBG("rfsock: %p fd %d real_sock %d chan %u",
-		rfsock, rfsock->fd, rfsock->real_sock, rfsock->channel);
+	DBG("rfsock: %p jv_sock %d bt_sock %d chan %u",
+		rfsock, rfsock->jv_sock, rfsock->bt_sock, rfsock->channel);
 
-	if (rfsock->fd >= 0)
-		if (close(rfsock->fd) < 0)
-			error("close() fd %d failed: %s", rfsock->fd,
+	if (rfsock->jv_sock >= 0)
+		if (close(rfsock->jv_sock) < 0)
+			error("close() fd %d failed: %s", rfsock->jv_sock,
 							strerror(errno));
 
-	if (rfsock->real_sock >= 0)
-		if (close(rfsock->real_sock) < 0)
-			error("close() fd %d: failed: %s", rfsock->real_sock,
+	if (rfsock->bt_sock >= 0)
+		if (close(rfsock->bt_sock) < 0)
+			error("close() fd %d: failed: %s", rfsock->bt_sock,
 							strerror(errno));
 
-	if (rfsock->rfcomm_watch > 0)
-		if (!g_source_remove(rfsock->rfcomm_watch))
-			error("rfcomm_watch source was not found");
+	if (rfsock->bt_watch > 0)
+		if (!g_source_remove(rfsock->bt_watch))
+			error("bt_watch source was not found");
 
-	if (rfsock->stack_watch > 0)
-		if (!g_source_remove(rfsock->stack_watch))
+	if (rfsock->jv_watch > 0)
+		if (!g_source_remove(rfsock->jv_watch))
 			error("stack_watch source was not found");
 
 	if (rfsock->service_handle)
@@ -148,23 +151,23 @@ static void cleanup_rfsock(gpointer data)
 	g_free(rfsock);
 }
 
-static struct rfcomm_sock *create_rfsock(int sock, int *hal_fd)
+static struct rfcomm_sock *create_rfsock(int bt_sock, int *hal_sock)
 {
 	int fds[2] = {-1, -1};
 	struct rfcomm_sock *rfsock;
 
 	if (socketpair(AF_LOCAL, SOCK_STREAM, 0, fds) < 0) {
 		error("socketpair(): %s", strerror(errno));
-		*hal_fd = -1;
+		*hal_sock = -1;
 		return NULL;
 	}
 
 	rfsock = g_new0(struct rfcomm_sock, 1);
-	rfsock->fd = fds[0];
-	*hal_fd = fds[1];
-	rfsock->real_sock = sock;
+	rfsock->jv_sock = fds[0];
+	*hal_sock = fds[1];
+	rfsock->bt_sock = bt_sock;
 
-	if (sock < 0)
+	if (bt_sock < 0)
 		return rfsock;
 
 	if (rfsock_set_buffer(rfsock) < 0) {
@@ -604,7 +607,7 @@ static int try_write_all(int fd, unsigned char *buf, int len)
 	return sent;
 }
 
-static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
+static gboolean jv_sock_client_event_cb(GIOChannel *io, GIOCondition cond,
 								gpointer data)
 {
 	struct rfcomm_sock *rfsock = data;
@@ -621,14 +624,14 @@ static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
 		goto fail;
 	}
 
-	len = read(rfsock->fd, rfsock->buf, rfsock->buf_size);
+	len = read(rfsock->jv_sock, rfsock->buf, rfsock->buf_size);
 	if (len <= 0) {
 		error("read(): %s", strerror(errno));
 		/* Read again */
 		return TRUE;
 	}
 
-	sent = try_write_all(rfsock->real_sock, rfsock->buf, len);
+	sent = try_write_all(rfsock->bt_sock, rfsock->buf, len);
 	if (sent < 0) {
 		error("write(): %s", strerror(errno));
 		goto fail;
@@ -642,7 +645,7 @@ fail:
 	return FALSE;
 }
 
-static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
+static gboolean bt_sock_event_cb(GIOChannel *io, GIOCondition cond,
 								gpointer data)
 {
 	struct rfcomm_sock *rfsock = data;
@@ -659,14 +662,14 @@ static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
 		goto fail;
 	}
 
-	len = read(rfsock->real_sock, rfsock->buf, rfsock->buf_size);
+	len = read(rfsock->bt_sock, rfsock->buf, rfsock->buf_size);
 	if (len <= 0) {
 		error("read(): %s", strerror(errno));
 		/* Read again */
 		return TRUE;
 	}
 
-	sent = try_write_all(rfsock->fd, rfsock->buf, len);
+	sent = try_write_all(rfsock->jv_sock, rfsock->buf, len);
 	if (sent < 0) {
 		error("write(): %s", strerror(errno));
 		goto fail;
@@ -693,7 +696,7 @@ static bool sock_send_accept(struct rfcomm_sock *rfsock, bdaddr_t *bdaddr,
 	cmd.channel = rfsock->channel;
 	cmd.status = 0;
 
-	len = bt_sock_send_fd(rfsock->fd, &cmd, sizeof(cmd), fd_accepted);
+	len = bt_sock_send_fd(rfsock->jv_sock, &cmd, sizeof(cmd), fd_accepted);
 	if (len != sizeof(cmd)) {
 		error("Error sending accept signal");
 		return false;
@@ -702,7 +705,7 @@ static bool sock_send_accept(struct rfcomm_sock *rfsock, bdaddr_t *bdaddr,
 	return true;
 }
 
-static gboolean sock_server_stack_event_cb(GIOChannel *io, GIOCondition cond,
+static gboolean jv_sock_server_event_cb(GIOChannel *io, GIOCondition cond,
 								gpointer data)
 {
 	struct rfcomm_sock *rfsock = data;
@@ -723,13 +726,13 @@ static gboolean sock_server_stack_event_cb(GIOChannel *io, GIOCondition cond,
 static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct rfcomm_sock *rfsock = user_data;
-	struct rfcomm_sock *rfsock_acc;
-	GIOChannel *io_stack;
+	struct rfcomm_sock *new_rfsock;
+	GIOChannel *jv_io;
 	GError *gerr = NULL;
 	bdaddr_t dst;
 	char address[18];
-	int sock_acc;
-	int hal_fd;
+	int new_sock;
+	int hal_sock;
 	guint id;
 	GIOCondition cond;
 
@@ -751,51 +754,51 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 	ba2str(&dst, address);
 	DBG("Incoming connection from %s rfsock %p", address, rfsock);
 
-	sock_acc = g_io_channel_unix_get_fd(io);
-	rfsock_acc = create_rfsock(sock_acc, &hal_fd);
-	if (!rfsock_acc) {
+	new_sock = g_io_channel_unix_get_fd(io);
+	new_rfsock = create_rfsock(new_sock, &hal_sock);
+	if (!new_rfsock) {
 		g_io_channel_shutdown(io, TRUE, NULL);
 		return;
 	}
 
-	DBG("rfsock: fd %d real_sock %d chan %u sock %d",
-		rfsock->fd, rfsock->real_sock, rfsock->channel,
-		sock_acc);
+	DBG("rfsock: jv_sock %d bt_sock %d chan %u new_sock %d",
+		rfsock->jv_sock, rfsock->bt_sock, rfsock->channel,
+		new_sock);
 
-	if (!sock_send_accept(rfsock, &dst, hal_fd)) {
-		cleanup_rfsock(rfsock_acc);
+	if (!sock_send_accept(rfsock, &dst, hal_sock)) {
+		cleanup_rfsock(new_rfsock);
 		return;
 	}
 
-	connections = g_list_append(connections, rfsock_acc);
+	connections = g_list_append(connections, new_rfsock);
 
 	/* Handle events from Android */
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_stack = g_io_channel_unix_new(rfsock_acc->fd);
-	id = g_io_add_watch(io_stack, cond, sock_stack_event_cb, rfsock_acc);
-	g_io_channel_unref(io_stack);
+	jv_io = g_io_channel_unix_new(new_rfsock->jv_sock);
+	id = g_io_add_watch(jv_io, cond, jv_sock_client_event_cb, new_rfsock);
+	g_io_channel_unref(jv_io);
 
-	rfsock_acc->stack_watch = id;
+	new_rfsock->jv_watch = id;
 
 	/* Handle rfcomm events */
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	id = g_io_add_watch(io, cond, sock_rfcomm_event_cb, rfsock_acc);
+	id = g_io_add_watch(io, cond, bt_sock_event_cb, new_rfsock);
 	g_io_channel_set_close_on_unref(io, FALSE);
 
-	rfsock_acc->rfcomm_watch = id;
+	new_rfsock->bt_watch = id;
 
-	DBG("rfsock %p rfsock_acc %p stack_watch %d rfcomm_watch %d",
-		rfsock, rfsock_acc, rfsock_acc->stack_watch,
-		rfsock_acc->rfcomm_watch);
+	DBG("rfsock %p rfsock_acc %p jv_watch %d bt_watch %d",
+		rfsock, new_rfsock, new_rfsock->jv_watch,
+		new_rfsock->bt_watch);
 }
 
 static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
-						uint8_t flags, int *hal_fd)
+						uint8_t flags, int *hal_sock)
 {
 	const struct profile_info *profile;
 	struct rfcomm_sock *rfsock = NULL;
 	BtIOSecLevel sec_level;
-	GIOChannel *io, *io_stack;
+	GIOChannel *io, *jv_io;
 	GIOCondition cond;
 	GError *err = NULL;
 	guint id;
@@ -820,7 +823,7 @@ static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 
 	DBG("rfcomm channel %d svc_name %s", chan, name);
 
-	rfsock = create_rfsock(-1, hal_fd);
+	rfsock = create_rfsock(-1, hal_sock);
 	if (!rfsock)
 		return HAL_STATUS_FAILED;
 
@@ -835,25 +838,25 @@ static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 		goto failed;
 	}
 
-	rfsock->real_sock = g_io_channel_unix_get_fd(io);
+	rfsock->bt_sock = g_io_channel_unix_get_fd(io);
 
 	g_io_channel_set_close_on_unref(io, FALSE);
 	g_io_channel_unref(io);
 
 	/* Handle events from Android */
 	cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_stack = g_io_channel_unix_new(rfsock->fd);
-	id = g_io_add_watch_full(io_stack, G_PRIORITY_HIGH, cond,
-					sock_server_stack_event_cb, rfsock,
+	jv_io = g_io_channel_unix_new(rfsock->jv_sock);
+	id = g_io_add_watch_full(jv_io, G_PRIORITY_HIGH, cond,
+					jv_sock_server_event_cb, rfsock,
 					NULL);
-	g_io_channel_unref(io_stack);
+	g_io_channel_unref(jv_io);
 
-	rfsock->stack_watch = id;
+	rfsock->jv_watch = id;
 
-	DBG("real_sock %d fd %d hal_fd %d", rfsock->real_sock, rfsock->fd,
-								*hal_fd);
+	DBG("bt_sock %d jv_sock %d hal_sock %d", rfsock->bt_sock,
+						rfsock->jv_sock, *hal_sock);
 
-	if (write(rfsock->fd, &chan, sizeof(chan)) != sizeof(chan)) {
+	if (write(rfsock->jv_sock, &chan, sizeof(chan)) != sizeof(chan)) {
 		error("Error sending RFCOMM channel");
 		goto failed;
 	}
@@ -867,7 +870,7 @@ static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
 failed:
 
 	cleanup_rfsock(rfsock);
-	close(*hal_fd);
+	close(*hal_sock);
 	return HAL_STATUS_FAILED;
 }
 
@@ -875,12 +878,12 @@ static void handle_listen(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_sock_listen *cmd = buf;
 	uint8_t status;
-	int hal_fd;
+	int hal_sock;
 
 	switch (cmd->type) {
 	case HAL_SOCK_RFCOMM:
 		status = rfcomm_listen(cmd->channel, cmd->name, cmd->uuid,
-							cmd->flags, &hal_fd);
+							cmd->flags, &hal_sock);
 		break;
 	case HAL_SOCK_SCO:
 	case HAL_SOCK_L2CAP:
@@ -895,8 +898,8 @@ static void handle_listen(const void *buf, uint16_t len)
 		goto failed;
 
 	ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_LISTEN, 0, NULL,
-									hal_fd);
-	close(hal_fd);
+								hal_sock);
+	close(hal_sock);
 	return ;
 
 failed:
@@ -916,7 +919,7 @@ static bool sock_send_connect(struct rfcomm_sock *rfsock, bdaddr_t *bdaddr)
 	cmd.channel = rfsock->channel;
 	cmd.status = 0;
 
-	len = write(rfsock->fd, &cmd, sizeof(cmd));
+	len = write(rfsock->jv_sock, &cmd, sizeof(cmd));
 	if (len < 0) {
 		error("%s", strerror(errno));
 		return false;
@@ -934,7 +937,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct rfcomm_sock *rfsock = user_data;
 	bdaddr_t *dst = &rfsock->dst;
-	GIOChannel *io_stack;
+	GIOChannel *jv_io;
 	char address[18];
 	guint id;
 	GIOCondition cond;
@@ -947,8 +950,8 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	ba2str(dst, address);
 	DBG("Connected to %s", address);
 
-	DBG("rfsock: fd %d real_sock %d chan %u sock %d",
-		rfsock->fd, rfsock->real_sock, rfsock->channel,
+	DBG("rfsock: jv_sock %d bt_sock %d chan %u sock %d",
+		rfsock->jv_sock, rfsock->bt_sock, rfsock->channel,
 		g_io_channel_unix_get_fd(io));
 
 	if (!sock_send_connect(rfsock, dst))
@@ -956,18 +959,18 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 
 	/* Handle events from Android */
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_stack = g_io_channel_unix_new(rfsock->fd);
-	id = g_io_add_watch(io_stack, cond, sock_stack_event_cb, rfsock);
-	g_io_channel_unref(io_stack);
+	jv_io = g_io_channel_unix_new(rfsock->jv_sock);
+	id = g_io_add_watch(jv_io, cond, jv_sock_client_event_cb, rfsock);
+	g_io_channel_unref(jv_io);
 
-	rfsock->stack_watch = id;
+	rfsock->jv_watch = id;
 
 	/* Handle rfcomm events */
 	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-	id = g_io_add_watch(io, cond, sock_rfcomm_event_cb, rfsock);
+	id = g_io_add_watch(io, cond, bt_sock_event_cb, rfsock);
 	g_io_channel_set_close_on_unref(io, FALSE);
 
-	rfsock->rfcomm_watch = id;
+	rfsock->bt_watch = id;
 
 	return;
 fail:
@@ -999,12 +1002,12 @@ static bool do_rfcomm_connect(struct rfcomm_sock *rfsock, int chan)
 	g_io_channel_set_close_on_unref(io, FALSE);
 	g_io_channel_unref(io);
 
-	if (write(rfsock->fd, &chan, sizeof(chan)) != sizeof(chan)) {
+	if (write(rfsock->jv_sock, &chan, sizeof(chan)) != sizeof(chan)) {
 		error("Error sending RFCOMM channel");
 		return false;
 	}
 
-	rfsock->real_sock = g_io_channel_unix_get_fd(io);
+	rfsock->bt_sock = g_io_channel_unix_get_fd(io);
 	rfsock_set_buffer(rfsock);
 	rfsock->channel = chan;
 	connections = g_list_append(connections, rfsock);
@@ -1063,7 +1066,8 @@ fail:
 }
 
 static uint8_t connect_rfcomm(const bdaddr_t *addr, int chan,
-				const uint8_t *uuid, uint8_t flags, int *hal_fd)
+					const uint8_t *uuid, uint8_t flags,
+					int *hal_sock)
 {
 	struct rfcomm_sock *rfsock;
 	uuid_t uu;
@@ -1074,7 +1078,7 @@ static uint8_t connect_rfcomm(const bdaddr_t *addr, int chan,
 		return HAL_STATUS_INVALID;
 	}
 
-	rfsock = create_rfsock(-1, hal_fd);
+	rfsock = create_rfsock(-1, hal_sock);
 	if (!rfsock)
 		return HAL_STATUS_FAILED;
 
@@ -1101,7 +1105,7 @@ static uint8_t connect_rfcomm(const bdaddr_t *addr, int chan,
 
 failed:
 	cleanup_rfsock(rfsock);
-	close(*hal_fd);
+	close(*hal_sock);
 	return HAL_STATUS_FAILED;
 }
 
@@ -1110,7 +1114,7 @@ static void handle_connect(const void *buf, uint16_t len)
 	const struct hal_cmd_sock_connect *cmd = buf;
 	bdaddr_t bdaddr;
 	uint8_t status;
-	int hal_fd;
+	int hal_sock;
 
 	DBG("");
 
@@ -1119,7 +1123,7 @@ static void handle_connect(const void *buf, uint16_t len)
 	switch (cmd->type) {
 	case HAL_SOCK_RFCOMM:
 		status = connect_rfcomm(&bdaddr, cmd->channel, cmd->uuid,
-							cmd->flags, &hal_fd);
+							cmd->flags, &hal_sock);
 		break;
 	case HAL_SOCK_SCO:
 	case HAL_SOCK_L2CAP:
@@ -1134,8 +1138,8 @@ static void handle_connect(const void *buf, uint16_t len)
 		goto failed;
 
 	ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT, 0, NULL,
-									hal_fd);
-	close(hal_fd);
+								hal_sock);
+	close(hal_sock);
 	return;
 
 failed:
-- 
1.8.5.3


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/3] android/socket: Move logic from HAL to daemon in listen
Date: Sat,  4 Jan 2014 21:16:13 +0100
Message-Id: <1388866574-20158-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1388866574-20158-1-git-send-email-szymon.janc@gmail.com>
References: <1388866574-20158-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reduce logic in HAL to bare minimum e.g. no modifications in
library will be needed to add different socket type support.

Both bdaddr2str and btuuid2str handle NULL pointers so it is safe to
print debug unconditionally.
---
 android/hal-msg.h  |  4 +++
 android/hal-sock.c | 36 ++++++--------------------
 android/socket.c   | 74 +++++++++++++++++++++++++++++++++++++-----------------
 3 files changed, 63 insertions(+), 51 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index bbbb99c..ceaa3b2 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -231,6 +231,10 @@ struct hal_cmd_le_test_mode {
 
 /* Bluetooth Socket HAL api */
 
+#define HAL_SOCK_RFCOMM		0x01
+#define HAL_SOCK_SCO		0x02
+#define HAL_SOCK_L2CAP		0x03
+
 #define HAL_OP_SOCK_LISTEN		0x01
 struct hal_cmd_sock_listen {
 	uint8_t type;
diff --git a/android/hal-sock.c b/android/hal-sock.c
index c39ca6a..47de63d 100644
--- a/android/hal-sock.c
+++ b/android/hal-sock.c
@@ -26,18 +26,23 @@
 #include "hal-utils.h"
 #include "hal.h"
 
-static bt_status_t sock_listen_rfcomm(const char *service_name,
+static bt_status_t sock_listen(btsock_type_t type, const char *service_name,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
 {
 	struct hal_cmd_sock_listen cmd;
 
-	DBG("");
+	if (!sock)
+		return BT_STATUS_PARM_INVALID;
+
+	DBG("uuid %s chan %d sock %p type %d service_name %s flags 0x%02x",
+		btuuid2str(uuid), chan, sock, type, service_name, flags);
 
 	memset(&cmd, 0, sizeof(cmd));
 
+	/* type match IPC type */
+	cmd.type = type;
 	cmd.flags = flags;
-	cmd.type = BTSOCK_RFCOMM;
 	cmd.channel = chan;
 
 	if (uuid)
@@ -50,31 +55,6 @@ static bt_status_t sock_listen_rfcomm(const char *service_name,
 				sizeof(cmd), &cmd, NULL, NULL, sock);
 }
 
-static bt_status_t sock_listen(btsock_type_t type, const char *service_name,
-					const uint8_t *uuid, int chan,
-					int *sock, int flags)
-{
-	if ((!uuid && chan <= 0) || !sock || !type) {
-		error("Invalid params: uuid %s, chan %d, sock %p",
-						btuuid2str(uuid), chan, sock);
-		return BT_STATUS_PARM_INVALID;
-	}
-
-	DBG("uuid %s chan %d sock %p type %d service_name %s flags 0x%02x",
-		btuuid2str(uuid), chan, sock, type, service_name, flags);
-
-	switch (type) {
-	case BTSOCK_RFCOMM:
-		return sock_listen_rfcomm(service_name, uuid, chan, sock,
-									flags);
-	default:
-		error("%s: Socket type %d not supported", __func__, type);
-		break;
-	}
-
-	return BT_STATUS_UNSUPPORTED;
-}
-
 static bt_status_t sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
diff --git a/android/socket.c b/android/socket.c
index f68fbf0..98862cb 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -62,6 +62,8 @@
 
 static bdaddr_t adapter_addr;
 
+static const uint8_t zero_uuid[16] = { 0 };
+
 /* Simple list of RFCOMM server sockets */
 GList *servers = NULL;
 
@@ -787,38 +789,40 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 		rfsock_acc->rfcomm_watch);
 }
 
-static void handle_listen(const void *buf, uint16_t len)
+static uint8_t rfcomm_listen(int chan, const uint8_t *name, const uint8_t *uuid,
+						uint8_t flags, int *hal_fd)
 {
-	const struct hal_cmd_sock_listen *cmd = buf;
 	const struct profile_info *profile;
 	struct rfcomm_sock *rfsock = NULL;
 	BtIOSecLevel sec_level;
 	GIOChannel *io, *io_stack;
 	GIOCondition cond;
 	GError *err = NULL;
-	int hal_fd = -1;
-	int chan;
 	guint id;
 
 	DBG("");
 
-	profile = get_profile_by_uuid(cmd->uuid);
+	if (!memcmp(uuid, zero_uuid, sizeof(zero_uuid)) && chan <= 0) {
+		error("Invalid rfcomm listen params");
+		return HAL_STATUS_INVALID;
+	}
+
+	profile = get_profile_by_uuid(uuid);
 	if (!profile) {
-		if (cmd->channel <= 0)
-			goto failed;
+		if (chan <= 0)
+			return HAL_STATUS_INVALID;
 
-		chan = cmd->channel;
 		sec_level = BT_IO_SEC_MEDIUM;
 	} else {
 		chan = profile->channel;
 		sec_level = profile->sec_level;
 	}
 
-	DBG("rfcomm channel %d svc_name %s", chan, cmd->name);
+	DBG("rfcomm channel %d svc_name %s", chan, name);
 
-	rfsock = create_rfsock(-1, &hal_fd);
+	rfsock = create_rfsock(-1, hal_fd);
 	if (!rfsock)
-		goto failed;
+		return HAL_STATUS_FAILED;
 
 	io = bt_io_listen(accept_cb, NULL, rfsock, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
@@ -847,31 +851,56 @@ static void handle_listen(const void *buf, uint16_t len)
 	rfsock->stack_watch = id;
 
 	DBG("real_sock %d fd %d hal_fd %d", rfsock->real_sock, rfsock->fd,
-								hal_fd);
+								*hal_fd);
 
 	if (write(rfsock->fd, &chan, sizeof(chan)) != sizeof(chan)) {
 		error("Error sending RFCOMM channel");
 		goto failed;
 	}
 
-	rfsock->service_handle = sdp_service_register(profile, cmd->name);
+	rfsock->service_handle = sdp_service_register(profile, name);
 
 	servers = g_list_append(servers, rfsock);
 
+	return HAL_STATUS_SUCCESS;
+
+failed:
+
+	cleanup_rfsock(rfsock);
+	close(*hal_fd);
+	return HAL_STATUS_FAILED;
+}
+
+static void handle_listen(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_sock_listen *cmd = buf;
+	uint8_t status;
+	int hal_fd;
+
+	switch (cmd->type) {
+	case HAL_SOCK_RFCOMM:
+		status = rfcomm_listen(cmd->channel, cmd->name, cmd->uuid,
+							cmd->flags, &hal_fd);
+		break;
+	case HAL_SOCK_SCO:
+	case HAL_SOCK_L2CAP:
+		status = HAL_STATUS_UNSUPPORTED;
+		break;
+	default:
+		status = HAL_STATUS_INVALID;
+		break;
+	}
+
+	if (status != HAL_STATUS_SUCCESS)
+		goto failed;
+
 	ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_LISTEN, 0, NULL,
 									hal_fd);
 	close(hal_fd);
-	return;
+	return ;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_LISTEN,
-							HAL_STATUS_FAILED);
-
-	if (rfsock)
-		cleanup_rfsock(rfsock);
-
-	if (hal_fd >= 0)
-		close(hal_fd);
+	ipc_send_rsp(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_LISTEN, status);
 }
 
 static bool sock_send_connect(struct rfcomm_sock *rfsock, bdaddr_t *bdaddr)
@@ -1036,7 +1065,6 @@ fail:
 static void handle_connect(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_sock_connect *cmd = buf;
-	static const uint8_t zero_uuid[16] = { 0 };
 	struct rfcomm_sock *rfsock;
 	uuid_t uuid;
 	int hal_fd = -1;
-- 
1.8.5.2


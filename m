Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 3/3] android/socket: Move logic from HAL to daemon in connect
Date: Sat,  4 Jan 2014 21:16:14 +0100
Message-Id: <1388866574-20158-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1388866574-20158-1-git-send-email-szymon.janc@gmail.com>
References: <1388866574-20158-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reduce logic in HAL to bare minimum e.g. no modifications in
library will be needed to add different socket type support.

Both bdaddr2str and btuuid2str handle NULL pointers so it is safe to
print debug unconditionally.
---
 android/hal-sock.c | 16 ++++-------
 android/socket.c   | 81 ++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 62 insertions(+), 35 deletions(-)

diff --git a/android/hal-sock.c b/android/hal-sock.c
index 47de63d..f62b7ef 100644
--- a/android/hal-sock.c
+++ b/android/hal-sock.c
@@ -61,30 +61,24 @@ static bt_status_t sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 {
 	struct hal_cmd_sock_connect cmd;
 
-	if ((!uuid && chan <= 0) || !bdaddr || !sock || !type) {
-		error("Invalid params: bd_addr %s, uuid %s, chan %d, sock %p",
-			bdaddr2str(bdaddr), btuuid2str(uuid), chan, sock);
+	if (!sock)
 		return BT_STATUS_PARM_INVALID;
-	}
 
 	DBG("bdaddr %s uuid %s chan %d sock %p type %d flags 0x%02x",
 		bdaddr2str(bdaddr), btuuid2str(uuid), chan, sock, type, flags);
 
-	if (type != BTSOCK_RFCOMM) {
-		error("Socket type %u not supported", type);
-		return BT_STATUS_UNSUPPORTED;
-	}
-
 	memset(&cmd, 0, sizeof(cmd));
 
-	cmd.flags = flags;
+	/* type match IPC type */
 	cmd.type = type;
+	cmd.flags = flags;
 	cmd.channel = chan;
 
 	if (uuid)
 		memcpy(cmd.uuid, uuid, sizeof(cmd.uuid));
 
-	memcpy(cmd.bdaddr, bdaddr, sizeof(cmd.bdaddr));
+	if (bdaddr)
+		memcpy(cmd.bdaddr, bdaddr, sizeof(cmd.bdaddr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT,
 					sizeof(cmd), &cmd, NULL, NULL, sock);
diff --git a/android/socket.c b/android/socket.c
index 98862cb..69b39ee 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -975,7 +975,7 @@ fail:
 	cleanup_rfsock(rfsock);
 }
 
-static bool do_connect(struct rfcomm_sock *rfsock, int chan)
+static bool do_rfcomm_connect(struct rfcomm_sock *rfsock, int chan)
 {
 	BtIOSecLevel sec_level = BT_IO_SEC_MEDIUM;
 	GIOChannel *io;
@@ -1056,58 +1056,91 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 
 	DBG("Got RFCOMM channel %d", chan);
 
-	if (do_connect(rfsock, chan))
+	if (do_rfcomm_connect(rfsock, chan))
 		return;
 fail:
 	cleanup_rfsock(rfsock);
 }
 
-static void handle_connect(const void *buf, uint16_t len)
+static uint8_t connect_rfcomm(const bdaddr_t *addr, int chan,
+				const uint8_t *uuid, uint8_t flags, int *hal_fd)
 {
-	const struct hal_cmd_sock_connect *cmd = buf;
 	struct rfcomm_sock *rfsock;
-	uuid_t uuid;
-	int hal_fd = -1;
+	uuid_t uu;
 
-	DBG("");
+	if ((!memcmp(uuid, zero_uuid, sizeof(zero_uuid)) && chan <= 0) ||
+						!bacmp(addr, BDADDR_ANY)) {
+		error("Invalid rfcomm connect params");
+		return HAL_STATUS_INVALID;
+	}
 
-	rfsock = create_rfsock(-1, &hal_fd);
+	rfsock = create_rfsock(-1, hal_fd);
 	if (!rfsock)
-		goto failed;
+		return HAL_STATUS_FAILED;
 
-	android2bdaddr(cmd->bdaddr, &rfsock->dst);
+	bacpy(&rfsock->dst, addr);
 
-	if (!memcmp(cmd->uuid, zero_uuid, sizeof(zero_uuid))) {
-		if (!do_connect(rfsock, cmd->channel))
+	if (!memcmp(uuid, zero_uuid, sizeof(zero_uuid))) {
+		if (!do_rfcomm_connect(rfsock, chan))
 			goto failed;
 	} else {
-		memset(&uuid, 0, sizeof(uuid));
-		uuid.type = SDP_UUID128;
-		memcpy(&uuid.value.uuid128, cmd->uuid, sizeof(uint128_t));
+		memset(&uu, 0, sizeof(uu));
+		uu.type = SDP_UUID128;
+		memcpy(&uu.value.uuid128, uuid, sizeof(uint128_t));
 
-		rfsock->profile = get_profile_by_uuid(cmd->uuid);
+		rfsock->profile = get_profile_by_uuid(uuid);
 
-		if (bt_search_service(&adapter_addr, &rfsock->dst, &uuid,
+		if (bt_search_service(&adapter_addr, &rfsock->dst, &uu,
 					sdp_search_cb, rfsock, NULL) < 0) {
 			error("Failed to search SDP records");
 			goto failed;
 		}
 	}
 
+	return HAL_STATUS_SUCCESS;
+
+failed:
+	cleanup_rfsock(rfsock);
+	close(*hal_fd);
+	return HAL_STATUS_FAILED;
+}
+
+static void handle_connect(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_sock_connect *cmd = buf;
+	bdaddr_t bdaddr;
+	uint8_t status;
+	int hal_fd;
+
+	DBG("");
+
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+
+	switch (cmd->type) {
+	case HAL_SOCK_RFCOMM:
+		status = connect_rfcomm(&bdaddr, cmd->channel, cmd->uuid,
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
 	ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT, 0, NULL,
 									hal_fd);
 	close(hal_fd);
 	return;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT,
-							HAL_STATUS_FAILED);
-
-	if (rfsock)
-		cleanup_rfsock(rfsock);
+	ipc_send_rsp(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT, status);
 
-	if (hal_fd >= 0)
-		close(hal_fd);
 }
 
 static const struct ipc_handler cmd_handlers[] = {
-- 
1.8.5.2


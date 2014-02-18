Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] android: Match socket IPC messages types with HAL name
Date: Tue, 18 Feb 2014 11:05:24 +0100
Message-Id: <1392717924-7712-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1392717924-7712-1-git-send-email-szymon.janc@tieto.com>
References: <1392717924-7712-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h    |  8 ++++----
 android/hal-socket.c |  8 ++++----
 android/ipc-tester.c | 24 ++++++++++++------------
 android/socket.c     | 20 ++++++++++----------
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 15c7ebe..964ab35 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -238,8 +238,8 @@ struct hal_cmd_le_test_mode {
 #define HAL_SOCK_FLAG_ENCRYPT	0x01
 #define HAL_SOCK_FLAG_AUTH	0x02
 
-#define HAL_OP_SOCK_LISTEN		0x01
-struct hal_cmd_sock_listen {
+#define HAL_OP_SOCKET_LISTEN		0x01
+struct hal_cmd_socket_listen {
 	uint8_t type;
 	uint8_t name[256];
 	uint8_t uuid[16];
@@ -247,8 +247,8 @@ struct hal_cmd_sock_listen {
 	uint8_t flags;
 } __attribute__((packed));
 
-#define HAL_OP_SOCK_CONNECT		0x02
-struct hal_cmd_sock_connect {
+#define HAL_OP_SOCKET_CONNECT		0x02
+struct hal_cmd_socket_connect {
 	uint8_t bdaddr[6];
 	uint8_t type;
 	uint8_t uuid[16];
diff --git a/android/hal-socket.c b/android/hal-socket.c
index ea7d9d8..3688c5f 100644
--- a/android/hal-socket.c
+++ b/android/hal-socket.c
@@ -30,7 +30,7 @@ static bt_status_t socket_listen(btsock_type_t type, const char *service_name,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
 {
-	struct hal_cmd_sock_listen cmd;
+	struct hal_cmd_socket_listen cmd;
 
 	if (!sock)
 		return BT_STATUS_PARM_INVALID;
@@ -51,7 +51,7 @@ static bt_status_t socket_listen(btsock_type_t type, const char *service_name,
 	if (service_name)
 		memcpy(cmd.name, service_name, strlen(service_name));
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_LISTEN,
+	return hal_ipc_cmd(HAL_SERVICE_ID_SOCK, HAL_OP_SOCKET_LISTEN,
 				sizeof(cmd), &cmd, NULL, NULL, sock);
 }
 
@@ -59,7 +59,7 @@ static bt_status_t socket_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
 {
-	struct hal_cmd_sock_connect cmd;
+	struct hal_cmd_socket_connect cmd;
 
 	if (!sock)
 		return BT_STATUS_PARM_INVALID;
@@ -80,7 +80,7 @@ static bt_status_t socket_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 	if (bdaddr)
 		memcpy(cmd.bdaddr, bdaddr, sizeof(cmd.bdaddr));
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT,
+	return hal_ipc_cmd(HAL_SERVICE_ID_SOCK, HAL_OP_SOCKET_CONNECT,
 					sizeof(cmd), &cmd, NULL, NULL, sock);
 }
 
diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index 1c8a595..246638a 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -1074,21 +1074,21 @@ int main(int argc, char *argv[])
 			HAL_SERVICE_ID_BLUETOOTH);
 
 	/* check for valid data size for SOCK */
-	test_datasize_valid("SOCK Listen+", HAL_SERVICE_ID_SOCK,
-			HAL_OP_SOCK_LISTEN,
-			sizeof(struct hal_cmd_sock_listen), 1,
+	test_datasize_valid("SOCKET Listen+", HAL_SERVICE_ID_SOCK,
+			HAL_OP_SOCKET_LISTEN,
+			sizeof(struct hal_cmd_socket_listen), 1,
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_SOCK);
-	test_datasize_valid("SOCK Listen-", HAL_SERVICE_ID_SOCK,
-			HAL_OP_SOCK_LISTEN,
-			sizeof(struct hal_cmd_sock_listen), -1,
+	test_datasize_valid("SOCKET Listen-", HAL_SERVICE_ID_SOCK,
+			HAL_OP_SOCKET_LISTEN,
+			sizeof(struct hal_cmd_socket_listen), -1,
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_SOCK);
-	test_datasize_valid("SOCK Connect+", HAL_SERVICE_ID_SOCK,
-			HAL_OP_SOCK_CONNECT,
-			sizeof(struct hal_cmd_sock_connect), 1,
+	test_datasize_valid("SOCKET Connect+", HAL_SERVICE_ID_SOCK,
+			HAL_OP_SOCKET_CONNECT,
+			sizeof(struct hal_cmd_socket_connect), 1,
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_SOCK);
-	test_datasize_valid("SOCK Connect-", HAL_SERVICE_ID_SOCK,
-			HAL_OP_SOCK_CONNECT,
-			sizeof(struct hal_cmd_sock_connect), -1,
+	test_datasize_valid("SOCKET Connect-", HAL_SERVICE_ID_SOCK,
+			HAL_OP_SOCKET_CONNECT,
+			sizeof(struct hal_cmd_socket_connect), -1,
 			HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_SOCK);
 
 	/* check for valid data size for HID Host */
diff --git a/android/socket.c b/android/socket.c
index 36fffbd..f67dab5 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -841,7 +841,7 @@ failed:
 
 static void handle_listen(const void *buf, uint16_t len)
 {
-	const struct hal_cmd_sock_listen *cmd = buf;
+	const struct hal_cmd_socket_listen *cmd = buf;
 	uint8_t status;
 	int hal_sock;
 
@@ -862,13 +862,13 @@ static void handle_listen(const void *buf, uint16_t len)
 	if (status != HAL_STATUS_SUCCESS)
 		goto failed;
 
-	ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_LISTEN, 0, NULL,
+	ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, HAL_OP_SOCKET_LISTEN, 0, NULL,
 								hal_sock);
 	close(hal_sock);
 	return ;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_LISTEN, status);
+	ipc_send_rsp(HAL_SERVICE_ID_SOCK, HAL_OP_SOCKET_LISTEN, status);
 }
 
 static bool sock_send_connect(struct rfcomm_sock *rfsock, bdaddr_t *bdaddr)
@@ -1080,7 +1080,7 @@ failed:
 
 static void handle_connect(const void *buf, uint16_t len)
 {
-	const struct hal_cmd_sock_connect *cmd = buf;
+	const struct hal_cmd_socket_connect *cmd = buf;
 	bdaddr_t bdaddr;
 	uint8_t status;
 	int hal_sock;
@@ -1106,21 +1106,21 @@ static void handle_connect(const void *buf, uint16_t len)
 	if (status != HAL_STATUS_SUCCESS)
 		goto failed;
 
-	ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT, 0, NULL,
+	ipc_send_rsp_full(HAL_SERVICE_ID_SOCK, HAL_OP_SOCKET_CONNECT, 0, NULL,
 								hal_sock);
 	close(hal_sock);
 	return;
 
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_SOCK, HAL_OP_SOCK_CONNECT, status);
+	ipc_send_rsp(HAL_SERVICE_ID_SOCK, HAL_OP_SOCKET_CONNECT, status);
 
 }
 
 static const struct ipc_handler cmd_handlers[] = {
-	/* HAL_OP_SOCK_LISTEN */
-	{ handle_listen, false, sizeof(struct hal_cmd_sock_listen) },
-	/* HAL_OP_SOCK_CONNECT */
-	{ handle_connect, false, sizeof(struct hal_cmd_sock_connect) },
+	/* HAL_OP_SOCKET_LISTEN */
+	{ handle_listen, false, sizeof(struct hal_cmd_socket_listen) },
+	/* HAL_OP_SOCKET_CONNECT */
+	{ handle_connect, false, sizeof(struct hal_cmd_socket_connect) },
 };
 
 void bt_socket_register(const bdaddr_t *addr)
-- 
1.8.3.2


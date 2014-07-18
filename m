Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 21/21] android/ipc: Rename connect_sco to get_fd
Date: Fri, 18 Jul 2014 12:48:20 +0300
Message-Id: <1405676900-17703-22-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

SCO get connected through handsfree HAL and Audio SCO HAL only need to
get SCO socket fd.
---
 android/hal-sco.c       |  4 ++--
 android/handsfree.c     | 10 +++++-----
 android/sco-ipc-api.txt |  6 +++---
 android/sco-msg.h       |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 0e87aad..e07bb9a 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -285,12 +285,12 @@ static int ipc_connect_sco(void)
 	pthread_mutex_lock(&sco_mutex);
 
 	if (sco_fd < 0) {
-		struct sco_rsp_connect rsp;
+		struct sco_rsp_get_fd rsp;
 		size_t rsp_len = sizeof(rsp);
 
 		DBG("Connecting SCO");
 
-		ret = sco_ipc_cmd(SCO_SERVICE_ID, SCO_OP_CONNECT, 0, NULL,
+		ret = sco_ipc_cmd(SCO_SERVICE_ID, SCO_OP_GET_FD, 0, NULL,
 						&rsp_len, &rsp, &sco_fd);
 
 		/* Sometimes mtu returned is wrong */
diff --git a/android/handsfree.c b/android/handsfree.c
index 4f84de2..3a4ac39 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2569,11 +2569,11 @@ static void disable_sco_server(void)
 	}
 }
 
-static void bt_sco_connect(const void *buf, uint16_t len)
+static void bt_sco_get_fd(const void *buf, uint16_t len)
 {
 	int fd;
 	GError *err = NULL;
-	struct sco_rsp_connect rsp;
+	struct sco_rsp_get_fd rsp;
 
 	DBG("");
 
@@ -2593,7 +2593,7 @@ static void bt_sco_connect(const void *buf, uint16_t len)
 
 	DBG("fd %d mtu %u", fd, rsp.mtu);
 
-	ipc_send_rsp_full(sco_ipc, SCO_SERVICE_ID, SCO_OP_CONNECT,
+	ipc_send_rsp_full(sco_ipc, SCO_SERVICE_ID, SCO_OP_GET_FD,
 							sizeof(rsp), &rsp, fd);
 
 	return;
@@ -2603,8 +2603,8 @@ failed:
 }
 
 static const struct ipc_handler sco_handlers[] = {
-	/* SCO_OP_CONNECT */
-	{ bt_sco_connect, false, 0 }
+	/* SCO_OP_GET_FD */
+	{ bt_sco_get_fd, false, 0 }
 };
 
 static void bt_sco_unregister(void)
diff --git a/android/sco-ipc-api.txt b/android/sco-ipc-api.txt
index 05848d2..17372fe 100644
--- a/android/sco-ipc-api.txt
+++ b/android/sco-ipc-api.txt
@@ -20,8 +20,8 @@ The SCO Audio Plugin communicate through abstract socket name
 	SCO HAL                               Daemon
 	----------------------------------------------------
 
-	call connect_sco()                    --> create SCO socket
-	return connect_sco()                  <-- return socket fd and mtu
+	call get_fd()                    --> Get SCO socket fd
+	return get_fd()                  <-- Return SCO socket fd and mtu
 
 SCO Audio Service (ID 0)
 ========================
@@ -30,7 +30,7 @@ SCO Audio Service (ID 0)
 
 		Response parameters: Status (1 octet)
 
-	Opcode 0x01 - Connect SCO command
+	Opcode 0x01 - Get SCO fd command
 
 		Command parameters: <none>
 		Response parameters: MTU (2 octets)
diff --git a/android/sco-msg.h b/android/sco-msg.h
index df0d858..74f25b8 100644
--- a/android/sco-msg.h
+++ b/android/sco-msg.h
@@ -30,7 +30,7 @@ static const char BLUEZ_SCO_SK_PATH[] = "\0bluez_sco_socket";
 
 #define SCO_OP_STATUS			IPC_OP_STATUS
 
-#define SCO_OP_CONNECT			0x01
-struct sco_rsp_connect {
+#define SCO_OP_GET_FD			0x01
+struct sco_rsp_get_fd {
 	uint16_t mtu;
 } __attribute__((packed));
-- 
1.9.1


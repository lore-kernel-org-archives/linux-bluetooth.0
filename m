Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3] android/ipc: Rename connect_sco to get_fd
Date: Mon, 21 Jul 2014 12:53:03 +0300
Message-Id: <1405936383-29130-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20140721085730.GB27596@t440s.lan>
References: <20140721085730.GB27596@t440s.lan>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

SCO get connected through handsfree HAL and Audio SCO HAL only need to
get SCO socket fd.
---
 android/hal-sco.c       | 14 +++++++-------
 android/handsfree.c     | 10 +++++-----
 android/sco-ipc-api.txt |  6 +++---
 android/sco-msg.h       |  4 ++--
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 55e58b5..c0a1fa6 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -277,19 +277,19 @@ failed:
 	return SCO_STATUS_FAILED;
 }
 
-static int ipc_connect_sco(void)
+static int ipc_get_sco_fd(void)
 {
 	int ret = SCO_STATUS_SUCCESS;
 
 	pthread_mutex_lock(&sco_mutex);
 
 	if (sco_fd < 0) {
-		struct sco_rsp_connect rsp;
+		struct sco_rsp_get_fd rsp;
 		size_t rsp_len = sizeof(rsp);
 
-		DBG("Connecting SCO");
+		DBG("Getting SCO fd");
 
-		ret = sco_ipc_cmd(SCO_SERVICE_ID, SCO_OP_CONNECT, 0, NULL,
+		ret = sco_ipc_cmd(SCO_SERVICE_ID, SCO_OP_GET_FD, 0, NULL,
 						&rsp_len, &rsp, &sco_fd);
 
 		/* Sometimes mtu returned is wrong */
@@ -445,7 +445,7 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 
 	DBG("write to fd %d bytes %zu", sco_fd, bytes);
 
-	if (ipc_connect_sco() != SCO_STATUS_SUCCESS)
+	if (ipc_get_sco_fd() != SCO_STATUS_SUCCESS)
 		return -1;
 
 	if (!out->downmix_buf) {
@@ -631,7 +631,7 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 		return -EIO;
 	}
 
-	if (ipc_connect_sco() != SCO_STATUS_SUCCESS)
+	if (ipc_get_sco_fd() != SCO_STATUS_SUCCESS)
 		DBG("SCO is not connected yet; get fd on write()");
 
 	out = calloc(1, sizeof(struct sco_stream_out));
@@ -1007,7 +1007,7 @@ static ssize_t in_read(struct audio_stream_in *stream, void *buffer,
 
 	DBG("Read from fd %d bytes %zu", sco_fd, bytes);
 
-	if (ipc_connect_sco() != SCO_STATUS_SUCCESS)
+	if (ipc_get_sco_fd() != SCO_STATUS_SUCCESS)
 		return -1;
 
 	if (!in->resampler && in->cfg.rate != AUDIO_STREAM_SCO_RATE) {
diff --git a/android/handsfree.c b/android/handsfree.c
index 599f16f..22d1861 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2565,11 +2565,11 @@ static void disable_sco_server(void)
 	}
 }
 
-static void bt_sco_connect(const void *buf, uint16_t len)
+static void bt_sco_get_fd(const void *buf, uint16_t len)
 {
 	int fd;
 	GError *err;
-	struct sco_rsp_connect rsp;
+	struct sco_rsp_get_fd rsp;
 
 	DBG("");
 
@@ -2588,7 +2588,7 @@ static void bt_sco_connect(const void *buf, uint16_t len)
 
 	DBG("fd %d mtu %u", fd, rsp.mtu);
 
-	ipc_send_rsp_full(sco_ipc, SCO_SERVICE_ID, SCO_OP_CONNECT,
+	ipc_send_rsp_full(sco_ipc, SCO_SERVICE_ID, SCO_OP_GET_FD,
 							sizeof(rsp), &rsp, fd);
 
 	return;
@@ -2598,8 +2598,8 @@ failed:
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


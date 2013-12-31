Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/10] android/ipc: Add initial code for audio IPC
Date: Tue, 31 Dec 2013 13:29:53 +0200
Message-Id: <1388489402-8919-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add initial code for listen and accept connections on the abstract
socket defined for the audio IPC.
---
 android/hal-msg.h |  1 +
 android/ipc.c     | 65 +++++++++++++++++++++++++++++++++++++++++++++----------
 android/ipc.h     |  3 +++
 3 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index c351501..b14eced 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -24,6 +24,7 @@
 #define BLUEZ_HAL_MTU 1024
 
 static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
+static const char BLUEZ_AUDIO_SK_PATH[] = "\0bluez_audio_socket";
 
 struct hal_hdr {
 	uint8_t  service_id;
diff --git a/android/ipc.c b/android/ipc.c
index 9e8ccc3..d062d95 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -49,8 +49,10 @@ static struct service_handler services[HAL_SERVICE_ID_MAX + 1];
 
 static GIOChannel *cmd_io = NULL;
 static GIOChannel *notif_io = NULL;
+static GIOChannel *audio_io = NULL;
 
-static void ipc_handle_msg(const void *buf, ssize_t len)
+static void ipc_handle_msg(struct service_handler *handlers, const void *buf,
+								ssize_t len)
 {
 	const struct hal_hdr *msg = buf;
 	const struct ipc_handler *handler;
@@ -76,7 +78,7 @@ static void ipc_handle_msg(const void *buf, ssize_t len)
 	}
 
 	/* if service is registered */
-	if (!services[msg->service_id].handler) {
+	if (!handlers[msg->service_id].handler) {
 		error("IPC: unregistered service (0x%x), terminating",
 							msg->service_id);
 		raise(SIGTERM);
@@ -85,7 +87,7 @@ static void ipc_handle_msg(const void *buf, ssize_t len)
 
 	/* if opcode is valid */
 	if (msg->opcode == HAL_OP_STATUS ||
-			msg->opcode > services[msg->service_id].size) {
+			msg->opcode > handlers[msg->service_id].size) {
 		error("IPC: invalid opcode 0x%x for service 0x%x, terminating",
 						msg->opcode, msg->service_id);
 		raise(SIGTERM);
@@ -93,7 +95,7 @@ static void ipc_handle_msg(const void *buf, ssize_t len)
 	}
 
 	/* opcode is table offset + 1 */
-	handler = &services[msg->service_id].handler[msg->opcode - 1];
+	handler = &handlers[msg->service_id].handler[msg->opcode - 1];
 
 	/* if payload size is valid */
 	if ((handler->var_len && handler->data_len > msg->len) ||
@@ -110,6 +112,7 @@ static void ipc_handle_msg(const void *buf, ssize_t len)
 static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
+	struct service_handler *handlers = user_data;
 	char buf[BLUEZ_HAL_MTU];
 	ssize_t ret;
 	int fd;
@@ -128,7 +131,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		goto fail;
 	}
 
-	ipc_handle_msg(buf, ret);
+	ipc_handle_msg(handlers, buf, ret);
 	return TRUE;
 
 fail:
@@ -145,7 +148,8 @@ static gboolean notif_watch_cb(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
-static GIOChannel *connect_hal(GIOFunc connect_cb)
+static GIOChannel *connect_hal(const char *path, size_t size,
+							GIOFunc connect_cb)
 {
 	struct sockaddr_un addr;
 	GIOCondition cond;
@@ -167,11 +171,11 @@ static GIOChannel *connect_hal(GIOFunc connect_cb)
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_UNIX;
 
-	memcpy(addr.sun_path, BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH));
+	memcpy(addr.sun_path, path, size);
 
 	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		error("IPC: failed to connect HAL socket: %d (%s)", errno,
-							strerror(errno));
+		error("IPC: failed to connect HAL socket %s: %d (%s)", &path[1],
+							errno, strerror(errno));
 		g_io_channel_unref(io);
 		return NULL;
 	}
@@ -200,7 +204,7 @@ static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
-	g_io_add_watch(cmd_io, cond, cmd_watch_cb, NULL);
+	g_io_add_watch(cmd_io, cond, cmd_watch_cb, services);
 
 	info("IPC: successfully connected");
 
@@ -218,7 +222,8 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	notif_io = connect_hal(notif_connect_cb);
+	notif_io = connect_hal(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
+							notif_connect_cb);
 	if (!notif_io)
 		raise(SIGTERM);
 
@@ -227,7 +232,8 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 
 void ipc_init(void)
 {
-	cmd_io = connect_hal(cmd_connect_cb);
+	cmd_io = connect_hal(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
+							cmd_connect_cb);
 	if (!cmd_io)
 		raise(SIGTERM);
 }
@@ -338,3 +344,38 @@ void ipc_unregister(uint8_t service)
 	services[service].handler = NULL;
 	services[service].size = 0;
 }
+
+static gboolean audio_connect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	DBG("");
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		error("Audio IPC: socket connect failed");
+		audio_ipc_cleanup();
+		return FALSE;
+	}
+
+	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+
+	g_io_add_watch(audio_io, cond, cmd_watch_cb, NULL);
+
+	info("Audio IPC: successfully connected");
+
+	return FALSE;
+}
+
+void audio_ipc_init(void)
+{
+	audio_io = connect_hal(BLUEZ_AUDIO_SK_PATH, sizeof(BLUEZ_AUDIO_SK_PATH),
+							audio_connect_cb);
+}
+
+void audio_ipc_cleanup(void)
+{
+	if (audio_io) {
+		g_io_channel_shutdown(audio_io, TRUE, NULL);
+		g_io_channel_unref(audio_io);
+		audio_io = NULL;
+	}
+}
diff --git a/android/ipc.h b/android/ipc.h
index 6cd102b..8e92811 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -37,3 +37,6 @@ void ipc_send_notif(uint8_t service_id, uint8_t opcode,  uint16_t len,
 void ipc_register(uint8_t service, const struct ipc_handler *handlers,
 								uint8_t size);
 void ipc_unregister(uint8_t service);
+
+void audio_ipc_init(void);
+void audio_ipc_cleanup(void);
-- 
1.8.4.2


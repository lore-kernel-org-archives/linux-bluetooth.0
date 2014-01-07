Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 02/10] android/ipc: Add message handling for audio IPC
Date: Tue,  7 Jan 2014 13:53:15 +0200
Message-Id: <1389095603-30504-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389095603-30504-1-git-send-email-luiz.dentz@gmail.com>
References: <1389095603-30504-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds audio_ipc_register and audio_ipc_unregister and adapt
ipc_handle_msg to be able to handle audio services messages.
---
 android/audio-ipc.c | 23 +++++++++++++++++++-
 android/audio-ipc.h |  3 +++
 android/audio-msg.h |  2 ++
 android/ipc.c       | 60 +++++++++++++++++++++++++----------------------------
 android/ipc.h       |  8 +++++++
 5 files changed, 63 insertions(+), 33 deletions(-)

diff --git a/android/audio-ipc.c b/android/audio-ipc.c
index b537f21..0c5433a 100644
--- a/android/audio-ipc.c
+++ b/android/audio-ipc.c
@@ -41,12 +41,14 @@
 
 static GIOChannel *audio_io = NULL;
 
+static struct service_handler service;
+
 static gboolean audio_watch_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	char buf[BLUEZ_AUDIO_MTU];
 	ssize_t ret;
-	int fd;
+	int fd, err;
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
 		info("Audio IPC: command socket closed");
@@ -61,6 +63,13 @@ static gboolean audio_watch_cb(GIOChannel *io, GIOCondition cond,
 		goto fail;
 	}
 
+	err = ipc_handle_msg(&service, AUDIO_SERVICE_ID, buf, ret);
+	if (err < 0) {
+		error("Audio IPC: failed to handle message (%s)",
+							strerror(-err));
+		goto fail;
+	}
+
 	return TRUE;
 
 fail:
@@ -102,3 +111,15 @@ void audio_ipc_cleanup(void)
 		audio_io = NULL;
 	}
 }
+
+void audio_ipc_register(const struct ipc_handler *handlers, uint8_t size)
+{
+	service.handler = handlers;
+	service.size = size;
+}
+
+void audio_ipc_unregister(void)
+{
+	service.handler = NULL;
+	service.size = 0;
+}
diff --git a/android/audio-ipc.h b/android/audio-ipc.h
index 769bfd6..1dfa245 100644
--- a/android/audio-ipc.h
+++ b/android/audio-ipc.h
@@ -23,3 +23,6 @@
 
 void audio_ipc_init(void);
 void audio_ipc_cleanup(void);
+
+void audio_ipc_register(const struct ipc_handler *handlers, uint8_t size);
+void audio_ipc_unregister(void);
diff --git a/android/audio-msg.h b/android/audio-msg.h
index d5b4099..1ec2520 100644
--- a/android/audio-msg.h
+++ b/android/audio-msg.h
@@ -24,3 +24,5 @@
 #define BLUEZ_AUDIO_MTU 1024
 
 static const char BLUEZ_AUDIO_SK_PATH[] = "\0bluez_audio_socket";
+
+#define AUDIO_SERVICE_ID		0
diff --git a/android/ipc.c b/android/ipc.c
index 8a91248..1499962 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -40,56 +40,45 @@
 #include "ipc.h"
 #include "log.h"
 
-struct service_handler {
-	const struct ipc_handler *handler;
-	uint8_t size;
-};
-
 static struct service_handler services[HAL_SERVICE_ID_MAX + 1];
 
 static GIOChannel *cmd_io = NULL;
 static GIOChannel *notif_io = NULL;
 
-static void ipc_handle_msg(const void *buf, ssize_t len)
+int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
+						const void *buf, ssize_t len)
 {
 	const struct hal_hdr *msg = buf;
 	const struct ipc_handler *handler;
 
 	if (len < (ssize_t) sizeof(*msg)) {
-		error("IPC: message too small (%zd bytes), terminating", len);
-		raise(SIGTERM);
-		return;
+		DBG("message too small (%zd bytes)", len);
+		return -EBADMSG;
 	}
 
 	if (len != (ssize_t) (sizeof(*msg) + msg->len)) {
-		error("IPC: message malformed (%zd bytes), terminating", len);
-		raise(SIGTERM);
-		return;
+		DBG("message malformed (%zd bytes)", len);
+		return -EBADMSG;
 	}
 
 	/* if service is valid */
-	if (msg->service_id > HAL_SERVICE_ID_MAX) {
-		error("IPC: unknown service (0x%x), terminating",
-							msg->service_id);
-		raise(SIGTERM);
-		return;
+	if (msg->service_id > max_index) {
+		DBG("unknown service (0x%x)", msg->service_id);
+		return -EOPNOTSUPP;
 	}
 
 	/* if service is registered */
-	if (!services[msg->service_id].handler) {
-		error("IPC: unregistered service (0x%x), terminating",
-							msg->service_id);
-		raise(SIGTERM);
-		return;
+	if (!handlers[msg->service_id].handler) {
+		DBG("service not registered (0x%x)", msg->service_id);
+		return -EOPNOTSUPP;
 	}
 
 	/* if opcode is valid */
 	if (msg->opcode == HAL_OP_STATUS ||
-			msg->opcode > services[msg->service_id].size) {
-		error("IPC: invalid opcode 0x%x for service 0x%x, terminating",
-						msg->opcode, msg->service_id);
-		raise(SIGTERM);
-		return;
+			msg->opcode > handlers[msg->service_id].size) {
+		DBG("invalid opcode 0x%x for service 0x%x", msg->opcode,
+							msg->service_id);
+		return -EOPNOTSUPP;
 	}
 
 	/* opcode is table offset + 1 */
@@ -98,13 +87,14 @@ static void ipc_handle_msg(const void *buf, ssize_t len)
 	/* if payload size is valid */
 	if ((handler->var_len && handler->data_len > msg->len) ||
 			(!handler->var_len && handler->data_len != msg->len)) {
-		error("IPC: size invalid opcode 0x%x service 0x%x, terminating",
+		DBG("invalid size for opcode 0x%x service 0x%x",
 						msg->service_id, msg->opcode);
-		raise(SIGTERM);
-		return;
+		return -EMSGSIZE;
 	}
 
 	handler->handler(msg->payload, msg->len);
+
+	return 0;
 }
 
 static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
@@ -112,7 +102,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 {
 	char buf[BLUEZ_HAL_MTU];
 	ssize_t ret;
-	int fd;
+	int fd, err;
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
 		info("IPC: command socket closed, terminating");
@@ -128,7 +118,13 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		goto fail;
 	}
 
-	ipc_handle_msg(buf, ret);
+	err = ipc_handle_msg(services, HAL_SERVICE_ID_MAX, buf, ret);
+	if (err < 0) {
+		error("IPC: failed to handle message, terminating (%s)",
+							strerror(-err));
+		goto fail;
+	}
+
 	return TRUE;
 
 fail:
diff --git a/android/ipc.h b/android/ipc.h
index 02ad6bb..7b8bdeb 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -26,9 +26,17 @@ struct ipc_handler {
 	bool var_len;
 	size_t data_len;
 };
+
+struct service_handler {
+	const struct ipc_handler *handler;
+	uint8_t size;
+};
+
 void ipc_init(void);
 void ipc_cleanup(void);
 GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb);
+int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
+						const void *buf, ssize_t len);
 
 void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status);
 void ipc_send_rsp_full(uint8_t service_id, uint8_t opcode, uint16_t len,
-- 
1.8.4.2


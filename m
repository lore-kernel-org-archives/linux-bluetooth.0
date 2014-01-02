Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 02/10] android/ipc: Add message handling for audio IPC
Date: Thu,  2 Jan 2014 13:58:26 +0200
Message-Id: <1388663914-25003-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
References: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds audio_ipc_register and audio_ipc_unregister and adapt
ipc_handle_msg to be able to handle audio services messages.
---
 android/hal-msg.h |  4 +++
 android/ipc.c     | 78 +++++++++++++++++++++++++++++++++++--------------------
 android/ipc.h     |  4 +++
 3 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index b14eced..267f9b2 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -48,6 +48,10 @@ struct hal_hdr {
 
 #define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_GATT
 
+#define AUDIO_SERVICE_ID_CORE		0
+
+#define AUDIO_SERVICE_ID_MAX AUDIO_SERVICE_ID_CORE
+
 /* Core Service */
 
 #define HAL_STATUS_SUCCESS		0x00
diff --git a/android/ipc.c b/android/ipc.c
index 4c5a77e..f18e1eb 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -46,51 +46,46 @@ struct service_handler {
 };
 
 static struct service_handler services[HAL_SERVICE_ID_MAX + 1];
+static struct service_handler audio_services[AUDIO_SERVICE_ID_MAX + 1];
 
 static GIOChannel *cmd_io = NULL;
 static GIOChannel *notif_io = NULL;
 static GIOChannel *audio_io = NULL;
 
-static void ipc_handle_msg(const void *buf, ssize_t len)
+static int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
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
@@ -99,13 +94,14 @@ static void ipc_handle_msg(const void *buf, ssize_t len)
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
@@ -113,7 +109,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 {
 	char buf[BLUEZ_HAL_MTU];
 	ssize_t ret;
-	int fd;
+	int fd, err;
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
 		info("IPC: command socket closed, terminating");
@@ -129,7 +125,13 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
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
@@ -348,7 +350,7 @@ static gboolean audio_watch_cb(GIOChannel *io, GIOCondition cond,
 {
 	char buf[BLUEZ_HAL_MTU];
 	ssize_t ret;
-	int fd;
+	int fd, err;
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
 		info("Audio IPC: command socket closed");
@@ -363,6 +365,13 @@ static gboolean audio_watch_cb(GIOChannel *io, GIOCondition cond,
 		goto fail;
 	}
 
+	err = ipc_handle_msg(audio_services, AUDIO_SERVICE_ID_MAX, buf, ret);
+	if (err < 0) {
+		error("Audio IPC: failed to handle message (%s)",
+							strerror(-err));
+		goto fail;
+	}
+
 	return TRUE;
 
 fail:
@@ -404,3 +413,16 @@ void audio_ipc_cleanup(void)
 		audio_io = NULL;
 	}
 }
+
+void audio_ipc_register(uint8_t service, const struct ipc_handler *handlers,
+								uint8_t size)
+{
+	audio_services[service].handler = handlers;
+	audio_services[service].size = size;
+}
+
+void audio_ipc_unregister(uint8_t service)
+{
+	audio_services[service].handler = NULL;
+	audio_services[service].size = 0;
+}
diff --git a/android/ipc.h b/android/ipc.h
index 8e92811..44d5a5d 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -40,3 +40,7 @@ void ipc_unregister(uint8_t service);
 
 void audio_ipc_init(void);
 void audio_ipc_cleanup(void);
+
+void audio_ipc_register(uint8_t service, const struct ipc_handler *handlers,
+								uint8_t size);
+void audio_ipc_unregister(uint8_t service);
-- 
1.8.4.2


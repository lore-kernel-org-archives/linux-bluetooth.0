Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 1/6] android/hal: Add initial code for IPC message handlers
Date: Tue, 19 Nov 2013 15:02:37 +0100
Message-Id: <1384869762-3097-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384869762-3097-1-git-send-email-szymon.janc@tieto.com>
References: <1384869762-3097-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to register and unregister handlers for IPC messages
Basic sanity check will be done in common code. Commands with variable
length will be verified against minimum size only.
---
 android/hal-ipc.c | 117 ++++++++++++++++++++++++++++++++++++------------------
 android/hal-ipc.h |  10 +++++
 2 files changed, 89 insertions(+), 38 deletions(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 5155e04..5d622e1 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -43,26 +43,86 @@ static pthread_mutex_t cmd_sk_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 static pthread_t notif_th = 0;
 
-static void notification_dispatch(struct hal_hdr *msg, int fd)
+struct service_handler {
+	const struct hal_ipc_handler *handler;
+	uint8_t size;
+};
+
+static struct service_handler services[HAL_SERVICE_ID_MAX + 1];
+
+void hal_ipc_register(uint8_t service, const struct hal_ipc_handler *handlers,
+								uint8_t size)
+{
+	services[service].handler = handlers;
+	services[service].size = size;
+}
+
+void hal_ipc_unregister(uint8_t service)
 {
-	switch (msg->service_id) {
-	case HAL_SERVICE_ID_BLUETOOTH:
-		bt_notify_adapter(msg->opcode, msg->payload, msg->len);
-		break;
-	case HAL_SERVICE_ID_HIDHOST:
-		bt_notify_hidhost(msg->opcode, msg->payload, msg->len);
-		break;
-	case HAL_SERVICE_ID_A2DP:
-		bt_notify_a2dp(msg->opcode, msg->payload, msg->len);
-		break;
-	case HAL_SERVICE_ID_PAN:
-		bt_notify_pan(msg->opcode, msg->payload, msg->len);
-		break;
-	default:
-		DBG("Unhandled notification service=%d opcode=0x%x",
+	services[service].handler = NULL;
+	services[service].size = 0;
+}
+
+static void handle_msg(void *buf, ssize_t len)
+{
+	struct hal_hdr *msg = buf;
+	const struct hal_ipc_handler *handler;
+	uint8_t opcode;
+
+	if (len < (ssize_t) sizeof(*msg)) {
+		error("IPC: message too small (%zd bytes), aborting", len);
+		exit(EXIT_FAILURE);
+	}
+
+	if (len != (ssize_t) (sizeof(*msg) + msg->len)) {
+		error("IPC: message malformed (%zd bytes), aborting", len);
+		exit(EXIT_FAILURE);
+	}
+
+	/* if service is valid */
+	if (msg->service_id > HAL_SERVICE_ID_MAX) {
+		error("IPC: unknown service (0x%x), aborting",
+							msg->service_id);
+		exit(EXIT_FAILURE);
+	}
+
+	/* if service is registered */
+	if (!services[msg->service_id].handler) {
+		error("IPC: unregistered service (0x%x), aborting",
+							msg->service_id);
+		exit(EXIT_FAILURE);
+	}
+
+	/* if opcode fit valid range */
+	if (msg->opcode < HAL_MINIMUM_EVENT) {
+		error("IPC: invalid opcode for service 0x%x (0x%x), aborting",
 						msg->service_id, msg->opcode);
-		break;
+		exit(EXIT_FAILURE);
+	}
+
+	/* opcode is used as table offset and must be adjusted as events start
+	 * with HAL_MINIMUM_EVENT offset */
+	opcode = msg->opcode - HAL_MINIMUM_EVENT;
+
+	/* if opcode is valid */
+	if (opcode >= services[msg->service_id].size) {
+		error("IPC: invalid opcode for service 0x%x (0x%x), aborting",
+						msg->service_id, msg->opcode);
+		exit(EXIT_FAILURE);
+	}
+
+	handler = &services[msg->service_id].handler[opcode];
+
+	/* if payload size is valid */
+	if ((handler->var_len && handler->data_len > msg->len) ||
+			(!handler->var_len && handler->data_len != msg->len)) {
+		error("IPC: message size invalid for service 0x%x opcode 0x%x "
+				"(%u bytes), aborting",
+				msg->service_id, msg->opcode, msg->len);
+		exit(EXIT_FAILURE);
 	}
+
+	handler->handler(msg->payload, msg->len);
 }
 
 static void *notification_handler(void *data)
@@ -72,7 +132,6 @@ static void *notification_handler(void *data)
 	struct cmsghdr *cmsg;
 	char cmsgbuf[CMSG_SPACE(sizeof(int))];
 	char buf[BLUEZ_HAL_MTU];
-	struct hal_hdr *ev = (void *) buf;
 	ssize_t ret;
 	int fd;
 
@@ -83,7 +142,7 @@ static void *notification_handler(void *data)
 		memset(buf, 0, sizeof(buf));
 		memset(cmsgbuf, 0, sizeof(cmsgbuf));
 
-		iv.iov_base = ev;
+		iv.iov_base = buf;
 		iv.iov_len = sizeof(buf);
 
 		msg.msg_iov = &iv;
@@ -108,24 +167,6 @@ static void *notification_handler(void *data)
 			exit(EXIT_FAILURE);
 		}
 
-		if (ret < (ssize_t) sizeof(*ev)) {
-			error("Too small notification (%zd bytes), aborting",
-									ret);
-			exit(EXIT_FAILURE);
-		}
-
-		if (ev->opcode < HAL_MINIMUM_EVENT) {
-			error("Invalid notification (0x%x), aborting",
-							ev->opcode);
-			exit(EXIT_FAILURE);
-		}
-
-		if (ret != (ssize_t) (sizeof(*ev) + ev->len)) {
-			error("Malformed notification(%zd bytes), aborting",
-									ret);
-			exit(EXIT_FAILURE);
-		}
-
 		fd = -1;
 
 		/* Receive auxiliary data in msg */
@@ -138,7 +179,7 @@ static void *notification_handler(void *data)
 			}
 		}
 
-		notification_dispatch(ev, fd);
+		handle_msg(buf, ret);
 	}
 
 	close(notif_sk);
diff --git a/android/hal-ipc.h b/android/hal-ipc.h
index ea53e1c..2fbf30f 100644
--- a/android/hal-ipc.h
+++ b/android/hal-ipc.h
@@ -15,8 +15,18 @@
  *
  */
 
+struct hal_ipc_handler {
+	void (*handler) (void *buf, uint16_t len);
+	bool var_len;
+	size_t data_len;
+};
+
 bool hal_ipc_init(void);
 void hal_ipc_cleanup(void);
 
 int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 					size_t *rsp_len, void *rsp, int *fd);
+
+void hal_ipc_register(uint8_t service, const struct hal_ipc_handler *handlers,
+								uint8_t size);
+void hal_ipc_unregister(uint8_t service);
-- 
1.8.4.3


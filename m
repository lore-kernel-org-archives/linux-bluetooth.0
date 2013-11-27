Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/13] android: Add initial code for IPC message handlers
Date: Wed, 27 Nov 2013 12:54:53 +0100
Message-Id: <1385553305-5807-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
References: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to register and unregister handlers for IPC messages
Basic sanity check will be done in common code. Commands with variable
length will be verified against minimum size only.
---
 android/ipc.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/ipc.h | 12 +++++++++
 2 files changed, 91 insertions(+)

diff --git a/android/ipc.c b/android/ipc.c
index 25c36fd..e55c82b 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -30,12 +30,20 @@
 #include <stdint.h>
 #include <string.h>
 #include <signal.h>
+#include <stdbool.h>
 #include <sys/socket.h>
 
 #include "hal-msg.h"
 #include "ipc.h"
 #include "log.h"
 
+struct service_handler {
+	const struct ipc_handler *handler;
+	uint8_t size;
+};
+
+static struct service_handler services[HAL_SERVICE_ID_MAX + 1];
+
 void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd)
 {
@@ -94,3 +102,74 @@ void ipc_send_rsp(int sk, uint8_t service_id, uint8_t opcode, uint8_t status)
 
 	ipc_send(sk, service_id, HAL_OP_STATUS, sizeof(s), &s, -1);
 }
+
+void ipc_register(uint8_t service, const struct ipc_handler *handlers,
+								uint8_t size)
+{
+	services[service].handler = handlers;
+	services[service].size = size;
+}
+
+void ipc_unregister(uint8_t service)
+{
+	services[service].handler = NULL;
+	services[service].size = 0;
+}
+
+void ipc_handle_msg(const void *buf, ssize_t len)
+{
+	const struct hal_hdr *msg = buf;
+	const struct ipc_handler *handler;
+
+	if (len < (ssize_t) sizeof(*msg)) {
+		error("IPC: message too small (%zd bytes), terminating", len);
+		raise(SIGTERM);
+		return;
+	}
+
+	if (len != (ssize_t) (sizeof(*msg) + msg->len)) {
+		error("IPC: message malformed (%zd bytes), terminating", len);
+		raise(SIGTERM);
+		return;
+	}
+
+	/* if service is valid */
+	if (msg->service_id > HAL_SERVICE_ID_MAX) {
+		error("IPC: unknown service (0x%x), terminating",
+							msg->service_id);
+		raise(SIGTERM);
+		return;
+	}
+
+	/* if service is registered */
+	if (!services[msg->service_id].handler) {
+		error("IPC: unregistered service (0x%x), terminating",
+							msg->service_id);
+		raise(SIGTERM);
+		return;
+	}
+
+	/* if opcode is valid */
+	if (msg->opcode == HAL_OP_STATUS ||
+			msg->opcode > services[msg->service_id].size) {
+		error("IPC: invalid opcode for service 0x%x (0x%x), "
+				"terminating", msg->service_id, msg->opcode);
+		raise(SIGTERM);
+		return;
+	}
+
+	/* opcode is table offset + 1 */
+	handler = &services[msg->service_id].handler[msg->opcode - 1];
+
+	/* if payload size is valid */
+	if ((handler->var_len && handler->data_len > msg->len) ||
+			(!handler->var_len && handler->data_len != msg->len)) {
+		error("IPC: message size invalid for service 0x%x opcode 0x%x "
+				"(%u bytes), terminating",
+				msg->service_id, msg->opcode, msg->len);
+		raise(SIGTERM);
+		return;
+	}
+
+	handler->handler(msg->payload, msg->len);
+}
diff --git a/android/ipc.h b/android/ipc.h
index ad4a2d2..cb03670 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -21,6 +21,18 @@
  *
  */
 
+struct ipc_handler {
+	void (*handler) (const void *buf, uint16_t len);
+	bool var_len;
+	size_t data_len;
+};
+
 void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd);
 void ipc_send_rsp(int sk, uint8_t service_id, uint8_t opcode, uint8_t status);
+
+void ipc_register(uint8_t service, const struct ipc_handler *handlers,
+								uint8_t size);
+void ipc_unregister(uint8_t service);
+
+void ipc_handle_msg(const void *buf, ssize_t len);
-- 
1.8.3.2


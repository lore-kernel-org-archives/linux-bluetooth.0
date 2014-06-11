Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/10] android/hal-ipc: Move exit calls outside of handle_msg
Date: Wed, 11 Jun 2014 16:32:46 +0200
Message-Id: <1402497172-12436-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
References: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reduce number of exit points in preparation for destroy callback.
---
 android/hal-ipc.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index ee3a04c..abb3b4b 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -62,41 +62,39 @@ void hal_ipc_unregister(uint8_t service)
 	services[service].size = 0;
 }
 
-static void handle_msg(void *buf, ssize_t len)
+static bool handle_msg(void *buf, ssize_t len)
 {
 	struct ipc_hdr *msg = buf;
 	const struct hal_ipc_handler *handler;
 	uint8_t opcode;
 
 	if (len < (ssize_t) sizeof(*msg)) {
-		error("IPC: message too small (%zd bytes), aborting", len);
-		exit(EXIT_FAILURE);
+		error("IPC: message too small (%zd bytes)", len);
+		return false;
 	}
 
 	if (len != (ssize_t) (sizeof(*msg) + msg->len)) {
-		error("IPC: message malformed (%zd bytes), aborting", len);
-		exit(EXIT_FAILURE);
+		error("IPC: message malformed (%zd bytes)", len);
+		return false;
 	}
 
 	/* if service is valid */
 	if (msg->service_id > HAL_SERVICE_ID_MAX) {
-		error("IPC: unknown service (0x%x), aborting",
-							msg->service_id);
-		exit(EXIT_FAILURE);
+		error("IPC: unknown service (0x%x)", msg->service_id);
+		return false;
 	}
 
 	/* if service is registered */
 	if (!services[msg->service_id].handler) {
-		error("IPC: unregistered service (0x%x), aborting",
-							msg->service_id);
-		exit(EXIT_FAILURE);
+		error("IPC: unregistered service (0x%x)", msg->service_id);
+		return false;
 	}
 
 	/* if opcode fit valid range */
 	if (msg->opcode < HAL_MINIMUM_EVENT) {
-		error("IPC: invalid opcode for service 0x%x (0x%x), aborting",
+		error("IPC: invalid opcode for service 0x%x (0x%x)",
 						msg->service_id, msg->opcode);
-		exit(EXIT_FAILURE);
+		return false;
 	}
 
 	/*
@@ -107,9 +105,9 @@ static void handle_msg(void *buf, ssize_t len)
 
 	/* if opcode is valid */
 	if (opcode >= services[msg->service_id].size) {
-		error("IPC: invalid opcode for service 0x%x (0x%x), aborting",
+		error("IPC: invalid opcode for service 0x%x (0x%x)",
 						msg->service_id, msg->opcode);
-		exit(EXIT_FAILURE);
+		return false;
 	}
 
 	handler = &services[msg->service_id].handler[opcode];
@@ -118,12 +116,14 @@ static void handle_msg(void *buf, ssize_t len)
 	if ((handler->var_len && handler->data_len > msg->len) ||
 			(!handler->var_len && handler->data_len != msg->len)) {
 		error("IPC: message size invalid for service 0x%x opcode 0x%x "
-				"(%u bytes), aborting",
+				"(%u bytes)",
 				msg->service_id, msg->opcode, msg->len);
-		exit(EXIT_FAILURE);
+		return false;
 	}
 
 	handler->handler(msg->payload, msg->len);
+
+	return true;
 }
 
 static void *notification_handler(void *data)
@@ -184,7 +184,8 @@ static void *notification_handler(void *data)
 			}
 		}
 
-		handle_msg(buf, ret);
+		if (!handle_msg(buf, ret))
+			exit(EXIT_FAILURE);
 	}
 
 	close(notif_sk);
-- 
1.9.1


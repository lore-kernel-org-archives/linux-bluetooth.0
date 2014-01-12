Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] android/ipc: Use proper handlers in ipc_handle_msg
Date: Sun, 12 Jan 2014 23:22:18 +0100
Message-Id: <1389565338-12618-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ipc_handle_msg() should use handlers passed as function parameter
instead of static one as otherwise Audio IPC will use incorrect
handlers.
---
 android/ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/ipc.c b/android/ipc.c
index a31d315..ed3ef3c 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -82,7 +82,7 @@ int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
 	}
 
 	/* opcode is table offset + 1 */
-	handler = &services[msg->service_id].handler[msg->opcode - 1];
+	handler = &handlers[msg->service_id].handler[msg->opcode - 1];
 
 	/* if payload size is valid */
 	if ((handler->var_len && handler->data_len > msg->len) ||
-- 
1.8.5.2


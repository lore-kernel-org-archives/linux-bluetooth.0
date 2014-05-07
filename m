Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 04/10] android/ipc: Use error printing error messages
Date: Wed,  7 May 2014 11:45:20 +0300
Message-Id: <1399452326-25009-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1399452326-25009-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1399452326-25009-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This helps to identify problem since DBG is not printed by default.
---
 android/ipc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/ipc.c b/android/ipc.c
index 8cd34ea..89fff8d 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -96,31 +96,31 @@ static int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
 	const struct ipc_handler *handler;
 
 	if (len < (ssize_t) sizeof(*msg)) {
-		DBG("message too small (%zd bytes)", len);
+		error("message too small (%zd bytes)", len);
 		return -EBADMSG;
 	}
 
 	if (len != (ssize_t) (sizeof(*msg) + msg->len)) {
-		DBG("message malformed (%zd bytes)", len);
+		error("message malformed (%zd bytes)", len);
 		return -EBADMSG;
 	}
 
 	/* if service is valid */
 	if (msg->service_id > max_index) {
-		DBG("unknown service (0x%x)", msg->service_id);
+		error("unknown service (0x%x)", msg->service_id);
 		return -EOPNOTSUPP;
 	}
 
 	/* if service is registered */
 	if (!handlers[msg->service_id].handler) {
-		DBG("service not registered (0x%x)", msg->service_id);
+		error("service not registered (0x%x)", msg->service_id);
 		return -EOPNOTSUPP;
 	}
 
 	/* if opcode is valid */
 	if (msg->opcode == IPC_OP_STATUS ||
 			msg->opcode > handlers[msg->service_id].size) {
-		DBG("invalid opcode 0x%x for service 0x%x", msg->opcode,
+		error("invalid opcode 0x%x for service 0x%x", msg->opcode,
 							msg->service_id);
 		return -EOPNOTSUPP;
 	}
@@ -131,7 +131,7 @@ static int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
 	/* if payload size is valid */
 	if ((handler->var_len && handler->data_len > msg->len) ||
 			(!handler->var_len && handler->data_len != msg->len)) {
-		DBG("invalid size for opcode 0x%x service 0x%x",
+		error("invalid size for opcode 0x%x service 0x%x",
 						msg->opcode, msg->service_id);
 		return -EMSGSIZE;
 	}
-- 
1.8.3.2


Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] android/ipc: Fix arguments order in DBG
Date: Sun, 12 Jan 2014 22:44:45 +0100
Message-Id: <1389563085-9731-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/ipc.c b/android/ipc.c
index 03bdc35..a31d315 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -88,7 +88,7 @@ int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
 	if ((handler->var_len && handler->data_len > msg->len) ||
 			(!handler->var_len && handler->data_len != msg->len)) {
 		DBG("invalid size for opcode 0x%x service 0x%x",
-						msg->service_id, msg->opcode);
+						msg->opcode, msg->service_id);
 		return -EMSGSIZE;
 	}
 
-- 
1.8.5.2


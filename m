Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 09/11] android: Add IPC helper for convenient error sending
Date: Mon, 21 Oct 2013 20:56:49 +0200
Message-Id: <1382381811-28123-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
References: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This simple helper will simplify error paths in code.
---
 android/ipc.c | 9 +++++++++
 android/ipc.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/android/ipc.c b/android/ipc.c
index 449ba23..406a19b 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -78,3 +78,12 @@ void ipc_send(GIOChannel *io, uint8_t service_id, uint8_t opcode, uint16_t len,
 		main_quit();
 	}
 }
+
+void ipc_send_error(GIOChannel *io, uint8_t service_id, uint8_t status)
+{
+	struct hal_msg_rsp_error err;
+
+	err.status = status;
+
+	ipc_send(io, service_id, HAL_MSG_OP_ERROR, sizeof(err), &err, -1);
+}
diff --git a/android/ipc.h b/android/ipc.h
index db92c97..4b0ee2a 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -23,3 +23,4 @@
 
 void ipc_send(GIOChannel *io, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd);
+void ipc_send_error(GIOChannel *io, uint8_t service_id, uint8_t status);
-- 
1.8.4


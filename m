Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 6/7] android: Remove not used functions from IPC API
Date: Tue, 25 Feb 2014 11:50:18 +0100
Message-Id: <1393325419-16544-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393325419-16544-1-git-send-email-szymon.janc@tieto.com>
References: <1393325419-16544-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those are used only internally and can be made static.
---
 android/ipc.c | 8 ++++----
 android/ipc.h | 7 -------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/android/ipc.c b/android/ipc.c
index e356439..636e1d8 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -86,7 +86,7 @@ static void ipc_disconnect(struct ipc *ipc, bool failed)
 		ipc->failed_cb(ipc->failed_cb_data);
 }
 
-int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
+static int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
 						const void *buf, ssize_t len)
 {
 	const struct hal_hdr *msg = buf;
@@ -190,8 +190,8 @@ static gboolean notif_watch_cb(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
-GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb,
-							void *user_data)
+static GIOChannel *ipc_connect(const char *path, size_t size,
+					GIOFunc connect_cb, void *user_data)
 {
 	struct sockaddr_un addr;
 	GIOCondition cond;
@@ -328,7 +328,7 @@ void ipc_disable_notifications(struct ipc *ipc)
 	ipc->notif_disabled = true;
 }
 
-void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
+static void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd)
 {
 	struct msghdr msg;
diff --git a/android/ipc.h b/android/ipc.h
index c4f8c41..6fdc162 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -42,19 +42,12 @@ void ipc_set_fail_handler(struct ipc *ipc, ipc_failed_cb cb, void *data);
 
 void ipc_disable_notifications(struct ipc *ipc);
 
-GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb,
-							void *user_data);
-int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
-						const void *buf, ssize_t len);
-
 void ipc_send_rsp(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
 								uint8_t status);
 void ipc_send_rsp_full(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
 					uint16_t len, void *param, int fd);
 void ipc_send_notif(struct ipc *ipc, uint8_t service_id, uint8_t opcode,
 						uint16_t len, void *param);
-void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
-							void *param, int fd);
 void ipc_register(struct ipc *ipc, uint8_t service,
 			const struct ipc_handler *handlers, uint8_t size);
 void ipc_unregister(struct ipc *ipc, uint8_t service);
-- 
1.8.3.2


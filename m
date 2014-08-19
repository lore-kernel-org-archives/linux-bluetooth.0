Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/11] android/hal-ipc: Constify param parameter
Date: Tue, 19 Aug 2014 21:51:05 +0200
Message-Id: <1408477872-24160-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
References: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

param buffer is not modified by function and should be const.
Due to non-const iov_base in struct iovec this needs to be later
casted to (void *).
---
 android/hal-ipc.c | 4 ++--
 android/hal-ipc.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 7aef971..8f02e97 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -396,8 +396,8 @@ void hal_ipc_cleanup(void)
 	disconnect_cb_data = NULL;
 }
 
-int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
-					size_t *rsp_len, void *rsp, int *fd)
+int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
+			const void *param, size_t *rsp_len, void *rsp, int *fd)
 {
 	ssize_t ret;
 	struct msghdr msg;
diff --git a/android/hal-ipc.h b/android/hal-ipc.h
index ddfcbd4..8b7b35f 100644
--- a/android/hal-ipc.h
+++ b/android/hal-ipc.h
@@ -32,8 +32,8 @@ void hal_ipc_set_thread_cb(hal_ipc_thread_t cb);
 bool hal_ipc_accept(void);
 void hal_ipc_cleanup(void);
 
-int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
-					size_t *rsp_len, void *rsp, int *fd);
+int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
+			const void *param, size_t *rsp_len, void *rsp, int *fd);
 
 void hal_ipc_register(uint8_t service, const struct hal_ipc_handler *handlers,
 								uint8_t size);
-- 
1.9.3


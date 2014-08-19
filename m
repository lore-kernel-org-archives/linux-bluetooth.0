Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/11] android/hal-ipc: Use IPC constants for return codes
Date: Tue, 19 Aug 2014 21:51:03 +0200
Message-Id: <1408477872-24160-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
References: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc.c    | 4 ++--
 android/ipc-common.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 1f5cc52..4f51c36 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -509,7 +509,7 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 
 	*rsp_len = cmd.len;
 
-	return BT_STATUS_SUCCESS;
+	return IPC_STATUS_SUCCESS;
 
 failed:
 	pthread_mutex_lock(&ipc_mutex);
@@ -519,5 +519,5 @@ failed_locked:
 		shutdown(notif_sk, SHUT_RD);
 	pthread_mutex_unlock(&ipc_mutex);
 
-	return BT_STATUS_FAIL;
+	return IPC_STATUS_FAIL;
 }
diff --git a/android/ipc-common.h b/android/ipc-common.h
index 27736e4..958ef9e 100644
--- a/android/ipc-common.h
+++ b/android/ipc-common.h
@@ -24,6 +24,7 @@
 #define IPC_MTU 1024
 
 #define IPC_STATUS_SUCCESS	0x00
+#define IPC_STATUS_FAIL		0x01
 
 struct ipc_hdr {
 	uint8_t  service_id;
-- 
1.9.3


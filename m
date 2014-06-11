Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/10] android/hal-ipc: Allow to pass custom path to IPC
Date: Wed, 11 Jun 2014 16:32:44 +0200
Message-Id: <1402497172-12436-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
References: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 2 +-
 android/hal-ipc.c       | 4 ++--
 android/hal-ipc.h       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index e9a677a..c2a1085 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -420,7 +420,7 @@ static int init(bt_callbacks_t *callbacks)
 	hal_ipc_register(HAL_SERVICE_ID_BLUETOOTH, ev_handlers,
 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
 
-	if (!hal_ipc_init()) {
+	if (!hal_ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH))) {
 		bt_hal_cbacks = NULL;
 		return BT_STATUS_FAIL;
 	}
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 8f5babe..81d3a1b 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -229,7 +229,7 @@ static int accept_connection(int sk)
 	return new_sk;
 }
 
-bool hal_ipc_init(void)
+bool hal_ipc_init(const char *path, size_t size)
 {
 	struct sockaddr_un addr;
 	int sk;
@@ -246,7 +246,7 @@ bool hal_ipc_init(void)
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_UNIX;
 
-	memcpy(addr.sun_path, BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH));
+	memcpy(addr.sun_path, path, size);
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		err = errno;
diff --git a/android/hal-ipc.h b/android/hal-ipc.h
index 2fbf30f..0d16cdb 100644
--- a/android/hal-ipc.h
+++ b/android/hal-ipc.h
@@ -21,7 +21,7 @@ struct hal_ipc_handler {
 	size_t data_len;
 };
 
-bool hal_ipc_init(void);
+bool hal_ipc_init(const char *path, size_t size);
 void hal_ipc_cleanup(void);
 
 int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
-- 
1.9.1


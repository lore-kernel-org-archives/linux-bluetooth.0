Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/10] android: Use ipc_send_rsp helper for replying success
Date: Thu, 28 Nov 2013 15:15:23 +0100
Message-Id: <1385648130-12808-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
References: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Where applicable use helper as this make code easier to understand.
---
 android/bluetooth.c | 2 +-
 android/main.c      | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 716c0eb..b5fd644 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2263,7 +2263,7 @@ void bt_bluetooth_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 		goto error;
 	}
 
-	ipc_send(sk, HAL_SERVICE_ID_BLUETOOTH, opcode, 0, NULL, -1);
+	ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, opcode, HAL_STATUS_SUCCESS);
 	return;
 
 error:
diff --git a/android/main.c b/android/main.c
index 6fe0d1c..211503b 100644
--- a/android/main.c
+++ b/android/main.c
@@ -115,8 +115,8 @@ static void service_register(void *buf, uint16_t len)
 
 	services[m->service_id] = true;
 
-	ipc_send(g_io_channel_unix_get_fd(hal_cmd_io), HAL_SERVICE_ID_CORE,
-					HAL_OP_REGISTER_MODULE, 0, NULL, -1);
+	ipc_send_rsp(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
+							HAL_STATUS_SUCCESS);
 
 	info("Service ID=%u registered", m->service_id);
 	return;
@@ -157,8 +157,8 @@ static void service_unregister(void *buf, uint16_t len)
 
 	services[m->service_id] = false;
 
-	ipc_send(g_io_channel_unix_get_fd(hal_cmd_io), HAL_SERVICE_ID_CORE,
-					HAL_OP_UNREGISTER_MODULE, 0, NULL, -1);
+	ipc_send_rsp(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+							HAL_STATUS_SUCCESS);
 
 	info("Service ID=%u unregistered", m->service_id);
 	return;
-- 
1.8.3.2


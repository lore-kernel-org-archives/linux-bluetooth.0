Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/13] android/main: Use IPC helper for all replies in core service
Date: Wed, 27 Nov 2013 12:54:55 +0100
Message-Id: <1385553305-5807-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
References: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes functions exit path simpler.
---
 android/main.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/android/main.c b/android/main.c
index 6139ed7..de19127 100644
--- a/android/main.c
+++ b/android/main.c
@@ -78,6 +78,7 @@ static void service_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_register_module *m = buf;
 	int sk = g_io_channel_unix_get_fd(hal_notif_io);
+	uint8_t status = HAL_STATUS_FAILED;
 
 	if (m->service_id > HAL_SERVICE_ID_MAX || services[m->service_id])
 		goto failed;
@@ -115,20 +116,19 @@ static void service_register(const void *buf, uint16_t len)
 
 	services[m->service_id] = true;
 
-	ipc_send(g_io_channel_unix_get_fd(hal_cmd_io), HAL_SERVICE_ID_CORE,
-					HAL_OP_REGISTER_MODULE, 0, NULL, -1);
+	status = HAL_STATUS_SUCCESS;
 
 	info("Service ID=%u registered", m->service_id);
-	return;
+
 failed:
-	ipc_send_rsp(g_io_channel_unix_get_fd(hal_cmd_io),
-				HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-				HAL_STATUS_FAILED);
+	ipc_send_rsp(g_io_channel_unix_get_fd(hal_cmd_io), HAL_SERVICE_ID_CORE,
+					HAL_OP_REGISTER_MODULE, status);
 }
 
 static void service_unregister(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_unregister_module *m = buf;
+	uint8_t status = HAL_STATUS_FAILED;
 
 	if (m->service_id > HAL_SERVICE_ID_MAX || !services[m->service_id])
 		goto failed;
@@ -158,15 +158,13 @@ static void service_unregister(const void *buf, uint16_t len)
 
 	services[m->service_id] = false;
 
-	ipc_send(g_io_channel_unix_get_fd(hal_cmd_io), HAL_SERVICE_ID_CORE,
-					HAL_OP_UNREGISTER_MODULE, 0, NULL, -1);
+	status = HAL_STATUS_SUCCESS;
 
 	info("Service ID=%u unregistered", m->service_id);
-	return;
+
 failed:
-	ipc_send_rsp(g_io_channel_unix_get_fd(hal_cmd_io),
-				HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
-				HAL_STATUS_FAILED);
+	ipc_send_rsp(g_io_channel_unix_get_fd(hal_cmd_io), HAL_SERVICE_ID_CORE,
+					HAL_OP_UNREGISTER_MODULE, status);
 }
 
 static const struct ipc_handler cmd_handlers[] = {
-- 
1.8.3.2


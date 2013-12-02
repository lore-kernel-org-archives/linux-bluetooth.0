Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 3/9] android/main: Use common exit path in core service functions
Date: Mon,  2 Dec 2013 13:20:42 +0100
Message-Id: <1385986848-8023-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
References: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes functions exit path simpler.
---
 android/main.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/android/main.c b/android/main.c
index 0816ec7..c0f8901 100644
--- a/android/main.c
+++ b/android/main.c
@@ -77,9 +77,12 @@ static bool services[HAL_SERVICE_ID_MAX + 1] = { false };
 static void service_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_register_module *m = buf;
+	uint8_t status;
 
-	if (m->service_id > HAL_SERVICE_ID_MAX || services[m->service_id])
+	if (m->service_id > HAL_SERVICE_ID_MAX || services[m->service_id]) {
+		status = HAL_STATUS_FAILED;
 		goto failed;
+	}
 
 	switch (m->service_id) {
 	case HAL_SERVICE_ID_BLUETOOTH:
@@ -91,43 +94,51 @@ static void service_register(const void *buf, uint16_t len)
 
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
-		if (!bt_hid_register(&adapter_bdaddr))
+		if (!bt_hid_register(&adapter_bdaddr)) {
+			status = HAL_STATUS_FAILED;
 			goto failed;
+		}
 
 		break;
 	case HAL_SERVICE_ID_A2DP:
-		if (!bt_a2dp_register(&adapter_bdaddr))
+		if (!bt_a2dp_register(&adapter_bdaddr)) {
+			status = HAL_STATUS_FAILED;
 			goto failed;
+		}
 
 		break;
 	case HAL_SERVICE_ID_PAN:
-		if (!bt_pan_register(&adapter_bdaddr))
+		if (!bt_pan_register(&adapter_bdaddr)) {
+			status = HAL_STATUS_FAILED;
 			goto failed;
+		}
 
 		break;
 	default:
 		DBG("service %u not supported", m->service_id);
+		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
 	services[m->service_id] = true;
 
-	ipc_send_rsp(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-							HAL_STATUS_SUCCESS);
+	status = HAL_STATUS_SUCCESS;
 
 	info("Service ID=%u registered", m->service_id);
-	return;
+
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE, status);
 }
 
 static void service_unregister(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_unregister_module *m = buf;
+	uint8_t status;
 
-	if (m->service_id > HAL_SERVICE_ID_MAX || !services[m->service_id])
+	if (m->service_id > HAL_SERVICE_ID_MAX || !services[m->service_id]) {
+		status = HAL_STATUS_FAILED;
 		goto failed;
+	}
 
 	switch (m->service_id) {
 	case HAL_SERVICE_ID_BLUETOOTH:
@@ -149,19 +160,18 @@ static void service_unregister(const void *buf, uint16_t len)
 		/* This would indicate bug in HAL, as unregister should not be
 		 * called in init failed */
 		DBG("service %u not supported", m->service_id);
+		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
 	services[m->service_id] = false;
 
-	ipc_send_rsp(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
-							HAL_STATUS_SUCCESS);
+	status = HAL_STATUS_SUCCESS;
 
 	info("Service ID=%u unregistered", m->service_id);
-	return;
+
 failed:
-	ipc_send_rsp(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
-							HAL_STATUS_FAILED);
+	ipc_send_rsp(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE, status);
 }
 
 static const struct ipc_handler cmd_handlers[] = {
-- 
1.8.3.2


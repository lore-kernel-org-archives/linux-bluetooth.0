Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/bluetooth: Make sure proper controller mode is set on start
Date: Thu,  8 May 2014 11:07:13 +0200
Message-Id: <1399540033-26119-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BR/EDR and LE features can be toggled before daemon is started and
we should not assume their state.
---
 android/bluetooth.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 2bc79e2..dbd6102 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3966,12 +3966,19 @@ static const struct ipc_handler cmd_handlers[] = {
 
 bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 {
+	uint32_t missing_settings;
+
 	DBG("mode 0x%x", mode);
 
+	missing_settings = adapter.current_settings ^
+					adapter.supported_settings;
+
 	switch (mode) {
 	case HAL_MODE_DEFAULT:
-		if (!(adapter.current_settings & MGMT_SETTING_LE) &&
-				(adapter.supported_settings & MGMT_SETTING_LE))
+		if (missing_settings & MGMT_SETTING_BREDR)
+			set_mode(MGMT_OP_SET_BREDR, 0x01);
+
+		if (missing_settings & MGMT_SETTING_LE)
 			set_mode(MGMT_OP_SET_LE, 0x01);
 		break;
 	case HAL_MODE_LE:
@@ -3990,14 +3997,24 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 			set_mode(MGMT_OP_SET_BREDR, 0x00);
 		break;
 	case HAL_MODE_BREDR:
-		/*
-		 * BR/EDR Should be enabled on start, if it is not that means
-		 * there is LE controller only and we should fail
-		 */
-		if (!(adapter.current_settings & MGMT_SETTING_BREDR)) {
+		/* Fail if controller does not support BR/EDR */
+		if (!(adapter.supported_settings & MGMT_SETTING_BREDR)) {
 			error("BR/EDR Mode not supported");
 			return false;
 		}
+
+		/* Enable BR/EDR if it is not enabled */
+		if (missing_settings & MGMT_SETTING_BREDR)
+			set_mode(MGMT_OP_SET_BREDR, 0x01);
+
+		/*
+		 * According to Core Spec 4.0 host should not disable LE in
+		 * controller if it was enabled (Vol 2. Part E. 7.3.79).
+		 * Core Spec 4.1 removed this limitation and chips seem to be
+		 * handling this just fine anyway.
+		 */
+		if (adapter.current_settings & MGMT_SETTING_LE)
+			set_mode(MGMT_OP_SET_LE, 0x00);
 		break;
 	default:
 		error("Unknown mode 0x%x", mode);
-- 
1.9.1


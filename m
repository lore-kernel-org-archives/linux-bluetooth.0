Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Add missing HAL IPC error status definitions
Date: Tue, 22 Oct 2013 08:54:12 +0200
Message-Id: <1382424852-8049-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 1f77586..7d91ed1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -47,6 +47,15 @@ struct hal_msg_hdr {
 /* Core Service */
 
 #define HAL_ERROR_FAILED		0x01
+#define HAL_ERROR_NOT_READY		0x02
+#define HAL_ERROR_NOMEM			0x03
+#define HAL_ERROR_BUSY			0x04
+#define HAL_ERROR_DONE			0x05
+#define HAL_ERROR_UNSUPPORTED		0x06
+#define HAL_ERROR_INVALID		0x07
+#define HAL_ERROR_UNHANDLED		0x08
+#define HAL_ERROR_AUTH_FAILURE		0x09
+#define HAL_ERROR_REMOTE_DEVICE_DOWN	0x0A
 
 #define HAL_MSG_OP_ERROR		0x00
 struct hal_msg_rsp_error {
-- 
1.8.4


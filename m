Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 02/15] android: Add properties defines to hal-msg.h
Date: Fri, 25 Oct 2013 12:49:58 +0200
Message-ID: <1382698211-9123-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
References: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android HAL defines some properties as adapter specific, some as
device specific and some as common. We split those to separate
adapter and device properties hence overlaping or holes in codes.
---
 android/hal-msg.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 854e9b8..352a64c 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -91,6 +91,27 @@ struct hal_cmd_get_adapter_prop {
 	uint8_t type;
 } __attribute__((packed));
 
+#define HAL_PROP_ADAPTER_NAME			0x01
+#define HAL_PROP_ADAPTER_ADDR			0x02
+#define HAL_PROP_ADAPTER_UUIDS			0x03
+#define HAL_PROP_ADAPTER_CLASS			0x04
+#define HAL_PROP_ADAPTER_TYPE			0x05
+#define HAL_PROP_ADAPTER_SERVICE_REC		0x06
+#define HAL_PROP_ADAPTER_SCAN_MODE		0x07
+#define HAL_PROP_ADAPTER_BONDED_DEVICES		0x08
+#define HAL_PROP_ADAPTER_DISC_TIMEOUT		0x09
+
+#define HAL_PROP_DEVICE_NAME			0x01
+#define HAL_PROP_DEVICE_ADDR			0x02
+#define HAL_PROP_DEVICE_UUIDS			0x03
+#define HAL_PROP_DEVICE_CLASS			0x04
+#define HAL_PROP_DEVICE_TYPE			0x05
+#define HAL_PROP_DEVICE_SERVICE_REC		0x06
+#define HAL_PROP_DEVICE_FRIENDLY_NAME		0x0a
+#define HAL_PROP_DEVICE_RSSI			0x0b
+#define HAL_PROP_DEVICE_VERSION_INFO		0x0c
+#define HAL_PROP_DEVICE_TIMESTAMP		0xFF
+
 #define HAL_OP_SET_ADAPTER_PROP		0x05
 struct hal_cmd_set_adapter_prop {
 	uint8_t  type;
-- 
1.8.4.1


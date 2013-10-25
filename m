Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/15] android: Add properties defines to hal-msg.h
Date: Fri, 25 Oct 2013 10:56:05 +0200
Message-ID: <1382691378-31940-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
References: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HAL_BT_PROP_ADP_* are specific to adapter. HAL_BT_PROP_REM_* are
specific to remote device. Rest is common.
---
 android/hal-msg.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 854e9b8..7689f38 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -91,6 +91,20 @@ struct hal_cmd_get_adapter_prop {
 	uint8_t type;
 } __attribute__((packed));
 
+#define HAL_BT_PROP_BDNAME		0x01
+#define HAL_BT_PROP_BDADDR		0x02
+#define HAL_BT_PROP_UUIDS		0x03
+#define HAL_BT_PROP_CLASS_OF_DEVICE	0x04
+#define HAL_BT_PROP_TYPE_OF_DEVICE	0x05
+#define HAL_BT_PROP_SERVICE_RECORD	0x06
+#define HAL_BT_PROP_ADP_SCAN_MODE	0x07
+#define HAL_BT_PROP_ADP_BONDED_DEVICES	0x08
+#define HAL_BT_PROP_ADP_DISC_TIMEOUT	0x09
+#define HAL_BT_PROP_REM_FRIENDLY_NAME	0x0a
+#define HAL_BT_PROP_REM_RSSI		0x0b
+#define HAL_BT_PROP_REM_VERSION_INFO	0x0c
+#define HAL_BT_PROP_REM_DEV_TIMESTAMP	0xFF
+
 #define HAL_OP_SET_ADAPTER_PROP		0x05
 struct hal_cmd_set_adapter_prop {
 	uint8_t  type;
-- 
1.8.4.1


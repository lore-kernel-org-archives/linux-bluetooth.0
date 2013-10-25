Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/6] android: Add missing scan mode difinitions to IPC header
Date: Fri, 25 Oct 2013 17:15:00 +0200
Message-ID: <1382714103-27689-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382714103-27689-1-git-send-email-szymon.janc@tieto.com>
References: <1382714103-27689-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 172cecb..677b00b 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -113,6 +113,10 @@ struct hal_cmd_get_adapter_prop {
 #define HAL_PROP_DEVICE_VERSION_INFO		0x0c
 #define HAL_PROP_DEVICE_TIMESTAMP		0xFF
 
+#define HAL_ADAPTER_SCAN_MODE_NONE		0x00
+#define HAL_ADAPTER_SCAN_MODE_CONN		0x01
+#define HAL_ADAPTER_SCAN_MODE_CONN_DISC	0x02
+
 #define HAL_OP_SET_ADAPTER_PROP		0x05
 struct hal_cmd_set_adapter_prop {
 	uint8_t  type;
-- 
1.8.4.1


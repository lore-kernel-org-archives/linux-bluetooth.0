Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 1/6] android/hal-msg: Add configuration command
Date: Tue, 13 May 2014 19:09:16 +0200
Message-Id: <1400000961-24376-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400000961-24376-1-git-send-email-szymon.janc@tieto.com>
References: <1400000961-24376-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 09bd9a0..8daea2d 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -69,6 +69,24 @@ struct hal_cmd_unregister_module {
 	uint8_t service_id;
 } __attribute__((packed));
 
+#define HAL_CONFIG_MANUFACTURER_NAME	0x00
+#define HAL_CONFIG_SYSTEM_ID		0x01
+#define HAL_CONFIG_MODEL_NUMBER		0x02
+#define HAL_CONFIG_SERIAL_NUMBER	0x03
+
+#define HAL_CONFIG_PROP_LEN		92
+
+struct hal_config_prop {
+	uint8_t type;
+	uint8_t buf[HAL_CONFIG_PROP_LEN];
+} __attribute__((packed));
+
+#define HAL_OP_CONFIGURATION		0x03
+struct hal_cmd_configuration {
+	uint8_t num;
+	struct hal_config_prop props[0];
+} __attribute__((packed));
+
 /* Bluetooth Core HAL API */
 
 #define HAL_OP_ENABLE			0x01
-- 
1.9.1


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/11] android/hal-msg: Add configuration command
Date: Mon, 15 Sep 2014 16:49:06 +0200
Message-Id: <1410792555-24765-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
References: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 3d95e10..48d3186 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -69,6 +69,23 @@ struct hal_cmd_unregister_module {
 	uint8_t service_id;
 } __attribute__((packed));
 
+#define HAL_CONFIG_VENDOR		0x00
+#define HAL_CONFIG_MODEL		0x01
+#define HAL_CONFIG_NAME			0x02
+
+#define HAL_CONFIG_MAX_LEN		92
+
+struct hal_config_prop {
+	uint8_t type;
+	uint8_t val[HAL_CONFIG_MAX_LEN];
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
1.9.3


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/9] android/bluetooth: Add support for reporting adapter type property
Date: Wed, 11 Dec 2013 11:31:19 +0100
Message-Id: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to get property with adapter type.
---
 android/bluetooth.c | 32 +++++++++++++++++++++++++++++---
 android/hal-msg.h   |  4 ++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index e456f3c..82003fd 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1674,13 +1674,39 @@ static uint8_t get_adapter_class(void)
 	return HAL_STATUS_SUCCESS;
 }
 
+static uint8_t settings2type(void)
+{
+	bool bredr, le;
+
+	bredr = adapter.current_settings & MGMT_SETTING_BREDR;
+	le = adapter.current_settings & MGMT_SETTING_LE;
+
+	if (bredr && le)
+		return HAL_TYPE_DUAL;
+
+	if (bredr && !le)
+		return HAL_TYPE_BREDR;
+
+	if (!bredr && le)
+		return HAL_TYPE_LE;
+
+	return 0;
+}
+
 static uint8_t get_adapter_type(void)
 {
-	DBG("Not implemented");
+	uint8_t type;
 
-	/* TODO: Add implementation */
+	DBG("");
 
-	return HAL_STATUS_FAILED;
+	type = settings2type();
+
+	if (!type)
+		return HAL_STATUS_FAILED;
+
+	send_adapter_property(HAL_PROP_ADAPTER_TYPE, sizeof(type), &type);
+
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t get_adapter_service_rec(void)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 80c4a25..3be91aa 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -116,6 +116,10 @@ struct hal_cmd_get_adapter_prop {
 #define HAL_ADAPTER_SCAN_MODE_CONN		0x01
 #define HAL_ADAPTER_SCAN_MODE_CONN_DISC	0x02
 
+#define HAL_TYPE_BREDR				0x01
+#define HAL_TYPE_LE				0x02
+#define HAL_TYPE_DUAL				0x03
+
 #define HAL_OP_SET_ADAPTER_PROP		0x05
 struct hal_cmd_set_adapter_prop {
 	uint8_t  type;
-- 
1.8.3.2


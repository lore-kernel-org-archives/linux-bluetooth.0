Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH v2 BlueZ 07/27] alert: Add Alert Status characteristic
Date: Thu, 27 Sep 2012 14:36:16 -0400
Message-Id: <1348770996-12236-8-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

This characteristic allows to read/notify the status of the ringer,
display and vibration motor.
---
 profiles/alert/server.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 59e6fdc..90536d5 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -43,6 +43,8 @@
 #include "profile.h"
 
 #define PHONE_ALERT_STATUS_SVC_UUID		0x180E
+
+#define ALERT_STATUS_CHR_UUID		0x2A3F
 #define RINGER_CP_CHR_UUID		0x2A40
 #define RINGER_SETTING_CHR_UUID		0x2A41
 
@@ -53,6 +55,7 @@ enum {
 };
 
 static uint8_t ringer_setting = RINGER_NORMAL;
+static uint8_t alert_status = 0;
 
 static uint8_t ringer_cp_write(struct attribute *a,
 						struct btd_device *device,
@@ -63,6 +66,21 @@ static uint8_t ringer_cp_write(struct attribute *a,
 	return 0;
 }
 
+static uint8_t alert_status_read(struct attribute *a,
+						struct btd_device *device,
+						gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	DBG("a = %p", a);
+
+	if (a->data == NULL || a->data[0] != alert_status)
+		attrib_db_update(adapter, a->handle, NULL, &alert_status,
+						sizeof(alert_status), NULL);
+
+	return 0;
+}
+
 static uint8_t ringer_setting_read(struct attribute *a,
 						struct btd_device *device,
 						gpointer user_data)
@@ -86,6 +104,12 @@ static void register_phone_alert_service(struct btd_adapter *adapter)
 
 	/* Phone Alert Status Service */
 	gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
+			/* Alert Status characteristic */
+			GATT_OPT_CHR_UUID, ALERT_STATUS_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
+							ATT_CHAR_PROPER_NOTIFY,
+			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+			alert_status_read, adapter,
 			/* Ringer Control Point characteristic */
 			GATT_OPT_CHR_UUID, RINGER_CP_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
-- 
1.7.9.5


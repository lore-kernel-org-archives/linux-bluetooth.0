Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 07/22] alert: Add Alert Status characteristic
Date: Mon, 27 Aug 2012 13:11:51 -0400
Message-Id: <1346087526-15107-8-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 profiles/alert/server.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 7dca94d..332ffa0 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -41,6 +41,8 @@
 #include "server.h"
 
 #define PHONE_ALERT_STATUS_SVC_UUID		0x180E
+
+#define ALERT_STATUS_CHR_UUID		0x2A3F
 #define RINGER_CP_CHR_UUID		0x2A40
 #define RINGER_SETTING_CHR_UUID		0x2A41
 
@@ -51,6 +53,7 @@ enum {
 };
 
 static uint8_t ringer_setting = RINGER_NORMAL;
+static uint8_t alert_status = 0;
 
 static uint8_t ringer_cp_write(struct attribute *a,
 						struct btd_device *device,
@@ -61,6 +64,21 @@ static uint8_t ringer_cp_write(struct attribute *a,
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
@@ -84,6 +102,12 @@ static void register_phone_alert_service(struct btd_adapter *adapter)
 
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


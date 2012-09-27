Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH v2 BlueZ 06/27] alert: Add Ringer Setting characteristic
Date: Thu, 27 Sep 2012 14:36:15 -0400
Message-Id: <1348770996-12236-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

This characteristic allows to read or notify the ringer mode (silent or
normal).
---
 profiles/alert/server.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 8337c38..59e6fdc 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -37,12 +37,22 @@
 #include "log.h"
 #include "gatt-service.h"
 #include "gattrib.h"
+#include "attrib-server.h"
 #include "gatt.h"
 #include "server.h"
 #include "profile.h"
 
 #define PHONE_ALERT_STATUS_SVC_UUID		0x180E
 #define RINGER_CP_CHR_UUID		0x2A40
+#define RINGER_SETTING_CHR_UUID		0x2A41
+
+/* Ringer Setting characteristic values */
+enum {
+	RINGER_SILENT,
+	RINGER_NORMAL,
+};
+
+static uint8_t ringer_setting = RINGER_NORMAL;
 
 static uint8_t ringer_cp_write(struct attribute *a,
 						struct btd_device *device,
@@ -53,6 +63,21 @@ static uint8_t ringer_cp_write(struct attribute *a,
 	return 0;
 }
 
+static uint8_t ringer_setting_read(struct attribute *a,
+						struct btd_device *device,
+						gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	DBG("a = %p", a);
+
+	if (a->data == NULL || a->data[0] != ringer_setting)
+		attrib_db_update(adapter, a->handle, NULL, &ringer_setting,
+						sizeof(ringer_setting), NULL);
+
+	return 0;
+}
+
 static void register_phone_alert_service(struct btd_adapter *adapter)
 {
 	bt_uuid_t uuid;
@@ -66,6 +91,12 @@ static void register_phone_alert_service(struct btd_adapter *adapter)
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
 			ringer_cp_write, NULL,
+			/* Ringer Setting characteristic */
+			GATT_OPT_CHR_UUID, RINGER_SETTING_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
+							ATT_CHAR_PROPER_NOTIFY,
+			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+			ringer_setting_read, adapter,
 			GATT_OPT_INVALID);
 }
 
-- 
1.7.9.5


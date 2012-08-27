Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 06/22] alert: Add Ringer Setting characteristic
Date: Mon, 27 Aug 2012 13:11:50 -0400
Message-Id: <1346087526-15107-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 profiles/alert/server.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 0f96c55..7dca94d 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -36,11 +36,21 @@
 #include "log.h"
 #include "gatt-service.h"
 #include "gattrib.h"
+#include "attrib-server.h"
 #include "gatt.h"
 #include "server.h"
 
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
@@ -51,6 +61,21 @@ static uint8_t ringer_cp_write(struct attribute *a,
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
@@ -64,6 +89,12 @@ static void register_phone_alert_service(struct btd_adapter *adapter)
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


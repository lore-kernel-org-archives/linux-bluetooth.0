Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 05/22] alert: Add Ringer Control Point characteristic
Date: Mon, 27 Aug 2012 13:11:49 -0400
Message-Id: <1346087526-15107-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 profiles/alert/server.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index cbf751f..0f96c55 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -31,12 +31,25 @@
 
 #include "att.h"
 #include "adapter.h"
+#include "device.h"
+#include "att-database.h"
+#include "log.h"
 #include "gatt-service.h"
 #include "gattrib.h"
 #include "gatt.h"
 #include "server.h"
 
 #define PHONE_ALERT_STATUS_SVC_UUID		0x180E
+#define RINGER_CP_CHR_UUID		0x2A40
+
+static uint8_t ringer_cp_write(struct attribute *a,
+						struct btd_device *device,
+						gpointer user_data)
+{
+	DBG("a = %p", a);
+
+	return 0;
+}
 
 static void register_phone_alert_service(struct btd_adapter *adapter)
 {
@@ -46,6 +59,11 @@ static void register_phone_alert_service(struct btd_adapter *adapter)
 
 	/* Phone Alert Status Service */
 	gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
+			/* Ringer Control Point characteristic */
+			GATT_OPT_CHR_UUID, RINGER_CP_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
+			GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
+			ringer_cp_write, NULL,
 			GATT_OPT_INVALID);
 }
 
-- 
1.7.9.5


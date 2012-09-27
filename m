Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH v2 BlueZ 05/27] alert: Add Ringer Control Point characteristic
Date: Thu, 27 Sep 2012 14:36:14 -0400
Message-Id: <1348770996-12236-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Ringer CP characteristic is used for configuring "silent mode" or muting
the ringer once.
---
 profiles/alert/server.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index b39ef8a..8337c38 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -32,6 +32,9 @@
 
 #include "att.h"
 #include "adapter.h"
+#include "device.h"
+#include "att-database.h"
+#include "log.h"
 #include "gatt-service.h"
 #include "gattrib.h"
 #include "gatt.h"
@@ -39,6 +42,16 @@
 #include "profile.h"
 
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
@@ -48,6 +61,11 @@ static void register_phone_alert_service(struct btd_adapter *adapter)
 
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


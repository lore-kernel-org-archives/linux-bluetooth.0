Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 04/22] alert: Add Phone Alert Service
Date: Mon, 27 Aug 2012 13:11:48 -0400
Message-Id: <1346087526-15107-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 profiles/alert/server.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 3fda23d..cbf751f 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -26,11 +26,33 @@
 #include <config.h>
 #endif
 
+#include <glib.h>
+#include <bluetooth/uuid.h>
+
+#include "att.h"
 #include "adapter.h"
+#include "gatt-service.h"
+#include "gattrib.h"
+#include "gatt.h"
 #include "server.h"
 
+#define PHONE_ALERT_STATUS_SVC_UUID		0x180E
+
+static void register_phone_alert_service(struct btd_adapter *adapter)
+{
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, PHONE_ALERT_STATUS_SVC_UUID);
+
+	/* Phone Alert Status Service */
+	gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
+			GATT_OPT_INVALID);
+}
+
 static int alert_server_probe(struct btd_adapter *adapter)
 {
+	register_phone_alert_service(adapter);
+
 	return 0;
 }
 
-- 
1.7.9.5


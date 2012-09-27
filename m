Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH v2 BlueZ 04/27] alert: Add Phone Alert Status Service
Date: Thu, 27 Sep 2012 14:36:13 -0400
Message-Id: <1348770996-12236-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Add Phone Alert Status service for PASP.
---
 profiles/alert/server.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index dc844d3..b39ef8a 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -27,14 +27,35 @@
 #endif
 
 #include <stdbool.h>
+#include <glib.h>
+#include <bluetooth/uuid.h>
 
+#include "att.h"
 #include "adapter.h"
+#include "gatt-service.h"
+#include "gattrib.h"
+#include "gatt.h"
 #include "server.h"
 #include "profile.h"
 
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
 static int alert_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
+	register_phone_alert_service(adapter);
+
 	return 0;
 }
 
-- 
1.7.9.5


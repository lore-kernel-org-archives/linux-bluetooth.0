Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC BlueZ 3/3] Migrate example service to high level GATT API
Date: Thu, 22 Sep 2011 16:56:38 -0400
Message-Id: <1316724998-1466-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1316724998-1466-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1316724998-1466-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This commit migrates the dummy "Battery Service" from example GATT
plugin to demonstrate how the new API is used.
---
 plugins/gatt-example.c |   61 +++++++++++++----------------------------------
 1 files changed, 17 insertions(+), 44 deletions(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 955d9fa..1456284 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -33,6 +33,7 @@
 #include "hcid.h"
 #include "log.h"
 #include "gattrib.h"
+#include "gatt-service.h"
 #include "att.h"
 #include "attrib-server.h"
 
@@ -57,54 +58,26 @@
 
 static GSList *sdp_handles = NULL;
 
-static void register_battery_service(void)
+static uint8_t battery_state_read(struct attribute *a, gpointer user_data)
 {
-	uint16_t start_handle, h;
-	const int svc_size = 4;
-	uint32_t sdp_handle;
-	uint8_t atval[256];
-	bt_uuid_t uuid;
-
-	start_handle = attrib_db_find_avail(svc_size);
-	if (start_handle == 0) {
-		error("Not enough free handles to register service");
-		return;
-	}
+	uint8_t value;
 
-	DBG("start_handle=0x%04x", start_handle);
-
-	h = start_handle;
+	value = 0x04;
+	attrib_db_update(a->handle, NULL, &value, sizeof(value), NULL);
 
-	/* Battery state service: primary service definition */
-	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	att_put_u16(BATTERY_STATE_SVC_UUID, &atval[0]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
-
-	/* Battery: battery state characteristic */
-	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_NOTIFY;
-	att_put_u16(h + 1, &atval[1]);
-	att_put_u16(BATTERY_STATE_UUID, &atval[3]);
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
-
-	/* Battery: battery state attribute */
-	bt_uuid16_create(&uuid, BATTERY_STATE_UUID);
-	atval[0] = 0x04;
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
-
-	/* Battery: Client Characteristic Configuration */
-	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	atval[0] = 0x00;
-	atval[1] = 0x00;
-	attrib_db_add(h++, &uuid, ATT_NONE, ATT_AUTHENTICATION, atval, 2);
-
-	g_assert(h - start_handle == svc_size);
+	return 0;
+}
 
-	/* Add an SDP record for the above service */
-	sdp_handle = attrib_create_sdp(start_handle, "Battery State Service");
-	if (sdp_handle)
-		sdp_handles = g_slist_prepend(sdp_handles,
-						GUINT_TO_POINTER(sdp_handle));
+static void register_battery_service(void)
+{
+	gatt_service_add(GATT_PRIM_SVC_UUID, BATTERY_STATE_SVC_UUID,
+			/* battery state characteristic */
+			GATT_OPT_CHR_UUID, BATTERY_STATE_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
+							ATT_CHAR_PROPER_NOTIFY,
+			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ, battery_state_read,
+
+			GATT_OPT_INVALID);
 }
 
 static void register_termometer_service(const uint16_t manuf1[2],
-- 
1.7.0.4


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] gatt: Use monitor code to decode service name
Date: Mon,  4 Dec 2017 10:10:53 -0200
Message-Id: <20171204121054.29186-2-luiz.dentz@gmail.com>
In-Reply-To: <20171204121054.29186-1-luiz.dentz@gmail.com>
References: <20171204121054.29186-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the daemon reuse the code for decoding service names that
the monitor uses.
---
 Makefile.am         |  3 ++-
 src/gatt-database.c | 16 ++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 02f02a100..cda23e7d6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -188,7 +188,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/gatt-client.h src/gatt-client.c \
 			src/device.h src/device.c \
 			src/dbus-common.c src/dbus-common.h \
-			src/eir.h src/eir.c
+			src/eir.h src/eir.c \
+			monitor/uuid.h monitor/uuid.c
 src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
 			src/libshared-glib.la \
diff --git a/src/gatt-database.c b/src/gatt-database.c
index fa94a83f8..76ec1cde1 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -30,6 +30,7 @@
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
 #include "lib/uuid.h"
+#include "monitor/uuid.h"
 #include "btio/btio.h"
 #include "gdbus/gdbus.h"
 #include "src/shared/util.h"
@@ -707,24 +708,29 @@ static sdp_record_t *record_new(uuid_t *uuid, uint16_t start, uint16_t end)
 }
 
 static uint32_t database_add_record(struct btd_gatt_database *database,
-					struct gatt_db_attribute *attr,
-					const char *name)
+					struct gatt_db_attribute *attr)
 {
 	sdp_record_t *record;
 	uint16_t start, end;
 	uuid_t svc, gap_uuid;
 	bt_uuid_t uuid;
+	const char *name = NULL;
+	char uuidstr[MAX_LEN_UUID_STR];
 
 	gatt_db_attribute_get_service_uuid(attr, &uuid);
 
 	switch (uuid.type) {
 	case BT_UUID16:
+		name = uuid16_to_str(uuid.value.u16);
 		sdp_uuid16_create(&svc, uuid.value.u16);
 		break;
 	case BT_UUID32:
+		name = uuid32_to_str(uuid.value.u32);
 		sdp_uuid32_create(&svc, uuid.value.u32);
 		break;
 	case BT_UUID128:
+		bt_uuid_to_string(&uuid, uuidstr, sizeof(uuidstr));
+		name = uuidstr_to_str(uuidstr);
 		sdp_uuid128_create(&svc, (void *) &uuid.value.u128);
 		break;
 	case BT_UUID_UNSPEC:
@@ -762,8 +768,7 @@ static void populate_gap_service(struct btd_gatt_database *database)
 	/* Add the GAP service */
 	bt_uuid16_create(&uuid, UUID_GAP);
 	service = gatt_db_add_service(database->db, &uuid, true, 5);
-	database->gap_handle = database_add_record(database, service,
-						"Generic Access Profile");
+	database->gap_handle = database_add_record(database, service);
 
 	/*
 	 * Device Name characteristic.
@@ -917,8 +922,7 @@ static void populate_gatt_service(struct btd_gatt_database *database)
 	/* Add the GATT service */
 	bt_uuid16_create(&uuid, UUID_GATT);
 	service = gatt_db_add_service(database->db, &uuid, true, 4);
-	database->gatt_handle = database_add_record(database, service,
-						"Generic Attribute Profile");
+	database->gatt_handle = database_add_record(database, service);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
 	database->svc_chngd = gatt_db_service_add_characteristic(service, &uuid,
-- 
2.13.6


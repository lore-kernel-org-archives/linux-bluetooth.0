Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 06/14] core: Add GATT UUIDs to Adapter1.UUIDs
Date: Wed, 11 Feb 2015 19:17:36 -0800
Message-Id: <1423711064-7390-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1423711064-7390-1-git-send-email-armansito@chromium.org>
References: <1423711064-7390-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Modified src/adapter so that the UUIDs property includes UUIDs that
were added to the local GATT database.
---
 src/adapter.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 0253d08..c903274 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -53,6 +53,9 @@
 #include "lib/mgmt.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
 
 #include "hcid.h"
 #include "sdpd.h"
@@ -2189,16 +2192,37 @@ static gboolean property_get_discovering(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static void add_gatt_uuid(struct gatt_db_attribute *attrib, void *user_data)
+{
+	DBusMessageIter *iter = user_data;
+	bt_uuid_t uuid, u128;
+	char uuidstr[MAX_LEN_UUID_STR + 1];
+	const char *ptr = uuidstr;
+
+	if (!gatt_db_service_get_active(attrib))
+		return;
+
+	if (!gatt_db_attribute_get_service_uuid(attrib, &uuid))
+		return;
+
+	bt_uuid_to_uuid128(&uuid, &u128);
+	bt_uuid_to_string(&u128, uuidstr, sizeof(uuidstr));
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
+}
+
 static gboolean property_get_uuids(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
 	DBusMessageIter entry;
 	sdp_list_t *l;
+	struct gatt_db *db;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_TYPE_STRING_AS_STRING, &entry);
 
+	/* SDP records */
 	for (l = adapter->services; l != NULL; l = l->next) {
 		sdp_record_t *rec = l->data;
 		char *uuid;
@@ -2212,6 +2236,11 @@ static gboolean property_get_uuids(const GDBusPropertyTable *property,
 		free(uuid);
 	}
 
+	/* GATT services */
+	db = btd_gatt_database_get_db(adapter);
+	if (db)
+		gatt_db_foreach_service(db, NULL, add_gatt_uuid, &entry);
+
 	dbus_message_iter_close_container(iter, &entry);
 
 	return TRUE;
-- 
2.2.0.rc0.207.ga3a616c


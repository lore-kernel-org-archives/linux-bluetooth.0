Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 1/4] core/adapter: Deduplicate local service UUIDs
Date: Wed,  4 Mar 2015 13:57:48 -0800
Message-Id: <1425506271-20775-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1425506271-20775-1-git-send-email-armansito@chromium.org>
References: <1425506271-20775-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

An adapter's local GATT database can contain multiple services with the
same UUID and some of these services may also be present in the SDP
tables. This patch deduplicates these so that the response returned for
the "UUIDs" property only contains a single instance of each service
UUID.
---
 src/adapter.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c12f557..93de573 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2192,10 +2192,9 @@ static gboolean property_get_discovering(const GDBusPropertyTable *property,
 
 static void add_gatt_uuid(struct gatt_db_attribute *attrib, void *user_data)
 {
-	DBusMessageIter *iter = user_data;
+	GHashTable *uuids = user_data;
 	bt_uuid_t uuid, u128;
 	char uuidstr[MAX_LEN_UUID_STR + 1];
-	const char *ptr = uuidstr;
 
 	if (!gatt_db_service_get_active(attrib))
 		return;
@@ -2206,7 +2205,15 @@ static void add_gatt_uuid(struct gatt_db_attribute *attrib, void *user_data)
 	bt_uuid_to_uuid128(&uuid, &u128);
 	bt_uuid_to_string(&u128, uuidstr, sizeof(uuidstr));
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
+	g_hash_table_add(uuids, strdup(uuidstr));
+}
+
+static void iter_append_uuid(gpointer key, gpointer value, gpointer user_data)
+{
+	DBusMessageIter *iter = user_data;
+	const char *uuid = key;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
 }
 
 static gboolean property_get_uuids(const GDBusPropertyTable *property,
@@ -2216,9 +2223,11 @@ static gboolean property_get_uuids(const GDBusPropertyTable *property,
 	DBusMessageIter entry;
 	sdp_list_t *l;
 	struct gatt_db *db;
+	GHashTable *uuids;
 
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-					DBUS_TYPE_STRING_AS_STRING, &entry);
+	uuids = g_hash_table_new_full(g_str_hash, g_str_equal, free, NULL);
+	if (!uuids)
+		return FALSE;
 
 	/* SDP records */
 	for (l = adapter->services; l != NULL; l = l->next) {
@@ -2229,18 +2238,21 @@ static gboolean property_get_uuids(const GDBusPropertyTable *property,
 		if (uuid == NULL)
 			continue;
 
-		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
-								&uuid);
-		free(uuid);
+		g_hash_table_add(uuids, uuid);
 	}
 
 	/* GATT services */
 	db = btd_gatt_database_get_db(adapter->database);
 	if (db)
-		gatt_db_foreach_service(db, NULL, add_gatt_uuid, &entry);
+		gatt_db_foreach_service(db, NULL, add_gatt_uuid, uuids);
 
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &entry);
+	g_hash_table_foreach(uuids, iter_append_uuid, &entry);
 	dbus_message_iter_close_container(iter, &entry);
 
+	g_hash_table_destroy(uuids);
+
 	return TRUE;
 }
 
-- 
2.2.0.rc0.207.ga3a616c


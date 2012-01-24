Return-Path: <cyrus@holtmann.org>
From: Vishal Agarwal <vishal.agarwal@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <naresh.gupta@stericsson.com>,
	Vishal Agarwal <vishal.agarwal@stericsson.com>
Subject: [PATCH BlueZ v3 1/2] Adapter-Add-Support-for-BLE-Services-to-Adapter
Date: Tue, 24 Jan 2012 09:19:59 +0530
Message-ID: <1327377000-17048-2-git-send-email-vishal.agarwal@stericsson.com>
In-Reply-To: <1327377000-17048-1-git-send-email-vishal.agarwal@stericsson.com>
References: <1327377000-17048-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support of adding BLE services to adapter, which
can be retrieved using GetProperties method.

---
 src/adapter.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/adapter.h |    2 +
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a75a0c4..51df126 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -154,6 +154,7 @@ struct btd_adapter {
 	GSList *pin_callbacks;
 
 	GSList *loaded_drivers;
+	GSList *primaries;
 };
 
 static void dev_info_free(void *data)
@@ -879,11 +880,12 @@ static void adapter_emit_uuids_updated(struct btd_adapter *adapter)
 	char **uuids;
 	int i;
 	sdp_list_t *list;
+	GSList *primary_list;
 
 	if (!adapter->initialized)
 		return;
 
-	uuids = g_new0(char *, sdp_list_len(adapter->services) + 1);
+	uuids = g_new0(char *, sdp_list_len(adapter->services) + g_slist_length(adapter->primaries) + 1);
 
 	for (i = 0, list = adapter->services; list; list = list->next) {
 		char *uuid;
@@ -894,6 +896,17 @@ static void adapter_emit_uuids_updated(struct btd_adapter *adapter)
 			uuids[i++] = uuid;
 	}
 
+	for (primary_list = adapter->primaries; primary_list; primary_list = primary_list->next) {
+		char *uuid = g_malloc0(MAX_LEN_UUID_STR);
+		bt_uuid_t *uuid128 = g_malloc(sizeof(bt_uuid_t));
+		bt_uuid_t *rec = primary_list->data;
+		bt_uuid_to_uuid128(rec, uuid128);
+
+		if (!bt_uuid_to_string(uuid128, uuid, MAX_LEN_UUID_STR))
+			uuids[i++] = uuid;
+		g_free(uuid128);
+	}
+
 	emit_array_property_changed(connection, adapter->path,
 			ADAPTER_INTERFACE, "UUIDs", DBUS_TYPE_STRING, &uuids, i);
 
@@ -986,6 +999,39 @@ void adapter_service_remove(struct btd_adapter *adapter, void *r)
 	adapter_emit_uuids_updated(adapter);
 }
 
+static void insert_primary_uuid(struct btd_adapter *adapter, const bt_uuid_t *uuid)
+{
+	if (!g_slist_find_custom(adapter->primaries, uuid, (GCompareFunc) bt_uuid_cmp))
+		adapter->primaries = g_slist_append(adapter->primaries, uuid);
+	else
+		g_free(uuid);
+}
+
+static void remove_primary_uuid(struct btd_adapter *adapter, const bt_uuid_t *uuid)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(adapter->primaries, uuid, (GCompareFunc) bt_uuid_cmp);
+	if (!l) {
+		adapter->primaries = g_slist_remove(adapter->primaries, l->data);
+		g_free(l->data);
+	}
+}
+
+void adapter_add_primary_uuid(struct btd_adapter *adapter, uint16_t val)
+{
+	bt_uuid_t *primary = g_malloc(sizeof(bt_uuid_t));
+	bt_uuid16_create(primary, val);
+	insert_primary_uuid(adapter, primary);
+}
+
+void adapter_remove_primary_uuid(struct btd_adapter *adapter, uint16_t val)
+{
+	bt_uuid_t primary;
+	bt_uuid16_create(&primary, val);
+	remove_primary_uuid(adapter, &primary);
+}
+
 static struct btd_device *adapter_create_device(DBusConnection *conn,
 						struct btd_adapter *adapter,
 						const char *address,
@@ -1148,6 +1194,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	int i;
 	GSList *l;
 	sdp_list_t *list;
+	GSList *primary_list;
 
 	ba2str(&adapter->bdaddr, srcaddr);
 
@@ -1214,7 +1261,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	g_free(devices);
 
 	/* UUIDs */
-	uuids = g_new0(char *, sdp_list_len(adapter->services) + 1);
+	uuids = g_new0(char *, sdp_list_len(adapter->services) + g_slist_length(adapter->primaries) + 1);
 
 	for (i = 0, list = adapter->services; list; list = list->next) {
 		sdp_record_t *rec = list->data;
@@ -1225,6 +1272,17 @@ static DBusMessage *get_properties(DBusConnection *conn,
 			uuids[i++] = uuid;
 	}
 
+	for (primary_list = adapter->primaries; primary_list; primary_list = primary_list->next) {
+		char *uuid = g_malloc0(MAX_LEN_UUID_STR);
+		bt_uuid_t *uuid128 = g_malloc(sizeof(bt_uuid_t));
+		bt_uuid_t *rec = primary_list->data;
+		bt_uuid_to_uuid128(rec, uuid128);
+
+		if (!bt_uuid_to_string(uuid128, uuid, MAX_LEN_UUID_STR))
+			uuids[i++] = uuid;
+		g_free(uuid128);
+	}
+
 	dict_append_array(&dict, "UUIDs", DBUS_TYPE_STRING, &uuids, i);
 
 	g_strfreev(uuids);
@@ -2324,6 +2382,7 @@ static void adapter_free(gpointer user_data)
 		off_timer_remove(adapter);
 
 	sdp_list_free(adapter->services, NULL);
+	g_slist_free(adapter->primaries);
 
 	g_slist_free_full(adapter->found_devices, dev_info_free);
 
diff --git a/src/adapter.h b/src/adapter.h
index c1f981a..6bc278e 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -123,6 +123,8 @@ int adapter_set_name(struct btd_adapter *adapter, const char *name);
 void adapter_name_changed(struct btd_adapter *adapter, const char *name);
 void adapter_service_insert(struct btd_adapter *adapter, void *rec);
 void adapter_service_remove(struct btd_adapter *adapter, void *rec);
+void adapter_add_primary_uuid(struct btd_adapter *adapter, uint16_t val);
+void adapter_remove_primary_uuid(struct btd_adapter *adapter, uint16_t val);
 void btd_adapter_class_changed(struct btd_adapter *adapter,
 							uint32_t new_class);
 void btd_adapter_pairable_changed(struct btd_adapter *adapter,
-- 
1.7.0.4


Return-Path: <cyrus@holtmann.org>
From: Francisco Alecrim <francisco.alecrim@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@openbossa.org>
Subject: [PATCH v2 2/2] Emit Adapter.PropertyChanged when UUIDs change
Date: Fri, 26 Mar 2010 18:54:36 -0400
Message-Id: <1269644076-10544-2-git-send-email-francisco.alecrim@openbossa.org>
In-Reply-To: <1269644076-10544-1-git-send-email-francisco.alecrim@openbossa.org>
References: <1269644076-10544-1-git-send-email-francisco.alecrim@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Emitting Adapter.PropertyChanged signal when UUIDs change. D-Bus message
to inform that adapter properties changed.
---
 src/adapter.c       |   75 ++++++++++++++++++++++++++++++++++++++++++++------
 src/adapter.h       |    1 +
 src/sdpd-database.c |    3 ++
 3 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2027484..884762f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1034,6 +1034,71 @@ static void adapter_update_devices(struct btd_adapter *adapter)
 	g_free(devices);
 }
 
+static char **adapter_get_uuids(struct btd_adapter *adapter)
+{
+	char **uuids;
+	sdp_list_t *list, *lfree;
+	int i;
+
+	list = sdp_get_record_list_by_device(&adapter->bdaddr);
+	if (!list)
+		return NULL;
+
+	/* Keep head to prevent leak */
+	lfree = list;
+	uuids = g_new0(char *, sdp_list_len(list) + 1);
+	for (i = 0; list; list = list->next, i++) {
+		sdp_record_t *rec = list->data;
+		uuids[i] = bt_uuid2string(&rec->svclass);
+	}
+
+	sdp_list_free(lfree, NULL);
+	return uuids;
+}
+
+static void adapter_emit_uuids_updated(struct btd_adapter *adapter)
+{
+	char **uuids;
+	int i;
+
+	uuids = adapter_get_uuids(adapter);
+	if (!uuids)
+		return;
+
+	emit_array_property_changed(connection, adapter->path,
+			ADAPTER_INTERFACE, "UUIDs",
+			DBUS_TYPE_STRING, &uuids);
+
+	for (i = 0; uuids[i]; i++)
+		g_free(uuids[i]);
+	g_free(uuids);
+}
+
+void adapter_uuids_updated(const bdaddr_t *bdaddr)
+{
+	GSList *adapters;
+	struct btd_adapter *adapter;
+
+	if (bacmp(bdaddr, BDADDR_ANY) != 0) {
+		/* Only one adapter */
+		adapter = manager_find_adapter(bdaddr);
+		if (!adapter)
+			return;
+
+		adapter_emit_uuids_updated(adapter);
+
+		return;
+	}
+
+	/* Emit D-Bus msg to all adapters */
+	adapters = manager_get_adapters();
+
+	for (; adapters; adapters = adapters->next) {
+		adapter = adapters->data;
+		adapter_emit_uuids_updated(adapter);
+	}
+}
+
 struct btd_device *adapter_create_device(DBusConnection *conn,
 						struct btd_adapter *adapter,
 						const char *address)
@@ -1198,7 +1263,6 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	char str[MAX_NAME_LENGTH + 1], srcaddr[18];
 	gboolean value;
 	char **devices, **uuids;
-	sdp_list_t *list, *lfree;
 	int i;
 	GSList *l;
 
@@ -1273,17 +1337,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	g_free(devices);
 
 	/* UUIDs */
-	list = sdp_get_record_list_by_device(&adapter->bdaddr);
-	lfree = list; /* keep head to prevent leak */
-	uuids = g_new0(char *, sdp_list_len(list) + 1);
+	uuids = adapter_get_uuids(adapter);
 
-	for (i = 0; list; list = list->next, i++) {
-		sdp_record_t *rec = list->data;
-		uuids[i] = bt_uuid2string(&rec->svclass);
-	}
 	dict_append_array(&dict, "UUIDs", DBUS_TYPE_STRING, &uuids, i);
 
-	sdp_list_free(lfree, NULL);
 	for (i = 0; uuids[i]; i++)
 		g_free(uuids[i]);
 	g_free(uuids);
diff --git a/src/adapter.h b/src/adapter.h
index 9b4ce10..e453eff 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -121,6 +121,7 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
 void adapter_setname_complete(bdaddr_t *local, uint8_t status);
 void adapter_update_tx_power(bdaddr_t *bdaddr, uint8_t status, void *ptr);
 void adapter_update_local_name(bdaddr_t *bdaddr, uint8_t status, void *ptr);
+void adapter_uuids_updated(const bdaddr_t *bdaddr);
 void adapter_set_class_complete(bdaddr_t *bdaddr, uint8_t status);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index 8f99758..97befe0 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -40,6 +40,7 @@
 
 #include "sdpd.h"
 #include "logging.h"
+#include "adapter.h"
 
 static sdp_list_t *service_db;
 static sdp_list_t *access_db;
@@ -183,6 +184,7 @@ void sdp_record_add(const bdaddr_t *device, sdp_record_t *rec)
 	dev->handle = rec->handle;
 
 	access_db = sdp_list_insert_sorted(access_db, dev, access_sort);
+	adapter_uuids_updated(device);
 }
 
 static sdp_list_t *record_locate(uint32_t handle)
@@ -253,6 +255,7 @@ int sdp_record_remove(uint32_t handle)
 		a = (sdp_access_t *) p->data;
 		if (a) {
 			access_db = sdp_list_remove(access_db, a);
+			adapter_uuids_updated(&a->device);
 			access_free(a);
 		}
 	}
-- 
1.6.3.3


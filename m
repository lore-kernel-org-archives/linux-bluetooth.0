Return-Path: <cyrus@holtmann.org>
From: Francisco Alecrim <francisco.alecrim@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@openbossa.org>
Subject: [PATCH v2 1/2] Report local services(UUIDs) through DBus
Date: Wed,  7 Apr 2010 11:04:22 -0400
Message-Id: <1270652663-23107-2-git-send-email-francisco.alecrim@openbossa.org>
In-Reply-To: <1270652663-23107-1-git-send-email-francisco.alecrim@openbossa.org>
References: <1270652663-23107-1-git-send-email-francisco.alecrim@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Include UUIDs field to method GetProperties(org.bluez.Adapter).
Applications can get local services(UUIDs) available through DBus.
* UUIDs per-adapter stored at btd_adapter to prevent some searches not
necessary regarding it requires information from access_db and service_db.
* Emit Adapter.PropertyChanged signal when UUIDs change.
---
 doc/adapter-api.txt |    5 +++
 src/adapter.c       |   89 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/adapter.h       |    2 +
 src/sdpd-database.c |    4 ++
 test/list-devices   |    3 ++
 5 files changed, 102 insertions(+), 1 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 48cab40..6098c76 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -270,3 +270,8 @@ Properties	string Address [readonly]
 		array{object} Devices [readonly]
 
 			List of device object paths.
+
+		array{string} UUIDs [readonly]
+
+			List of 128-bit UUIDs that represents the available
+			local services.
diff --git a/src/adapter.c b/src/adapter.c
index 5fd0736..cdd5562 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -37,6 +37,7 @@
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
 #include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
@@ -115,6 +116,7 @@ struct btd_adapter {
 	GSList *mode_sessions;		/* Request Mode sessions */
 	GSList *disc_sessions;		/* Discovery sessions */
 	guint scheduler_id;		/* Scheduler handle */
+	sdp_list_t *services;		/* Services associated to adapter */
 
 	struct hci_dev dev;		/* hci info */
 	int8_t tx_power;		/* inq response tx power level */
@@ -1033,6 +1035,76 @@ static void adapter_update_devices(struct btd_adapter *adapter)
 	g_free(devices);
 }
 
+static void adapter_emit_uuids_updated(struct btd_adapter *adapter)
+{
+	char **uuids;
+	int i;
+	sdp_list_t *list;
+
+	uuids = g_new0(char *, sdp_list_len(adapter->services) + 1);
+
+	for (i = 0, list = adapter->services; list; list = list->next, i++) {
+		sdp_record_t *rec = list->data;
+		uuids[i] = bt_uuid2string(&rec->svclass);
+	}
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
+/*
+ * adapter_services_inc_rem - Insert or remove UUID from adapter
+ */
+static void adapter_service_ins_rem(const bdaddr_t *bdaddr, void *rec,
+		gboolean insert)
+{
+	struct btd_adapter *adapter;
+	GSList *adapters;
+
+	adapters = NULL;
+
+	if (bacmp(bdaddr, BDADDR_ANY) != 0) {
+		/* Only one adapter */
+		adapter = manager_find_adapter(bdaddr);
+		if (!adapter)
+			return;
+
+		adapters = g_slist_append(adapters, adapter);
+	} else
+		/* Emit D-Bus msg to all adapters */
+		adapters = manager_get_adapters();
+
+	for (; adapters; adapters = adapters->next) {
+		adapter = adapters->data;
+
+		if (insert == TRUE)
+			adapter->services = sdp_list_append(adapter->services,
+					rec);
+		else
+			adapter->services = sdp_list_remove(adapter->services,
+					rec);
+
+		adapter_emit_uuids_updated(adapter);
+	}
+}
+
+void adapter_service_insert(const bdaddr_t *bdaddr, void *rec)
+{
+	/* TRUE to include service*/
+	adapter_service_ins_rem(bdaddr, rec, TRUE);
+}
+
+void adapter_service_remove(const bdaddr_t *bdaddr, void *rec)
+{
+	/* FALSE to remove service*/
+	adapter_service_ins_rem(bdaddr, rec, FALSE);
+}
+
 struct btd_device *adapter_create_device(DBusConnection *conn,
 						struct btd_adapter *adapter,
 						const char *address)
@@ -1196,9 +1268,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	DBusMessageIter dict;
 	char str[MAX_NAME_LENGTH + 1], srcaddr[18];
 	gboolean value;
-	char **devices;
+	char **devices, **uuids;
 	int i;
 	GSList *l;
+	sdp_list_t *list;
 
 	ba2str(&adapter->bdaddr, srcaddr);
 
@@ -1270,6 +1343,20 @@ static DBusMessage *get_properties(DBusConnection *conn,
 								&devices, i);
 	g_free(devices);
 
+	/* UUIDs */
+	uuids = g_new0(char *, sdp_list_len(adapter->services) + 1);
+
+	for (i = 0, list = adapter->services; list; list = list->next, i++) {
+		sdp_record_t *rec = list->data;
+		uuids[i] = bt_uuid2string(&rec->svclass);
+	}
+
+	dict_append_array(&dict, "UUIDs", DBUS_TYPE_STRING, &uuids, i);
+
+	for (i = 0; uuids[i]; i++)
+		g_free(uuids[i]);
+	g_free(uuids);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
diff --git a/src/adapter.h b/src/adapter.h
index 9b4ce10..e4307d8 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -121,6 +121,8 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
 void adapter_setname_complete(bdaddr_t *local, uint8_t status);
 void adapter_update_tx_power(bdaddr_t *bdaddr, uint8_t status, void *ptr);
 void adapter_update_local_name(bdaddr_t *bdaddr, uint8_t status, void *ptr);
+void adapter_service_insert(const bdaddr_t *bdaddr, void *rec);
+void adapter_service_remove(const bdaddr_t *bdaddr, void *rec);
 void adapter_set_class_complete(bdaddr_t *bdaddr, uint8_t status);
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index 07a0bc3..224a4e7 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -40,6 +40,7 @@
 
 #include "sdpd.h"
 #include "logging.h"
+#include "adapter.h"
 
 static sdp_list_t *service_db;
 static sdp_list_t *access_db;
@@ -183,6 +184,8 @@ void sdp_record_add(const bdaddr_t *device, sdp_record_t *rec)
 	dev->handle = rec->handle;
 
 	access_db = sdp_list_insert_sorted(access_db, dev, access_sort);
+
+	adapter_service_insert(device, rec);
 }
 
 static sdp_list_t *record_locate(uint32_t handle)
@@ -252,6 +255,7 @@ int sdp_record_remove(uint32_t handle)
 	if (p) {
 		a = (sdp_access_t *) p->data;
 		if (a) {
+			adapter_service_remove(&a->device, r);
 			access_db = sdp_list_remove(access_db, a);
 			access_free(a);
 		}
diff --git a/test/list-devices b/test/list-devices
index 511d0cf..9120714 100755
--- a/test/list-devices
+++ b/test/list-devices
@@ -40,6 +40,9 @@ for i in adapter_list:
 		if (key == "Devices"):
 			list = extract_objects(value)
 			print "    %s = %s" % (key, list)
+		elif (key == "UUIDs"):
+			list = extract_uuids(value)
+			print "    %s = %s" % (key, list)
 		else:
 			print "    %s = %s" % (key, value)
 
-- 
1.6.3.3


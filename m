Return-Path: <cyrus@holtmann.org>
From: Francisco Alecrim <francisco.alecrim@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@openbossa.org>
Subject: [PATCH v2 1/2] Report local services(UUIDs) through DBus
Date: Fri, 26 Mar 2010 18:54:35 -0400
Message-Id: <1269644076-10544-1-git-send-email-francisco.alecrim@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Include UUIDs field to method GetProperties(org.bluez.Adapter).
Applications can get local services(UUIDs) available through DBus.
---
 doc/adapter-api.txt |    5 +++++
 src/adapter.c       |   20 +++++++++++++++++++-
 src/sdpd-database.c |   20 ++++++++++++++++++++
 src/sdpd.h          |    1 +
 test/list-devices   |    3 +++
 5 files changed, 48 insertions(+), 1 deletions(-)

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
index 5fd0736..2027484 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -37,6 +37,7 @@
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
 #include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
@@ -1196,7 +1197,8 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	DBusMessageIter dict;
 	char str[MAX_NAME_LENGTH + 1], srcaddr[18];
 	gboolean value;
-	char **devices;
+	char **devices, **uuids;
+	sdp_list_t *list, *lfree;
 	int i;
 	GSList *l;
 
@@ -1270,6 +1272,22 @@ static DBusMessage *get_properties(DBusConnection *conn,
 								&devices, i);
 	g_free(devices);
 
+	/* UUIDs */
+	list = sdp_get_record_list_by_device(&adapter->bdaddr);
+	lfree = list; /* keep head to prevent leak */
+	uuids = g_new0(char *, sdp_list_len(list) + 1);
+
+	for (i = 0; list; list = list->next, i++) {
+		sdp_record_t *rec = list->data;
+		uuids[i] = bt_uuid2string(&rec->svclass);
+	}
+	dict_append_array(&dict, "UUIDs", DBUS_TYPE_STRING, &uuids, i);
+
+	sdp_list_free(lfree, NULL);
+	for (i = 0; uuids[i]; i++)
+		g_free(uuids[i]);
+	g_free(uuids);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index 07a0bc3..8f99758 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -273,6 +273,26 @@ sdp_list_t *sdp_get_access_list(void)
 	return access_db;
 }
 
+sdp_list_t *sdp_get_record_list_by_device(const bdaddr_t *device)
+{
+	sdp_list_t *list, *acc;
+
+	acc = access_db;
+	list = NULL;
+	for (; acc; acc = acc->next) {
+		sdp_access_t *a = acc->data;
+		sdp_record_t *rec = sdp_record_find(a->handle);
+		if (!rec)
+			continue;
+
+		if (bacmp(&a->device, device) == 0 ||
+				bacmp(&a->device, BDADDR_ANY) == 0)
+			list = sdp_list_append(list, rec);
+	}
+
+	return list;
+}
+
 int sdp_check_access(uint32_t handle, bdaddr_t *device)
 {
 	sdp_list_t *p = access_locate(handle);
diff --git a/src/sdpd.h b/src/sdpd.h
index 1352a83..15e163b 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -79,6 +79,7 @@ void sdp_record_add(const bdaddr_t *device, sdp_record_t *rec);
 int sdp_record_remove(uint32_t handle);
 sdp_list_t *sdp_get_record_list(void);
 sdp_list_t *sdp_get_access_list(void);
+sdp_list_t *sdp_get_record_list_by_device(const bdaddr_t *device);
 int sdp_check_access(uint32_t handle, bdaddr_t *device);
 uint32_t sdp_next_handle(void);
 
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


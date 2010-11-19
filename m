Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 2/2] Avoid reallocations of services UUID array
Date: Fri, 19 Nov 2010 10:59:19 -0400
Message-Id: <1290178759-9270-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The array of service UUIDs used by the DeviceFound signal contains the
same information from the GSList of services. Instead of reallocating
this array on each signal, store it on the remote_dev_info structure and
only reallocate it if there are new UUIDs.
---
 src/adapter.c |   18 +++++++++---------
 src/adapter.h |    3 ++-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c650a63..4fe8276 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -204,6 +204,7 @@ static void dev_info_free(struct remote_dev_info *dev)
 	g_free(dev->alias);
 	g_slist_foreach(dev->services, (GFunc) g_free, NULL);
 	g_slist_free(dev->services);
+	g_strfreev(dev->uuids);
 	g_free(dev);
 }
 
@@ -2964,7 +2965,6 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	dbus_bool_t paired = FALSE;
 	dbus_int16_t rssi = dev->rssi;
 	char *alias;
-	char **uuids = NULL;
 	size_t uuid_count;
 
 	ba2str(&dev->bdaddr, peer_addr);
@@ -2977,9 +2977,11 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	/* Extract UUIDs from extended inquiry response if any */
 	dev->services = get_eir_uuids(eir_data, eir_length, dev->services);
 	uuid_count = g_slist_length(dev->services);
-
-	if (dev->services)
-		uuids = strlist2array(dev->services);
+	if (dev->services && dev->uuid_count != uuid_count) {
+		g_strfreev(dev->uuids);
+		dev->uuids = strlist2array(dev->services);
+		dev->uuid_count = uuid_count;
+	}
 
 	if (dev->le) {
 		emit_device_found(adapter->path, paddr,
@@ -2987,9 +2989,8 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 				"RSSI", DBUS_TYPE_INT16, &rssi,
 				"Name", DBUS_TYPE_STRING, &dev->name,
 				"Paired", DBUS_TYPE_BOOLEAN, &paired,
-				"UUIDs", DBUS_TYPE_ARRAY, &uuids, uuid_count,
-				NULL);
-		g_strfreev(uuids);
+				"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids,
+				dev->uuid_count, NULL);
 		return;
 	}
 
@@ -3013,11 +3014,10 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 			"Alias", DBUS_TYPE_STRING, &alias,
 			"LegacyPairing", DBUS_TYPE_BOOLEAN, &dev->legacy,
 			"Paired", DBUS_TYPE_BOOLEAN, &paired,
-			"UUIDs", DBUS_TYPE_ARRAY, &uuids, uuid_count,
+			"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids, dev->uuid_count,
 			NULL);
 
 	g_free(alias);
-	g_strfreev(uuids);
 }
 
 static struct remote_dev_info *get_found_dev(struct btd_adapter *adapter,
diff --git a/src/adapter.h b/src/adapter.h
index 4af69b3..955bb9a 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -70,7 +70,8 @@ struct remote_dev_info {
 	dbus_bool_t legacy;
 	name_status_t name_status;
 	gboolean le;
-	/* LE adv data */
+	char **uuids;
+	size_t uuid_count;
 	GSList *services;
 	uint8_t evt_type;
 	uint8_t bdaddr_type;
-- 
1.7.0.4


Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] Set primary services before probing
Date: Tue, 12 Jul 2011 16:10:09 -0300
Message-Id: <1310497809-19636-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix accessing primary services data in the probing function of GATT
based plugins.
---
 src/adapter.c |    6 ++++--
 src/device.c  |    9 ++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0909a22..4cc2a68 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1876,11 +1876,12 @@ static void create_stored_device_from_profiles(char *key, char *value,
 	device_set_temporary(device, FALSE);
 	adapter->devices = g_slist_append(adapter->devices, device);
 
-	device_probe_drivers(device, uuids);
 	list = device_services_from_record(device, uuids);
 	if (list)
 		device_register_services(connection, device, list, ATT_PSM);
 
+	device_probe_drivers(device, uuids);
+
 	g_slist_free_full(uuids, g_free);
 }
 
@@ -2051,9 +2052,10 @@ static void create_stored_device_from_primary(char *key, char *value,
 		uuids = g_slist_append(uuids, prim->uuid);
 	}
 
-	device_probe_drivers(device, uuids);
 	device_register_services(connection, device, services, -1);
 
+	device_probe_drivers(device, uuids);
+
 	g_slist_free(uuids);
 }
 
diff --git a/src/device.c b/src/device.c
index 21b3d8d..4d17082 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1448,12 +1448,12 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 	if (req->profiles_added) {
 		GSList *list;
 
-		device_probe_drivers(device, req->profiles_added);
-
 		list = device_services_from_record(device, req->profiles_added);
 		if (list)
 			device_register_services(req->conn, device, list,
 								ATT_PSM);
+
+		device_probe_drivers(device, req->profiles_added);
 	}
 
 	/* Remove drivers for services removed */
@@ -1652,9 +1652,8 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 		uuids = g_slist_append(uuids, prim->uuid);
 	}
 
-	device_probe_drivers(device, uuids);
-
 	device_register_services(req->conn, device, g_slist_copy(services), -1);
+	device_probe_drivers(device, uuids);
 
 	g_slist_free(uuids);
 
@@ -2463,9 +2462,9 @@ void device_set_authorizing(struct btd_device *device, gboolean auth)
 void device_register_services(DBusConnection *conn, struct btd_device *device,
 						GSList *prim_list, int psm)
 {
+	device->primaries = g_slist_concat(device->primaries, prim_list);
 	device->services = attrib_client_register(conn, device, psm, NULL,
 								prim_list);
-	device->primaries = g_slist_concat(device->primaries, prim_list);
 }
 
 GSList *btd_device_get_primaries(struct btd_device *device)
-- 
1.7.6


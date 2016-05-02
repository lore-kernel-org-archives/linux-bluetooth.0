Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ] device: Fix emitting properties in the wrong order
Date: Mon,  2 May 2016 16:02:33 -0300
Message-Id: <1462215753-32348-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes the org.bluez.Device1 UUIDs property to be emitted as soon as
possible, so the ServicesResolved property is only emitted after all
D-Bus objects representing attributes are added to the bus.

The problem happens because the g_idle'r that actually emits the signals
are unique per D-Bus object, so when multiple properties are emitted
their ordering on the bus will be based on the first signal for each
object.

In this case, the 'UUIDs' property was scheduled earlier in the mainloop
iteration, then GATT related objects, then the ServicesResolved
property, as the UUIDs and ServicesResolved properties belong to the
same object, they would be emitted together.

With this patch the UUIDs property is emitted as soon as possible, and
the ordering is kept.
---

This is more like an RFC, as there is a bug: the UUIDs property is
emitted multiple times with the same value.


 src/device.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index b004f43..8558dcf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1547,8 +1547,9 @@ void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
 	}

 	if (added)
-		g_dbus_emit_property_changed(dbus_conn, dev->path,
-						DEVICE_INTERFACE, "UUIDs");
+		g_dbus_emit_property_changed_full(dbus_conn, dev->path,
+				DEVICE_INTERFACE, "UUIDs",
+				G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
 }

 static void add_manufacturer_data(void *data, void *user_data)
@@ -3292,8 +3293,9 @@ static void device_add_uuids(struct btd_device *device, GSList *uuids)
 	}

 	if (changed)
-		g_dbus_emit_property_changed(dbus_conn, device->path,
-						DEVICE_INTERFACE, "UUIDs");
+		g_dbus_emit_property_changed_full(dbus_conn, device->path,
+				DEVICE_INTERFACE, "UUIDs",
+				G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
 }

 static bool device_match_profile(struct btd_device *device,
@@ -3510,8 +3512,9 @@ static void gatt_service_removed(struct gatt_db_attribute *attr,

 		g_free(l->data);
 		device->uuids = g_slist_delete_link(device->uuids, l);
-		g_dbus_emit_property_changed(dbus_conn, device->path,
-						DEVICE_INTERFACE, "UUIDs");
+		g_dbus_emit_property_changed_full(dbus_conn, device->path,
+					DEVICE_INTERFACE, "UUIDs",
+					G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
 	}

 	g_free(prim);
@@ -4464,8 +4467,9 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 	device_probe_profiles(device, req->profiles_added);

 	/* Propagate services changes */
-	g_dbus_emit_property_changed(dbus_conn, req->device->path,
-						DEVICE_INTERFACE, "UUIDs");
+	g_dbus_emit_property_changed_full(dbus_conn, req->device->path,
+					  DEVICE_INTERFACE, "UUIDs",
+					  G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);

 send_reply:
 	device_svc_resolved(device, BDADDR_BREDR, err);
@@ -5923,8 +5927,9 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid)

 	store_device_info(device);

-	g_dbus_emit_property_changed(dbus_conn, device->path,
-						DEVICE_INTERFACE, "UUIDs");
+	g_dbus_emit_property_changed_full(dbus_conn, device->path,
+					DEVICE_INTERFACE, "UUIDs",
+					G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
 }

 static sdp_list_t *read_device_records(struct btd_device *device)
--
2.8.1


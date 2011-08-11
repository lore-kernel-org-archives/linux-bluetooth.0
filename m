Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/3] Remove paired and bonded from btd_device structure
Date: Thu, 11 Aug 2011 17:59:46 +0300
Message-Id: <1313074788-16317-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

paired and bonded device properties are replaced by pairing_status.
---
 src/device.c |   43 ++++++++++++++++++++++++++++++-------------
 1 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/src/device.c b/src/device.c
index 9dd657c..7ff26c1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -114,6 +114,12 @@ struct attio_data {
 	gpointer user_data;
 };
 
+typedef enum {
+	DEVICE_PAIRING_STATUS_NONE,
+	DEVICE_PAIRING_STATUS_PAIRED,
+	DEVICE_PAIRING_STATUS_BONDED
+} pairing_status_t;
+
 struct btd_device {
 	bdaddr_t	bdaddr;
 	device_type_t	type;
@@ -144,9 +150,8 @@ struct btd_device {
 	sdp_list_t	*tmp_records;
 
 	gboolean	trusted;
-	gboolean	paired;
 	gboolean	blocked;
-	gboolean	bonded;
+	pairing_status_t	pairing_status;
 
 	gboolean	authorizing;
 	gint		ref;
@@ -247,12 +252,13 @@ static void device_free(gpointer user_data)
 
 gboolean device_is_paired(struct btd_device *device)
 {
-	return device->paired;
+	return (device->pairing_status == DEVICE_PAIRING_STATUS_PAIRED) ||
+		(device->pairing_status == DEVICE_PAIRING_STATUS_BONDED);
 }
 
 gboolean device_is_bonded(struct btd_device *device)
 {
-	return device->bonded;
+	return device->pairing_status == DEVICE_PAIRING_STATUS_BONDED;
 }
 
 gboolean device_is_trusted(struct btd_device *device)
@@ -855,7 +861,7 @@ void device_remove_connection(struct btd_device *device, DBusConnection *conn)
 		device->disconnects = g_slist_remove(device->disconnects, msg);
 	}
 
-	if (device_is_paired(device) && !device_is_bonded(device))
+	if (!device_is_bonded(device))
 		device_set_paired(device, FALSE);
 
 	emit_property_changed(conn, device->path,
@@ -941,7 +947,6 @@ struct btd_device *device_create(DBusConnection *conn,
 		device_block(conn, device);
 
 	if (read_link_key(&src, &device->bdaddr, NULL, NULL) == 0) {
-		device_set_paired(device, TRUE);
 		device_set_bonded(device, TRUE);
 	}
 
@@ -992,7 +997,6 @@ static void device_remove_stored(struct btd_device *device)
 		delete_entry(&src, "linkkeys", addr);
 		delete_entry(&src, "aliases", addr);
 		device_set_bonded(device, FALSE);
-		device_set_paired(device, FALSE);
 		btd_adapter_remove_bonding(device->adapter, &device->bdaddr);
 	}
 	delete_entry(&src, "profiles", addr);
@@ -1912,12 +1916,20 @@ void device_set_temporary(struct btd_device *device, gboolean temporary)
 
 void device_set_bonded(struct btd_device *device, gboolean bonded)
 {
-	if (!device)
+	DBusConnection *conn = get_dbus_connection();
+
+	if (device_is_bonded(device) == bonded)
 		return;
 
-	DBG("bonded %d", bonded);
+	DBG("%s", bonded ? "TRUE" : "FALSE");
 
-	device->bonded = bonded;
+	if (bonded)
+		device->pairing_status = DEVICE_PAIRING_STATUS_BONDED;
+	else
+		device->pairing_status = DEVICE_PAIRING_STATUS_NONE;
+
+	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Paired",
+				DBUS_TYPE_BOOLEAN, &bonded);
 }
 
 void device_set_type(struct btd_device *device, device_type_t type)
@@ -2035,10 +2047,15 @@ void device_set_paired(struct btd_device *device, gboolean value)
 {
 	DBusConnection *conn = get_dbus_connection();
 
-	if (device->paired == value)
+	if (device_is_paired(device) == value)
 		return;
 
-	device->paired = value;
+	DBG("%s", value ? "TRUE" : "FALSE");
+
+	if (value)
+		device->pairing_status = DEVICE_PAIRING_STATUS_PAIRED;
+	else
+		device->pairing_status = DEVICE_PAIRING_STATUS_NONE;
 
 	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Paired",
 				DBUS_TYPE_BOOLEAN, &value);
@@ -2198,7 +2215,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 	device_auth_req_free(device);
 
 	/* If we're already paired nothing more is needed */
-	if (device->paired)
+	if (device_is_paired(device) && !bonding)
 		return;
 
 	device_set_paired(device, TRUE);
-- 
1.7.4.1


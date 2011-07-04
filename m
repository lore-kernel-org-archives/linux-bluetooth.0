Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ v2] Fix unpair device when disconnected for No Bonding
Date: Mon,  4 Jul 2011 16:40:28 +0300
Message-Id: <1309786828-11792-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1309786828-11792-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1309786828-11792-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix Paired property of device to be false if 'No Bonding' authentication
is used. This property is set to false when device is disconnected and
no link key is stored. Otherwise, there can be cases when device is still
valid and being claimed as paired without available bonding information.

For instanse, use of CreateDevice method call and obex client file
transfer is such use case.
---
 src/device.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 82759a4..4c135bc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -132,6 +132,7 @@ struct btd_device {
 	gboolean	trusted;
 	gboolean	paired;
 	gboolean	blocked;
+	gboolean	bonded;
 
 	gboolean	authorizing;
 	gint		ref;
@@ -824,6 +825,9 @@ void device_remove_connection(struct btd_device *device, DBusConnection *conn)
 		device->disconnects = g_slist_remove(device->disconnects, msg);
 	}
 
+	if (device_is_paired(device) && !device->bonded)
+		device_set_paired(device, FALSE);
+
 	emit_property_changed(conn, device->path,
 					DEVICE_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &device->connected);
@@ -906,8 +910,10 @@ struct btd_device *device_create(DBusConnection *conn,
 	if (read_blocked(&src, &device->bdaddr))
 		device_block(conn, device);
 
-	if (read_link_key(&src, &device->bdaddr, NULL, NULL) == 0)
+	if (read_link_key(&src, &device->bdaddr, NULL, NULL) == 0) {
 		device->paired = TRUE;
+		device->bonded = TRUE;
+	}
 
 	return btd_device_ref(device);
 }
@@ -958,6 +964,7 @@ void device_remove_bonding(struct btd_device *device)
 
 	/* Delete the link key from storage */
 	textfile_casedel(filename, dstaddr);
+	device->bonded = FALSE;
 
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr,
 						"aliases");
@@ -2069,6 +2076,9 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 
 	device_auth_req_free(device);
 
+	if (bonding)
+		device->bonded = TRUE;
+
 	/* If we're already paired nothing more is needed */
 	if (device->paired)
 		return;
-- 
1.7.4.1


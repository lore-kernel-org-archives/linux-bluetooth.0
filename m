Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] device: Use new storage for device trust
Date: Wed, 14 Nov 2012 11:16:06 +0100
Message-Id: <1352888166-7391-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1352888166-7391-1-git-send-email-frederic.danis@linux.intel.com>
References: <1352888166-7391-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As set_trust() changes value in device structure and write to
storage is deferred, property set could not return failure.
---
 src/device.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/src/device.c b/src/device.c
index c508d18..792fe3d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -226,6 +226,9 @@ static gboolean store_device_info_cb(gpointer user_data)
 		g_key_file_set_string(key_file, "General", "Alias",
 					device->alias);
 
+	g_key_file_set_boolean(key_file, "General", "Trusted",
+				device->trusted);
+
 	ba2str(adapter_get_address(device->adapter), adapter_addr);
 	ba2str(&device->bdaddr, device_addr);
 	snprintf(filename, PATH_MAX, INFO_PATH, adapter_addr, device_addr);
@@ -713,23 +716,14 @@ static gboolean dev_property_get_trusted(const GDBusPropertyTable *property,
 static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data)
 {
 	struct btd_device *device = data;
-	struct btd_adapter *adapter = device->adapter;
-	char srcaddr[18], dstaddr[18];
-	int err;
 
 	if (device->trusted == value)
 		return g_dbus_pending_property_success(id);
 
-	ba2str(adapter_get_address(adapter), srcaddr);
-	ba2str(&device->bdaddr, dstaddr);
-
-	err = write_trust(srcaddr, dstaddr, device->bdaddr_type, value);
-	if (err < 0)
-		return g_dbus_pending_property_error(id,
-				ERROR_INTERFACE ".Failed", strerror(-err));
-
 	device->trusted = value;
 
+	store_device_info(device);
+
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				device->path, DEVICE_INTERFACE, "Trusted");
 
@@ -1743,6 +1737,10 @@ static void load_info(struct btd_device *device, const gchar *local,
 	device->alias = g_key_file_get_string(key_file, "General", "Alias",
 						NULL);
 
+	/* Load trust */
+	device->trusted = g_key_file_get_boolean(key_file, "General",
+							"Trusted", NULL);
+
 	if (store_needed)
 		store_device_info(device);
 
@@ -1787,8 +1785,6 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 
 	load_info(device, srcaddr, address);
 
-	device->trusted = read_trust(src, address, device->bdaddr_type);
-
 	if (read_blocked(src, &device->bdaddr, device->bdaddr_type))
 		device_block(device, FALSE);
 
-- 
1.7.9.5


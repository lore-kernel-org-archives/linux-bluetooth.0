Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] device: Retrieve device blocked from storage
Date: Wed, 21 Nov 2012 14:49:49 +0100
Message-Id: <1353505791-21134-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1353505791-21134-1-git-send-email-frederic.danis@linux.intel.com>
References: <1353505791-21134-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/device.c b/src/device.c
index 915b0f8..d4a553d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -233,6 +233,9 @@ static gboolean store_device_info_cb(gpointer user_data)
 	g_key_file_set_boolean(key_file, "General", "Trusted",
 							device->trusted);
 
+	g_key_file_set_boolean(key_file, "General", "Blocked",
+							device->blocked);
+
 	ba2str(adapter_get_address(device->adapter), adapter_addr);
 	ba2str(&device->bdaddr, device_addr);
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
@@ -920,10 +923,7 @@ int device_block(struct btd_device *device, gboolean update_only)
 
 	device->blocked = TRUE;
 
-	err = write_blocked(adapter_get_address(device->adapter),
-				&device->bdaddr, device->bdaddr_type, TRUE);
-	if (err < 0)
-		error("write_blocked(): %s (%d)", strerror(-err), -err);
+	store_device_info(device);
 
 	device_set_temporary(device, FALSE);
 
@@ -950,10 +950,7 @@ int device_unblock(struct btd_device *device, gboolean silent,
 
 	device->blocked = FALSE;
 
-	err = write_blocked(adapter_get_address(device->adapter),
-				&device->bdaddr, device->bdaddr_type, FALSE);
-	if (err < 0)
-		error("write_blocked(): %s (%d)", strerror(-err), -err);
+	store_device_info(device);
 
 	if (!silent) {
 		g_dbus_emit_property_changed(btd_get_dbus_connection(),
@@ -1768,6 +1765,7 @@ static void load_info(struct btd_device *device, const gchar *local,
 	GKeyFile *key_file;
 	char *str;
 	gboolean store_needed = FALSE;
+	gboolean blocked;
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", local, peer);
 	filename[PATH_MAX] = '\0';
@@ -1808,6 +1806,11 @@ static void load_info(struct btd_device *device, const gchar *local,
 	device->trusted = g_key_file_get_boolean(key_file, "General",
 							"Trusted", NULL);
 
+	/* Load device blocked */
+	blocked = g_key_file_get_boolean(key_file, "General", "Blocked", NULL);
+	if (blocked)
+		device_block(device, FALSE);
+
 	if (store_needed)
 		store_device_info(device);
 
@@ -1852,9 +1855,6 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 
 	load_info(device, srcaddr, address);
 
-	if (read_blocked(src, &device->bdaddr, device->bdaddr_type))
-		device_block(device, FALSE);
-
 	if (read_link_key(src, &device->bdaddr, device->bdaddr_type, NULL,
 								NULL) == 0) {
 		device_set_paired(device, TRUE);
-- 
1.7.9.5


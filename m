Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 15/15] core: Fix deleting entries
Date: Wed, 23 May 2012 15:48:33 -0300
Message-Id: <1337798914-20974-16-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The "aliases" and "longtermkeys" files now use the new storage format,
so the correct keys must be passed to delete_entry() function.
---
 src/device.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index 2357684..0d24134 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1155,23 +1155,28 @@ uint16_t btd_device_get_version(struct btd_device *device)
 static void device_remove_stored(struct btd_device *device)
 {
 	bdaddr_t src;
-	char addr[18];
+	char key[20];
 	DBusConnection *conn = get_dbus_connection();
 
 	adapter_get_address(device->adapter, &src);
-	ba2str(&device->bdaddr, addr);
+	ba2str(&device->bdaddr, key);
+
+	delete_entry(&src, "profiles", key);
+	delete_entry(&src, "trusts", key);
 
 	if (device_is_bonded(device)) {
-		delete_entry(&src, "linkkeys", addr);
-		delete_entry(&src, "aliases", addr);
-		delete_entry(&src, "longtermkeys", addr);
+		delete_entry(&src, "linkkeys", key);
+
+		sprintf(&key[17], "#%hhu", device->bdaddr_type);
+
+		delete_entry(&src, "aliases", key);
+		delete_entry(&src, "longtermkeys", key);
 		device_set_bonded(device, FALSE);
 		device->paired = FALSE;
 		btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
 							device->bdaddr_type);
 	}
-	delete_entry(&src, "profiles", addr);
-	delete_entry(&src, "trusts", addr);
+
 	delete_all_records(&src, &device->bdaddr);
 	delete_device_service(&src, &device->bdaddr, device->bdaddr_type);
 
-- 
1.7.7.6


Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Fix not deleting stored keys when a new one is created
Date: Wed, 11 Aug 2010 15:44:26 +0300
Message-Id: <1281530667-25379-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

When a new link key is created but it doesn't match any criteria to be
stored any previouly one should be removed from filesystem.
---
 src/dbus-hci.c |   12 +++++++-----
 src/device.c   |    2 +-
 src/device.h   |    2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 6d27caa..22f378d 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -700,6 +700,13 @@ int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 	/* Clear any previous debug key */
 	device_set_debug_key(device, NULL);
 
+	/* If this is not the first link key set a flag so a subsequent auth
+	 * complete event doesn't trigger SDP and remove any stored key */
+	if (old_key_type != 0xff) {
+		device_set_renewed_key(device, TRUE);
+		device_remove_bonding(device);
+	}
+
 	/* Store the link key only in runtime memory if it's a debug
 	 * key, else store the link key persistently if one of the
 	 * following is true:
@@ -734,11 +741,6 @@ int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 	} else
 		temporary = TRUE;
 
-	/* If this is not the first link key set a flag so a subsequent auth
-	 * complete event doesn't trigger SDP */
-	if (old_key_type != 0xff)
-		device_set_renewed_key(device, TRUE);
-
 	if (!device_is_connected(device))
 		device_set_secmode3_conn(device, TRUE);
 	else if (!bonding && old_key_type == 0xff)
diff --git a/src/device.c b/src/device.c
index 10ba779..e72f289 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1056,7 +1056,7 @@ void device_get_name(struct btd_device *device, char *name, size_t len)
 	strncpy(name, device->name, len);
 }
 
-static void device_remove_bonding(struct btd_device *device)
+void device_remove_bonding(struct btd_device *device)
 {
 	char filename[PATH_MAX + 1];
 	char srcaddr[18], dstaddr[18];
diff --git a/src/device.h b/src/device.h
index 5f75e61..21f67d0 100644
--- a/src/device.h
+++ b/src/device.h
@@ -66,7 +66,7 @@ void device_set_secmode3_conn(struct btd_device *device, gboolean enable);
 DBusMessage *device_create_bonding(struct btd_device *device,
 				DBusConnection *conn, DBusMessage *msg,
 				const char *agent_path, uint8_t capability);
-void device_remove_bondind(struct btd_device *device, DBusConnection *connection);
+void device_remove_bonding(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t status);
 void device_simple_pairing_complete(struct btd_device *device, uint8_t status);
 gboolean device_is_creating(struct btd_device *device, const char *sender);
-- 
1.7.0.4


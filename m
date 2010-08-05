Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix not deleting stored keys when a new one is created
Date: Thu,  5 Aug 2010 16:58:06 +0300
Message-Id: <1281016686-20512-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

When a new link key is created but it doesn't match any criteria to be
stored any previouly one should be removed from filesystem.

This can be reproduced by the following steps:

1. Pair devices normally so that a valid link key is stored
2. Remove link key on remote device
3. Attempt to do a rfcomm connection with security level higher than low

This can be triggered in some other ways but right now this is the
easiest since kernel will switch the authentication requirements in this
case, here is the hcidump output:

< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
  bdaddr xx:xx:xx:xx:xx:xx capability 0x01 oob 0x00 auth 0x00
  Capability: DisplayYesNo (OOB data not present)
  Authentication: No Bonding (No MITM Protection)
...
> HCI Event: Link Key Notification (0x18) plen 23
  bdaddr xx:xx:xx:xx:xx:xx key 26D32FBEF7B7CBD7923CA391A2DE600F type 4
  Type: Unauthenticated Combination Key
...
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  bdaddr xx:xx:xx:xx:xx:xx key 38E2BC10B26148FBC264E0DBA2535F1B
> HCI Event: Auth Complete (0x06) plen 3
  status 0x05 handle 1
Error: Authentication Failure

Note that the reason this is reproducible with a single rfcomm connection
might be a bug in kernel, but there is clearly a problem in the daemon
too since link keys doesn't match.

So link keys information should be available while connected even in
cases where bonding is not required, to fix this everytime there is a new
link key the old one is clear, to make sure this actually work with those
keys that are not stored persistently all keys are cached in memory so
they are always accessible via device object as long the object exists,
this changes should also enable the code path bellow:

	/* Don't use unauthenticated combination keys if MITM is
	 * required */
	if (type == 0x04 && req.type != 0xff && (req.type & 0x01))

and follow the recommendation of the simple pairing white paper which
says:

	"Bonding is defined as the connection process where the link key
	and connection information are stored in non-volatile memory.
	Thus bonding implies that the device’s link information is
	available after the current connection ceases. If the link key
	and current connection information are not stored, then the
	connection process uses “Pairing”"

Devices which link key is not permanently stored are currently being
marked as temporary so their information will be lost once the connection
ceases.
---
 src/dbus-hci.c |   23 +++++++++++------------
 src/device.c   |   31 ++++++++++++++++---------------
 src/device.h   |    5 +++--
 src/security.c |    5 ++---
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index b83506f..c8b2ad6 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -674,11 +674,12 @@ int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 	if (!get_adapter_and_device(local, peer, &adapter, &device, TRUE))
 		return -ENODEV;
 
+	/* Check if there is a key cached in memory */
+	device_get_key(device, NULL, &old_key_type);
+
 	new_key_type = key_type;
 
 	if (key_type == 0x06) {
-		if (device_get_debug_key(device, NULL))
-			old_key_type = 0x03;
 		if (old_key_type != 0xff)
 			new_key_type = old_key_type;
 		else
@@ -697,12 +698,11 @@ int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 	DBG("local auth 0x%02x and remote auth 0x%02x",
 					local_auth, remote_auth);
 
-	/* Clear any previous debug key */
-	device_set_debug_key(device, NULL);
+	/* Cache new link key */
+	device_set_key(device, key, new_key_type);
 
-	/* Store the link key only in runtime memory if it's a debug
-	 * key, else store the link key persistently if one of the
-	 * following is true:
+	/* Link key are ALWAYS stored in runtime memory, they are also stored
+	 * in filesystem persistently if one of the following is true:
 	 * 1. this is a legacy link key
 	 * 2. this is a changed combination key and there was a previously
 	 *    stored one
@@ -710,13 +710,12 @@ int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 	 * 4. the local side had dedicated bonding as a requirement
 	 * 5. the remote side is using dedicated bonding since in that case
 	 *    also the local requirements are set to dedicated bonding
-	 * If none of the above match only keep the link key around for
+	 * If none of the above match and only keep the link key around for
 	 * this connection and set the temporary flag for the device.
 	 */
-	if (new_key_type == 0x03) {
-		DBG("Storing debug key in runtime memory");
-		device_set_debug_key(device, key);
-	} else if (key_type < 0x03 ||
+	if (new_key_type == 0x03)
+		temporary = FALSE;
+	else if (key_type < 0x03 ||
 				(key_type == 0x06 && old_key_type != 0xff) ||
 				(local_auth > 0x01 && remote_auth > 0x01) ||
 				(local_auth == 0x02 || local_auth == 0x03) ||
diff --git a/src/device.c b/src/device.c
index 6af76d1..059aec3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -143,8 +143,8 @@ struct btd_device {
 	gboolean	authorizing;
 	gint		ref;
 
-	gboolean	has_debug_key;
-	uint8_t		debug_key[16];
+	uint8_t		key[16];
+	uint8_t		key_type;
 };
 
 static uint16_t uuid_list[] = {
@@ -1024,7 +1024,8 @@ struct btd_device *device_create(DBusConnection *conn,
 
 	device->auth = 0xff;
 
-	if (read_link_key(&src, &device->bdaddr, NULL, NULL) == 0)
+	if (read_link_key(&src, &device->bdaddr, device->key,
+						&device->key_type) == 0)
 		device->paired = TRUE;
 
 	return btd_device_ref(device);
@@ -2399,26 +2400,26 @@ const sdp_record_t *btd_device_get_record(struct btd_device *device,
 	return find_record_in_list(device->tmp_records, uuid);
 }
 
-gboolean device_set_debug_key(struct btd_device *device, uint8_t *key)
+void device_set_key(struct btd_device *device, uint8_t *key, uint8_t type)
 {
-	if (key == NULL) {
-		device->has_debug_key = FALSE;
-		return TRUE;
-	}
-
-	memcpy(device->debug_key, key, 16);
-	device->has_debug_key = TRUE;
+	/* Clear any previous key */
+	if (device->paired)
+		device_remove_bonding(device);
 
-	return TRUE;
+	memcpy(device->key, key, 16);
+	device->key_type = type;
 }
 
-gboolean device_get_debug_key(struct btd_device *device, uint8_t *key)
+gboolean device_get_key(struct btd_device *device, uint8_t *key, uint8_t *type)
 {
-	if (!device->has_debug_key)
+	if (!device->paired)
 		return FALSE;
 
 	if (key != NULL)
-		memcpy(key, device->debug_key, 16);
+		memcpy(key, device->key, 16);
+
+	if (type != NULL)
+		*type = device->key_type;
 
 	return TRUE;
 }
diff --git a/src/device.h b/src/device.h
index 5f75e61..229bc9e 100644
--- a/src/device.h
+++ b/src/device.h
@@ -79,8 +79,9 @@ gboolean device_is_authenticating(struct btd_device *device);
 gboolean device_is_authorizing(struct btd_device *device);
 void device_set_authorizing(struct btd_device *device, gboolean auth);
 void device_set_renewed_key(struct btd_device *device, gboolean renewed);
-gboolean device_set_debug_key(struct btd_device *device, uint8_t *key);
-gboolean device_get_debug_key(struct btd_device *device, uint8_t *key);
+void device_set_key(struct btd_device *device, uint8_t *key, uint8_t type);
+gboolean device_get_key(struct btd_device *device, uint8_t *key,
+								uint8_t *type);
 void device_add_connection(struct btd_device *device, DBusConnection *conn,
 				uint16_t handle);
 void device_remove_connection(struct btd_device *device, DBusConnection *conn,
diff --git a/src/security.c b/src/security.c
index ca394e1..9d9e26f 100644
--- a/src/security.c
+++ b/src/security.c
@@ -329,9 +329,8 @@ static void link_key_request(int dev, bdaddr_t *sba, bdaddr_t *dba)
 
 	DBG("kernel auth requirements = 0x%02x", req.type);
 
-	if (main_opts.debug_keys && device && device_get_debug_key(device, key))
-		type = 0x03;
-	else if (read_link_key(sba, dba, key, &type) < 0 || type == 0x03) {
+	if (device_get_key(device, key, &type) == FALSE ||
+			(type == 0x03 && main_opts.debug_keys == FALSE)) {
 		/* Link key not found */
 		hci_send_cmd(dev, OGF_LINK_CTL, OCF_LINK_KEY_NEG_REPLY, 6, dba);
 		return;
-- 
1.7.0.4


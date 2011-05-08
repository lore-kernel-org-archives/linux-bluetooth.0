Return-Path: <cyrus@holtmann.org>
Subject: Adapter stored link keys
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Sun, 08 May 2011 15:21:53 +0100
Content-Type: multipart/mixed; boundary="=-OcKtDjqsTajBPFucgiwK"
Message-ID: <1304864514.2427.18.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-OcKtDjqsTajBPFucgiwK
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Heya,

I updated my KeyOnAdapter property patch, and cooked up a few related
patches.

This is the test I intend on making work:
- pair keyboard
- set KeyOnAdapter value to TRUE
- check that key is indeed on the adapter using the hciconfig readkeys
command, and the bluetoothd output
- stop bluetoothd
- remove all mentions of keyboard from /var/lib/bluetooth (or nuke
directory)
- start bluetoothd
- check that debug output mentions the key still being on the adapter
- turn on keyboard, make sure it still connects without triggering a
link_key_request event.

If the above works, can we agree that we should add KeyOnAdapter to
bluez, and get front-ends to use it?

Cheers

--=-OcKtDjqsTajBPFucgiwK
Content-Disposition: attachment;
	filename="0001-hciconfig-Add-command-to-trigger-key-read.patch"
Content-Type: text/x-patch; name="0001-hciconfig-Add-command-to-trigger-key-read.patch";
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 82626d66ddb556d555c5c668d4b80188bce8ab46 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sun, 8 May 2011 14:53:50 +0100
Subject: [PATCH 1/3] hciconfig: Add command to trigger key read

Add support for "hci_read_stored_link_key" command to trigger
reading linkkeys from the adapter. Whether keys are read will be
listed in bluetoothd's debug output.
---
 tools/hciconfig.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index cbd0d0e..19b9b7e 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -1016,6 +1016,41 @@ static void cmd_putkey(int ctl, int hdev, char *opt)
 	hci_close_dev(dd);
 }
 
+static void cmd_readkeys(int ctl, int hdev, char *opt)
+{
+	struct hci_dev_info di;
+	bdaddr_t bdaddr;
+	int dd, ret;
+
+	dd = hci_open_dev(hdev);
+	if (dd < 0) {
+		fprintf(stderr, "Can't open device hci%d: %s (%d)\n",
+						hdev, strerror(errno), errno);
+		exit(1);
+	}
+
+	if (hci_devinfo(hdev, &di) < 0) {
+		fprintf(stderr, "Can't get device info for hci%d: %s (%d)\n",
+						hdev, strerror(errno), errno);
+		exit(1);
+	}
+
+	if (opt != NULL) {
+		str2ba(opt, &bdaddr);
+		ret = hci_read_stored_link_key (dd, &bdaddr, 0, 1000);
+	} else {
+		ret = hci_read_stored_link_key (dd, &bdaddr, 1, 1000);
+	}
+
+	if (ret < 0) {
+		fprintf(stderr, "Can't write stored link key on hci%d: %s (%d)\n",
+						hdev, strerror(errno), errno);
+		exit(1);
+	}
+
+	hci_close_dev(dd);
+}
+
 static void cmd_delkey(int ctl, int hdev, char *opt)
 {
 	bdaddr_t bdaddr;
@@ -1923,6 +1958,7 @@ static struct {
 	{ "aclmtu",	cmd_aclmtu,	"<mtu:pkt>",	"Set ACL MTU and number of packets" },
 	{ "scomtu",	cmd_scomtu,	"<mtu:pkt>",	"Set SCO MTU and number of packets" },
 	{ "putkey",	cmd_putkey,	"<bdaddr>",	"Store link key on the device" },
+	{ "readkeys",	cmd_readkeys,	"[bdaddr]",	"Read link keys from the device" },
 	{ "delkey",	cmd_delkey,	"<bdaddr>",	"Delete link key from the device" },
 	{ "oobdata",	cmd_oob_data,	0,		"Display local OOB data" },
 	{ "commands",	cmd_commands,	0,		"Display supported commands" },
-- 
1.7.5.1


--=-OcKtDjqsTajBPFucgiwK
Content-Disposition: attachment;
	filename="0002-hciops-Add-comment-about-ignored-link-key-value.patch"
Content-Type: text/x-patch;
	name="0002-hciops-Add-comment-about-ignored-link-key-value.patch";
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From b341dfe715fd90313848fde0b93f188c6c88a66d Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sun, 8 May 2011 14:55:17 +0100
Subject: [PATCH 2/3] hciops: Add comment about ignored link key value

As per spec, the key value is useless and will be ignored,
in the return_link_keys() event callback, so mention that clearly.
---
 plugins/hciops.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 49dd48d..9caf2c1 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1030,7 +1030,6 @@ static void return_link_keys(int index, void *ptr)
 	struct dev_info *dev = &devs[index];
 	evt_return_link_keys *evt = ptr;
 	uint8_t num = evt->num_keys;
-	unsigned char key[16];
 	char da[18];
 	bdaddr_t dba;
 	int i;
@@ -1041,7 +1040,10 @@ static void return_link_keys(int index, void *ptr)
 
 	for (i = 0; i < num; i++) {
 		bacpy(&dba, ptr); ba2str(&dba, da);
-		memcpy(key, ptr + 6, 16);
+		/* Ignore 16 bytes long key. From Core 2.1+EDR spec:
+		 * The link keys value parameter shall always contain
+		 * the value of zero.
+		 */
 
 		DBG("hci%d returned key for %s", index, da);
 
-- 
1.7.5.1


--=-OcKtDjqsTajBPFucgiwK
Content-Disposition: attachment; filename="0003-Add-KeyOnAdapter-property-to-devices.patch"
Content-Type: text/x-patch; name="0003-Add-KeyOnAdapter-property-to-devices.patch";
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 1a624e5be5f1e87b9958956d4e495198e8450505 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sun, 8 May 2011 15:14:18 +0100
Subject: [PATCH 3/3] Add KeyOnAdapter property to devices

The KeyOnAdapter property will be true if the linkkey comes from
the adapter storage, rather than the local filesystem storage.

This makes it possible for front-ends to add linkkeys to the
adapter itself for keyboard and mice to automatically work
when dual-booting under other OSes.
---
 doc/device-api.txt |   16 ++++++++
 plugins/hciops.c   |   32 ++++++++++++++++
 src/adapter.c      |   22 +++++++++++
 src/adapter.h      |    6 +++
 src/device.c       |  106 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h       |    2 +
 src/event.c        |    1 +
 7 files changed, 185 insertions(+), 0 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index d1feb18..37aa1ed 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -165,6 +165,22 @@ Properties	string Address [readonly]
 			drivers will also be removed and no new ones will
 			be probed as long as the device is blocked.
 
+		boolean KeyOnAdapter [readwrite]
+
+			Whether the linkkey for the device is available
+			on the adapter. This will be FALSE if the device
+			is not paired, or the key is not available on
+			the adapter (and just on the filesystem).
+
+			Setting this to TRUE, will write the key to the
+			adapter, returning an error if the adapter
+			does not support this.
+
+			Note that the key is not removed from the local
+			filesystem storage, as, once on the adapter, it
+			will lack linkkey type information, which is
+			required for Bluetooth 2.1 devices.
+
 		string Alias [readwrite]
 
 			The name alias for the remote device. The alias can
diff --git a/plugins/hciops.c b/plugins/hciops.c
index 9caf2c1..3070a7f 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3803,6 +3803,36 @@ static int hciops_remove_remote_oob_data(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int hciops_put_key (int index, bdaddr_t bdaddr, uint8_t *key)
+{
+	int dd, err;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	err = hci_write_stored_link_key(dd, &bdaddr, key, 0);
+
+	hci_close_dev(dd);
+
+	return -err;
+}
+
+static int hciops_del_key (int index, bdaddr_t bdaddr)
+{
+	int dd, err;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	err = hci_delete_stored_link_key(dd, &bdaddr, 0, 0);
+
+	hci_close_dev(dd);
+
+	return -err;
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
@@ -3842,6 +3872,8 @@ static struct btd_adapter_ops hci_ops = {
 	.read_local_oob_data = hciops_read_local_oob_data,
 	.add_remote_oob_data = hciops_add_remote_oob_data,
 	.remove_remote_oob_data = hciops_remove_remote_oob_data,
+	.put_key = hciops_put_key,
+	.del_key = hciops_del_key,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 76fc01b..d7023a0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3594,3 +3594,25 @@ int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 {
 	return adapter_ops->remove_remote_oob_data(adapter->dev_id, bdaddr);
 }
+
+int btd_adapter_put_key (struct btd_adapter *adapter, bdaddr_t bdaddr, uint8_t *key)
+{
+	if (!adapter_ops)
+		return -EINVAL;
+
+	if (!adapter->up)
+		return -EINVAL;
+
+	return adapter_ops->put_key(adapter->dev_id, bdaddr, key);
+}
+
+int btd_adapter_del_key (struct btd_adapter *adapter, bdaddr_t bdaddr)
+{
+	if (!adapter_ops)
+		return -EINVAL;
+
+	if (!adapter->up)
+		return -EINVAL;
+
+	return adapter_ops->del_key(adapter->dev_id, bdaddr);
+}
diff --git a/src/adapter.h b/src/adapter.h
index 9406b9b..de8a62b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -221,6 +221,8 @@ struct btd_adapter_ops {
 	int (*add_remote_oob_data) (int index, bdaddr_t *bdaddr, uint8_t *hash,
 							uint8_t *randomizer);
 	int (*remove_remote_oob_data) (int index, bdaddr_t *bdaddr);
+	int (*put_key) (int index, bdaddr_t bdaddr, uint8_t *key);
+	int (*del_key) (int index, bdaddr_t bdaddr);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *ops, gboolean priority);
@@ -277,3 +279,7 @@ int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
 
 int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 							bdaddr_t *bdaddr);
+int btd_adapter_put_key (struct btd_adapter *adapter,
+					bdaddr_t bdaddr,
+					uint8_t *key);
+int btd_adapter_del_key (struct btd_adapter *adapter, bdaddr_t bdaddr);
diff --git a/src/device.c b/src/device.c
index b0a6542..f3de5f5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -135,6 +135,7 @@ struct btd_device {
 	gboolean	trusted;
 	gboolean	paired;
 	gboolean	blocked;
+	gboolean        key_on_adapter;
 
 	gboolean	authorizing;
 	gint		ref;
@@ -233,6 +234,11 @@ gboolean device_is_paired(struct btd_device *device)
 	return device->paired;
 }
 
+gboolean device_linkkey_is_on_adapter(struct btd_device *device)
+{
+	return device->key_on_adapter;
+}
+
 gboolean device_is_trusted(struct btd_device *device)
 {
 	return device->trusted;
@@ -306,6 +312,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	boolean = device_is_paired(device);
 	dict_append_entry(&dict, "Paired", DBUS_TYPE_BOOLEAN, &boolean);
 
+	/* KeyOnAdapter */
+	boolean = device_linkkey_is_on_adapter(device);
+	dict_append_entry(&dict, "KeyOnAdapter", DBUS_TYPE_BOOLEAN, &boolean);
+
 	/* Trusted */
 	boolean = device_is_trusted(device);
 	dict_append_entry(&dict, "Trusted", DBUS_TYPE_BOOLEAN, &boolean);
@@ -404,6 +414,80 @@ static DBusMessage *set_trust(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static int device_put_key_on_adapter(DBusConnection *conn, struct btd_device *device)
+{
+	int err;
+	bdaddr_t src;
+	unsigned char linkkey[16];
+
+	if (device->key_on_adapter)
+		return 0;
+	if (!device->paired)
+		return 0;
+
+	adapter_get_address(device->adapter, &src);
+	if (read_link_key(&src, &device->bdaddr, linkkey, NULL) < 0)
+		return -ENOKEY;
+
+	err = btd_adapter_put_key(device->adapter, device->bdaddr, linkkey);
+	if (err < 0)
+		return -err;
+
+	device->key_on_adapter = TRUE;
+
+	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "KeyOnAdapter",
+					DBUS_TYPE_BOOLEAN, &device->key_on_adapter);
+
+	return 0;
+}
+
+static int device_del_key_on_adapter(DBusConnection *conn, struct btd_device *device)
+{
+	int err;
+
+	if (!device->key_on_adapter)
+		return 0;
+
+	err = btd_adapter_del_key(device->adapter, device->bdaddr);
+	if (err < 0)
+		return err;
+
+	device->key_on_adapter = FALSE;
+
+	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "KeyOnAdapter",
+					DBUS_TYPE_BOOLEAN, &device->key_on_adapter);
+
+	return 0;
+}
+
+static DBusMessage *set_key_on_adapter(DBusConnection *conn, DBusMessage *msg,
+						gboolean value, void *data)
+{
+	struct btd_device *device = data;
+	int err;
+
+	if (value)
+		err = device_put_key_on_adapter(conn, device);
+	else
+		err = device_del_key_on_adapter(conn, device);
+
+	switch (-err) {
+	case 0:
+		return dbus_message_new_method_return(msg);
+	case EINVAL:
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".NotSupported",
+					"Adapter lacks storage support");
+	case ENOKEY:
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".Failed",
+					"Device is paired but link key is not available");
+	default:
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
+						"%s", strerror(-err));
+	}
+}
+
 static void driver_remove(struct btd_device_driver *driver,
 						struct btd_device *device)
 {
@@ -552,6 +636,15 @@ static DBusMessage *set_property(DBusConnection *conn,
 		dbus_message_iter_get_basic(&sub, &value);
 
 		return set_blocked(conn, msg, value, data);
+	} else if (g_str_equal("KeyOnAdapter", property)) {
+		dbus_bool_t value;
+
+		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_BOOLEAN)
+			return btd_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&sub, &value);
+
+		return set_key_on_adapter(conn, msg, value, data);
 	}
 
 	return btd_error_invalid_args(msg);
@@ -1920,6 +2013,19 @@ void device_set_paired(struct btd_device *device, gboolean value)
 				DBUS_TYPE_BOOLEAN, &value);
 }
 
+void device_set_key_on_adapter(struct btd_device *device, gboolean value)
+{
+	DBusConnection *conn = get_dbus_connection();
+
+	if (device->key_on_adapter == value)
+		return;
+
+	device->key_on_adapter = value;
+
+	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "KeyOnAdapter",
+				DBUS_TYPE_BOOLEAN, &value);
+}
+
 static void device_agent_removed(struct agent *agent, void *user_data)
 {
 	struct btd_device *device = user_data;
diff --git a/src/device.h b/src/device.h
index d59b8eb..0326e24 100644
--- a/src/device.h
+++ b/src/device.h
@@ -69,7 +69,9 @@ gboolean device_is_busy(struct btd_device *device);
 gboolean device_is_temporary(struct btd_device *device);
 gboolean device_is_paired(struct btd_device *device);
 gboolean device_is_trusted(struct btd_device *device);
+gboolean device_linkkey_is_on_adapter(struct btd_device *device);
 void device_set_paired(struct btd_device *device, gboolean paired);
+void device_set_key_on_adapter(struct btd_device *device, gboolean key_on_adapter);
 void device_set_temporary(struct btd_device *device, gboolean temporary);
 void device_set_type(struct btd_device *device, device_type_t type);
 gboolean device_is_connected(struct btd_device *device);
diff --git a/src/event.c b/src/event.c
index cf68711..fd35c08 100644
--- a/src/event.c
+++ b/src/event.c
@@ -691,4 +691,5 @@ void btd_event_returned_link_key(bdaddr_t *local, bdaddr_t *peer)
 		return;
 
 	device_set_paired(device, TRUE);
+	device_set_key_on_adapter(device, TRUE);
 }
-- 
1.7.5.1


--=-OcKtDjqsTajBPFucgiwK--


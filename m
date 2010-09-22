Return-Path: <cyrus@holtmann.org>
Subject: Re: Running "putkey" for keyboards and mice
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1283791359.7529.28.camel@localhost.localdomain>
References: <1283767613.7529.6.camel@localhost.localdomain>
	 <AANLkTim3SSZhhJOB0DfaOsxMEzsaNKe-dkEf59p-7UQv@mail.gmail.com>
	 <1283775595.7529.21.camel@localhost.localdomain>
	 <1283791359.7529.28.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-ptqIj0L6HEAo2OFF2I9D"
Date: Wed, 22 Sep 2010 12:33:55 +0100
Message-ID: <1285155235.13582.98.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-ptqIj0L6HEAo2OFF2I9D
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Mon, 2010-09-06 at 17:42 +0100, Bastien Nocera wrote:
> On Mon, 2010-09-06 at 13:19 +0100, Bastien Nocera wrote:
> <snip>
> > Johan mentioned that we could implement this using a boolean property
> > for whether to store the linkkey on the device or not. When TRUE, should
> > we store the linkkey on both the device and on the local filesystem, or
> > just on the device?
> > 
> > hci_read_stored_link_key() is not currently used in the code at all, so
> > it's possible that a device will be paired, but not marked as such in
> > the interface.
> 
> I was wrongly reading the code, and it already does that.
> 
> Patch attached to add the "KeyOnAdapter" property to devices.
> 
> Note that I did not test this thoroughly yet. I'm more looking for
> comments right now.

Updated for latest git master.

Cheers

--=-ptqIj0L6HEAo2OFF2I9D
Content-Disposition: attachment; filename="0001-Add-KeyOnAdapter-property-to-devices.patch"
Content-Type: text/x-patch; name="0001-Add-KeyOnAdapter-property-to-devices.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From ae889732f66e1814622b546f167963cda2fa5de5 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Mon, 6 Sep 2010 17:21:30 +0100
Subject: [PATCH] Add KeyOnAdapter property to devices

The KeyOnAdapter property will be true if the linkkey comes from
the adapter storage, rather than the local filesystem storage.

This makes it possible for front-ends to add linkkeys to the
adapter itself for keyboard and mice to automatically work
when dual-booting under other OSes.
---
 doc/device-api.txt |   16 ++++++++
 plugins/hciops.c   |   32 ++++++++++++++++
 src/adapter.c      |   22 +++++++++++
 src/adapter.h      |    7 +++
 src/dbus-hci.c     |    1 +
 src/device.c       |  106 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h       |    1 +
 7 files changed, 185 insertions(+), 0 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index b818299..c4f633b 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -161,6 +161,22 @@ Properties	string Address [readonly]
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
index 626cba2..e935eb0 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -786,6 +786,36 @@ fail:
 	return err;
 }
 
+static int hciops_put_key (int index, bdaddr_t bdaddr, uint8_t *key)
+{
+	int dd, err;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	err = hci_write_stored_link_key(dd, &bdaddr, key, HCI_REQ_TIMEOUT);
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
+	err = hci_delete_stored_link_key(dd, &bdaddr, 0, HCI_REQ_TIMEOUT);
+
+	hci_close_dev(dd);
+
+	return -err;
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
@@ -805,6 +835,8 @@ static struct btd_adapter_ops hci_ops = {
 	.set_fast_connectable = hciops_fast_connectable,
 	.read_clock = hciops_read_clock,
 	.get_conn_handle = hciops_conn_handle,
+	.put_key = hciops_put_key,
+	.del_key = hciops_del_key,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 9121c20..675787c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3544,3 +3544,25 @@ int btd_adapter_get_conn_handle(struct btd_adapter *adapter,
 
 	return adapter_ops->get_conn_handle(adapter->dev_id, bdaddr, handle);
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
index 5eceaee..ec9981f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -190,6 +190,8 @@ struct btd_adapter_ops {
 	int (*read_clock) (int index, int handle, int which, int timeout,
 				 uint32_t *clock, uint16_t *accuracy);
 	int (*get_conn_handle) (int index, const bdaddr_t *bdaddr, int *handle);
+	int (*put_key) (int index, bdaddr_t bdaddr, uint8_t *key);
+	int (*del_key) (int index, bdaddr_t bdaddr);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
@@ -214,3 +216,8 @@ int btd_adapter_read_clock(struct btd_adapter *adapter, int handle, int which,
 						uint16_t *accuracy);
 int btd_adapter_get_conn_handle(struct btd_adapter *adapter,
 				const bdaddr_t *bdaddr, int *handle);
+
+int btd_adapter_put_key (struct btd_adapter *adapter,
+					bdaddr_t bdaddr,
+					uint8_t *key);
+int btd_adapter_del_key (struct btd_adapter *adapter, bdaddr_t bdaddr);
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 9055ffe..f266409 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -903,6 +903,7 @@ void hcid_dbus_returned_link_key(bdaddr_t *local, bdaddr_t *peer)
 		return;
 
 	device_set_paired(device, TRUE);
+	device_set_key_on_adapter(device, TRUE);
 }
 
 int hcid_dbus_get_io_cap(bdaddr_t *local, bdaddr_t *remote,
diff --git a/src/device.c b/src/device.c
index 9055eca..df89656 100644
--- a/src/device.c
+++ b/src/device.c
@@ -139,6 +139,7 @@ struct btd_device {
 	gboolean	paired;
 	gboolean	blocked;
 	gboolean	renewed_key;
+	gboolean	key_on_adapter;
 
 	gboolean	authorizing;
 	gint		ref;
@@ -256,6 +257,11 @@ gboolean device_is_paired(struct btd_device *device)
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
@@ -329,6 +335,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	boolean = device_is_paired(device);
 	dict_append_entry(&dict, "Paired", DBUS_TYPE_BOOLEAN, &boolean);
 
+	/* KeyOnAdapter */
+	boolean = device_linkkey_is_on_adapter(device);
+	dict_append_entry(&dict, "KeyOnAdapter", DBUS_TYPE_BOOLEAN, &boolean);
+
 	/* Trusted */
 	boolean = device_is_trusted(device);
 	dict_append_entry(&dict, "Trusted", DBUS_TYPE_BOOLEAN, &boolean);
@@ -570,6 +580,80 @@ static DBusMessage *set_blocked(DBusConnection *conn, DBusMessage *msg,
 	}
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
 static inline DBusMessage *invalid_args(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
@@ -620,6 +704,15 @@ static DBusMessage *set_property(DBusConnection *conn,
 		dbus_message_iter_get_basic(&sub, &value);
 
 		return set_blocked(conn, msg, value, data);
+	} else if (g_str_equal("KeyOnAdapter", property)) {
+		dbus_bool_t value;
+
+		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_BOOLEAN)
+			return invalid_args(msg);
+
+		dbus_message_iter_get_basic(&sub, &value);
+
+		return set_key_on_adapter(conn, msg, value, data);
 	}
 
 	return invalid_args(msg);
@@ -1836,6 +1929,19 @@ void device_set_paired(struct btd_device *device, gboolean value)
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
index 21f67d0..6f57b37 100644
--- a/src/device.h
+++ b/src/device.h
@@ -55,6 +55,7 @@ gboolean device_is_temporary(struct btd_device *device);
 gboolean device_is_paired(struct btd_device *device);
 gboolean device_is_trusted(struct btd_device *device);
 void device_set_paired(struct btd_device *device, gboolean paired);
+void device_set_key_on_adapter(struct btd_device *device, gboolean key_on_adapter);
 void device_set_temporary(struct btd_device *device, gboolean temporary);
 void device_set_cap(struct btd_device *device, uint8_t cap);
 uint8_t device_get_cap(struct btd_device *device);
-- 
1.7.2.3


--=-ptqIj0L6HEAo2OFF2I9D--


Return-Path: <cyrus@holtmann.org>
Subject: AddCablePairedDevice (was Re: [PATCHes] Add sixpair)
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1224116918.5268.3845.camel@cookie.hadess.net>
References: <1224083727.5268.3149.camel@cookie.hadess.net>
	 <1224114777.28173.41.camel@californication>
	 <1224116918.5268.3845.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-wbPPXm7j1b7/acs9waoL"
Date: Sat, 28 Feb 2009 21:48:45 +0000
Message-Id: <1235857725.7310.797.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-wbPPXm7j1b7/acs9waoL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-10-16 at 01:28 +0100, Bastien Nocera wrote:
<snip>
> We could solve the data loss, and update problem by having an internal,
> root only, dbus method available for cable pairing of that sort. For
> example, on org.bluez.Adapter:
> void AddCablePairedDevice (string name,
>                            string address,
>                            unsigned int vendor_id,
>                            unsigned int product_id,
>                            string pnp_record);
>=20
> The function would just need to do all the storage work sixpair
> currently does, and create the device internally similarly to
> create_stored_device_from_profiles().

Patch to do that attached.

After setting the master bdaddr on the sixaxis using sixpair, I ran:
dbus-send --system --type=3Dmethod_call --print-reply --dest=3D"org.bluez" =
/org/bluez/11043/hci0 org.bluez.Adapter.AddCablePairedDevice string:Foobar =
string:00:19:C1:61:D6:62 uint32:0x054c uint32:0x0268 string:3601920900000A0=
00100000900013503191124090004350D35061901000900113503190011090006350909656E=
09006A0901000900093508350619112409010009000D350F350D35061901000900133503190=
0110901002513576972656C65737320436F6E74726F6C6C65720901012513576972656C6573=
7320436F6E74726F6C6C6572090102251B536F6E7920436F6D707574657220456E746572746=
1696E6D656E7409020009010009020109010009020208000902030821090204280109020528=
01090206359A35980822259405010904A101A102850175089501150026FF008103750195131=
50025013500450105091901291381027501950D0600FF8103150026FF0005010901A1007508=
9504350046FF0009300931093209358102C0050175089527090181027508953009019102750=
895300901B102C0A1028502750895300901B102C0A10285EE750895300901B102C0A10285EF=
750895300901B102C0C0090207350835060904090901000902082800090209280109020A280=
109020B09010009020C093E8009020D280009020E2800

Which created the device in bluez. I'd leave it up to sixpair to remove
the device from other adapters, and setting the device as trusted
(though this didn't seem necessary for the pad to work).

Cheers

--=-wbPPXm7j1b7/acs9waoL
Content-Disposition: attachment; filename="bluez-create-paired-device-api.patch"
Content-Type: text/x-patch; name="bluez-create-paired-device-api.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

diff --git a/src/adapter.c b/src/adapter.c
index c1995a3..ba2c5fb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -977,6 +977,36 @@ struct btd_device *adapter_create_device(DBusConnection *conn,
 	return device;
 }
 
+struct btd_device *adapter_add_cable_paired_device(DBusConnection *conn,
+						   struct btd_adapter *adapter,
+						   const char *name,
+						   const char *address,
+						   guint32 vendor_id,
+						   guint32 product_id,
+						   const char *pnp_record)
+{
+	struct btd_device *device;
+	const char *path;
+
+	debug("adapter_add_cable_paired_device(%s)", address);
+
+	device = device_create_cable_paired_device(conn, adapter, name, address, vendor_id, product_id, pnp_record);
+	if (!device)
+		return NULL;
+
+	adapter->devices = g_slist_append(adapter->devices, device);
+
+	path = device_get_path(device);
+	g_dbus_emit_signal(conn, adapter->path,
+			ADAPTER_INTERFACE, "DeviceCreated",
+			DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID);
+
+	adapter_update_devices(adapter);
+
+	return device;
+}
+
 void adapter_remove_device(DBusConnection *conn, struct btd_adapter *adapter,
 				struct btd_device *device)
 {
@@ -1508,6 +1538,41 @@ static DBusMessage *create_device(DBusConnection *conn,
 	return NULL;
 }
 
+static DBusMessage *add_cable_paired_device(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct btd_adapter *adapter = data;
+	struct btd_device *device;
+	guint vendor_id, product_id;
+	const gchar *address, *pnp_record, *name;
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &name,
+						DBUS_TYPE_STRING, &address,
+						DBUS_TYPE_UINT32, &vendor_id,
+						DBUS_TYPE_UINT32, &product_id,
+						DBUS_TYPE_STRING, &pnp_record,
+						DBUS_TYPE_INVALID) == FALSE)
+		return invalid_args(msg);
+
+	if (check_address(address) < 0)
+		return invalid_args(msg);
+
+	if (adapter_find_device(adapter, address))
+		return g_dbus_create_error(msg,
+				ERROR_INTERFACE ".AlreadyExists",
+				"Device already exists");
+
+	debug("create_device(%s)", address);
+
+	device = adapter_add_cable_paired_device(conn, adapter, name, address, vendor_id, product_id, pnp_record);
+	if (!device)
+		return NULL;
+
+	device_set_temporary(device, FALSE);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static uint8_t parse_io_capability(const char *capability)
 {
 	if (g_str_equal(capability, ""))
@@ -1707,6 +1772,7 @@ static GDBusMethodTable adapter_methods[] = {
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "ListDevices",	"",	"ao",	list_devices,
 						G_DBUS_METHOD_FLAG_DEPRECATED},
+	{ "AddCablePairedDevice", "ssuus", "o",	add_cable_paired_device	},
 	{ "CreateDevice",	"s",	"o",	create_device,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "CreatePairedDevice",	"sos",	"o",	create_paired_device,
diff --git a/src/adapter.h b/src/adapter.h
index 06f558a..1a24a1a 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -91,6 +91,14 @@ void adapter_remove_device(DBusConnection *conn, struct btd_adapter *adapter,
 struct btd_device *adapter_create_device(DBusConnection *conn,
 				struct btd_adapter *adapter, const char *address);
 
+struct btd_device *adapter_add_cable_paired_device(DBusConnection *conn,
+				struct btd_adapter *adapter,
+				const char *name,
+				const char *address,
+				guint vendor_id,
+				guint product_id,
+				const char *pnp_record);
+
 int pending_remote_name_cancel(struct btd_adapter *adapter);
 
 void remove_pending_device(struct btd_adapter *adapter);
diff --git a/src/device.c b/src/device.c
index 9b32379..6a153dc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -654,6 +654,57 @@ struct btd_device *device_create(DBusConnection *conn,
 	return device;
 }
 
+struct btd_device *device_create_cable_paired_device(DBusConnection *conn,
+						     struct btd_adapter *adapter,
+						     const char *name,
+						     const char *address,
+						     guint32 vendor_id,
+						     guint32 product_id,
+						     const char *pnp_record)
+{
+	gchar *address_up;
+	sdp_record_t *rec;
+	struct btd_device *device;
+	const gchar *adapter_path = adapter_get_path(adapter);
+	bdaddr_t src;
+	char srcaddr[18];
+
+	device = g_try_malloc0(sizeof(struct btd_device));
+	if (device == NULL)
+		return NULL;
+
+	address_up = g_ascii_strup(address, -1);
+	device->path = g_strdup_printf("%s/dev_%s", adapter_path, address_up);
+	g_strdelimit(device->path, ":", '_');
+	g_free(address_up);
+
+	debug("Creating cable paired device %s", device->path);
+
+	if (g_dbus_register_interface(conn, device->path, DEVICE_INTERFACE,
+				device_methods, device_signals, NULL,
+				device, device_free) == FALSE) {
+		device_free(device);
+		return NULL;
+	}
+
+	str2ba(address, &device->bdaddr);
+	device->adapter = adapter;
+	adapter_get_address(adapter, &src);
+	ba2str(&src, srcaddr);
+	write_device_name(&device->bdaddr, &src, name);
+	device_set_name (device, name);
+
+	/* Store the device's SDP record */
+	rec = record_from_string (pnp_record);
+	store_record(srcaddr, address, rec);
+	sdp_record_free(rec);
+	/* Set the device id */
+	store_device_id(srcaddr, address, 0xffff, vendor_id, product_id, 0);
+	/* Don't write a profile, it will be updated when the device connects */
+
+	return device;
+}
+
 void device_set_name(struct btd_device *device, const char *name)
 {
 	DBusConnection *conn = get_dbus_connection();
diff --git a/src/device.h b/src/device.h
index 5c230b8..a3e5447 100644
--- a/src/device.h
+++ b/src/device.h
@@ -36,6 +36,13 @@ typedef enum {
 
 struct btd_device *device_create(DBusConnection *conn, struct btd_adapter *adapter,
 				const gchar *address);
+struct btd_device *device_create_cable_paired_device(DBusConnection *conn,
+						     struct btd_adapter *adapter,
+						     const char *name,
+						     const char *address,
+						     guint32 vendor_id,
+						     guint32 product_id,
+						     const char *pnp_record);
 void device_set_name(struct btd_device *device, const char *name);
 void device_remove(struct btd_device *device, DBusConnection *conn,
 						gboolean remove_stored);

--=-wbPPXm7j1b7/acs9waoL--

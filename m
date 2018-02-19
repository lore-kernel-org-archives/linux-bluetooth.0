Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] adapter: Add ConnectDevice method
Date: Mon, 19 Feb 2018 14:29:16 +0100
Message-ID: <11012483.I3YDyZz7AY@ix>
In-Reply-To: <93997D35-47A7-4EBD-AC18-AB1C601411A4@holtmann.org>
References: <20180212215946.30909-1-szymon.janc@codecoup.pl> <93997D35-47A7-4EBD-AC18-AB1C601411A4@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Friday, 16 February 2018 19:03:51 CET Marcel Holtmann wrote:
> Hi Szymon,
>=20
> > This allows to connect device without doing general discovery. This is
> > needed for some of qualification tests where there is no general
> > discovery upfront and we need to do connection to device with provided
> > address.
> >=20
> > Another usecase is for scenario where scanning happen on one controller
> > but connection handling on another.
> >=20
> > New device object is announced only if physical connection was
> > successful. On success this method returns path to created device
> > object. After ConnectProfile return bluetoothd continue with
> > services discovery and profile connection.
> >=20
> > This patch implements bare minimum properties needed for connection -
> > address and address type. If needed eg. for non-NFC based OOB it could
> > be extended with more options.
> > ---
> > doc/adapter-api.txt |  40 ++++++++++++
> > src/adapter.c       | 183
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++ src/device.c      =
=20
> > |  32 +++++----
> > 3 files changed, 241 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > index 0533b674a..23121a936 100644
> > --- a/doc/adapter-api.txt
> > +++ b/doc/adapter-api.txt
> > @@ -145,6 +145,46 @@ Methods		void StartDiscovery()
> >=20
> > 			Possible errors: None
> >=20
> > +		object ConnectDevice(dict properties) [experimental]
> > +
> > +			This method creates new temporary device with defined
> > +			properties and issues connection to that device without
> > +			need of performing General Discovery first. Connection
> > +			mechanism is similar to Connect method from Device1
> > +			interface with exception that this method returns
> > +			success when physical connection is established. After
> > +			this method returns bluetoothd will continue with
>=20
> Don=E2=80=99t mention bluetoothd here. That is just one specific implemen=
tation.
> Rephrase this in generic terms.

OK.

> > +			services discovery and connect any supported profiles so
> > +			there is no need for calling Connect on Device1.
> > +			If connection failed, created device is removed and this
> > +			method fails. If connection was successful this method
> > +			returns object path to created device object.
>=20
> This is also an odd phrasing. The created device is never there in the fi=
rst
> place. That is an internal detail. I mean we should make sure that the
> device does not even gets announced via object manager. It is internal
> detail. Only once it succeeds this should be announced.

Yeah, this is acctually leftover from previous version as current version=20
behaves like you described - new device object is announced on object manag=
er=20
after if connection was succesfull. I'll just remove this from description.

> > +
> > +			Parameters that may be set in the filter dictionary
> > +			include the following:
> > +
> > +			string Address
> > +
> > +				The Bluetooth device address of the remote
> > +				device. This parameter is mandatory.
> > +
> > +			string AddressType
> > +
> > +				The Bluetooth device Address Type. This is
> > +				address type that should be used for initial
> > +				connection. If this parameter is not present
> > +				BR/EDR device is created.
> > +
> > +				Possible values:
> > +					"public" - Public address
> > +					"random" - Random address
> > +
> > +			Possible errors: org.bluez.Error.InvalidArguments
> > +					 org.bluez.Error.AlreadyExists
> > +					 org.bluez.Error.NotSupported
> > +					 org.bluez.Error.NotReady
> > +					 org.bluez.Error.Failed
> > +
> > Properties	string Address [readonly]
> >=20
> > 			The Bluetooth device address.
> >=20
> > diff --git a/src/adapter.c b/src/adapter.c
> > index bd5c1e150..3a62dd142 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -59,6 +59,7 @@
> > #include "src/shared/att.h"
> > #include "src/shared/gatt-db.h"
> >=20
> > +#include "btio/btio.h"
> > #include "hcid.h"
> > #include "sdpd.h"
> > #include "adapter.h"
> > @@ -3074,6 +3075,185 @@ static DBusMessage
> > *get_discovery_filters(DBusConnection *conn,>=20
> > 	return reply;
> >=20
> > }
> >=20
> > +struct device_connect_data {
> > +	struct btd_adapter *adapter;
> > +	bdaddr_t dst;
> > +	uint8_t dst_type;
> > +	DBusMessage *msg;
> > +};
> > +
> > +static void device_browse_cb(struct btd_device *dev, int err, void
> > *user_data) +{
> > +	DBG("err %d (%s)", err, strerror(-err));
> > +
> > +	if (!err)
> > +		btd_device_connect_services(dev, NULL);
> > +}
> > +
> > +static void device_connect_cb(GIOChannel *io, GError *gerr, gpointer
> > user_data) +{
> > +	struct device_connect_data *data =3D user_data;
> > +	struct btd_adapter *adapter =3D data->adapter;
> > +	struct btd_device *device;
> > +	const char *path;
> > +
> > +	DBG("%s", gerr ? gerr->message : "");
> > +
> > +	if (gerr)
> > +		goto failed;
> > +
> > +	/* object might already exist due to mgmt socket event */
> > +	device =3D btd_adapter_get_device(adapter, &data->dst, data->dst_type=
);
> > +	if (!device)
> > +		goto failed;
> > +
> > +	path =3D device_get_path(device);
> > +
> > +	g_dbus_send_reply(dbus_conn, data->msg, DBUS_TYPE_OBJECT_PATH, &path,
> > +							DBUS_TYPE_INVALID);
> > +
> > +	/* continue with service discovery and connection */
> > +	btd_device_set_temporary(device, false);
> > +	device_update_last_seen(device, data->dst_type);
> > +
> > +	if (data->dst_type !=3D BDADDR_BREDR){
> > +		g_io_channel_set_close_on_unref(io, FALSE);
> > +		device_attach_att(device, io);
> > +	}
> > +
> > +	device_discover_services(device);
> > +	device_wait_for_svc_complete(device, device_browse_cb, NULL);
> > +
> > +	g_io_channel_unref(io);
> > +	dbus_message_unref(data->msg);
> > +	free(data);
> > +	return;
> > +
> > +failed:
> > +	g_dbus_send_error(dbus_conn, data->msg, "org.bluez.Failed", NULL);
> > +	g_io_channel_unref(io);
> > +	dbus_message_unref(data->msg);
> > +	free(data);
> > +}
> > +
> > +static void device_connect(struct btd_adapter *adapter, const bdaddr_t
> > *dst, +					uint8_t dst_type, DBusMessage *msg)
> > +{
> > +	struct device_connect_data *data;
> > +	GIOChannel *io;
> > +
> > +	data =3D new0(struct device_connect_data, 1);
> > +	data->adapter =3D adapter;
> > +	bacpy(&data->dst, dst);
> > +	data->dst_type =3D dst_type;
> > +	data->msg =3D dbus_message_ref(msg);
> > +
> > +	if (dst_type =3D=3D BDADDR_BREDR)
> > +		io =3D bt_io_connect(device_connect_cb, data, NULL, NULL,
> > +				BT_IO_OPT_SOURCE_BDADDR, &adapter->bdaddr,
> > +				BT_IO_OPT_SOURCE_TYPE, BDADDR_BREDR,
> > +				BT_IO_OPT_DEST_BDADDR, dst,
> > +				BT_IO_OPT_DEST_TYPE, BDADDR_BREDR,
> > +				BT_IO_OPT_PSM, SDP_PSM,
> > +				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
> > +				BT_IO_OPT_INVALID);
> > +	else
> > +		io =3D bt_io_connect(device_connect_cb, data, NULL, NULL,
> > +				BT_IO_OPT_SOURCE_BDADDR, &adapter->bdaddr,
> > +				BT_IO_OPT_SOURCE_TYPE, adapter->bdaddr_type,
> > +				BT_IO_OPT_DEST_BDADDR, dst,
> > +				BT_IO_OPT_DEST_TYPE, dst_type,
> > +				BT_IO_OPT_CID, ATT_CID,
> > +				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
> > +				BT_IO_OPT_INVALID);
> > +
> > +	if (!io) {
> > +		g_dbus_send_message(dbus_conn,
> > +				btd_error_failed(msg, "Connect failed"));
> > +		dbus_message_unref(data->msg);
> > +		free(data);
> > +	}
> > +}
> > +
> > +static DBusMessage *connect_device(DBusConnection *conn,
> > +					DBusMessage *msg, void *user_data)
> > +{
> > +	struct btd_adapter *adapter =3D user_data;
> > +	DBusMessageIter iter, subiter, dictiter, value;
> > +	uint8_t addr_type =3D BDADDR_BREDR;
> > +	bdaddr_t addr =3D *BDADDR_ANY;
> > +
> > +	DBG("sender %s", dbus_message_get_sender(msg));
> > +
> > +	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
> > +		return btd_error_not_ready(msg);
> > +
> > +	dbus_message_iter_init(msg, &iter);
> > +	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_ARRAY ||
> > +	    dbus_message_iter_get_element_type(&iter) !=3D DBUS_TYPE_DICT_ENT=
RY)
> > +		return btd_error_invalid_args(msg);
> > +
> > +	dbus_message_iter_recurse(&iter, &subiter);
> > +	while (true) {
> > +		int type =3D dbus_message_iter_get_arg_type(&subiter);
> > +		char *key;
> > +		char *str;
> > +
> > +		if (type =3D=3D DBUS_TYPE_INVALID)
> > +			break;
> > +
> > +		dbus_message_iter_recurse(&subiter, &dictiter);
> > +
> > +		dbus_message_iter_get_basic(&dictiter, &key);
> > +		if (!dbus_message_iter_next(&dictiter))
> > +			return btd_error_invalid_args(msg);
> > +
> > +		if (dbus_message_iter_get_arg_type(&dictiter) !=3D
> > +							DBUS_TYPE_VARIANT)
> > +			return btd_error_invalid_args(msg);
> > +
> > +		dbus_message_iter_recurse(&dictiter, &value);
> > +
> > +		if (!strcmp(key, "Address")) {
> > +			if (dbus_message_iter_get_arg_type(&value) !=3D
> > +							DBUS_TYPE_STRING)
> > +				return btd_error_invalid_args(msg);
> > +
> > +			dbus_message_iter_get_basic(&value, &str);
> > +
> > +			if (str2ba(str, &addr) < 0 )
> > +				return btd_error_invalid_args(msg);
> > +		} else if (!strcmp(key, "AddressType")) {
> > +			if (dbus_message_iter_get_arg_type(&value) !=3D
> > +							DBUS_TYPE_STRING)
> > +				return btd_error_invalid_args(msg);
> > +
> > +			dbus_message_iter_get_basic(&value, &str);
> > +
> > +
> > +			if (!strcmp(str, "public"))
> > +				addr_type =3D BDADDR_LE_PUBLIC;
> > +			else if (!strcmp(str, "random"))
> > +				addr_type =3D BDADDR_LE_RANDOM;
> > +			else
> > +				return btd_error_invalid_args(msg);
> > +		} else {
> > +			return btd_error_invalid_args(msg);
> > +		}
> > +
> > +		dbus_message_iter_next(&subiter);
> > +	}
> > +
> > +	if (!bacmp(&addr, BDADDR_ANY))
> > +		return btd_error_invalid_args(msg);
> > +
> > +	if (btd_adapter_find_device(adapter, &addr, addr_type))
> > +		return btd_error_already_exists(msg);
> > +
> > +	device_connect(adapter, &addr, addr_type, msg);
> > +	return NULL;
> > +}
> > +
> > static const GDBusMethodTable adapter_methods[] =3D {
> >=20
> > 	{ GDBUS_ASYNC_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
> > 	{ GDBUS_METHOD("SetDiscoveryFilter",
> >=20
> > @@ -3085,6 +3265,9 @@ static const GDBusMethodTable adapter_methods[] =
=3D {
> >=20
> > 	{ GDBUS_METHOD("GetDiscoveryFilters", NULL,
> > =09
> > 			GDBUS_ARGS({ "filters", "as" }),
> > 			get_discovery_filters) },
> >=20
> > +	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ConnectDevice",
> > +				GDBUS_ARGS({ "properties", "a{sv}" }), NULL,
> > +				connect_device) },
> >=20
> > 	{ }
> >=20
> > };
> >=20
> > diff --git a/src/device.c b/src/device.c
> > index 1acecce33..1633516a7 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -1749,10 +1749,16 @@ int btd_device_connect_services(struct btd_devi=
ce
> > *dev, GSList *services)>=20
> > 	if (!dev->bredr_state.svc_resolved)
> > =09
> > 		return -ENOENT;
> >=20
> > -	for (l =3D services; l; l =3D g_slist_next(l)) {
> > -		struct btd_service *service =3D l->data;
> > +	if (services) {
> > +		for (l =3D services; l; l =3D g_slist_next(l)) {
> > +			struct btd_service *service =3D l->data;
> > +
> > +			dev->pending =3D g_slist_append(dev->pending, service);
> > +		}
> > +	} else {
> > +		dev->pending =3D create_pending_list(dev, NULL);
> >=20
> > -		dev->pending =3D g_slist_append(dev->pending, service);
> > +		DBG("BLAH %d", g_slist_length(dev->pending));
>=20
> Hmmmm ;)

:-)

=2D-=20
pozdrawiam
Szymon Janc

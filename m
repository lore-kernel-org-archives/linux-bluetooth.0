Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1468842547-7088-1-git-send-email-luiz.dentz@gmail.com>
References: <1468842547-7088-1-git-send-email-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Aug 2016 14:57:33 +0300
Message-ID: <CABBYNZJruciEcqON8K_hdkFBnFO87HpdV8J0Rvn9woi_Lmhb=Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] core/gatt: Promote GATT D-Bus interfaces to stable
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jul 18, 2016 at 2:49 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> These interfaces have been in use for quite a while in chromium where it
> is used by Web Bluetooth APIs.
> ---
>  doc/gatt-api.txt    | 10 +++++-----
>  src/gatt-client.c   | 37 +++++++++++--------------------------
>  src/gatt-database.c | 10 +++++-----
>  3 files changed, 21 insertions(+), 36 deletions(-)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 4992243..f2f3d89 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -27,7 +27,7 @@ using GattManager1 registration method and must implement the methods and
>  properties defined in GattService1 interface.
>
>  Service                org.bluez
> -Interface      org.bluez.GattService1 [Experimental]
> +Interface      org.bluez.GattService1
>  Object path    [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX
>
>  Properties     string UUID [read-only]
> @@ -58,7 +58,7 @@ For local GATT defined services, the object paths need to follow the service
>  path hierarchy and are freely definable.
>
>  Service                org.bluez
> -Interface      org.bluez.GattCharacteristic1 [Experimental]
> +Interface      org.bluez.GattCharacteristic1
>  Object path    [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY
>
>  Methods                array{byte} ReadValue(dict options)
> @@ -159,7 +159,7 @@ Characteristic Descriptors hierarchy
>  Local or remote GATT characteristic descriptors hierarchy.
>
>  Service                org.bluez
> -Interface      org.bluez.GattDescriptor1 [Experimental]
> +Interface      org.bluez.GattDescriptor1
>  Object path    [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY/descriptorZZZ
>
>  Methods                array{byte} ReadValue(dict flags)
> @@ -231,7 +231,7 @@ and requests automatic connections to be established to devices
>  supporting it.
>
>  Service                <application dependent>
> -Interface      org.bluez.GattProfile1 [Experimental]
> +Interface      org.bluez.GattProfile1
>  Object path    <application dependent>
>
>  Methods                void Release()
> @@ -308,7 +308,7 @@ all of its registered services will be automatically unregistered.
>  InterfacesAdded signals will be ignored.
>
>  Service                org.bluez
> -Interface      org.bluez.GattManager1 [Experimental]
> +Interface      org.bluez.GattManager1
>  Object path    [variable prefix]/{hci0,hci1,...}
>
>  Methods                void RegisterApplication(object application, dict options)
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 7abb306..f50db0b 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -623,12 +623,10 @@ static const GDBusPropertyTable descriptor_properties[] = {
>  };
>
>  static const GDBusMethodTable descriptor_methods[] = {
> -       { GDBUS_EXPERIMENTAL_ASYNC_METHOD("ReadValue",
> -                                       GDBUS_ARGS({ "options", "a{sv}" }),
> +       { GDBUS_ASYNC_METHOD("ReadValue", GDBUS_ARGS({ "options", "a{sv}" }),
>                                         GDBUS_ARGS({ "value", "ay" }),
>                                         descriptor_read_value) },
> -       { GDBUS_EXPERIMENTAL_ASYNC_METHOD("WriteValue",
> -                                       GDBUS_ARGS({ "value", "ay" },
> +       { GDBUS_ASYNC_METHOD("WriteValue", GDBUS_ARGS({ "value", "ay" },
>                                                 { "options", "a{sv}" }),
>                                         NULL,
>                                         descriptor_write_value) },
> @@ -1251,34 +1249,27 @@ static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
>  }
>
>  static const GDBusPropertyTable characteristic_properties[] = {
> -       { "UUID", "s", characteristic_get_uuid, NULL, NULL,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Service", "o", characteristic_get_service, NULL, NULL,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> +       { "UUID", "s", characteristic_get_uuid, NULL, NULL },
> +       { "Service", "o", characteristic_get_service, NULL, NULL },
>         { "Value", "ay", characteristic_get_value, NULL,
> -                                       characteristic_value_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> +                                       characteristic_value_exists },
>         { "Notifying", "b", characteristic_get_notifying, NULL,
> -                                       characteristic_notifying_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Flags", "as", characteristic_get_flags, NULL, NULL,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> +                                       characteristic_notifying_exists },
> +       { "Flags", "as", characteristic_get_flags, NULL, NULL },
>         { }
>  };
>
>  static const GDBusMethodTable characteristic_methods[] = {
> -       { GDBUS_EXPERIMENTAL_ASYNC_METHOD("ReadValue",
> -                                       GDBUS_ARGS({ "options", "a{sv}" }),
> +       { GDBUS_ASYNC_METHOD("ReadValue", GDBUS_ARGS({ "options", "a{sv}" }),
>                                         GDBUS_ARGS({ "value", "ay" }),
>                                         characteristic_read_value) },
> -       { GDBUS_EXPERIMENTAL_ASYNC_METHOD("WriteValue",
> -                                       GDBUS_ARGS({ "value", "ay" },
> +       { GDBUS_ASYNC_METHOD("WriteValue", GDBUS_ARGS({ "value", "ay" },
>                                                 { "options", "a{sv}" }),
>                                         NULL,
>                                         characteristic_write_value) },
> -       { GDBUS_EXPERIMENTAL_ASYNC_METHOD("StartNotify", NULL, NULL,
> +       { GDBUS_ASYNC_METHOD("StartNotify", NULL, NULL,
>                                         characteristic_start_notify) },
> -       { GDBUS_EXPERIMENTAL_METHOD("StopNotify", NULL, NULL,
> +       { GDBUS_METHOD("StopNotify", NULL, NULL,
>                                         characteristic_stop_notify) },
>         { }
>  };
> @@ -1584,12 +1575,6 @@ static void export_service(struct gatt_db_attribute *attr, void *user_data)
>
>  static void create_services(struct btd_gatt_client *client)
>  {
> -       /* Don't attempt to create any objects if experimental is disabled */
> -       if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
> -               info("GATT service objects disabled");
> -               return;
> -       }
> -
>         DBG("Exporting objects for GATT services: %s", client->devaddr);
>
>         gatt_db_foreach_service(client->db, NULL, export_service, client);
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index bf1925b..27559fd 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -2579,11 +2579,11 @@ static DBusMessage *manager_unregister_app(DBusConnection *conn,
>  }
>
>  static const GDBusMethodTable manager_methods[] = {
> -       { GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterApplication",
> -                       GDBUS_ARGS({ "application", "o" },
> -                       { "options", "a{sv}" }), NULL,
> -                       manager_register_app) },
> -       { GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterApplication",
> +       { GDBUS_ASYNC_METHOD("RegisterApplication",
> +                                       GDBUS_ARGS({ "application", "o" },
> +                                               { "options", "a{sv}" }),
> +                                       NULL, manager_register_app) },
> +       { GDBUS_ASYNC_METHOD("UnregisterApplication",
>                                         GDBUS_ARGS({ "application", "o" }),
>                                         NULL, manager_unregister_app) },
>         { }
> --
> 2.7.4

Applied, note that we may need to add APIs for observer role since
beacons may be able to rotate different advertisements which perhaps
don't make sense to be aggregated as properties but in peripherals
role this is less likely to happen.



-- 
Luiz Augusto von Dentz

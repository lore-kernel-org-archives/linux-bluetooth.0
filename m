Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1430863554-30611-2-git-send-email-armansito@chromium.org>
References: <1430863554-30611-1-git-send-email-armansito@chromium.org>
	<1430863554-30611-2-git-send-email-armansito@chromium.org>
Date: Thu, 7 May 2015 11:04:13 +0300
Message-ID: <CABBYNZ+NxOZp0ZbzJ_ESDTZBCnyT-uYBt=dEGURd5gphxCi2zQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] core/device: Implement GattServices property
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	ortuno@google.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, May 6, 2015 at 1:05 AM, Arman Uguray <armansito@chromium.org> wrote:
> This patch implements the new GattServices property, which gets updated
> when a device's associated bt_gatt_client becomes ready.

Looks like you went ahead before I had time to review, anyway here are
my comments.

> ---
>  src/device.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 8b678a9..d4d72c0 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -233,6 +233,7 @@ struct btd_device {
>          * attribute cache support can be built.
>          */
>         struct gatt_db *db;                     /* GATT db cache */
> +       bool gatt_cache_used;                   /* true if discovery skipped */

Not sure why this has anything to do with the changes, and if you can
basically check if the db is empty Im not sure if this is worth it.

>         struct bt_gatt_client *client;          /* GATT client instance */
>         struct bt_gatt_server *server;          /* GATT server instance */
>
> @@ -546,8 +547,11 @@ static void gatt_client_cleanup(struct btd_device *device)
>          * the bonding state for the correct bearer based on the transport over
>          * which GATT is being done.
>          */
> -       if (!device->le_state.bonded)
> -               gatt_db_clear(device->db);
> +       if (device->le_state.bonded)
> +               return;
> +
> +       gatt_db_clear(device->db);
> +       device->gatt_cache_used = false;
>  }
>
>  static void gatt_server_cleanup(struct btd_device *device)
> @@ -948,6 +952,42 @@ static gboolean dev_property_exists_tx_power(const GDBusPropertyTable *property,
>         return TRUE;
>  }
>
> +static void append_service_path(const char *path, void *user_data)
> +{
> +       DBusMessageIter *array = user_data;
> +
> +       dbus_message_iter_append_basic(array, DBUS_TYPE_OBJECT_PATH, &path);
> +}
> +
> +static gboolean dev_property_get_gatt_services(
> +                                       const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct btd_device *dev = data;
> +       DBusMessageIter array;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "o", &array);
> +
> +       btd_gatt_client_foreach_service(dev->client_dbus, append_service_path,
> +                                                                       &array);
> +
> +       dbus_message_iter_close_container(iter, &array);
> +
> +       return TRUE;
> +}
> +
> +static gboolean dev_property_exists_gatt_services(
> +                                       const GDBusPropertyTable *property,
> +                                       void *data)
> +{
> +       struct btd_device *dev = data;
> +
> +       if (!dev->client || !bt_gatt_client_is_ready(dev->client))
> +               return FALSE;
> +
> +       return TRUE;
> +}
> +
>  static gboolean dev_property_get_trusted(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data)
>  {
> @@ -2331,6 +2371,9 @@ static const GDBusPropertyTable device_properties[] = {
>         { "TxPower", "n", dev_property_get_tx_power, NULL,
>                                         dev_property_exists_tx_power,
>                                         G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> +       { "GattServices", "ao", dev_property_get_gatt_services, NULL,
> +                                       dev_property_exists_gatt_services,
> +                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
>
>         { }
>  };
> @@ -2927,6 +2970,16 @@ static void device_remove_gatt_profile(struct btd_device *device,
>         service_remove(service);
>  }
>
> +static gboolean gatt_services_changed(gpointer user_data)
> +{
> +       struct btd_device *device = user_data;
> +
> +       g_dbus_emit_property_changed(dbus_conn, device->path, DEVICE_INTERFACE,
> +                                                               "GattServices");
> +
> +       return FALSE;
> +}
> +
>  static void gatt_service_added(struct gatt_db_attribute *attr, void *user_data)
>  {
>         struct btd_device *device = user_data;
> @@ -2971,6 +3024,8 @@ static void gatt_service_added(struct gatt_db_attribute *attr, void *user_data)
>         store_device_info(device);
>
>         btd_gatt_client_service_added(device->client_dbus, attr);

You could have just return the path on btd_gatt_client_service_added.

> +
> +       gatt_services_changed(device);
>  }
>
>  static gint prim_attr_cmp(gconstpointer a, gconstpointer b)
> @@ -3058,6 +3113,8 @@ static void gatt_service_removed(struct gatt_db_attribute *attr,
>         store_device_info(device);
>
>         btd_gatt_client_service_removed(device->client_dbus, attr);
> +
> +       gatt_services_changed(device);
>  }
>
>  static struct btd_device *device_new(struct btd_adapter *adapter,
> @@ -4147,6 +4204,19 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
>         device_accept_gatt_profiles(device);
>
>         btd_gatt_client_ready(device->client_dbus);
> +
> +       /*
> +        * Update the GattServices property. Do this asynchronously since this
> +        * should happen after the "Characteristics" and "Descriptors"
> +        * properties of all services have been asynchronously updated by
> +        * btd_gatt_client.
> +        *
> +        * Service discovery will be skipped and exported objects won't change
> +        * if the attribute cache was populated when bt_gatt_client gets
> +        * initialized, so no need to to send this signal if that's the case.
> +        */
> +       if (!device->gatt_cache_used)
> +               g_idle_add(gatt_services_changed, device);

This one I do not understand, you are already triggering
gatt_services_changed if any attribute was added/removed, why do you
need this logic here? Besides this might generate duplicate signals if
the idle callback is called after gdbus PropertiesChanged callback
which btw already happen on idle to group the changes.

>  }
>
>  static void gatt_client_service_changed(uint16_t start_handle,
> @@ -4192,6 +4262,8 @@ static void gatt_client_init(struct btd_device *device)
>                 gatt_client_cleanup(device);
>                 return;
>         }
> +
> +       device->gatt_cache_used = !gatt_db_isempty(device->db);
>  }
>
>  static void gatt_server_init(struct btd_device *device, struct gatt_db *db)
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

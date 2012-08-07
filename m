Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343194947-13659-6-git-send-email-chen.ganir@ti.com>
References: <1343194947-13659-1-git-send-email-chen.ganir@ti.com>
	<1343194947-13659-6-git-send-email-chen.ganir@ti.com>
Date: Tue, 7 Aug 2012 13:29:32 -0300
Message-ID: <CAAngNManvC8Q1Rt9qtni7txOPx24++wQqVPO+c3qmZu1oc7EMQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] Battery: Add Battery list to btd_device
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Chen Ganir <chen.ganir@ti.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 25, 2012 at 2:42 AM, Chen Ganir <chen.ganir@ti.com> wrote:
> Add peer battery list to the btd_device. New property added to Device
> called Batteries.
> ---
>  doc/device-api.txt                   |    5 +++
>  profiles/batterystate/batterystate.c |    6 ++++
>  src/device.c                         |   66 ++++++++++++++++++++++++++++++++++
>  src/device.h                         |    3 ++
>  4 files changed, 80 insertions(+)
>
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 3b84033..3d19a53 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -175,3 +175,8 @@ Properties  string Address [readonly]
>                         Note that this property can exhibit false-positives
>                         in the case of Bluetooth 2.1 (or newer) devices that
>                         have disabled Extended Inquiry Response support.
> +
> +               array{string} Batteries [readonly]
> +
> +                       List of device battery object paths that represents the available
> +                       batteries on the remote device.

This property should be deprecated by the introduction of the D-Bus
object manager (scheduled for the 5.0 release).

> diff --git a/profiles/batterystate/batterystate.c b/profiles/batterystate/batterystate.c
> index d3a1974..23dfab5 100644
> --- a/profiles/batterystate/batterystate.c
> +++ b/profiles/batterystate/batterystate.c
> @@ -50,6 +50,7 @@ struct battery {
>  static GSList *servers;
>
>  struct characteristic {
> +       char                    *path;          /* object path */
>         struct gatt_char        attr;           /* Characteristic */
>         struct battery          *batt;          /* Parent Battery Service */
>         GSList                          *desc;  /* Descriptors */
> @@ -206,6 +207,11 @@ static void configure_batterystate_cb(GSList *characteristics, guint8 status,
>                         ch->attr.value_handle = c->value_handle;
>                         memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
>                         ch->batt = batt;
> +                       ch->path = g_strdup_printf("%s/BATT%04X",
> +                                               device_get_path(batt->dev),
> +                                               c->handle);
> +

What's the reationale behind using the characteristic handle as an
identifier of the battery on the object path? Can't we do anything
better than that? I understand this avoids clashing on a device with
multiple battery services, but I don't really like the idea of
exposing this internal details as an identifier on the API. Maybe
using the battery namespace + description? It is mandatory when the
device implements more than one instance of the battery service. If
there is only one instance we don't need an identifier at all, only
BATT would be sufficient.

> +                       device_add_battery(batt->dev, ch->path);
>
>                         batt->chars = g_slist_append(batt->chars, ch);
>
> diff --git a/src/device.c b/src/device.c
> index cd571f7..98e431a 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -127,6 +127,10 @@ struct att_callbacks {
>         gpointer user_data;
>  };
>
> +struct btd_battery {
> +       char *path;
> +};
> +
>  struct btd_device {
>         bdaddr_t        bdaddr;
>         uint8_t         bdaddr_type;
> @@ -172,6 +176,7 @@ struct btd_device {
>
>         GIOChannel      *att_io;
>         guint           cleanup_id;
> +       GSList          *batteries;
>  };
>
>  static uint16_t uuid_list[] = {
> @@ -262,6 +267,7 @@ static void device_free(gpointer user_data)
>         g_slist_free_full(device->primaries, g_free);
>         g_slist_free_full(device->attios, g_free);
>         g_slist_free_full(device->attios_offline, g_free);
> +       g_slist_free_full(device->batteries, g_free);
>
>         attio_cleanup(device);
>
> @@ -433,6 +439,15 @@ static DBusMessage *get_properties(DBusConnection *conn,
>         ptr = adapter_get_path(adapter);
>         dict_append_entry(&dict, "Adapter", DBUS_TYPE_OBJECT_PATH, &ptr);
>
> +       /* Batteries */
> +       str = g_new0(char *, g_slist_length(device->batteries) + 1);
> +       for (i = 0, l = device->batteries; l; l = l->next, i++) {
> +               struct btd_battery *b = l->data;
> +               str[i] = b->path;
> +       }
> +       dict_append_array(&dict, "Batteries", DBUS_TYPE_OBJECT_PATH, &str, i);
> +       g_free(str);
> +
>         dbus_message_iter_close_container(&iter, &dict);
>
>         return reply;
> @@ -1219,6 +1234,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
>         g_slist_free(device->drivers);
>         device->drivers = NULL;
>
> +       g_slist_free(device->batteries);
> +       device->batteries = NULL;
> +
>         attrib_client_unregister(device->services);
>
>         btd_device_unref(device);
> @@ -3141,3 +3159,51 @@ void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
>         device_set_product(device, product_id);
>         device_set_version(device, product_ver);
>  }
> +
> +static void batteries_changed(struct btd_device *device)
> +{
> +       DBusConnection *conn = get_dbus_connection();
> +       char **batteries;
> +       GSList *l;
> +       int i;
> +
> +       batteries = g_new0(char *, g_slist_length(device->batteries) + 1);
> +       for (i = 0, l = device->batteries; l; l = l->next, i++) {
> +               struct btd_battery *batt = l->data;
> +               batteries[i] = batt->path;
> +       }
> +
> +       emit_array_property_changed(conn, device->path, DEVICE_INTERFACE,
> +                                       "Batteries", DBUS_TYPE_STRING, &batteries,
> +                                       i);
> +
> +       g_free(batteries);
> +}
> +
> +void device_add_battery(struct btd_device *device, char *path)
> +{
> +       struct btd_battery *batt;
> +
> +       batt = g_new0(struct btd_battery, 1);
> +       batt->path = g_strdup(path);
> +       device->batteries = g_slist_append(device->batteries, batt);
> +       batteries_changed(device);
> +}
> +
> +void device_remove_battery(struct btd_device *device, char *path)
> +{
> +       GSList *l;
> +
> +       for (l = device->batteries; l; l = l->next) {
> +               struct btd_battery *b = l->data;
> +
> +               if (g_strcmp0(path, b->path) == 0) {
> +                       device->batteries = g_slist_remove(device->batteries, b);
> +                       g_free(b->path);
> +                       g_free(b);
> +                       return;

If you return here the property changed signal will not be emitted.

> +               }
> +       }
> +
> +       batteries_changed(device);
> +}
> diff --git a/src/device.h b/src/device.h
> index 26e17f7..db71a8a 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -126,3 +126,6 @@ int device_unblock(DBusConnection *conn, struct btd_device *device,
>  void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
>                         uint16_t vendor_id, uint16_t product_id,
>                         uint16_t product_ver);
> +
> +void device_add_battery(struct btd_device *device, char *path);
> +void device_remove_battery(struct btd_device *device, char *path);
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
João Paulo Rechi Vita
Openbossa Labs - INdT

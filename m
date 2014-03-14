Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1394597040-4483-3-git-send-email-armansito@chromium.org>
References: <1394597040-4483-1-git-send-email-armansito@chromium.org>
	<1394597040-4483-3-git-send-email-armansito@chromium.org>
Date: Fri, 14 Mar 2014 11:56:07 -0400
Message-ID: <CAJdJm_Pz7wPDY7jLzfC5HSCRjwAzCOXXK7sbrcBWE8Oqs_WkfQ@mail.gmail.com>
Subject: Re: [RFC BlueZ 2/2] gatt-dbus: Add remote GATT characteristic objects.
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: armansito@chromium.org
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Mar 12, 2014 at 12:04 AM,  <armansito@chromium.org> wrote:
> From: Arman Uguray <armansito@chromium.org>
>
> This CL adds remote GATT characteristic objects to the D-Bus API. The
> API only exposes the UUID; the characteristic value and permissions have
> not yet been implemented.

Same general comments about coding style apply to this patch as well.
A few other comments below.

> ---
>  src/gatt-dbus.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 164 insertions(+), 1 deletion(-)
>
> diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
> index 60b87fa..db98137 100644
> --- a/src/gatt-dbus.c
> +++ b/src/gatt-dbus.c
> @@ -52,8 +52,24 @@
>
>  struct btd_gatt_dbus_service {
>         bt_uuid_t uuid;
> +       struct att_range range;
> +       GAttrib *attrib;
> +       guint attioid;
> +       guint request;
> +
>         struct btd_device *device;
>         char *path;
> +       GSList *characteristics;
> +};
> +
> +struct gatt_dbus_characteristic {
> +       bt_uuid_t uuid;
> +       uint8_t handle;
> +       uint8_t value_handle;

I wonder why handle/value_handle are uint8_t and not uint16_t.

> +       uint8_t properties;
> +
> +       struct btd_gatt_dbus_service *service;
> +       char *path;
>  };
>
>  struct external_app {
> @@ -491,19 +507,156 @@ static gboolean service_property_get_uuid(const GDBusPropertyTable *property,
>         return TRUE;
>  }
>
> +static gboolean characteristic_property_get_uuid(
> +               const GDBusPropertyTable *table,
> +               DBusMessageIter *iter, void *data)
> +{
> +       char uuid[MAX_LEN_UUID_STR + 1];
> +       const char *ptr = uuid;
> +       struct gatt_dbus_characteristic *chr = data;
> +
> +       bt_uuid_to_string(&chr->uuid, uuid, sizeof(uuid));
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ptr);
> +
> +       return TRUE;
> +}
> +
>  static const GDBusPropertyTable service_properties[] = {
>         { "UUID", "s", service_property_get_uuid },
>         {}
>  };
>
> +static const GDBusPropertyTable characteristic_properties[] = {
> +       { "UUID", "s", characteristic_property_get_uuid },
> +       {}
> +};
> +
> +static void unregister_characteristic(gpointer user_data)
> +{
> +       struct gatt_dbus_characteristic *chr = user_data;
> +       g_dbus_unregister_interface(btd_get_dbus_connection(),
> +                                       chr->path, GATT_CHR_IFACE);
> +}
> +
> +static void attio_cleanup(struct btd_gatt_dbus_service *service)
> +{
> +       if (!service->attrib)
> +               return;
> +       GAttrib *attrib = service->attrib;

Declaration should be in the beginning of the function.

> +       service->attrib = NULL;
> +       if (service->request) {
> +               g_attrib_cancel(attrib, service->request);
> +               service->request = 0;
> +       }
> +       g_attrib_unref(attrib);
> +}
> +
>  static void service_free(gpointer user_data)
>  {
>         struct btd_gatt_dbus_service *service = user_data;
>
> +       g_slist_free_full(service->characteristics, unregister_characteristic);
> +
> +       if (service->attioid) {
> +               btd_device_remove_attio_callback(service->device,
> +                                               service->attioid);
> +       }

As an exception to the "use kernel coding style" rule, if() blocks
with a single statement should not have brackets ({}).

> +       attio_cleanup(service);
>         g_free(service->path);
>         g_free(service);
>  }
>
> +static void characteristic_free(gpointer user_data)
> +{
> +       struct gatt_dbus_characteristic *characteristic = user_data;
> +
> +       g_free(characteristic->path);
> +       g_free(characteristic);
> +}
> +
> +static struct gatt_dbus_characteristic *characteristic_create(
> +               struct btd_gatt_dbus_service *service,
> +               struct gatt_char *chr)
> +{
> +       struct gatt_dbus_characteristic *characteristic;
> +       bt_uuid_t uuid;
> +
> +       DBG("GATT characteristic UUID: %s", chr->uuid);
> +
> +       characteristic = g_try_malloc0(sizeof(struct gatt_dbus_characteristic));

We usually use g_new0() or g_try_new0() for structs.

> +       if (characteristic == NULL)
> +               return NULL;
> +
> +       characteristic->path = g_strdup_printf("%s/char%04X", service->path,
> +                                               chr->handle);
> +       characteristic->service = service;
> +       characteristic->handle = chr->handle;
> +       characteristic->value_handle = chr->value_handle;
> +       characteristic->properties = chr->properties;
> +
> +       if (bt_string_to_uuid(&uuid, chr->uuid)) {
> +               error("Characteristic has invalid UUID: %s", chr->uuid);
> +               goto fail;
> +       }
> +
> +       bt_uuid_to_uuid128(&uuid, &characteristic->uuid);
> +
> +       DBG("Creating GATT characteristic %s", characteristic->path);
> +
> +       if (g_dbus_register_interface(btd_get_dbus_connection(),
> +                                       characteristic->path,
> +                                       GATT_CHR_IFACE, NULL, NULL,
> +                                       characteristic_properties,
> +                                       characteristic,
> +                                       characteristic_free) == FALSE) {
> +               error("Unable to register GATT characteristic: %s", chr->uuid);
> +               goto fail;
> +       }
> +
> +       return characteristic;
> +
> +fail:
> +       characteristic_free(characteristic);
> +       return NULL;
> +}
> +
> +static void discover_char_cb(uint8_t status, GSList *chars, void *user_data)
> +{
> +       struct btd_gatt_dbus_service *service = user_data;

Add an empty line after variable declaration (at least for function level ones).

> +       service->request = 0;
> +       if (status) {
> +               error("Characteristic discovery failed.");
> +               return;
> +       }
> +       for (; chars; chars = chars->next) {
> +               struct gatt_char *chr = chars->data;
> +               struct gatt_dbus_characteristic *dbus_chr =
> +                               characteristic_create(service, chr);
> +               if (dbus_chr == NULL)
> +                       continue;
> +               service->characteristics = g_slist_append(
> +                               service->characteristics, dbus_chr);
> +       }
> +       attio_cleanup(service);
> +}
> +
> +static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
> +{
> +       struct btd_gatt_dbus_service *service = user_data;

Same as above.

> +       service->attrib = g_attrib_ref(attrib);
> +       service->request = gatt_discover_char(service->attrib,
> +                       service->range.start,
> +                       service->range.end,
> +                       NULL, discover_char_cb,
> +                       service);
> +}
> +
> +static void attio_disconnected_cb(gpointer user_data)
> +{
> +       struct btd_gatt_dbus_service *service = user_data;
> +       attio_cleanup(service);
> +}
> +
>  struct btd_gatt_dbus_service *btd_gatt_dbus_service_create(
>                 struct btd_device *device, struct gatt_primary *primary)
>  {
> @@ -520,6 +673,12 @@ struct btd_gatt_dbus_service *btd_gatt_dbus_service_create(
>         service->path = g_strdup_printf("%s/service%04X", device_path,
>                                         primary->range.start);
>
> +       service->device = device;
> +       service->range = primary->range;
> +       service->characteristics = NULL;
> +       service->attrib = NULL;
> +       service->request = 0;

If you use g_try_new0(), there is no need to initialize pointers to
NULL or integers to 0.

> +
>         if (bt_string_to_uuid(&uuid, primary->uuid)) {
>                 error("Primary has invalid UUID: %s", primary->uuid);
>                 goto fail;
> @@ -541,7 +700,11 @@ struct btd_gatt_dbus_service *btd_gatt_dbus_service_create(
>                 goto fail;
>         }
>
> -       service->device = device;
> +       service->attioid = service->attioid = btd_device_add_attio_callback(
> +                       service->device,
> +                       attio_connected_cb,
> +                       attio_disconnected_cb, service);
> +
>         return service;
>
>  fail:

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1445537368-4764-1-git-send-email-jpawlowski@google.com>
References: <1445537368-4764-1-git-send-email-jpawlowski@google.com>
Date: Mon, 26 Oct 2015 10:56:10 +0200
Message-ID: <CABBYNZL4m6OL63FrAdj6fVS1CV4_k-NZkzL3JQszgmKGZKJWVQ@mail.gmail.com>
Subject: Re: [PATCH v2] profiles/deviceinfo: rewrite deviceinfo profile
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, Oct 22, 2015 at 9:09 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> This patch include new version of deviceinfo profile. It is now
> not triggering autoconnect. It's also using accept callback instead
> of btd_device_add_attio_callback.
> ---
>  profiles/deviceinfo/deviceinfo.c | 217 +++++++++++++++++++++++----------------
>  1 file changed, 131 insertions(+), 86 deletions(-)
>
> diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
> index 6ee018c..e930f9d 100644
> --- a/profiles/deviceinfo/deviceinfo.c
> +++ b/profiles/deviceinfo/deviceinfo.c
> @@ -3,6 +3,7 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2012 Texas Instruments, Inc.
> + *  Copyright (C) 2015 Google Inc.
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License as published by
> @@ -38,160 +39,204 @@
>  #include "src/device.h"
>  #include "src/profile.h"
>  #include "src/service.h"
> -#include "src/shared/util.h"
>  #include "attrib/gattrib.h"
> -#include "src/attio.h"
> +#include "src/shared/util.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/gatt-db.h"
> +#include "src/shared/gatt-client.h"
>  #include "attrib/att.h"
> -#include "attrib/gatt.h"
>  #include "src/log.h"
>
>  #define PNP_ID_SIZE    7
>
>  struct deviceinfo {
> -       struct btd_device       *dev;           /* Device reference */
> -       GAttrib                 *attrib;        /* GATT connection */
> -       guint                   attioid;        /* Att watcher id */
> -       struct att_range        *svc_range;     /* DeviceInfo range */
> -       GSList                  *chars;         /* Characteristics */
> +       struct btd_device *device;
> +       struct gatt_db *db;
> +       struct bt_gatt_client *client;
> +       struct gatt_db_attribute *attr;
>  };
>
> -struct characteristic {
> -       struct gatt_char        attr;   /* Characteristic */
> -       struct deviceinfo       *d;     /* deviceinfo where the char belongs */
> -};
> +static GSList *devices;
>
> -static void deviceinfo_driver_remove(struct btd_service *service)
> +static void deviceinfo_free(struct deviceinfo *d)
>  {
> -       struct deviceinfo *d = btd_service_get_user_data(service);
> -
> -       if (d->attioid > 0)
> -               btd_device_remove_attio_callback(d->dev, d->attioid);
> -
> -       if (d->attrib != NULL)
> -               g_attrib_unref(d->attrib);
> +       gatt_db_unref(d->db);
> +       bt_gatt_client_unref(d->client);
> +       btd_device_unref(d->device);
> +       g_free(d);
> +};
>
> -       g_slist_free_full(d->chars, g_free);
> +static int cmp_device(gconstpointer a, gconstpointer b)
> +{
> +       const struct deviceinfo *d = a;
> +       const struct btd_device *device = b;
>
> -       btd_device_unref(d->dev);
> -       g_free(d->svc_range);
> -       g_free(d);
> +       return d->device == device ? 0 : -1;
>  }
>
> -static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
> -                                                       gpointer user_data)
> +static void read_pnpid_cb(bool success, uint8_t att_ecode, const uint8_t *value,
> +                                       uint16_t length, void *user_data)
>  {
> -       struct characteristic *ch = user_data;
> -       uint8_t value[PNP_ID_SIZE];
> -       ssize_t vlen;
> -
> -       if (status != 0) {
> -               error("Error reading PNP_ID value: %s", att_ecode2str(status));
> -               return;
> -       }
> +       struct deviceinfo *d = user_data;
>
> -       vlen = dec_read_resp(pdu, len, value, sizeof(value));
> -       if (vlen < 0) {
> -               error("Error reading PNP_ID: Protocol error");
> +       if (!success) {
> +               error("Error reading PNP_ID value: %s",
> +                                               att_ecode2str(att_ecode));
>                 return;
>         }
>
> -       if (vlen < 7) {
> +       if (length < PNP_ID_SIZE) {
>                 error("Error reading PNP_ID: Invalid pdu length received");
>                 return;
>         }
>
> -       btd_device_set_pnpid(ch->d->dev, value[0], get_le16(&value[1]),
> +       btd_device_set_pnpid(d->device, value[0], get_le16(&value[1]),
>                                 get_le16(&value[3]), get_le16(&value[5]));
>  }
>
> -static void process_deviceinfo_char(struct characteristic *ch)
> +static void handle_pnpid(struct deviceinfo *d, uint16_t value_handle)
>  {
> -       if (g_strcmp0(ch->attr.uuid, PNPID_UUID) == 0)
> -               gatt_read_char(ch->d->attrib, ch->attr.value_handle,
> -                                                       read_pnpid_cb, ch);
> +       if (!bt_gatt_client_read_value(d->client, value_handle,
> +                                               read_pnpid_cb, d, NULL))
> +               DBG("Failed to send request to read pnpid");
>  }
>
> -static void configure_deviceinfo_cb(uint8_t status, GSList *characteristics,
> +static void handle_characteristic(struct gatt_db_attribute *attr,
>                                                                 void *user_data)
>  {
>         struct deviceinfo *d = user_data;
> -       GSList *l;
> +       uint16_t value_handle;
> +       bt_uuid_t uuid, pnpid_uuid;
> +
> +       bt_string_to_uuid(&pnpid_uuid, PNPID_UUID);
>
> -       if (status != 0) {
> -               error("Discover deviceinfo characteristics: %s",
> -                                                       att_ecode2str(status));
> +       if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NULL,
> +                                                               &uuid)) {
> +               error("Failed to obtain characteristic data");
>                 return;
>         }
>
> -       for (l = characteristics; l; l = l->next) {
> -               struct gatt_char *c = l->data;
> -               struct characteristic *ch;
> -
> -               ch = g_new0(struct characteristic, 1);
> -               ch->attr.handle = c->handle;
> -               ch->attr.properties = c->properties;
> -               ch->attr.value_handle = c->value_handle;
> -               memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
> -               ch->d = d;
> -
> -               d->chars = g_slist_append(d->chars, ch);
> +       if (bt_uuid_cmp(&pnpid_uuid, &uuid) == 0)
> +               handle_pnpid(d, value_handle);
> +       else {
> +               char uuid_str[MAX_LEN_UUID_STR];
>
> -               process_deviceinfo_char(ch);
> +               bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> +               DBG("Unsupported characteristic: %s", uuid_str);
>         }
>  }
> -static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
> -{
> -       struct deviceinfo *d = user_data;
> -
> -       d->attrib = g_attrib_ref(attrib);
>
> -       gatt_discover_char(d->attrib, d->svc_range->start, d->svc_range->end,
> -                                       NULL, configure_deviceinfo_cb, d);
> +static void handle_deviceinfo_service(struct deviceinfo *d)
> +{
> +       gatt_db_service_foreach_char(d->attr, handle_characteristic, d);
>  }
>
> -static void attio_disconnected_cb(gpointer user_data)
> +static void foreach_deviceinfo_service(struct gatt_db_attribute *attr,
> +                                                               void *user_data)
>  {
>         struct deviceinfo *d = user_data;
>
> -       g_attrib_unref(d->attrib);
> -       d->attrib = NULL;
> +       if (d->attr) {
> +               error("More than one deviceinfo service exists for this device");
> +               return;
> +       }
> +
> +       d->attr = attr;
> +       handle_deviceinfo_service(d);
>  }
>
> -static int deviceinfo_register(struct btd_service *service,
> -                                               struct gatt_primary *prim)
> +static int deviceinfo_driver_probe(struct btd_service *service)
>  {
>         struct btd_device *device = btd_service_get_device(service);
>         struct deviceinfo *d;
> +       GSList *l;
> +       char addr[18];
> +
> +       ba2str(device_get_address(device), addr);
> +       DBG("deviceinfo profile probe (%s)", addr);
> +
> +       /* Ignore, if we were probed for this device already */
> +       l = g_slist_find_custom(devices, device, cmp_device);
> +       if (l) {
> +               error("Profile probed twice for the same device!");
> +               return -1;
> +       }
>
>         d = g_new0(struct deviceinfo, 1);
> -       d->dev = btd_device_ref(device);
> -       d->svc_range = g_new0(struct att_range, 1);
> -       d->svc_range->start = prim->range.start;
> -       d->svc_range->end = prim->range.end;
> +       if (!d)
> +               return -1;
>
> -       btd_service_set_user_data(service, d);
> +       d->device = btd_device_ref(device);
> +       devices = g_slist_append(devices, d);
>
> -       d->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
> -                                               attio_disconnected_cb, d);
>         return 0;
>  }
>
> -static int deviceinfo_driver_probe(struct btd_service *service)
> +static void deviceinfo_driver_remove(struct btd_service *service)
>  {
>         struct btd_device *device = btd_service_get_device(service);
> -       struct gatt_primary *prim;
> +       struct deviceinfo *d;
> +       GSList *l;
> +       char addr[18];
>
> -       prim = btd_device_get_primary(device, DEVICE_INFORMATION_UUID);
> -       if (prim == NULL)
> -               return -EINVAL;
> +       ba2str(device_get_address(device), addr);
> +       DBG("deviceinfo profile remove (%s)", addr);
>
> -       return deviceinfo_register(service, prim);
> +       l = g_slist_find_custom(devices, device, cmp_device);
> +       if (!l) {
> +               error("deviceinfo service not handled by profile");
> +               return;
> +       }
> +
> +       d = l->data;
> +
> +       devices = g_slist_remove(devices, d);
> +       deviceinfo_free(d);
>  }
>
> +static int deviceinfo_accept(struct btd_service *service)
> +{
> +       struct btd_device *device = btd_service_get_device(service);
> +       struct gatt_db *db = btd_device_get_gatt_db(device);
> +       struct bt_gatt_client *client = btd_device_get_gatt_client(device);
> +       struct deviceinfo *d;
> +       GSList *l;
> +       char addr[18];
> +       bt_uuid_t deviceinfo_uuid;
> +
> +       ba2str(device_get_address(device), addr);
> +       DBG("deviceinfo profile accept (%s)", addr);
> +
> +       l = g_slist_find_custom(devices, device, cmp_device);
> +       if (!l) {
> +               error("deviceinfo service not handled by profile");
> +               return -1;
> +       }
> +
> +       d = l->data;
> +
> +       /* Clean-up any old client/db and acquire the new ones */
> +       d->attr = NULL;
> +       gatt_db_unref(d->db);
> +       bt_gatt_client_unref(d->client);
> +
> +       d->db = gatt_db_ref(db);
> +       d->client = bt_gatt_client_ref(client);
> +
> +       /* Handle the device info service */
> +       bt_string_to_uuid(&deviceinfo_uuid, DEVICE_INFORMATION_UUID);
> +       gatt_db_foreach_service(db, &deviceinfo_uuid,
> +                                               foreach_deviceinfo_service, d);
> +
> +       return 0;
> +}
> +
> +
>  static struct btd_profile deviceinfo_profile = {
>         .name           = "deviceinfo",
>         .remote_uuid    = DEVICE_INFORMATION_UUID,
>         .external       = true,
> +       .accept         = deviceinfo_accept,
>         .device_probe   = deviceinfo_driver_probe,
>         .device_remove  = deviceinfo_driver_remove
>  };
> --
> 2.5.0

Applied, thanks.


-- 
Luiz Augusto von Dentz

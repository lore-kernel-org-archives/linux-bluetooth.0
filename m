Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418782038-10999-8-git-send-email-armansito@chromium.org>
References: <1418782038-10999-1-git-send-email-armansito@chromium.org>
	<1418782038-10999-8-git-send-email-armansito@chromium.org>
Date: Wed, 17 Dec 2014 14:57:32 +0200
Message-ID: <CABBYNZJxK+cqZQq1kAb0_11qPACcXxJQXEtajw82VJZLovGcuA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 07/10] core: device: Make profile calls in GATT events
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Dec 17, 2014 at 4:07 AM, Arman Uguray <armansito@chromium.org> wrote:
> This patch correctly integrates all profile calls into the various GATT
> client events (ready, service-added, service-removed) so that profiles
> can perform the necessary updates. The major changes introduced in this
> this patch are:
>
>   1. Added new profile probe/remove functions for GATT services, which
>      operate on a btd_device's client db and initialize btd_service
>      instances with start & end handles:
>         - device_probe_gatt_profiles
>         - device_probe_gatt_profile
>         - device_remove_gatt_profile
>         - device_accept_gatt_profiles
>
>   2. device_probe_gatt_profiles is called when the gatt-client becomes
>      ready. Profiles are then notified with the "accept" call.
>
>   3. device_probe_gatt_profile is called when a new GATT service is
>      added to the db.
>
>   4. device_remove_gatt_profile is called when a GATT service is removed
>      from the db.
>
>   5. Profiles are notified that the gatt-client is ready via the
>      btd_service "accept" function on a per-service basis. Currently this
>      is always called immediately after a probe.

After probe? I thought the idea was to indicate that a connection
becomes available, if it is called after probe that means it is called
just once?

> ---
>  src/device.c | 261 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 212 insertions(+), 49 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 854d9f3..6242c76 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -292,6 +292,27 @@ static GSList *find_service_with_state(GSList *list,
>         return NULL;
>  }
>
> +static GSList *find_service_with_gatt_handles(GSList *list,
> +                                                       uint16_t start_handle,
> +                                                       uint16_t end_handle)
> +{
> +       GSList *l;
> +       uint16_t svc_start, svc_end;
> +
> +       for (l = list; l != NULL; l = g_slist_next(l)) {
> +               struct btd_service *service = l->data;
> +
> +               if (!btd_service_get_gatt_handles(service, &svc_start,
> +                                                               &svc_end))
> +                       continue;
> +
> +               if (svc_start == start_handle && svc_end == end_handle)
> +                       return l;
> +       }
> +
> +       return NULL;
> +}
> +
>  static void update_technologies(GKeyFile *file, struct btd_device *dev)
>  {
>         const char *list[2];
> @@ -2390,15 +2411,168 @@ static void add_primary(struct gatt_db_attribute *attr, void *user_data)
>         *new_services = g_slist_append(*new_services, prim);
>  }
>
> +static void device_add_uuids(struct btd_device *device, GSList *uuids)
> +{
> +       GSList *l;
> +
> +       for (l = uuids; l != NULL; l = g_slist_next(l)) {
> +               GSList *match = g_slist_find_custom(device->uuids, l->data,
> +                                                       bt_uuid_strcmp);
> +               if (match)
> +                       continue;
> +
> +               device->uuids = g_slist_insert_sorted(device->uuids,
> +                                               g_strdup(l->data),
> +                                               bt_uuid_strcmp);
> +       }
> +
> +       g_dbus_emit_property_changed(dbus_conn, device->path,
> +                                               DEVICE_INTERFACE, "UUIDs");
> +}
> +
>  static void store_services(struct btd_device *device);
>
> +struct gatt_probe_data {
> +       struct btd_device *dev;
> +       bool add_uuid_to_device;
> +       GSList *uuids;
> +       struct gatt_db_attribute *cur_attr;
> +       char cur_uuid[MAX_LEN_UUID_STR];
> +       uint16_t start_handle, end_handle;
> +};
> +
> +static bool device_match_profile(struct btd_device *device,
> +                                       struct btd_profile *profile,
> +                                       GSList *uuids)
> +{
> +       if (profile->remote_uuid == NULL)
> +               return false;
> +
> +       if (g_slist_find_custom(uuids, profile->remote_uuid,
> +                                                       bt_uuid_strcmp) == NULL)
> +               return false;
> +
> +       return true;
> +}
> +
> +static void dev_probe_gatt(struct btd_profile *p, void *user_data)
> +{
> +       struct gatt_probe_data *data = user_data;
> +       struct btd_service *service;
> +
> +       if (p->device_probe == NULL)
> +               return;
> +
> +       if (!device_match_profile(data->dev, p, g_slist_last(data->uuids)))
> +               return;

Using g_slist_last is not very smart since afaik GSList has to iterate
to to access the last.

> +
> +       service = service_create_gatt(data->dev, p, data->start_handle,
> +                                                       data->end_handle);
> +       if (!service)
> +               return;
> +
> +       if (service_probe(service) < 0) {
> +               btd_service_unref(service);
> +               return;
> +       }
> +
> +       data->dev->services = g_slist_append(data->dev->services, service);
> +}
> +
> +static void dev_probe_gatt_profile(struct gatt_db_attribute *attr,
> +                                                       void *user_data)
> +{
> +       struct gatt_probe_data *data = user_data;
> +       bt_uuid_t uuid;
> +       GSList *l;
> +
> +       gatt_db_attribute_get_service_data(attr, &data->start_handle,
> +                                                       &data->end_handle, NULL,
> +                                                       &uuid);
> +       bt_uuid_to_string(&uuid, data->cur_uuid, sizeof(data->cur_uuid));
> +
> +       data->uuids = g_slist_append(data->uuids, g_strdup(data->cur_uuid));

If the order in the list is not really important than use prepend and
g_slist_first in dev_probe_gatt, actually do we even need this list
since we are adding one by one the UUIDs?

> +       data->cur_attr = attr;
> +
> +       btd_profile_foreach(dev_probe_gatt, data);
> +
> +       if (!data->add_uuid_to_device)
> +               return;
> +
> +       l = g_slist_append(l, g_strdup(data->cur_uuid));
> +       device_add_uuids(data->dev, l);
> +}
> +
> +static void device_probe_gatt_profile(struct btd_device *device,
> +                                               struct gatt_db_attribute *attr)
> +{
> +       struct gatt_probe_data data;
> +
> +       memset(&data, 0, sizeof(data));
> +
> +       data.dev = device;
> +       data.add_uuid_to_device = true;
> +
> +       dev_probe_gatt_profile(attr, &data);
> +       g_slist_free_full(data.uuids, g_free);
> +}
> +
> +static void device_probe_gatt_profiles(struct btd_device *device)
> +{
> +       struct gatt_probe_data data;
> +       char addr[18];
> +
> +       ba2str(&device->bdaddr, addr);
> +
> +       if (device->blocked) {
> +               DBG("Skipping profiles for blocked device %s", addr);
> +               return;
> +       }
> +
> +       memset(&data, 0, sizeof(data));
> +
> +       data.dev = device;
> +
> +       gatt_db_foreach_service(device->db, NULL, dev_probe_gatt_profile,
> +                                                                       &data);
> +       device_add_uuids(device, data.uuids);
> +       g_slist_free_full(data.uuids, g_free);
> +}
> +
> +static void device_accept_gatt_profiles(struct btd_device *device)
> +{
> +       GSList *l;
> +
> +       for (l = device->services; l != NULL; l = g_slist_next(l))
> +               service_accept(l->data);
> +}
> +
> +static void device_remove_gatt_profile(struct btd_device *device,
> +                                               struct gatt_db_attribute *attr)
> +{
> +       uint16_t start, end;
> +       struct btd_service *service;
> +       GSList *l;
> +
> +       gatt_db_attribute_get_service_handles(attr, &start, &end);
> +
> +       l = find_service_with_gatt_handles(device->services, start, end);
> +       if (!l)
> +               return;
> +
> +       service = l->data;
> +       device->services = g_slist_delete_link(device->services, l);
> +       device->pending = g_slist_remove(device->pending, service);
> +       service_remove(service);
> +}
> +
>  static void gatt_service_added(struct gatt_db_attribute *attr, void *user_data)
>  {
>         struct btd_device *device = user_data;
> -       struct gatt_primary *prim;
>         GSList *new_service = NULL;
> -       GSList *profiles_added = NULL;
>         uint16_t start, end;
> +       GSList *l;
>
>         if (!bt_gatt_client_is_ready(device->client))
>                 return;
> @@ -2417,14 +2591,13 @@ static void gatt_service_added(struct gatt_db_attribute *attr, void *user_data)
>
>         device_register_primaries(device, new_service, -1);
>
> -       prim = new_service->data;
> -       profiles_added = g_slist_append(profiles_added, g_strdup(prim->uuid));
> +       device_probe_gatt_profile(device, attr);
>
> -       device_probe_profiles(device, profiles_added);
> +       l = find_service_with_gatt_handles(device->services, start, end);
> +       if (l)
> +               service_accept(l->data);
>
>         store_services(device);
> -
> -       g_slist_free_full(profiles_added, g_free);
>  }
>
>  static gint prim_attr_cmp(gconstpointer a, gconstpointer b)
> @@ -2438,6 +2611,14 @@ static gint prim_attr_cmp(gconstpointer a, gconstpointer b)
>         return !(prim->range.start == start && prim->range.end == end);
>  }
>
> +static gint prim_uuid_cmp(gconstpointer a, gconstpointer b)
> +{
> +       const struct gatt_primary *prim = a;
> +       const char *uuid = b;
> +
> +       return bt_uuid_strcmp(prim->uuid, uuid);
> +}
> +
>  static void gatt_service_removed(struct gatt_db_attribute *attr,
>                                                                 void *user_data)
>  {
> @@ -2461,20 +2642,24 @@ static void gatt_service_removed(struct gatt_db_attribute *attr,
>         prim = l->data;
>         device->primaries = g_slist_delete_link(device->primaries, l);
>
> -       /* Remove the corresponding UUIDs entry */
> -       l = g_slist_find_custom(device->uuids, prim->uuid, bt_uuid_strcmp);
> -       device->uuids = g_slist_delete_link(device->uuids, l);
> -       g_free(prim);
> -
> -       store_services(device);
> +       device_remove_gatt_profile(device, attr);
>
>         /*
> -        * TODO: Notify the profiles somehow. It may be sufficient for each
> -        * profile to register a service_removed handler.
> +        * Remove the corresponding UUIDs entry, only if this is the last
> +        * service with this UUID.
>          */
> +       l = g_slist_find_custom(device->uuids, prim->uuid, bt_uuid_strcmp);
>
> -       g_dbus_emit_property_changed(dbus_conn, device->path,
> +       if (!g_slist_find_custom(device->primaries, prim->uuid,
> +                                                       prim_uuid_cmp)) {
> +               device->uuids = g_slist_delete_link(device->uuids, l);
> +               g_dbus_emit_property_changed(dbus_conn, device->path,
>                                                 DEVICE_INTERFACE, "UUIDs");
> +       }
> +
> +       g_free(prim);
> +
> +       store_services(device);
>  }
>
>  static struct btd_device *device_new(struct btd_adapter *adapter,
> @@ -2975,20 +3160,6 @@ GSList *btd_device_get_uuids(struct btd_device *device)
>         return device->uuids;
>  }
>
> -static bool device_match_profile(struct btd_device *device,
> -                                       struct btd_profile *profile,
> -                                       GSList *uuids)
> -{
> -       if (profile->remote_uuid == NULL)
> -               return false;
> -
> -       if (g_slist_find_custom(uuids, profile->remote_uuid,
> -                                                       bt_uuid_strcmp) == NULL)
> -               return false;
> -
> -       return true;
> -}
> -
>  struct probe_data {
>         struct btd_device *dev;
>         GSList *uuids;
> @@ -3065,7 +3236,6 @@ void device_remove_profile(gpointer a, gpointer b)
>  void device_probe_profiles(struct btd_device *device, GSList *uuids)
>  {
>         struct probe_data d = { device, uuids };
> -       GSList *l;
>         char addr[18];
>
>         ba2str(&device->bdaddr, addr);
> @@ -3080,19 +3250,7 @@ void device_probe_profiles(struct btd_device *device, GSList *uuids)
>         btd_profile_foreach(dev_probe, &d);
>
>  add_uuids:
> -       for (l = uuids; l != NULL; l = g_slist_next(l)) {
> -               GSList *match = g_slist_find_custom(device->uuids, l->data,
> -                                                       bt_uuid_strcmp);
> -               if (match)
> -                       continue;
> -
> -               device->uuids = g_slist_insert_sorted(device->uuids,
> -                                               g_strdup(l->data),
> -                                               bt_uuid_strcmp);
> -       }
> -
> -       g_dbus_emit_property_changed(dbus_conn, device->path,
> -                                               DEVICE_INTERFACE, "UUIDs");
> +       device_add_uuids(device, uuids);
>  }
>
>  static void store_sdp_record(GKeyFile *key_file, sdp_record_t *rec)
> @@ -3412,6 +3570,13 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
>         if (primaries)
>                 device_register_primaries(device, primaries, ATT_PSM);
>
> +       /*
> +        * TODO: The btd_service instances for GATT services need to be
> +        * initialized with the service handles. Eventually this code should
> +        * perform ATT protocol service discovery over the ATT PSM to obtain
> +        * the full list of services and populate a client-role gatt_db over
> +        * BR/EDR.
> +        */
>         device_probe_profiles(device, req->profiles_added);
>
>         /* Propagate services changes */
> @@ -3640,7 +3805,7 @@ static void register_gatt_services(struct browse_req *req)
>
>         device_register_primaries(device, services, -1);
>
> -       device_probe_profiles(device, req->profiles_added);
> +       device_probe_gatt_profiles(device);
>
>         device_svc_resolved(device, device->bdaddr_type, 0);
>
> @@ -3675,10 +3840,8 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
>         if (device->browse)
>                 register_gatt_services(device->browse);
>
> -       /*
> -        * TODO: Change attio callbacks to accept a gatt-client instead of a
> -        * GAttrib.
> -        */
> +       device_accept_gatt_profiles(device);
> +
>         g_slist_foreach(device->attios, attio_connected, device->attrib);
>  }
>
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

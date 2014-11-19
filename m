Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416252138-17477-7-git-send-email-armansito@chromium.org>
References: <1416252138-17477-1-git-send-email-armansito@chromium.org>
	<1416252138-17477-7-git-send-email-armansito@chromium.org>
Date: Wed, 19 Nov 2014 17:43:50 +0200
Message-ID: <CABBYNZL7hvzYjM4drdufenYTzos9qxg-5=7c+CNeGzw-n0k0nA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 06/12] core: device: Use shared/gatt-client for GATT.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Nov 17, 2014 at 9:22 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch changes the GATT service discovery code path with the
> following:
>    - As part for device_attach_attrib, a bt_gatt_client structure is
>    created that performs MTU exchange and service discovery, caches the
>    services in an internal list, and handles the remote GATT service.
>
>    - The device_browse_primary code path obtains service information
>    by iterating through bt_gatt_client's services, instead of directly
>    initiating primary and secondary service discovery using attrib/gatt.
>    If the bt_gatt_client isn't ready at the time, the code defers
>    registration of services and profile probing until the ready handler
>    is called.
>
>    - The attio connected callbacks are invoked from bt_gatt_client's
>    ready handler instead of device_attach_attrib.
> ---

I would suggest that before we start changing the core we make sure we
have completed the TODO items for bt_gatt_client/bt_gatt_server, there
are items such as gatt-client + gatt-server coexistence that haven't
been tested  and I also remember that we had some ideas about a new
object that would take care of both client and server under it, the
caching probably needs to be addressed as well otherwise
bt_gatt_client will always end up discovering the service in every
connection.


>  src/device.c           | 286 ++++++++++++++++++++++++++-----------------------
>  src/device.h           |   2 -
>  src/shared/att-types.h |   3 +-
>  3 files changed, 152 insertions(+), 139 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 45c7e9c..3d0159e 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -74,6 +74,10 @@
>  #define DISCONNECT_TIMER       2
>  #define DISCOVERY_TIMER                1
>
> +#ifndef MIN
> +#define MIN(a, b) ((a) < (b) ? (a) : (b))
> +#endif
> +
>  static DBusConnection *dbus_conn = NULL;
>  unsigned service_state_cb_id;
>
> @@ -205,9 +209,12 @@ struct btd_device {
>         GSList          *attios_offline;
>         guint           attachid;               /* Attrib server attach */
>
> -       struct bt_att *att;     /* The new ATT transport */
> +       struct bt_att *att;                     /* The new ATT transport */
> +       uint16_t att_mtu;                       /* The ATT MTU */
>         unsigned int att_disconn_id;
>
> +       struct bt_gatt_client *gatt_client;     /* GATT client cache */
> +
>         struct bearer_state bredr_state;
>         struct bearer_state le_state;
>
> @@ -463,6 +470,18 @@ static void browse_request_free(struct browse_req *req)
>         g_free(req);
>  }
>
> +static void gatt_client_cleanup(struct btd_device *device)
> +{
> +       if (!device->gatt_client)
> +               return;
> +
> +       bt_gatt_client_set_service_changed(device->gatt_client, NULL, NULL,
> +                                                                       NULL);
> +       bt_gatt_client_set_ready_handler(device->gatt_client, NULL, NULL, NULL);
> +       bt_gatt_client_unref(device->gatt_client);
> +       device->gatt_client = NULL;
> +}
> +
>  static void attio_cleanup(struct btd_device *device)
>  {
>         if (device->attachid) {
> @@ -480,6 +499,8 @@ static void attio_cleanup(struct btd_device *device)
>                 device->att_io = NULL;
>         }
>
> +       gatt_client_cleanup(device);
> +
>         if (device->att) {
>                 bt_att_unref(device->att);
>                 device->att = NULL;
> @@ -3445,41 +3466,6 @@ done:
>         attio_cleanup(device);
>  }
>
> -static void register_all_services(struct browse_req *req, GSList *services)
> -{
> -       struct btd_device *device = req->device;
> -
> -       btd_device_set_temporary(device, FALSE);
> -
> -       update_gatt_services(req, device->primaries, services);
> -       g_slist_free_full(device->primaries, g_free);
> -       device->primaries = NULL;
> -
> -       device_register_primaries(device, services, -1);
> -
> -       device_probe_profiles(device, req->profiles_added);
> -
> -       if (device->attios == NULL && device->attios_offline == NULL)
> -               attio_cleanup(device);
> -
> -       g_dbus_emit_property_changed(dbus_conn, device->path,
> -                                               DEVICE_INTERFACE, "UUIDs");
> -
> -       device_svc_resolved(device, device->bdaddr_type, 0);
> -
> -       store_services(device);
> -
> -       browse_request_free(req);
> -}
> -
> -static int service_by_range_cmp(gconstpointer a, gconstpointer b)
> -{
> -       const struct gatt_primary *prim = a;
> -       const struct att_range *range = b;
> -
> -       return memcmp(&prim->range, range, sizeof(*range));
> -}
> -
>  static void send_le_browse_response(struct browse_req *req)
>  {
>         struct btd_device *dev = req->device;
> @@ -3510,122 +3496,152 @@ static void send_le_browse_response(struct browse_req *req)
>         g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
>  }
>
> -static void find_included_cb(uint8_t status, GSList *includes, void *user_data)
> +/*
> + * TODO: Remove this function once btd_device stops storing gatt_primary
> + * structures for discovered services.
> + */
> +static bool populate_primaries(struct btd_device *device, GSList **services)
>  {
> -       struct included_search *search = user_data;
> -       struct btd_device *device = search->req->device;
> +       struct bt_gatt_service_iter iter;
> +       const bt_gatt_service_t *service;
>         struct gatt_primary *prim;
> -       GSList *l;
> +       uint128_t u128;
> +       bt_uuid_t uuid;
>
> -       DBG("status %u", status);
> +       /* Create gatt_primary structures for all primary/secondary services */
> +       if (!bt_gatt_service_iter_init(&iter, device->gatt_client))
> +               return false;
>
> -       if (device->attrib == NULL || status) {
> -               struct browse_req *req = device->browse;
> +       while (bt_gatt_service_iter_next(&iter, &service)) {
> +               prim = g_new0(struct gatt_primary, 1);
> +               prim->range.start = service->start_handle;
> +               prim->range.end = service->end_handle;
>
> -               if (status)
> -                       error("Find included services failed: %s (%d)",
> -                                       att_ecode2str(status), status);
> -               else
> -                       error("Disconnected while doing included discovery");
> +               memcpy(u128.data, service->uuid, 16);
> +               bt_uuid128_create(&uuid, u128);
> +               bt_uuid_to_string(&uuid, prim->uuid, MAX_LEN_UUID_STR + 1);
>
> -               if (!req)
> -                       goto complete;
> +               *services = g_slist_append(*services, prim);
> +       }
>
> +       return true;
> +}
> +
> +static void register_gatt_services(struct browse_req *req)
> +{
> +       struct btd_device *device = req->device;
> +       GSList *services = NULL;
> +
> +       if (!bt_gatt_client_is_ready(device->gatt_client))
> +               return;
> +
> +       if (!populate_primaries(device, &services)) {
>                 send_le_browse_response(req);
>                 device->browse = NULL;
>                 browse_request_free(req);
> -
> -               goto complete;
> +               return;
>         }
>
> -       if (includes == NULL)
> -               goto next;
> +       btd_device_set_temporary(device, FALSE);
>
> -       for (l = includes; l; l = l->next) {
> -               struct gatt_included *incl = l->data;
> +       update_gatt_services(req, device->primaries, services);
> +       g_slist_free_full(device->primaries, g_free);
> +       device->primaries = NULL;
>
> -               if (g_slist_find_custom(search->services, &incl->range,
> -                                               service_by_range_cmp))
> -                       continue;
> +       device_register_primaries(device, services, -1);
>
> -               prim = g_new0(struct gatt_primary, 1);
> -               memcpy(prim->uuid, incl->uuid, sizeof(prim->uuid));
> -               memcpy(&prim->range, &incl->range, sizeof(prim->range));
> +       device_probe_profiles(device, req->profiles_added);
>
> -               search->services = g_slist_append(search->services, prim);
> -       }
> +       if (device->attios == NULL && device->attios_offline == NULL)
> +               attio_cleanup(device);
>
> -next:
> -       search->current = search->current->next;
> -       if (search->current == NULL) {
> -               register_all_services(search->req, search->services);
> -               search->services = NULL;
> -               goto complete;
> -       }
> +       g_dbus_emit_property_changed(dbus_conn, device->path,
> +                                               DEVICE_INTERFACE, "UUIDs");
>
> -       prim = search->current->data;
> -       gatt_find_included(device->attrib, prim->range.start, prim->range.end,
> -                                       find_included_cb, search);
> -       return;
> +       device_svc_resolved(device, device->bdaddr_type, 0);
>
> -complete:
> -       g_slist_free_full(search->services, g_free);
> -       g_free(search);
> +       store_services(device);
> +
> +       browse_request_free(req);
>  }
>
> -static void find_included_services(struct browse_req *req, GSList *services)
> +static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
> +                                                               void *user_data)
>  {
> -       struct btd_device *device = req->device;
> -       struct included_search *search;
> -       struct gatt_primary *prim;
> -       GSList *l;
> +       struct btd_device *device = user_data;
>
> -       DBG("service count %u", g_slist_length(services));
> +       DBG("gatt-client ready -- status: %s, ATT error: %u",
> +                                               success ? "success" : "failed",
> +                                               att_ecode);
> +
> +       if (!success) {
> +               if (device->browse) {
> +                       struct browse_req *req = device->browse;
> +                       send_le_browse_response(req);
> +                       device->browse = NULL;
> +                       browse_request_free(req);
> +               }
>
> -       if (services == NULL) {
> -               DBG("No services found");
> -               register_all_services(req, NULL);
>                 return;
>         }
>
> -       search = g_new0(struct included_search, 1);
> -       search->req = req;
> +       device->att_mtu = bt_att_get_mtu(device->att);
>
> -       /* We have to completely duplicate the data in order to have a
> -        * clearly defined responsibility of freeing regardless of
> -        * failure or success. Otherwise memory leaks are inevitable.
> -        */
> -       for (l = services; l; l = g_slist_next(l)) {
> -               struct gatt_primary *dup;
> +       DBG("gatt-client exchanged MTU: %u", device->att_mtu);
>
> -               dup = g_memdup(l->data, sizeof(struct gatt_primary));
> +       if (device->browse)
> +               register_gatt_services(device->browse);
>
> -               search->services = g_slist_append(search->services, dup);
> -       }
> +       /*
> +        * TODO: Change attio callbacks to accept a gatt-client instead of a
> +        * GAttrib.
> +        */
> +       g_slist_foreach(device->attios, attio_connected, device->attrib);
> +}
>
> -       search->current = search->services;
> +static void gatt_client_service_changed(uint16_t start_handle,
> +                                                       uint16_t end_handle,
> +                                                       void *user_data)
> +{
> +       struct btd_device *device = user_data;
> +
> +       DBG("gatt-client: Service Changed: start 0x%04x, end: 0x%04x",
> +                                               start_handle, end_handle);
>
> -       prim = search->current->data;
> -       gatt_find_included(device->attrib, prim->range.start, prim->range.end,
> -                                       find_included_cb, search);
> +       /*
> +        * TODO: Notify clients that services changed so they can handle it
> +        * directly. Remove the profile if a service was removed.
> +        */
> +       device_browse_primary(device, NULL);
>  }
>
> -static void primary_cb(uint8_t status, GSList *services, void *user_data)
> +static void gatt_client_init(struct btd_device *device)
>  {
> -       struct browse_req *req = user_data;
> +       gatt_client_cleanup(device);
>
> -       DBG("status %u", status);
> +       device->gatt_client = bt_gatt_client_new(device->att, device->att_mtu);
> +       if (!device->gatt_client) {
> +               DBG("Failed to initialize gatt-client");
> +               return;
> +       }
>
> -       if (status) {
> -               struct btd_device *device = req->device;
> +       if (!bt_gatt_client_set_ready_handler(device->gatt_client,
> +                                                       gatt_client_ready_cb,
> +                                                       device, NULL)) {
> +               DBG("Failed to set ready handler for gatt-client");
> +               gatt_client_cleanup(device);
> +               return;
> +       }
>
> -               send_le_browse_response(req);
> -               device->browse = NULL;
> -               browse_request_free(req);
> +       if (!bt_gatt_client_set_service_changed(device->gatt_client,
> +                                               gatt_client_service_changed,
> +                                               device, NULL)) {
> +               DBG("Failed to set service changed handler for gatt-client");
> +               gatt_client_cleanup(device);
>                 return;
>         }
>
> -       find_included_services(req, services);
> +       DBG("gatt-client created");
>  }
>
>  bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
> @@ -3660,10 +3676,8 @@ bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
>                 }
>         }
>
> -       if (cid == ATT_CID)
> -               mtu = BT_ATT_DEFAULT_LE_MTU;
> -
> -       attrib = g_attrib_new(io, mtu);
> +       dev->att_mtu = MIN(mtu, BT_ATT_MAX_LE_MTU);
> +       attrib = g_attrib_new(io, dev->att_mtu);
>         if (!attrib) {
>                 error("Unable to create new GAttrib instance");
>                 return false;
> @@ -3678,11 +3692,12 @@ bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
>
>         dev->attrib = attrib;
>         dev->att = bt_att_ref(g_attrib_get_att(attrib));
> -
>         dev->att_disconn_id = bt_att_register_disconnect(dev->att,
>                                                 att_disconnected_cb, dev, NULL);
>         bt_att_set_close_on_unref(dev->att, true);
>
> +       gatt_client_init(dev);
> +
>         /*
>          * Remove the device from the connect_list and give the passive
>          * scanning another chance to be restarted in case there are
> @@ -3690,8 +3705,6 @@ bool device_attach_attrib(struct btd_device *dev, GIOChannel *io)
>          */
>         adapter_connect_list_remove(dev->adapter, dev);
>
> -       g_slist_foreach(dev->attios, attio_connected, dev->attrib);
> -
>         return true;
>  }
>
> @@ -3845,13 +3858,29 @@ static void att_browse_error_cb(const GError *gerr, gpointer user_data)
>         browse_request_free(req);
>  }
>
> +static void browse_gatt_client(struct browse_req *req)
> +{
> +       struct btd_device *device = req->device;
> +
> +       if (!device->gatt_client) {
> +               DBG("No gatt-client currently attached");
> +               return;
> +       }
> +
> +       /*
> +        * If gatt-client is ready, then register all services. Otherwise, this
> +        * will be deferred until client becomes ready.
> +        */
> +       if (bt_gatt_client_is_ready(device->gatt_client))
> +               register_gatt_services(req);
> +}
> +
>  static void att_browse_cb(gpointer user_data)
>  {
>         struct att_callbacks *attcb = user_data;
>         struct btd_device *device = attcb->user_data;
>
> -       gatt_discover_primary(device->attrib, NULL, primary_cb,
> -                                                       device->browse);
> +       browse_gatt_client(device->browse);
>  }
>
>  static int device_browse_primary(struct btd_device *device, DBusMessage *msg)
> @@ -3869,7 +3898,7 @@ static int device_browse_primary(struct btd_device *device, DBusMessage *msg)
>         device->browse = req;
>
>         if (device->attrib) {
> -               gatt_discover_primary(device->attrib, NULL, primary_cb, req);
> +               browse_gatt_client(device->browse);
>                 goto done;
>         }
>
> @@ -4738,21 +4767,6 @@ GSList *btd_device_get_primaries(struct btd_device *device)
>         return device->primaries;
>  }
>
> -void btd_device_gatt_set_service_changed(struct btd_device *device,
> -                                               uint16_t start, uint16_t end)
> -{
> -       GSList *l;
> -
> -       for (l = device->primaries; l; l = g_slist_next(l)) {
> -               struct gatt_primary *prim = l->data;
> -
> -               if (start <= prim->range.end && end >= prim->range.start)
> -                       prim->changed = TRUE;
> -       }
> -
> -       device_browse_primary(device, NULL);
> -}
> -
>  void btd_device_add_uuid(struct btd_device *device, const char *uuid)
>  {
>         GSList *uuid_list;
> diff --git a/src/device.h b/src/device.h
> index 2e0473e..00cb502 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -67,8 +67,6 @@ const sdp_record_t *btd_device_get_record(struct btd_device *device,
>  struct gatt_primary *btd_device_get_primary(struct btd_device *device,
>                                                         const char *uuid);
>  GSList *btd_device_get_primaries(struct btd_device *device);
> -void btd_device_gatt_set_service_changed(struct btd_device *device,
> -                                               uint16_t start, uint16_t end);
>  bool device_attach_attrib(struct btd_device *dev, GIOChannel *io);
>  void btd_device_add_uuid(struct btd_device *device, const char *uuid);
>  void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
> diff --git a/src/shared/att-types.h b/src/shared/att-types.h
> index 3d8829a..8b6d537 100644
> --- a/src/shared/att-types.h
> +++ b/src/shared/att-types.h
> @@ -27,7 +27,8 @@
>  #define __packed __attribute__((packed))
>  #endif
>
> -#define BT_ATT_DEFAULT_LE_MTU 23
> +#define BT_ATT_DEFAULT_LE_MTU  23
> +#define BT_ATT_MAX_LE_MTU      517
>
>  /* ATT protocol opcodes */
>  #define BT_ATT_OP_ERROR_RSP                    0x01
> --
> 2.1.0.rc2.206.gedb03e5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

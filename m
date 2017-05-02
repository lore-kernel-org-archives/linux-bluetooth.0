Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1493209933-10790-1-git-send-email-marcin.kraglak@tieto.com>
References: <1493209933-10790-1-git-send-email-marcin.kraglak@tieto.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 May 2017 18:36:45 +0300
Message-ID: <CABBYNZL6unBJTHsh41qnEU-NQNf=m22A5NFzE1oLbmQ7fxg_Xw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] core/gatt-client: Add support for Includes property
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Apr 26, 2017 at 3:32 PM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> Add implementation of Includes property in GATT service interface.
> Include services are updated after exporting all services, when new service
> has been added or service was removed.
> ---
>  src/gatt-client.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 106 insertions(+), 7 deletions(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 114981c..b86bfe6 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -72,6 +72,7 @@ struct service {
>         bt_uuid_t uuid;
>         char *path;
>         struct queue *chrcs;
> +       struct queue *incl_services;
>  };
>
>  typedef bool (*async_dbus_op_complete_t)(void *data);
> @@ -1398,10 +1399,36 @@ static gboolean service_get_primary(const GDBusPropertyTable *property,
>         return TRUE;
>  }
>
> +static void append_incl_service_path(void *data, void *user_data)
> +{
> +       struct service *incl_service = data;
> +       DBusMessageIter *array = user_data;
> +
> +       dbus_message_iter_append_basic(array, DBUS_TYPE_OBJECT_PATH,
> +                                       &incl_service->path);
> +}
> +
> +static gboolean service_get_includes(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct service *service = data;
> +       DBusMessageIter array;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{o}", &array);
> +
> +       queue_foreach(service->incl_services, append_incl_service_path, &array);
> +
> +       dbus_message_iter_close_container(iter, &array);
> +
> +       return TRUE;
> +
> +}
> +
>  static const GDBusPropertyTable service_properties[] = {
>         { "UUID", "s", service_get_uuid },
>         { "Device", "o", service_get_device },
>         { "Primary", "b", service_get_primary },
> +       { "Includes", "ao", service_get_includes },
>         { }
>  };
>
> @@ -1410,6 +1437,7 @@ static void service_free(void *data)
>         struct service *service = data;
>
>         queue_destroy(service->chrcs, NULL);  /* List should be empty here */
> +       queue_destroy(service->incl_services, NULL);
>         g_free(service->path);
>         free(service);
>  }
> @@ -1423,6 +1451,7 @@ static struct service *service_create(struct gatt_db_attribute *attr,
>
>         service = new0(struct service, 1);
>         service->chrcs = queue_new();
> +       service->incl_services = queue_new();
>         service->client = client;
>
>         gatt_db_attribute_get_service_data(attr, &service->start_handle,
> @@ -1459,13 +1488,29 @@ static struct service *service_create(struct gatt_db_attribute *attr,
>         return service;
>  }
>
> +static void on_service_removed(void *data, void *user_data)
> +{
> +       struct service *service = data;
> +       struct service *removed_service = user_data;
> +
> +       if (queue_remove(service->incl_services, removed_service))
> +               g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                                                       service->path,
> +                                                       GATT_SERVICE_IFACE,
> +                                                       "Includes");
> +}
> +
>  static void unregister_service(void *data)
>  {
>         struct service *service = data;
> +       struct btd_gatt_client *client = service->client;
>
>         DBG("Removing GATT service: %s", service->path);
>
>         queue_remove_all(service->chrcs, NULL, NULL, unregister_characteristic);
> +       queue_remove_all(service->incl_services, NULL, NULL, NULL);
> +
> +       queue_foreach(client->services, on_service_removed, service);
>
>         g_dbus_unregister_interface(btd_get_dbus_connection(), service->path,
>                                                         GATT_SERVICE_IFACE);
> @@ -1567,11 +1612,71 @@ static void export_service(struct gatt_db_attribute *attr, void *user_data)
>         queue_push_tail(client->services, service);
>  }
>
> +static bool match_service_handle(const void *a, const void *b)
> +{
> +       const struct service *service = a;
> +       uint16_t start_handle = PTR_TO_UINT(b);
> +
> +       return service->start_handle == start_handle;
> +}
> +
> +struct update_incl_data {
> +       struct service *service;
> +       bool changed;
> +};
> +
> +static void update_included_service(struct gatt_db_attribute *attrib,
> +                                                       void *user_data)
> +{
> +       struct update_incl_data *update_data = user_data;
> +       struct btd_gatt_client *client = update_data->service->client;
> +       struct service *service = update_data->service;
> +       struct service *incl_service;
> +       uint16_t start_handle;
> +
> +       gatt_db_attribute_get_incl_data(attrib, NULL, &start_handle, NULL);
> +
> +       incl_service = queue_find(client->services, match_service_handle,
> +                                               UINT_TO_PTR(start_handle));
> +
> +       if (!incl_service)
> +               return;
> +
> +       /* Check if service is already on list */
> +       if (queue_find(service->incl_services, NULL, incl_service))
> +               return;
> +
> +       queue_push_tail(service->incl_services, incl_service);
> +       update_data->changed = true;
> +}
> +
> +static void update_included_services(void *data, void *user_data)
> +{
> +       struct btd_gatt_client *client = user_data;
> +       struct service *service = data;
> +       struct gatt_db_attribute *attr;
> +       struct update_incl_data inc_data = {
> +               .changed = false,
> +               .service = service,
> +       };
> +
> +       attr = gatt_db_get_attribute(client->db, service->start_handle);
> +       gatt_db_service_foreach_incl(attr, update_included_service, &inc_data);
> +
> +       if (inc_data.changed)
> +               g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                                                       service->path,
> +                                                       GATT_SERVICE_IFACE,
> +                                                       "Includes");
> +}
> +
>  static void create_services(struct btd_gatt_client *client)
>  {
>         DBG("Exporting objects for GATT services: %s", client->devaddr);
>
>         gatt_db_foreach_service(client->db, NULL, export_service, client);
> +
> +       queue_foreach(client->services, update_included_services, client);
>  }
>
>  struct btd_gatt_client *btd_gatt_client_new(struct btd_device *device)
> @@ -1689,14 +1794,8 @@ void btd_gatt_client_service_added(struct btd_gatt_client *client,
>                 return;
>
>         export_service(attrib, client);
> -}
> -
> -static bool match_service_handle(const void *a, const void *b)
> -{
> -       const struct service *service = a;
> -       uint16_t start_handle = PTR_TO_UINT(b);
>
> -       return service->start_handle == start_handle;
> +       queue_foreach(client->services, update_included_services, client);
>  }
>
>  void btd_gatt_client_service_removed(struct btd_gatt_client *client,
> --
> 2.4.3

Applied, thanks.



-- 
Luiz Augusto von Dentz

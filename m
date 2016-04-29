Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1461325357-4013-1-git-send-email-luiz.dentz@gmail.com>
References: <1461325357-4013-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 29 Apr 2016 13:07:48 +0300
Message-ID: <CABBYNZJRcBVyJYn3AaqnzCkXhOF2OZgJNjcigiLxbmXd3HwUFg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] core/gatt-client: Don't read extended properties
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Apr 22, 2016 at 2:42 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Extended properties are already read and stored in the database and can be
> retrieved with gatt_db_attribute_get_char_data.
> ---
>  src/gatt-client.c | 55 +++----------------------------------------------------
>  1 file changed, 3 insertions(+), 52 deletions(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index ebb7b35..16a1f6c 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -71,7 +71,6 @@ struct service {
>         bt_uuid_t uuid;
>         char *path;
>         struct queue *chrcs;
> -       struct queue *pending_ext_props;
>  };
>
>  struct characteristic {
> @@ -1283,7 +1282,8 @@ static struct characteristic *characteristic_create(
>
>         gatt_db_attribute_get_char_data(attr, &chrc->handle,
>                                                         &chrc->value_handle,
> -                                                       &chrc->props, NULL,
> +                                                       &chrc->props,
> +                                                       &chrc->ext_props,
>                                                         &uuid);
>
>         chrc->attr = gatt_db_get_attribute(service->client->db,
> @@ -1398,7 +1398,6 @@ static void service_free(void *data)
>         struct service *service = data;
>
>         queue_destroy(service->chrcs, NULL);  /* List should be empty here */
> -       queue_destroy(service->pending_ext_props, NULL);
>         g_free(service->path);
>         free(service);
>  }
> @@ -1412,7 +1411,6 @@ static struct service *service_create(struct gatt_db_attribute *attr,
>
>         service = new0(struct service, 1);
>         service->chrcs = queue_new();
> -       service->pending_ext_props = queue_new();
>         service->client = client;
>
>         gatt_db_attribute_get_service_data(attr, &service->start_handle,
> @@ -1484,44 +1482,6 @@ static void export_desc(struct gatt_db_attribute *attr, void *user_data)
>         queue_push_tail(charac->descs, desc);
>  }
>
> -static void read_ext_props_cb(bool success, uint8_t att_ecode,
> -                                       const uint8_t *value, uint16_t length,
> -                                       void *user_data)
> -{
> -       struct characteristic *chrc = user_data;
> -       struct service *service = chrc->service;
> -
> -       if (!success) {
> -               error("Failed to obtain extended properties - error: 0x%02x",
> -                                                               att_ecode);
> -               return;
> -       }
> -
> -       if (!value || length != 2) {
> -               error("Malformed extended properties value");
> -               return;
> -       }
> -
> -       chrc->ext_props = get_le16(value);
> -       if (chrc->ext_props)
> -               g_dbus_emit_property_changed(btd_get_dbus_connection(),
> -                                               chrc->path,
> -                                               GATT_CHARACTERISTIC_IFACE,
> -                                               "Flags");
> -
> -       queue_remove(service->pending_ext_props, chrc);
> -}
> -
> -static void read_ext_props(void *data, void *user_data)
> -{
> -       struct characteristic *chrc = data;
> -
> -       bt_gatt_client_read_value(chrc->service->client->gatt,
> -                                                       chrc->ext_props_handle,
> -                                                       read_ext_props_cb,
> -                                                       chrc, NULL);
> -}
> -
>  static bool create_descriptors(struct gatt_db_attribute *attr,
>                                         struct characteristic *charac)
>  {
> @@ -1555,9 +1515,6 @@ static void export_char(struct gatt_db_attribute *attr, void *user_data)
>
>         queue_push_tail(service->chrcs, charac);
>
> -       if (charac->ext_props_handle)
> -               queue_push_tail(service->pending_ext_props, charac);
> -
>         return;
>
>  fail:
> @@ -1574,13 +1531,7 @@ static bool create_characteristics(struct gatt_db_attribute *attr,
>
>         gatt_db_service_foreach_char(attr, export_char, &data);
>
> -       if (data.failed)
> -               return false;
> -
> -       /* Obtain extended properties */
> -       queue_foreach(service->pending_ext_props, read_ext_props, NULL);
> -
> -       return true;
> +       return !data.failed;
>  }
>
>  static void export_service(struct gatt_db_attribute *attr, void *user_data)
> --
> 2.5.5

Applied.


-- 
Luiz Augusto von Dentz

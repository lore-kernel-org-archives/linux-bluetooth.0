Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170821215918.68432-1-yunhanw@google.com>
References: <20170821215918.68432-1-yunhanw@google.com>
From: Yunhan Wang <yunhanw@google.com>
Date: Mon, 21 Aug 2017 15:04:06 -0700
Message-ID: <CALvjcs-aZB=PHEkDPj-znJfFYcz2jTxf=+Yvge955jAtmF7zCg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Add implementation of IndicationConf
To: linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Yunhan Wang <yunhanw@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Luiz

This is the patch to add a method,  IndicationConf, to
GattCharacteristic1. Now i am able to handle indication confirmation.

Thanks
Best wishes
Yunhan

On Mon, Aug 21, 2017 at 2:59 PM, Yunhan Wang <yunhanw@google.com> wrote:
> ---
>  src/gatt-client.c   |  9 +++++++++
>  src/gatt-database.c | 15 +++++++++++----
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 1cd7fbcf5..120fffb5b 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -1598,6 +1598,13 @@ static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
>         return dbus_message_new_method_return(msg);
>  }
>
> +static DBusMessage *characteristic_indication_conf(DBusConnection *conn,
> +                                       DBusMessage *msg, void *user_data)
> +{
> +       DBG("indication conf received");
> +       return dbus_message_new_method_return(msg);
> +}
> +
>  static const GDBusPropertyTable characteristic_properties[] = {
>         { "UUID", "s", characteristic_get_uuid, NULL, NULL },
>         { "Service", "o", characteristic_get_service, NULL, NULL },
> @@ -1635,6 +1642,8 @@ static const GDBusMethodTable characteristic_methods[] = {
>                                         characteristic_start_notify) },
>         { GDBUS_METHOD("StopNotify", NULL, NULL,
>                                         characteristic_stop_notify) },
> +       { GDBUS_METHOD("IndicationConf", NULL, NULL,
> +                                  characteristic_indication_conf) },
>         { }
>  };
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 3b4bc7c8d..e28ccd3b0 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -867,11 +867,17 @@ struct notify {
>         const uint8_t *value;
>         uint16_t len;
>         bool indicate;
> +       GDBusProxy *proxy;
>  };
>
>  static void conf_cb(void *user_data)
>  {
>         DBG("GATT server received confirmation");
> +       GDBusProxy *proxy = user_data;
> +       if (proxy != NULL)
> +       {
> +               g_dbus_proxy_method_call(proxy, "IndicationConf", NULL, NULL, NULL, NULL);
> +       }
>  }
>
>  static void send_notification_to_device(void *data, void *user_data)
> @@ -917,7 +923,7 @@ static void send_notification_to_device(void *data, void *user_data)
>         DBG("GATT server sending indication");
>         bt_gatt_server_send_indication(server, notify->handle, notify->value,
>                                                         notify->len, conf_cb,
> -                                                       NULL, NULL);
> +                                                       notify->proxy, NULL);
>
>         return;
>
> @@ -930,7 +936,7 @@ remove:
>  static void send_notification_to_devices(struct btd_gatt_database *database,
>                                         uint16_t handle, const uint8_t *value,
>                                         uint16_t len, uint16_t ccc_handle,
> -                                       bool indicate)
> +                                       bool indicate, GDBusProxy *proxy)
>  {
>         struct notify notify;
>
> @@ -942,6 +948,7 @@ static void send_notification_to_devices(struct btd_gatt_database *database,
>         notify.value = value;
>         notify.len = len;
>         notify.indicate = indicate;
> +       notify.proxy = proxy;
>
>         queue_foreach(database->device_states, send_notification_to_device,
>                                                                 &notify);
> @@ -972,7 +979,7 @@ static void send_service_changed(struct btd_gatt_database *database,
>         put_le16(end, value + 2);
>
>         send_notification_to_devices(database, handle, value, sizeof(value),
> -                                                       ccc_handle, true);
> +                                                       ccc_handle, true, NULL);
>  }
>
>  static void gatt_db_service_added(struct gatt_db_attribute *attrib,
> @@ -1861,7 +1868,7 @@ static void property_changed_cb(GDBusProxy *proxy, const char *name,
>                                 gatt_db_attribute_get_handle(chrc->attrib),
>                                 value, len,
>                                 gatt_db_attribute_get_handle(chrc->ccc),
> -                               chrc->props & BT_GATT_CHRC_PROP_INDICATE);
> +                               chrc->props & BT_GATT_CHRC_PROP_INDICATE, proxy);
>  }
>
>  static bool database_add_ccc(struct external_service *service,
> --
> 2.14.1.480.gb18f417b89-goog
>

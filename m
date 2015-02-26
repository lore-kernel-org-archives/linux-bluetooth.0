Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424927610-26226-14-git-send-email-armansito@chromium.org>
References: <1424927610-26226-1-git-send-email-armansito@chromium.org>
	<1424927610-26226-14-git-send-email-armansito@chromium.org>
Date: Thu, 26 Feb 2015 11:02:50 +0200
Message-ID: <CABBYNZJhdhRv_DNfqnB=KzW7G6jB0SXgW1ZNmtg6fyJgdkYqXw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 13/17] core/gatt: Send not/ind for D-Bus characteristics
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Thu, Feb 26, 2015 at 7:13 AM, Arman Uguray <armansito@chromium.org> wrote:
> This patch adds support for sending out notification/indication packets
> for external characteristics whenever a PropertiesChanged signal is
> received for the "Value" property of an external characteristic that has
> either the 'notify' or the 'indicate' property.
> ---
>  src/gatt-manager.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 56 insertions(+), 3 deletions(-)
>
> diff --git a/src/gatt-manager.c b/src/gatt-manager.c
> index 4353f38..5e69495 100644
> --- a/src/gatt-manager.c
> +++ b/src/gatt-manager.c
> @@ -72,6 +72,7 @@ struct external_service {
>  };
>
>  struct external_chrc {
> +       struct external_service *service;
>         GDBusProxy *proxy;
>         uint8_t props;
>         uint8_t ext_props;
> @@ -121,8 +122,10 @@ static void chrc_free(void *data)
>
>         queue_foreach(chrc->pending_ops, cancel_pending_dbus_op, NULL);
>
> -       if (chrc->proxy)
> +       if (chrc->proxy) {
> +               g_dbus_proxy_set_property_watch(chrc->proxy, NULL, NULL);
>                 g_dbus_proxy_unref(chrc->proxy);
> +       }
>
>         free(chrc);
>  }
> @@ -206,7 +209,8 @@ static void service_remove(void *data)
>         service_remove_helper(service);
>  }
>
> -static struct external_chrc *chrc_create(GDBusProxy *proxy)
> +static struct external_chrc *chrc_create(struct external_service *service,
> +                                                       GDBusProxy *proxy)
>  {
>         struct external_chrc *chrc;
>
> @@ -220,6 +224,7 @@ static struct external_chrc *chrc_create(GDBusProxy *proxy)
>                 return NULL;
>         }
>
> +       chrc->service = service;
>         chrc->proxy = g_dbus_proxy_ref(proxy);
>
>         return chrc;
> @@ -348,7 +353,7 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
>                         return;
>                 }
>
> -               chrc = chrc_create(proxy);
> +               chrc = chrc_create(service, proxy);
>                 if (!chrc) {
>                         service->failed = true;
>                         return;
> @@ -724,6 +729,48 @@ static uint8_t ccc_write_cb(uint16_t value, void *user_data)
>         return 0;
>  }
>
> +static void property_changed_cb(GDBusProxy *proxy, const char *name,
> +                                       DBusMessageIter *iter, void *user_data)
> +{
> +       struct external_chrc *chrc = user_data;
> +       struct btd_gatt_database *database;
> +       DBusMessageIter array;
> +       uint8_t *value = NULL;
> +       int len = 0;
> +
> +       if (strcmp(name, "Value"))
> +               return;
> +
> +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
> +               DBG("Malformed \"Value\" property received");
> +               return;
> +       }
> +
> +       dbus_message_iter_recurse(iter, &array);
> +       dbus_message_iter_get_fixed_array(&array, &value, &len);
> +
> +       if (len < 0) {
> +               DBG("Malformed \"Value\" property received");
> +               return;
> +       }
> +
> +       /* Truncate the value if it's too large */
> +       len = MIN(BT_ATT_MAX_VALUE_LEN, len);
> +       value = len ? value : NULL;
> +
> +       database = btd_adapter_get_database(chrc->service->manager->adapter);
> +       if (!database) {
> +               error("Failed to obtain GATT database from adapter!");
> +               return;
> +       }
> +
> +       btd_gatt_database_notify(database,
> +                               gatt_db_attribute_get_handle(chrc->attrib),
> +                               value, len,
> +                               gatt_db_attribute_get_handle(chrc->ccc),
> +                               chrc->props & BT_GATT_CHRC_PROP_INDICATE);

Here instead of call to btd_gatt_database_notify we should have
gatt_db_attribute_write, but perhaps it gets tricky because that is
also called for when the remote attempts to write, so perhaps we
should do gatt_db_attribute_notify which takes care of notifying via
gatt_db, anyway it is important to note that once we enable
notification the value can be cached.

> +}
> +
>  static bool create_ccc_entry(struct external_service *service,
>                                                 struct external_chrc *chrc)
>  {
> @@ -748,6 +795,12 @@ static bool create_ccc_entry(struct external_service *service,
>                 return false;
>         }
>
> +       if (g_dbus_proxy_set_property_watch(chrc->proxy, property_changed_cb,
> +                                                       chrc) == FALSE) {
> +               error("Failed to set up property watch for characteristic");
> +               return false;
> +       }
> +
>         return true;
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

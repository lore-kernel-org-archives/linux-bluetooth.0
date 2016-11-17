Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1479308501-24667-1-git-send-email-luiz.dentz@gmail.com>
References: <1479308501-24667-1-git-send-email-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 17 Nov 2016 14:16:26 +0200
Message-ID: <CABBYNZLssZV_eGjXS4S_Bmd+w7MQcYezgnsGq_o_eTXERbCWtg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/advertising: Fix not clearing instance id properly
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 16, 2016 at 5:01 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The instance id needs to be cleared in case of an error during
> registration otherwise it cannot be reused anymore.
> ---
>  src/advertising.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index e5cd31c..ef84e45 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -95,6 +95,9 @@ static void advertisement_free(void *data)
>                 g_dbus_client_unref(ad->client);
>         }
>
> +       if (ad->instance)
> +               util_clear_uid(&ad->manager->instance_bitmap, ad->instance);
> +
>         bt_ad_unref(ad->data);
>
>         g_dbus_proxy_unref(ad->proxy);
> @@ -155,8 +158,6 @@ static void advertisement_remove(void *data)
>
>         queue_remove(ad->manager->ads, ad);
>
> -       util_clear_uid(&ad->manager->instance_bitmap, ad->instance);
> -
>         g_idle_add(advertisement_free_idle_cb, ad);
>  }
>
> @@ -585,7 +586,8 @@ static void advertisement_proxy_added(GDBusProxy *proxy, void *data)
>         ad->reg = NULL;
>  }
>
> -static struct advertisement *advertisement_create(DBusConnection *conn,
> +static struct advertisement *
> +advertisement_create(struct btd_advertising *manager, DBusConnection *conn,
>                                         DBusMessage *msg, const char *path)
>  {
>         struct advertisement *ad;
> @@ -621,6 +623,13 @@ static struct advertisement *advertisement_create(DBusConnection *conn,
>         if (!ad->data)
>                 goto fail;
>
> +       ad->instance = util_get_uid(&manager->instance_bitmap,
> +                                                       manager->max_ads);
> +       if (!ad->instance)
> +               goto fail;
> +
> +       ad->manager = manager;
> +
>         return ad;
>
>  fail:
> @@ -636,7 +645,6 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
>         DBusMessageIter args;
>         struct advertisement *ad;
>         struct dbus_obj_match match;
> -       uint8_t instance;
>
>         DBG("RegisterAdvertisement");
>
> @@ -653,25 +661,18 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
>         if (queue_find(manager->ads, match_advertisement, &match))
>                 return btd_error_already_exists(msg);
>
> -       instance = util_get_uid(&manager->instance_bitmap, manager->max_ads);
> -       if (!instance)
> -               return btd_error_failed(msg, "Maximum advertisements reached");
> -
>         dbus_message_iter_next(&args);
>
>         if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
>                 return btd_error_invalid_args(msg);
>
> -       ad = advertisement_create(conn, msg, match.path);
> +       ad = advertisement_create(manager, conn, msg, match.path);
>         if (!ad)
>                 return btd_error_failed(msg,
>                                         "Failed to register advertisement");
>
>         DBG("Registered advertisement at path %s", match.path);
>
> -       ad->instance = instance;
> -       ad->manager = manager;
> -
>         queue_push_tail(manager->ads, ad);
>
>         return NULL;
> --
> 2.7.4

Applied.


-- 
Luiz Augusto von Dentz

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426180319-16509-8-git-send-email-jamuraa@chromium.org>
References: <1426180319-16509-1-git-send-email-jamuraa@chromium.org>
	<1426180319-16509-8-git-send-email-jamuraa@chromium.org>
Date: Thu, 12 Mar 2015 13:15:23 -0700
Message-ID: <CAHrH25Q7Yo9Y76U=NTi9+mVrr_+Ra_L_T+JNhZZDxZxBNQuDhw@mail.gmail.com>
Subject: Re: [BlueZ 07/12] advertising-manager: use advertising_data
From: Arman Uguray <armansito@google.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

> On Thu, Mar 12, 2015 at 10:11 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> Start using the newly introduced struct advertising_data API.
> ---
>  src/advertising-manager.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/src/advertising-manager.c b/src/advertising-manager.c
> index 5045a06..3f53637 100644
> --- a/src/advertising-manager.c
> +++ b/src/advertising-manager.c
> @@ -32,6 +32,7 @@
>  #include "dbus-common.h"
>  #include "error.h"
>  #include "log.h"
> +#include "src/shared/advertising-data.h"
>  #include "src/shared/queue.h"
>  #include "src/shared/util.h"
>
> @@ -56,6 +57,7 @@ struct advertisement {
>         uint8_t type; /* Advertising type */
>         bool random;
>         bool published;
> +       struct advertising_data *data;
>  };
>
>  static bool match_advertisement_path(const void *a, const void *b)
> @@ -76,6 +78,9 @@ static void advertisement_free(struct advertisement *ad)
>                 g_dbus_client_unref(ad->client);
>         }
>
> +       if (ad->data)
> +               advertising_data_unref(ad->data);
> +

The checks for NULL are probably not needed since unref should
silently fail if NULL is passed.

>         if (ad->proxy)
>                 g_dbus_proxy_unref(ad->proxy);
>
> @@ -272,6 +277,10 @@ static struct advertisement *advertisement_create(DBusConnection *conn,
>         if (!ad->path)
>                 goto fail;
>
> +       ad->data = advertising_data_new();
> +       if (!ad->data)
> +               goto fail;
> +
>         ad->reg = dbus_message_ref(msg);
>
>         g_dbus_client_set_disconnect_watch(ad->client, client_disconnect_cb,
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Arman

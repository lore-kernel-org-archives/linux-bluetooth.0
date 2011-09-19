Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1316422359-16167-2-git-send-email-sancane@gmail.com>
References: <1316422359-16167-1-git-send-email-sancane@gmail.com>
	<1316422359-16167-2-git-send-email-sancane@gmail.com>
Date: Mon, 19 Sep 2011 07:39:17 -0400
Message-ID: <CAJdJm_M=19tbUqYFztW8EJM5qCOdy00ddZ6rRMtgtQ0hcN55YA@mail.gmail.com>
Subject: Re: [PATCH 1/9] Load device driver if thermometer service attribute
 appears in GATT
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Mon, Sep 19, 2011 at 4:52 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> ---
>  thermometer/manager.c     |   25 ++++++++++++++++++++++++-
>  thermometer/thermometer.c |    5 ++++-
>  thermometer/thermometer.h |    3 ++-
>  3 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/thermometer/manager.c b/thermometer/manager.c
> index 08f0e0a..0062ea1 100644
> --- a/thermometer/manager.c
> +++ b/thermometer/manager.c
> @@ -21,19 +21,42 @@
>  */
>
>  #include <gdbus.h>
> +#include <bluetooth/uuid.h>
>
>  #include "adapter.h"
>  #include "device.h"
> +#include "att.h"
>  #include "thermometer.h"
>  #include "manager.h"
>
> +#define HEALTH_THERMOMETER_SVC_UUID    "1809"
>  #define HEALTH_THERMOMETER_UUID                "00001809-0000-1000-8000-00805f9b34fb"
>
>  static DBusConnection *connection = NULL;
>
> +static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
> +{
> +       const struct att_primary *prim = a;
> +       const char *uuid = b;
> +
> +       return g_strcmp0(prim->uuid, uuid);
> +}
> +
>  static int thermometer_driver_probe(struct btd_device *device, GSList *uuids)
>  {
> -       return thermometer_register(connection, device);
> +       struct att_primary *tattr;
> +       GSList *l, *primaries;
> +
> +       primaries = btd_device_get_primaries(device);
> +
> +       l = g_slist_find_custom(primaries, HEALTH_THERMOMETER_SVC_UUID,
> +                                                       primary_uuid_cmp);

I think this is incorrect. You should compare against the 128-bit
UUID, not the 16-bit one. I.e. use HEALTH_THERMOMETER_UUID here.

> +       if (!l)
> +               return -1;
> +
> +       tattr = l->data;
> +
> +       return thermometer_register(connection, device, tattr);
>  }
>
>  static void thermometer_driver_remove(struct btd_device *device)
> diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
> index 3cd821a..027ae02 100644
> --- a/thermometer/thermometer.c
> +++ b/thermometer/thermometer.c
> @@ -21,12 +21,15 @@
>  */
>
>  #include <gdbus.h>
> +#include <bluetooth/uuid.h>
>
>  #include "adapter.h"
>  #include "device.h"
> +#include "att.h"
>  #include "thermometer.h"
>
> -int thermometer_register(DBusConnection *connection, struct btd_device *device)
> +int thermometer_register(DBusConnection *connection, struct btd_device *device,
> +                                               struct att_primary *tattr)
>  {
>        /* TODO: Register Health Thermometer Interface */
>        return 0;
> diff --git a/thermometer/thermometer.h b/thermometer/thermometer.h
> index 0937444..298c9ad 100644
> --- a/thermometer/thermometer.h
> +++ b/thermometer/thermometer.h
> @@ -20,5 +20,6 @@
>  *
>  */
>
> -int thermometer_register(DBusConnection *connection, struct btd_device *device);
> +int thermometer_register(DBusConnection *connection, struct btd_device *device,
> +                                               struct att_primary *tattr);
>  void thermometer_unregister(struct btd_device *device);
> --
> 1.7.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1438364565-24642-1-git-send-email-adam.moore@savantsystems.com>
References: <1438364565-24642-1-git-send-email-adam.moore@savantsystems.com>
Date: Sun, 2 Aug 2015 12:04:41 +0300
Message-ID: <CABBYNZLWpbr36dvPP-QsSTtMjW=zZqU7ZfK7KW8SohBeeTtvbg@mail.gmail.com>
Subject: Re: [PATCH] gatt-database: allow GattService anywhere in
 ObjectManager tree
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Adam Moore <adam.moore@savantsystems.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

On Fri, Jul 31, 2015 at 8:42 PM, Adam Moore
<adam.moore@savantsystems.com> wrote:
> Relaxes the requirement that object provide ObjectManager AND
> GattService interfaces.
>
> Maintains check that GattService and GattCharacteristics are
> children of ObjectManager, but loses the check that
> GattCharacteristics are children of GattService. Therefore,
> meant as a temporary workaround.
> ---
>  src/gatt-database.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 69a814d..e82165c 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -85,6 +85,7 @@ struct external_service {
>         bool failed;
>         char *owner;
>         char *path;     /* Path to GattService1 */
> +       char *manager_path;     /* Path to ObjectManager */
>         DBusMessage *reg;
>         GDBusClient *client;
>         GDBusProxy *proxy;
> @@ -372,6 +373,7 @@ static void service_free(void *data)
>
>         g_free(service->owner);
>         g_free(service->path);
> +       g_free(service->manager_path);
>
>         free(service);
>  }
> @@ -1042,7 +1044,7 @@ static bool match_service(const void *a, const void *b)
>         const struct external_service *service = a;
>         const struct svc_match_data *data = b;
>
> -       return g_strcmp0(service->path, data->path) == 0 &&
> +       return g_strcmp0(service->manager_path, data->path) == 0 &&
>                                 g_strcmp0(service->owner, data->sender) == 0;
>  }
>
> @@ -1321,7 +1323,7 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
>         iface = g_dbus_proxy_get_interface(proxy);
>         path = g_dbus_proxy_get_path(proxy);
>
> -       if (!g_str_has_prefix(path, service->path))
> +       if (!g_str_has_prefix(path, service->manager_path))
>                 return;
>
>         if (g_strcmp0(iface, GATT_SERVICE_IFACE) == 0) {
> @@ -1332,12 +1334,20 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
>                  * TODO: We may want to support adding included services in a
>                  * single hierarchy.
>                  */
> -               if (g_strcmp0(path, service->path) != 0) {
> +               if (service->path != NULL) {
>                         error("Multiple services added within hierarchy");
>                         service->failed = true;
>                         return;
>                 }
>
> +               // Set service path now that we've found a service
> +               service->path = g_strdup(path);
> +               if (!service->path) {
> +                       error("Failed to allocate service path");
> +                       service->failed = true;
> +                       return;
> +               }
> +
>                 /* Add 1 for the service declaration */
>                 if (!incr_attr_count(service, 1)) {
>                         error("Failed to increment attribute count");
> @@ -2171,8 +2181,8 @@ static struct external_service *service_create(DBusConnection *conn,
>         if (!service->owner)
>                 goto fail;
>
> -       service->path = g_strdup(path);
> -       if (!service->path)
> +       service->manager_path = g_strdup(path);
> +       if (!service->manager_path)
>                 goto fail;
>
>         service->chrcs = queue_new();
> --
> 2.4.6

Well if we are doing to do that then perhaps we should list all the
services under the path ObjectManager path not only one.


-- 
Luiz Augusto von Dentz

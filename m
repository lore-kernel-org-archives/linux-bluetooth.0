Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426786477-27229-4-git-send-email-jamuraa@chromium.org>
References: <1426786477-27229-1-git-send-email-jamuraa@chromium.org>
	<1426786477-27229-4-git-send-email-jamuraa@chromium.org>
Date: Fri, 20 Mar 2015 15:57:05 +0200
Message-ID: <CABBYNZ+4MQbhXTFZpjq7G7QUZasoHHd1xLAdtuj-1+nwdrkdWQ@mail.gmail.com>
Subject: Re: [BlueZ v3 03/15] gdbus/client: add g_dbus_proxy_set_read_watch
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Thu, Mar 19, 2015 at 7:34 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> Adds a new gdbus utility function which will set a function to be called
> after the properties of a proxy are updated.
>
> This enables using GDBusClient for objects without the ObjectManager
> interface as long as you know in advance the object path using
> g_dbus_proxy_new
> ---
>  gdbus/client.c | 17 +++++++++++++++++
>  gdbus/gdbus.h  |  3 +++
>  2 files changed, 20 insertions(+)
>
> diff --git a/gdbus/client.c b/gdbus/client.c
> index fe0c0db..c913773 100644
> --- a/gdbus/client.c
> +++ b/gdbus/client.c
> @@ -76,6 +76,8 @@ struct GDBusProxy {
>         void *prop_data;
>         GDBusProxyFunction removed_func;
>         void *removed_data;
> +       GDBusProxyFunction read_func;
> +       void *read_data;
>  };
>
>  struct prop_entry {
> @@ -297,6 +299,9 @@ static void get_all_properties_reply(DBusPendingCall *call, void *user_data)
>
>         update_properties(proxy, &iter, FALSE);
>
> +       if (proxy->read_func)
> +               proxy->read_func(proxy, proxy->read_data);
> +
>  done:
>         if (g_list_find(client->proxy_list, proxy) == NULL) {
>                 if (client->proxy_added)
> @@ -914,6 +919,18 @@ gboolean g_dbus_proxy_set_removed_watch(GDBusProxy *proxy,
>         return TRUE;
>  }
>
> +gboolean g_dbus_proxy_set_read_watch(GDBusProxy *proxy,
> +                               GDBusProxyFunction function, void *user_data)
> +{
> +       if (proxy == NULL)
> +               return FALSE;
> +
> +       proxy->read_func = function;
> +       proxy->read_data = user_data;
> +
> +       return TRUE;
> +}
> +
>  static void refresh_properties(GDBusClient *client)
>  {
>         GList *list;
> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> index 9814838..ae281d9 100644
> --- a/gdbus/gdbus.h
> +++ b/gdbus/gdbus.h
> @@ -353,6 +353,9 @@ gboolean g_dbus_proxy_set_property_watch(GDBusProxy *proxy,
>  gboolean g_dbus_proxy_set_removed_watch(GDBusProxy *proxy,
>                         GDBusProxyFunction destroy, void *user_data);
>
> +gboolean g_dbus_proxy_set_read_watch(GDBusProxy *proxy,
> +                       GDBusProxyFunction ready, void *user_data);

Is this supposed to be ready or read watch, Id say this is a ready
watch? Also you should name the callback consistently in one place you
call it ready and in the other function, I would go with the later.

Btw, it looks like this would still trigger proxy added callback so I
wonder why you did not use it instead of creating a new callback?

>  GDBusClient *g_dbus_client_new(DBusConnection *connection,
>                                         const char *service, const char *path);
>  GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

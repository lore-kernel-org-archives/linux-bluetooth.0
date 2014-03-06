Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1394113467-24331-2-git-send-email-claudio.takahasi@openbossa.org>
References: <CAKT1EBfVP_aYMDFdK+vqBxOKEZh2tdfasKkEks4v5H6h-ZXerw@mail.gmail.com>
	<1394113467-24331-1-git-send-email-claudio.takahasi@openbossa.org>
	<1394113467-24331-2-git-send-email-claudio.takahasi@openbossa.org>
Date: Thu, 6 Mar 2014 15:56:45 +0200
Message-ID: <CABBYNZLAWCBmOg0VMnjJWQm4gwHH3uvs4LAWCt+xGZ+hd6C5mw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 1/9] gdbus: Add g_dbus_client_set_ready_watch()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Mar 6, 2014 at 3:44 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> This patch adds a new gdbus helper to notify the clients that
> GetManagedObjects reply was received and the last proxy has been
> informed previously by the proxy_added callback.
> ---
>  gdbus/client.c | 17 +++++++++++++++++
>  gdbus/gdbus.h  |  4 +++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/gdbus/client.c b/gdbus/client.c
> index be8cc29..5193b6c 100644
> --- a/gdbus/client.c
> +++ b/gdbus/client.c
> @@ -56,6 +56,8 @@ struct GDBusClient {
>         void *signal_data;
>         GDBusProxyFunction proxy_added;
>         GDBusProxyFunction proxy_removed;
> +       GDBusClientFunction ready;
> +       void *ready_data;
>         GDBusPropertyFunction property_changed;
>         void *user_data;
>         GList *proxy_list;
> @@ -982,6 +984,9 @@ static void parse_managed_objects(GDBusClient *client, DBusMessage *msg)
>
>                 dbus_message_iter_next(&dict);
>         }
> +
> +       if (client->ready)
> +               client->ready(client, client->ready_data);
>  }
>
>  static void get_managed_objects_reply(DBusPendingCall *call, void *user_data)
> @@ -1243,6 +1248,18 @@ gboolean g_dbus_client_set_signal_watch(GDBusClient *client,
>         return TRUE;
>  }
>
> +gboolean g_dbus_client_set_ready_watch(GDBusClient *client,
> +                               GDBusClientFunction ready, void *user_data)
> +{
> +       if (client == NULL)
> +               return FALSE;
> +
> +       client->ready = ready;
> +       client->ready_data = user_data;
> +
> +       return TRUE;
> +}
> +
>  gboolean g_dbus_client_set_proxy_handlers(GDBusClient *client,
>                                         GDBusProxyFunction proxy_added,
>                                         GDBusProxyFunction proxy_removed,
> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> index 9542109..8ada200 100644
> --- a/gdbus/gdbus.h
> +++ b/gdbus/gdbus.h
> @@ -337,6 +337,7 @@ gboolean g_dbus_proxy_method_call(GDBusProxy *proxy, const char *method,
>                                 GDBusReturnFunction function, void *user_data,
>                                 GDBusDestroyFunction destroy);
>
> +typedef void (* GDBusClientFunction) (GDBusClient *client, void *user_data);
>  typedef void (* GDBusProxyFunction) (GDBusProxy *proxy, void *user_data);
>  typedef void (* GDBusPropertyFunction) (GDBusProxy *proxy, const char *name,
>                                         DBusMessageIter *iter, void *user_data);
> @@ -359,7 +360,8 @@ gboolean g_dbus_client_set_disconnect_watch(GDBusClient *client,
>                                 GDBusWatchFunction function, void *user_data);
>  gboolean g_dbus_client_set_signal_watch(GDBusClient *client,
>                                 GDBusMessageFunction function, void *user_data);
> -
> +gboolean g_dbus_client_set_ready_watch(GDBusClient *client,
> +                               GDBusClientFunction ready, void *user_data);
>  gboolean g_dbus_client_set_proxy_handlers(GDBusClient *client,
>                                         GDBusProxyFunction proxy_added,
>                                         GDBusProxyFunction proxy_removed,
> --
> 1.8.3.1

It should be relatively simple to add a unit for it, doesn't need to
be in the same patch-set since I don't want to slow down the set just
because of the lack of it.


-- 
Luiz Augusto von Dentz

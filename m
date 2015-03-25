Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427199032-23492-1-git-send-email-luiz.dentz@gmail.com>
References: <1427199032-23492-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 25 Mar 2015 12:39:32 +0200
Message-ID: <CABBYNZKRrCJr5DhCcUAqv-G8V=-WKM9e0XsB-eLVvmnYynYEnQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] gdbus: Make GDBusClient work without ObjectManager
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 24, 2015 at 2:10 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes GDBusClient work normally without ObjectManager.
> ---
>  gdbus/client.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/gdbus/client.c b/gdbus/client.c
> index fe0c0db..48711ae 100644
> --- a/gdbus/client.c
> +++ b/gdbus/client.c
> @@ -1111,7 +1111,8 @@ static void get_managed_objects(GDBusClient *client)
>         if (!client->connected)
>                 return;
>
> -       if (!client->proxy_added && !client->proxy_removed) {
> +       if ((!client->proxy_added && !client->proxy_removed) ||
> +                                                       !client->root_path) {
>                 refresh_properties(client);
>                 return;
>         }
> @@ -1212,7 +1213,7 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
>         GDBusClient *client;
>         unsigned int i;
>
> -       if (!connection || !service || !root_path)
> +       if (!connection || !service)
>                 return NULL;
>
>         client = g_try_new0(GDBusClient, 1);
> @@ -1238,6 +1239,10 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
>                                                 service_connect,
>                                                 service_disconnect,
>                                                 client, NULL);
> +
> +       if (!root_path)
> +               return g_dbus_client_ref(client);
> +
>         client->added_watch = g_dbus_add_signal_watch(connection, service,
>                                                 client->root_path,
>                                                 DBUS_INTERFACE_OBJECT_MANAGER,
> --
> 2.1.0

Applied.


-- 
Luiz Augusto von Dentz

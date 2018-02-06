Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180206085151.15515-1-schultetwin1@gmail.com>
References: <20180206085151.15515-1-schultetwin1@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 6 Feb 2018 06:59:36 -0200
Message-ID: <CABBYNZ+7MvpXmpF3MS-WBCBdum1s6uvXjm7+z=UCutSoW_W=7A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: properly init client connected state
To: Matt Schulte <schultetwin1@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matt,

On Tue, Feb 6, 2018 at 6:51 AM, Matt Schulte <schultetwin1@gmail.com> wrote:
> GDBusClient struct's connected member was being initialize to false for
> all new clients even if the connection was connected. This changes the
> GDBusClient connected field to be initialized from the state of the dbus
> connection
> ---
>  gdbus/client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gdbus/client.c b/gdbus/client.c
> index eaab7d50b..a41ce1a7f 100644
> --- a/gdbus/client.c
> +++ b/gdbus/client.c
> @@ -1316,7 +1316,7 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
>         client->service_name = g_strdup(service);
>         client->base_path = g_strdup(path);
>         client->root_path = g_strdup(root_path);
> -       client->connected = FALSE;
> +       client->connected = dbus_connection_get_is_connected(connection);

This is actually to track if the client service name is available on
the bus, not the local connection passed as parameter which shall
always be connected, if the service has not been acquired yet it will
wait until it appears.

>         client->match_rules = g_ptr_array_sized_new(1);
>         g_ptr_array_set_free_func(client->match_rules, g_free);
> --
> 2.16.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

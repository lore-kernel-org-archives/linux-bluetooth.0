Return-Path: <cyrus@holtmann.org>
Message-ID: <1360136399.15783.1.camel@aeonflux>
Subject: Re: [PATCH v0] core: Fix racy D-Bus service name request
From: Marcel Holtmann <marcel@holtmann.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Date: Wed, 06 Feb 2013 09:39:59 +0200
In-Reply-To: <1360076455-32716-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1360076455-32716-1-git-send-email-mikel.astiz.oss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

> The ObjectManager interface should already be ready by the time the
> D-Bus service name is owned. Hence, use g_dbus_request_name() explicitly
> once g_dbus_attach_object_manager() has finished.
> 
> Without this patch, clients relying on the presence of the ObjectManager
> could potentially face a race condition.

I almost expected that someone sooner or later will run into this issue.

> ---
>  src/main.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/src/main.c b/src/main.c
> index 1e40ebc..12ae3d9 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -424,7 +424,7 @@ static int connect_dbus(void)
>  
>  	dbus_error_init(&err);
>  
> -	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, BLUEZ_NAME, &err);
> +	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, &err);
>  	if (!conn) {
>  		if (dbus_error_is_set(&err)) {
>  			g_printerr("D-Bus setup failed: %s\n", err.message);
> @@ -439,6 +439,12 @@ static int connect_dbus(void)
>  	g_dbus_set_disconnect_function(conn, disconnected_dbus, NULL, NULL);
>  	g_dbus_attach_object_manager(conn);
>  
> +	if (!g_dbus_request_name(conn, BLUEZ_NAME, &err)) {
> +		g_printerr("D-Bus service name request failed: %s\n",
> +								err.message);
> +		return -EIO;
> +	}
> +

The only thing that I do not really like here is that the request name
is actually a blocking call. If we are trying to fix this, then we might
actually really do this async.

Regards

Marcel



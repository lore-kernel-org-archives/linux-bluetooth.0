Return-Path: <cyrus@holtmann.org>
Message-ID: <1347882276.7515.6.camel@sirocco.hadess.net>
Subject: Re: [PATCH BlueZ v0 4/4] cups: Free D-Bus error
From: Bastien Nocera <hadess@hadess.net>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 17 Sep 2012 12:44:36 +0100
In-Reply-To: <1347639011-22924-4-git-send-email-s.syam@samsung.com>
References: <1347639011-22924-1-git-send-email-s.syam@samsung.com>
	 <1347639011-22924-4-git-send-email-s.syam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Em Fri, 2012-09-14 às 21:40 +0530, Syam Sidhardhan escreveu:
> If D-Bus error is set we should free it.

Looks good to me.

> ---
>  profiles/cups/main.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/profiles/cups/main.c b/profiles/cups/main.c
> index a884c6e..5aa927f 100644
> --- a/profiles/cups/main.c
> +++ b/profiles/cups/main.c
> @@ -446,8 +446,10 @@ static gboolean list_known_printers(const char *adapter)
>  
>  	dbus_message_unref(message);
>  
> -	if (dbus_error_is_set(&error))
> +	if (dbus_error_is_set(&error)) {
> +		dbus_error_free(&error);
>  		return FALSE;
> +	}
>  
>  	dbus_message_iter_init(reply, &reply_iter);
>  	if (dbus_message_iter_get_arg_type(&reply_iter) != DBUS_TYPE_ARRAY) {
> @@ -549,8 +551,10 @@ static gboolean list_printers(void)
>  
>  	dbus_error_init(&error);
>  	hcid_exists = dbus_bus_name_has_owner(conn, "org.bluez", &error);
> -	if (dbus_error_is_set(&error))
> +	if (dbus_error_is_set(&error)) {
> +		dbus_error_free(&error);
>  		return TRUE;
> +	}
>  
>  	if (!hcid_exists)
>  		return TRUE;
> @@ -570,6 +574,7 @@ static gboolean list_printers(void)
>  	dbus_message_unref(message);
>  
>  	if (dbus_error_is_set(&error)) {
> +		dbus_error_free(&error);
>  		dbus_connection_unref(conn);
>  		/* No adapter */
>  		return TRUE;



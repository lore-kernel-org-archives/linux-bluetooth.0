Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] gdbus: Use g_dbus_create_error_valist internally
Date: Thu, 09 Apr 2015 16:39:32 +0200
Message-ID: <1504839.97hPZ0nfai@leonov>
In-Reply-To: <1428437449-11210-1-git-send-email-szymon.janc@tieto.com>
References: <1428437449-11210-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 07 of April 2015 22:10:48 Szymon Janc wrote:
> There is no need to duplicate code in g_dbus_send_error_valist.
> ---
>  gdbus/object.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 4d5a64c..c3c137b 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -1530,11 +1530,8 @@ gboolean g_dbus_send_error_valist(DBusConnection
> *connection, const char *format, va_list args)
>  {
>  	DBusMessage *error;
> -	char str[1024];
> -
> -	vsnprintf(str, sizeof(str), format, args);
> 
> -	error = dbus_message_new_error(message, name, str);
> +	error = g_dbus_create_error_valist(message, name, format, args);
>  	if (error == NULL)
>  		return FALSE;

Applied.

-- 
BR
Szymon Janc

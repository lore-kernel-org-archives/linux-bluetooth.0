Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1419636684-7158-2-git-send-email-mariusz.skamra@tieto.com>
References: <1419636684-7158-1-git-send-email-mariusz.skamra@tieto.com>
	<1419636684-7158-2-git-send-email-mariusz.skamra@tieto.com>
Date: Mon, 29 Dec 2014 15:49:19 -0200
Message-ID: <CABBYNZLywKAkXEaWbFBQiKBeCBfWhegEdhbpp7z7dVYTiOcK4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add missing format specifiers in src/error.c
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Fri, Dec 26, 2014 at 9:31 PM, Mariusz Skamra
<mariusz.skamra@tieto.com> wrote:
> ---
>  src/error.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/src/error.c b/src/error.c
> index a80c1ab..ae227b6 100644
> --- a/src/error.c
> +++ b/src/error.c
> @@ -40,7 +40,7 @@ DBusMessage *btd_error_invalid_args(DBusMessage *msg)
>  DBusMessage *btd_error_invalid_args_str(DBusMessage *msg, const char *str)
>  {
>         return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
> -                                                                       str);
> +                                       "%s", str);
>  }
>
>  DBusMessage *btd_error_busy(DBusMessage *msg)
> @@ -99,7 +99,8 @@ DBusMessage *btd_error_not_authorized(DBusMessage *msg)
>
>  DBusMessage *btd_error_not_permitted(DBusMessage *msg, const char *str)
>  {
> -       return g_dbus_create_error(msg, ERROR_INTERFACE ".NotPermitted", str);
> +       return g_dbus_create_error(msg, ERROR_INTERFACE ".NotPermitted",
> +                                       "%s", str);
>  }
>
>  DBusMessage *btd_error_no_such_adapter(DBusMessage *msg)
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz

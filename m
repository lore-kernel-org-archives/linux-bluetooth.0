Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150604190626.GA6440@localhost.Belkin>
References: <20150604190626.GA6440@localhost.Belkin>
Date: Fri, 5 Jun 2015 17:32:50 +0300
Message-ID: <CABBYNZ+xEYWL2RD3mTRkjfhxEAbE=E6WbneWqxjp57vrBQ78Sw@mail.gmail.com>
Subject: Re: [PATCH] client: Display address if calling 'disconnect' without arguments
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mateusz Lemusisk <mrlemux@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mateusz,

On Thu, Jun 4, 2015 at 10:06 PM, Mateusz Lemusisk <mrlemux@gmail.com> wrote:
> Before:
>
> [PHILIPS BTM2180]# disconnect
> Attempting to disconnect from
> Successful disconnected
>
> After:
>
> [PHILIPS BTM2180]# disconnect
> Attempting to disconnect from XX:XX:XX:XX:XX:XX
> Successful disconnected
>
> ---
>  client/main.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/client/main.c b/client/main.c
> index 41e95b2..88ae5ed 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -1422,7 +1422,19 @@ static void cmd_disconn(const char *arg)
>                 return;
>         }
>
> -       rl_printf("Attempting to disconnect from %s\n", arg);
> +       if (strlen(arg) == 0) {
> +               const char *default_address;
> +               DBusMessageIter iter;
> +
> +               if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
> +                       default_address = "";
> +               else
> +                       dbus_message_iter_get_basic(&iter, &default_address);
> +
> +               rl_printf("Attempting to disconnect from %s\n", default_address);
> +       } else {
> +               rl_printf("Attempting to disconnect from %s\n", arg);
> +       }
>  }

Please check the columns limit is 80:
WARNING:LONG_LINE: line over 80 characters
#19: FILE: client/main.c:1434:
+ rl_printf("Attempting to disconnect from %s\n", default_address);

Also there is no need to add braces to single line if/else statements
and perhaps you could move rl_printf line out of them and make it
common so in case you have an arg you just assign it to address
variable, in fact it might be possible to use arg directly.

>  static void cmd_list_attributes(const char *arg)
> --
> 2.4.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

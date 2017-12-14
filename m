Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] client: Fix printing of array properties
Date: Thu, 14 Dec 2017 09:25:00 +0100
Message-ID: <25650192.ySbRX1kfQ5@ix>
In-Reply-To: <20171213132831.24740-1-szymon.janc@codecoup.pl>
References: <20171213132831.24740-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday, 13 December 2017 14:28:31 CET Szymon Janc wrote:
>         ServiceData Key: 00001234-0000-1000-8000-00805f9b34fb
>         ServiceData Value:
> "3D     RSSI: -76
>         TxPower: -7
> ---
>  client/main.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/client/main.c b/client/main.c
> index f3369e89a..a4b8b0fe5 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -184,7 +184,7 @@ static void print_fixed_iter(const char *label, const
> char *name, return;
> 
>  		bt_shell_printf("%s%s:\n", label, name);
> -		bt_shell_printf((void *)valbool, len * sizeof(*valbool));
> +		bt_shell_hexdump((void *)valbool, len * sizeof(*valbool));
> 
>  		break;
>  	case DBUS_TYPE_UINT32:
> @@ -194,7 +194,7 @@ static void print_fixed_iter(const char *label, const
> char *name, return;
> 
>  		bt_shell_printf("%s%s:\n", label, name);
> -		bt_shell_printf((void *)valu32, len * sizeof(*valu32));
> +		bt_shell_hexdump((void *)valu32, len * sizeof(*valu32));
> 
>  		break;
>  	case DBUS_TYPE_UINT16:
> @@ -204,7 +204,7 @@ static void print_fixed_iter(const char *label, const
> char *name, return;
> 
>  		bt_shell_printf("%s%s:\n", label, name);
> -		bt_shell_printf((void *)valu16, len * sizeof(*valu16));
> +		bt_shell_hexdump((void *)valu16, len * sizeof(*valu16));
> 
>  		break;
>  	case DBUS_TYPE_INT16:
> @@ -214,7 +214,7 @@ static void print_fixed_iter(const char *label, const
> char *name, return;
> 
>  		bt_shell_printf("%s%s:\n", label, name);
> -		bt_shell_printf((void *)vals16, len * sizeof(*vals16));
> +		bt_shell_hexdump((void *)vals16, len * sizeof(*vals16));
> 
>  		break;
>  	case DBUS_TYPE_BYTE:
> @@ -224,7 +224,7 @@ static void print_fixed_iter(const char *label, const
> char *name, return;
> 
>  		bt_shell_printf("%s%s:\n", label, name);
> -		bt_shell_printf((void *)byte, len * sizeof(*byte));
> +		bt_shell_hexdump((void *)byte, len * sizeof(*byte));
> 
>  		break;
>  	default:

Applied.

-- 
pozdrawiam
Szymon Janc

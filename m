Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bf9cb175-d8ae-6b6d-6a05-90b087ac4b49@jp.fujitsu.com>
References: <bf9cb175-d8ae-6b6d-6a05-90b087ac4b49@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Dec 2017 14:21:53 +0200
Message-ID: <CABBYNZKgood+9Jcmu9RT5o2YfxS8e4BLDw5RXFMS20WKbs5jow@mail.gmail.com>
Subject: Re: [PATCH BlueZ] tools/obexctl: Fix display of size/time during transfer
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Wed, Nov 29, 2017 at 10:29 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> When obexctl is run after starting to transfer a file, the transferred
> size and the remaining time will be extreme values first as below:
>
>   [NEW] Transfer /org/bluez/obex/server/session8/transfer6
>   [CHG] Transfer /org/bluez/obex/server/session8/transfer6 Transferred: 1670741 (@1670KB/s 03:52)
>   [CHG] Transfer /org/bluez/obex/server/session8/transfer6 Transferred: 1703502 (@32KB/s 197:14)
>   [CHG] Transfer /org/bluez/obex/server/session8/transfer6 Transferred: 1736263 (@32KB/s 197:13)
> ---
>  tools/obexctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/obexctl.c b/tools/obexctl.c
> index ece50f682..33ee180a3 100644
> --- a/tools/obexctl.c
> +++ b/tools/obexctl.c
> @@ -2319,7 +2319,7 @@ static void transfer_added(GDBusProxy *proxy)
>
>         data = g_new0(struct transfer_data, 1);
>
> -       if (g_dbus_proxy_get_property(proxy, "Transfered", &iter))
> +       if (g_dbus_proxy_get_property(proxy, "Transferred", &iter))
>                 dbus_message_iter_get_basic(&iter, &data->transferred);
>
>         if (g_dbus_proxy_get_property(proxy, "Size", &iter))
> --
> 2.14.1

Applied, thanks.

-- 
Luiz Augusto von Dentz

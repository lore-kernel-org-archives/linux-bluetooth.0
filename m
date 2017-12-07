Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171207142143.27324-5-szymon.janc@codecoup.pl>
References: <20171207142143.27324-1-szymon.janc@codecoup.pl> <20171207142143.27324-5-szymon.janc@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 7 Dec 2017 15:42:55 -0200
Message-ID: <CABBYNZ+Nw0KLgbEfU6F9f6kE4FAgTPspphFO5yW3Qs47hh05Sg@mail.gmail.com>
Subject: Re: [PATCH 4/9] tools/btpclient: Store index along with adapter proxy
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Dec 7, 2017 at 12:21 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> ---
>  tools/btpclient.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index c7ff239b0..3a4971eeb 100644
> --- a/tools/btpclient.c
> +++ b/tools/btpclient.c
> @@ -37,6 +37,7 @@
>
>  struct btp_adapter {
>         struct l_dbus_proxy *proxy;
> +       unsigned int index;
>  };
>
>  struct btp_device {
> @@ -157,9 +158,18 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
>
>         if (!strcmp(interface, "org.bluez.Adapter1")) {
>                 struct btp_adapter *adapter;
> +               unsigned int index;
> +
> +               /* TODO should we rely on path for index or use other mapping
> +                * like queue size?
> +                */
> +               if (sscanf(l_dbus_proxy_get_path(proxy), "/org/bluez/hci%u",
> +                                                               &index) != 1)
> +                       return;

Usually, we don't operate by index over D-Bus so if all operation are
over D-Bus knowing the index shall not be needed, if this is for BTP
then we could perhaps just map directly to the queue directly but Im
not sure why would BTP have an adapter index?

>                 adapter = l_new(struct btp_adapter, 1);
>                 adapter->proxy = proxy;
> +               adapter->index = index;
>
>                 l_queue_push_tail(adapters, adapter);
>                 return;
> --
> 2.14.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170906052743.6821-1-yunhanw@google.com>
References: <20170906052743.6821-1-yunhanw@google.com>
From: Yunhan Wang <yunhanw@google.com>
Date: Tue, 5 Sep 2017 22:36:49 -0700
Message-ID: <CALvjcs-LqVChWFu-Xtq7=7HeUt3ki7jyCqbZjbLj+-CaE0zp0g@mail.gmail.com>
Subject: Re: [PATCH v2] client: Fix default_ctrl change when new adapter is found
To: linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Yunhan Wang <yunhanw@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Luiz

Could you help to have a further review?

Thanks
Best wishes
Yunhan

On Tue, Sep 5, 2017 at 10:27 PM, Yunhan Wang <yunhanw@google.com> wrote:
> When another adapter is found, the default adapter would be changed,
> which is not expected. Default adapter can only be changed by select
> command.
> ---
>  client/main.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/client/main.c b/client/main.c
> index 75696c2c1..e76b6fc25 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -67,6 +67,7 @@ struct adapter {
>  };
>
>  static struct adapter *default_ctrl;
> +static struct adapter *cache_ctrl;
>  static GDBusProxy *default_dev;
>  static GDBusProxy *default_attr;
>  static GList *ctrl_list;
> @@ -151,7 +152,7 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
>
>         g_list_free_full(ctrl_list, proxy_leak);
>         ctrl_list = NULL;
> -
> +       cache_ctrl = NULL;
>         default_ctrl = NULL;
>  }
>
> @@ -521,15 +522,21 @@ static void device_added(GDBusProxy *proxy)
>
>  static void adapter_added(GDBusProxy *proxy)
>  {
> -       default_ctrl = g_malloc0(sizeof(struct adapter));
> -       default_ctrl->proxy = proxy;
> -       ctrl_list = g_list_append(ctrl_list, default_ctrl);
> +       struct adapter *adapter = g_malloc0(sizeof(struct adapter));
> +
> +       adapter->proxy = proxy;
> +       cache_ctrl = adapter;
> +       ctrl_list = g_list_append(ctrl_list, adapter);
> +
> +       if (!default_ctrl)
> +               default_ctrl = adapter;
> +
>         print_adapter(proxy, COLORED_NEW);
>  }
>
>  static void ad_manager_added(GDBusProxy *proxy)
>  {
> -       default_ctrl->ad_proxy = proxy;
> +       cache_ctrl->ad_proxy = proxy;
>  }
>
>  static void proxy_added(GDBusProxy *proxy, void *user_data)
> --
> 2.14.1.581.gf28d330327-goog
>

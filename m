Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170821060902.11655-1-yunhanw@google.com>
References: <20170821060902.11655-1-yunhanw@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 22 Aug 2017 16:38:51 +0300
Message-ID: <CABBYNZJsQ+wpt_y0r0MgxhrQNQ-L61N=sbEnnucNMkv21Ke84A@mail.gmail.com>
Subject: Re: [PATCH v3] client: Fix the selection bug of ad manager
To: Yunhan Wang <yunhanw@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On Mon, Aug 21, 2017 at 9:09 AM, Yunhan Wang <yunhanw@google.com> wrote:
> If there are multiple adapters, bluetoothctl may choose the wrong
> advertising manager. In addition, select command cannot update
> current advertising manager when choosing another adapter. Therefore, we
> need to put advertising manager under adapter structure to resolve this
> issue.
> ---
>  client/main.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/client/main.c b/client/main.c
> index 276e7f184..a29dab4aa 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -62,13 +62,13 @@ static char *auto_register_agent = NULL;
>
>  struct adapter {
>         GDBusProxy *proxy;
> +       GDBusProxy *ad_proxy;
>         GList *devices;
>  };
>
>  static struct adapter *default_ctrl;
>  static GDBusProxy *default_dev;
>  static GDBusProxy *default_attr;
> -static GDBusProxy *ad_manager;
>  static GList *ctrl_list;
>
>  static guint input = 0;
> @@ -521,17 +521,17 @@ static void device_added(GDBusProxy *proxy)
>
>  static void adapter_added(GDBusProxy *proxy)
>  {
> -       struct adapter *adapter = g_malloc0(sizeof(struct adapter));
> -
> -       adapter->proxy = proxy;
> -       ctrl_list = g_list_append(ctrl_list, adapter);
> -
> -       if (!default_ctrl)
> -               default_ctrl = adapter;
> -
> +       default_ctrl = g_malloc0(sizeof(struct adapter));
> +       default_ctrl->proxy = proxy;
> +       ctrl_list = g_list_append(ctrl_list, default_ctrl);
>         print_adapter(proxy, COLORED_NEW);
>  }
>
> +static void ad_manager_added(GDBusProxy *proxy)
> +{
> +       default_ctrl->ad_proxy = proxy;
> +}
> +
>  static void proxy_added(GDBusProxy *proxy, void *user_data)
>  {
>         const char *interface;
> @@ -560,7 +560,7 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
>         } else if (!strcmp(interface, "org.bluez.GattManager1")) {
>                 gatt_add_manager(proxy);
>         } else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
> -               ad_manager = proxy;
> +               ad_manager_added(proxy);
>         }
>  }
>
> @@ -649,8 +649,7 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
>         } else if (!strcmp(interface, "org.bluez.GattManager1")) {
>                 gatt_remove_manager(proxy);
>         } else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
> -               if (ad_manager == proxy) {
> -                       agent_manager = NULL;
> +               if(!dbus_conn){
>                         ad_unregister(dbus_conn, NULL);
>                 }
>         }
> @@ -2296,15 +2295,15 @@ static void cmd_advertise(const char *arg)
>         if (parse_argument_advertise(arg, &enable, &type) == FALSE)
>                 return;
>
> -       if (!ad_manager) {
> +       if (!default_ctrl || !default_ctrl->ad_proxy) {
>                 rl_printf("LEAdvertisingManager not found\n");
>                 return;
>         }
>
>         if (enable == TRUE)
> -               ad_register(dbus_conn, ad_manager, type);
> +               ad_register(dbus_conn, default_ctrl->ad_proxy, type);
>         else
> -               ad_unregister(dbus_conn, ad_manager);
> +               ad_unregister(dbus_conn, default_ctrl->ad_proxy);
>  }
>
>  static char *ad_generator(const char *text, int state)
> --
> 2.14.1.480.gb18f417b89-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz

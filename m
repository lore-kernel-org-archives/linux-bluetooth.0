Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1472807335-14958-2-git-send-email-beaufort.francois@gmail.com>
References: <1472807335-14958-1-git-send-email-beaufort.francois@gmail.com> <1472807335-14958-2-git-send-email-beaufort.francois@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 2 Sep 2016 17:14:54 +0300
Message-ID: <CABBYNZJ1QaQUHrEnrmAfWzNVqQV2ZqgnJxN9pEk4cwwZi8AORA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Add device set-alias bluetoothctl command
To: Francois Beaufort <beaufort.francois@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Francois,

On Fri, Sep 2, 2016 at 12:08 PM, Francois Beaufort
<beaufort.francois@gmail.com> wrote:
> ---
>  client/main.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/client/main.c b/client/main.c
> index 9ba5a40..e1198a8 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -1666,6 +1666,30 @@ static void cmd_list_attributes(const char *arg)
>         gatt_list_attributes(g_dbus_proxy_get_path(proxy));
>  }
>
> +static void cmd_set_alias(const char *arg)
> +{
> +       char *name;
> +
> +       if (!arg || !strlen(arg)) {
> +               rl_printf("Missing name argument\n");
> +               return;
> +       }
> +
> +       if (!default_dev) {
> +               rl_printf("No device connected\n");
> +               return;
> +       }
> +
> +       name = g_strdup(arg);
> +
> +       if (g_dbus_proxy_set_property_basic(default_dev, "Alias",
> +                                       DBUS_TYPE_STRING, &name,
> +                                       generic_callback, name, g_free) == TRUE)
> +               return;
> +
> +       g_free(name);
> +}
> +
>  static void cmd_select_attribute(const char *arg)
>  {
>         GDBusProxy *proxy;
> @@ -2105,6 +2129,7 @@ static const struct {
>                                                         dev_generator },
>         { "list-attributes", "[dev]", cmd_list_attributes, "List attributes",
>                                                         dev_generator },
> +       { "set-alias",    "<alias>",  cmd_set_alias, "Set device alias" },
>         { "select-attribute", "<attribute>",  cmd_select_attribute,
>                                 "Select attribute", attribute_generator },
>         { "attribute-info", "[attribute]",  cmd_attribute_info,
> --
> 2.7.0

Applied, thanks.

-- 
Luiz Augusto von Dentz

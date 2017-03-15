Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170314115241.18886-1-luiz.dentz@gmail.com>
References: <20170314115241.18886-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 15 Mar 2017 17:23:48 +0200
Message-ID: <CABBYNZLebDkd+J4Nod6H2kcQUaY-L84hko64qBLnsBSzbiW=QA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] client: Add support to pass UUIDs to select-attribute
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 14, 2017 at 1:52 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds support to match attributes by UUID instead of object path.
> ---
>  client/gatt.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>  client/main.c |  4 ++--
>  2 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/client/gatt.c b/client/gatt.c
> index 37f222d..f7a2f0c 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -299,7 +299,7 @@ static GDBusProxy *select_proxy(const char *path, GList *source)
>         return NULL;
>  }
>
> -GDBusProxy *gatt_select_attribute(const char *path)
> +static GDBusProxy *select_attribute(const char *path)
>  {
>         GDBusProxy *proxy;
>
> @@ -314,6 +314,50 @@ GDBusProxy *gatt_select_attribute(const char *path)
>         return select_proxy(path, descriptors);
>  }
>
> +static GDBusProxy *select_proxy_by_uuid(const char *uuid, GList *source)
> +{
> +       GList *l;
> +       const char *value;
> +       DBusMessageIter iter;
> +
> +       for (l = source; l; l = g_list_next(l)) {
> +               GDBusProxy *proxy = l->data;
> +
> +               if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
> +                       continue;
> +
> +               dbus_message_iter_get_basic(&iter, &value);
> +
> +               if (strcasecmp(uuid, value) == 0)
> +                       return proxy;
> +       }
> +
> +       return NULL;
> +}
> +
> +static GDBusProxy *select_attribute_by_uuid(const char *uuid)
> +{
> +       GDBusProxy *proxy;
> +
> +       proxy = select_proxy_by_uuid(uuid, services);
> +       if (proxy)
> +               return proxy;
> +
> +       proxy = select_proxy_by_uuid(uuid, characteristics);
> +       if (proxy)
> +               return proxy;
> +
> +       return select_proxy_by_uuid(uuid, descriptors);
> +}
> +
> +GDBusProxy *gatt_select_attribute(const char *arg)
> +{
> +       if (arg[0] == '/')
> +               return select_attribute(arg);
> +
> +       return select_attribute_by_uuid(arg);
> +}
> +
>  static char *attribute_generator(const char *text, int state, GList *source)
>  {
>         static int index, len;
> diff --git a/client/main.c b/client/main.c
> index e1198a8..d01e5fa 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -2130,9 +2130,9 @@ static const struct {
>         { "list-attributes", "[dev]", cmd_list_attributes, "List attributes",
>                                                         dev_generator },
>         { "set-alias",    "<alias>",  cmd_set_alias, "Set device alias" },
> -       { "select-attribute", "<attribute>",  cmd_select_attribute,
> +       { "select-attribute", "<attribute/UUID>",  cmd_select_attribute,
>                                 "Select attribute", attribute_generator },
> -       { "attribute-info", "[attribute]",  cmd_attribute_info,
> +       { "attribute-info", "[attribute/UUID]",  cmd_attribute_info,
>                                 "Select attribute", attribute_generator },
>         { "read",         NULL,       cmd_read, "Read attribute value" },
>         { "write",        "<data=[xx xx ...]>", cmd_write,
> --
> 2.9.3


Applied.


-- 
Luiz Augusto von Dentz

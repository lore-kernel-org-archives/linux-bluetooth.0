Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170815081842.14872-1-luiz.dentz@gmail.com>
References: <20170815081842.14872-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Aug 2017 14:01:27 +0300
Message-ID: <CABBYNZKMXffvW46SZh_aqhGwJ2JoH0QNHcQV6FfxFFVE5XTojQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] advertising: Allow changes to properties
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 15, 2017 at 11:18 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This enables the application to change the advertising object instead of
> having it unregistered and registered once again.
> ---
>  src/advertising.c | 156 +++++++++++++++++++++++++++++-------------------------
>  1 file changed, 85 insertions(+), 71 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 9eb22b9fd..f125ca5c8 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -21,6 +21,7 @@
>
>  #include <stdint.h>
>  #include <stdbool.h>
> +#include <errno.h>
>
>  #include <dbus/dbus.h>
>  #include <gdbus/gdbus.h>
> @@ -468,6 +469,7 @@ static bool parse_local_name(DBusMessageIter *iter,
>
>         dbus_message_iter_get_basic(iter, &name);
>
> +       free(client->name);
>         client->name = strdup(name);
>
>         return true;
> @@ -504,58 +506,6 @@ static struct adv_parser {
>         { },
>  };
>
> -static void add_client_complete(struct btd_adv_client *client, uint8_t status)
> -{
> -       DBusMessage *reply;
> -
> -       if (status) {
> -               error("Failed to add advertisement: %s (0x%02x)",
> -                                               mgmt_errstr(status), status);
> -               reply = btd_error_failed(client->reg,
> -                                       "Failed to register advertisement");
> -               queue_remove(client->manager->clients, client);
> -               g_idle_add(client_free_idle_cb, client);
> -
> -       } else
> -               reply = dbus_message_new_method_return(client->reg);
> -
> -       g_dbus_send_message(btd_get_dbus_connection(), reply);
> -       dbus_message_unref(client->reg);
> -       client->reg = NULL;
> -}
> -
> -static void add_adv_callback(uint8_t status, uint16_t length,
> -                                         const void *param, void *user_data)
> -{
> -       struct btd_adv_client *client = user_data;
> -       const struct mgmt_rp_add_advertising *rp = param;
> -
> -       if (status)
> -               goto done;
> -
> -       if (!param || length < sizeof(*rp)) {
> -               status = MGMT_STATUS_FAILED;
> -               goto done;
> -       }
> -
> -       client->instance = rp->instance;
> -
> -       g_dbus_client_set_disconnect_watch(client->client, client_disconnect_cb,
> -                                                                       client);
> -       DBG("Advertisement registered: %s", client->path);
> -
> -       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> -                               adapter_get_path(client->manager->adapter),
> -                               LE_ADVERTISING_MGR_IFACE, "SupportedInstances");
> -
> -       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> -                               adapter_get_path(client->manager->adapter),
> -                               LE_ADVERTISING_MGR_IFACE, "ActiveInstances");
> -
> -done:
> -       add_client_complete(client, status);
> -}
> -
>  static size_t calc_max_adv_len(struct btd_adv_client *client, uint32_t flags)
>  {
>         size_t max = client->manager->max_adv_len;
> @@ -619,7 +569,7 @@ static uint8_t *generate_scan_rsp(struct btd_adv_client *client,
>         return bt_ad_generate(client->scan, len);
>  }
>
> -static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
> +static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func)
>  {
>         struct mgmt_cp_add_advertising *cp;
>         uint8_t param_len;
> @@ -639,33 +589,24 @@ static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
>         adv_data = generate_adv_data(client, &flags, &adv_data_len);
>         if (!adv_data || (adv_data_len > calc_max_adv_len(client, flags))) {
>                 error("Advertising data too long or couldn't be generated.");
> -
> -               return g_dbus_create_error(client->reg, ERROR_INTERFACE
> -                                               ".InvalidLength",
> -                                               "Advertising data too long.");
> +               return -EINVAL;
>         }
>
>         scan_rsp = generate_scan_rsp(client, &flags, &scan_rsp_len);
>         if (!scan_rsp && scan_rsp_len) {
>                 error("Scan data couldn't be generated.");
> -
> -               return g_dbus_create_error(client->reg, ERROR_INTERFACE
> -                                               ".InvalidLength",
> -                                               "Advertising data too long.");
> +               return -EINVAL;
>         }
>
>         param_len = sizeof(struct mgmt_cp_add_advertising) + adv_data_len +
>                                                         scan_rsp_len;
>
>         cp = malloc0(param_len);
> -
>         if (!cp) {
>                 error("Couldn't allocate for MGMT!");
> -
>                 free(adv_data);
>                 free(scan_rsp);
> -
> -               return btd_error_failed(client->reg, "Failed");
> +               return -ENOMEM;
>         }
>
>         cp->flags = htobl(flags);
> @@ -680,22 +621,93 @@ static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
>
>         if (!mgmt_send(client->manager->mgmt, MGMT_OP_ADD_ADVERTISING,
>                                 client->manager->mgmt_index, param_len, cp,
> -                               add_adv_callback, client, NULL)) {
> +                               func, client, NULL)) {
>                 error("Failed to add Advertising Data");
> -
>                 free(cp);
> -
> -               return btd_error_failed(client->reg, "Failed");
> +               return -EINVAL;
>         }
>
>         free(cp);
>
> -       return NULL;
> +       return 0;
> +}
> +
> +static void properties_changed(GDBusProxy *proxy, const char *name,
> +                                       DBusMessageIter *iter, void *user_data)
> +{
> +       struct btd_adv_client *client = user_data;
> +       struct adv_parser *parser;
> +
> +       for (parser = parsers; parser && parser->name; parser++) {
> +               if (strcmp(parser->name, name))
> +                       continue;
> +
> +               if (parser->func(iter, client)) {
> +                       refresh_adv(client, NULL);
> +                       break;
> +               }
> +       }
> +}
> +
> +static void add_client_complete(struct btd_adv_client *client, uint8_t status)
> +{
> +       DBusMessage *reply;
> +
> +       if (status) {
> +               error("Failed to add advertisement: %s (0x%02x)",
> +                                               mgmt_errstr(status), status);
> +               reply = btd_error_failed(client->reg,
> +                                       "Failed to register advertisement");
> +               queue_remove(client->manager->clients, client);
> +               g_idle_add(client_free_idle_cb, client);
> +
> +       } else
> +               reply = dbus_message_new_method_return(client->reg);
> +
> +       g_dbus_send_message(btd_get_dbus_connection(), reply);
> +       dbus_message_unref(client->reg);
> +       client->reg = NULL;
> +}
> +
> +static void add_adv_callback(uint8_t status, uint16_t length,
> +                                         const void *param, void *user_data)
> +{
> +       struct btd_adv_client *client = user_data;
> +       const struct mgmt_rp_add_advertising *rp = param;
> +
> +       if (status)
> +               goto done;
> +
> +       if (!param || length < sizeof(*rp)) {
> +               status = MGMT_STATUS_FAILED;
> +               goto done;
> +       }
> +
> +       client->instance = rp->instance;
> +
> +       g_dbus_client_set_disconnect_watch(client->client, client_disconnect_cb,
> +                                                                       client);
> +       DBG("Advertisement registered: %s", client->path);
> +
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                               adapter_get_path(client->manager->adapter),
> +                               LE_ADVERTISING_MGR_IFACE, "SupportedInstances");
> +
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                               adapter_get_path(client->manager->adapter),
> +                               LE_ADVERTISING_MGR_IFACE, "ActiveInstances");
> +
> +       g_dbus_proxy_set_property_watch(client->proxy, properties_changed,
> +                                                               client);
> +
> +done:
> +       add_client_complete(client, status);
>  }
>
>  static DBusMessage *parse_advertisement(struct btd_adv_client *client)
>  {
>         struct adv_parser *parser;
> +       int err;
>
>         for (parser = parsers; parser && parser->name; parser++) {
>                 DBusMessageIter iter;
> @@ -710,7 +722,9 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
>                 }
>         }
>
> -       return refresh_advertisement(client);
> +       err = refresh_adv(client, add_adv_callback);
> +       if (!err)
> +               return NULL;
>
>  fail:
>         return btd_error_failed(client->reg, "Failed to parse advertisement.");
> --
> 2.13.4

Applied.


-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180529083218.32603-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180529083218.32603-1-grzegorz.kolodziejczyk@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 May 2018 14:39:37 +0300
Message-ID: <CABBYNZ+EzkhLD23QkWhVN4vXt-3snxPhCorvNG2qhe4zEzswGw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] client: Don't require authorization for trusted devices
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tue, May 29, 2018 at 11:32 AM, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@codecoup.pl> wrote:
> This patch adds possibility to ommit authorization request from trusted
> devices.
> ---
>  client/gatt.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/client/gatt.c b/client/gatt.c
> index 3e70f365c..c7dfe42d7 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -1720,6 +1720,20 @@ error:
>         g_free(aad);
>  }
>
> +static bool is_device_trusted(const char *path)
> +{
> +       GDBusProxy *proxy;
> +       DBusMessageIter iter;
> +       bool trusted;
> +
> +       proxy = bt_shell_get_env(path);
> +
> +       if (g_dbus_proxy_get_property(proxy, "Trusted", &iter))
> +               dbus_message_iter_get_basic(&iter, &trusted);
> +
> +       return trusted;
> +}
> +
>  static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
>                                                         void *user_data)
>  {
> @@ -1739,7 +1753,7 @@ static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
>         bt_shell_printf("ReadValue: %s offset %u link %s\n",
>                                         path_to_address(device), offset, link);
>
> -       if (chrc->authorization_req) {
> +       if (!is_device_trusted(device) && chrc->authorization_req) {
>                 struct authorize_attribute_data *aad;
>
>                 aad = g_new0(struct authorize_attribute_data, 1);
> @@ -1865,6 +1879,7 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
>         struct chrc *chrc = user_data;
>         uint16_t offset = 0;
>         bool prep_authorize = false;
> +       char *device = NULL;
>         DBusMessageIter iter;
>         int value_len;
>         uint8_t *value;
> @@ -1877,11 +1892,11 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
>                                 "org.bluez.Error.InvalidArguments", NULL);
>
>         dbus_message_iter_next(&iter);
> -       if (parse_options(&iter, &offset, NULL, NULL, NULL, &prep_authorize))
> +       if (parse_options(&iter, &offset, NULL, &device, NULL, &prep_authorize))
>                 return g_dbus_create_error(msg,
>                                 "org.bluez.Error.InvalidArguments", NULL);
>
> -       if (chrc->authorization_req) {
> +       if (!is_device_trusted(device) && chrc->authorization_req) {
>                 struct authorize_attribute_data *aad;
>
>                 aad = g_new0(struct authorize_attribute_data, 1);
> --
> 2.13.6

Applied, thanks.

-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20180502091757.24190-1-grzegorz.kolodziejczyk@codecoup.pl> <20180502091757.24190-3-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180502091757.24190-3-grzegorz.kolodziejczyk@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 02 May 2018 10:42:29 +0000
Message-ID: <CABBYNZJVwKdAKPGxgOE_48=2zLvETe8oirr8w56Su5PrUh1eyA@mail.gmail.com>
Subject: Re: [RFC 2/2] client: Add authorized property handling to
 characteristic attribute
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,
On Wed, May 2, 2018 at 1:09 PM Grzegorz Kolodziejczyk <
grzegorz.kolodziejczyk@codecoup.pl> wrote:

> This patch adds handling of authorized property to bluetoothctl.
> ---
>   client/gatt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)

> diff --git a/client/gatt.c b/client/gatt.c
> index 6bf644c48..fffa86851 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -1432,6 +1432,30 @@ static gboolean chrc_notify_acquired_exists(const
GDBusPropertyTable *property,
>          return FALSE;
>   }

> +static gboolean chrc_get_authorized(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct chrc *chrc = data;
> +       dbus_bool_t value;
> +
> +       value = chrc->authorized ? TRUE : FALSE;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
> +
> +       return TRUE;
> +}
> +
> +static gboolean chrc_get_authorized_exists(const GDBusPropertyTable
*property,
> +                                                               void
*data)
> +{
> +       struct chrc *chrc = data;
> +
> +       if (chrc->authorization_req)
> +               return TRUE;
> +
> +       return FALSE;
> +}
> +
>   static const GDBusPropertyTable chrc_properties[] = {
>          { "UUID", "s", chrc_get_uuid, NULL, NULL },
>          { "Service", "o", chrc_get_service, NULL, NULL },
> @@ -1442,6 +1466,8 @@ static const GDBusPropertyTable chrc_properties[] =
{
>                                          chrc_write_acquired_exists },
>          { "NotifyAcquired", "b", chrc_get_notify_acquired, NULL,
>                                          chrc_notify_acquired_exists },
> +       { "Authorized", "b", chrc_get_authorized, NULL,
> +
chrc_get_authorized_exists },
>          { }
>   };

> @@ -1665,6 +1691,15 @@ static void authorize_write_response(const char
*input, void *user_data)

>          chrc->authorized = true;

> +       /* Authorization check of prepare writes */
> +       if (!chrc->value_len) {
> +               reply = g_dbus_create_reply(pending_message,
DBUS_TYPE_INVALID);
> +               g_dbus_send_message(aad->conn, reply);
> +               g_free(aad);
> +
> +               return;
> +       }
> +
>          errsv = parse_value_arg(&iter, &chrc->value, &chrc->value_len,

chrc->max_val_len);
>          if (errsv == -EINVAL) {
> @@ -1701,8 +1736,16 @@ static DBusMessage
*chrc_write_value(DBusConnection *conn, DBusMessage *msg,
>          DBusMessageIter iter;
>          char *str;
>          int errsv;
> +       uint16_t offset = 0;

>          dbus_message_iter_init(msg, &iter);
> +       /* Get offset only (second parameter) */
> +       dbus_message_iter_next(&iter);
> +
> +       parse_options(&iter, &offset, NULL, NULL, NULL);
> +
> +       if (chrc->authorization_req && offset == 0)
> +               chrc->authorized = false;

>          if (chrc->authorization_req && !chrc->authorized) {
>                  struct authorize_attribute_data *aad;
> @@ -1722,6 +1765,9 @@ static DBusMessage *chrc_write_value(DBusConnection
*conn, DBusMessage *msg,
>                  return NULL;
>          }

> +       /* Rewind to value parameter */
> +       dbus_message_iter_init(msg, &iter);

I would prefer to make parse_value_arg parse the offset as well so we don't
have to reinit the iter.

>          errsv = parse_value_arg(&iter, &chrc->value, &chrc->value_len,

chrc->max_val_len);
>          if (errsv == -EINVAL) {
> --
> 2.13.6

> --
> To unsubscribe from this list: send the line "unsubscribe
linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

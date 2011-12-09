Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1323358075-27857-10-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
	<1323358075-27857-10-git-send-email-mikel.astiz@bmw-carit.de>
Date: Fri, 9 Dec 2011 14:17:43 +0200
Message-ID: <CABBYNZ+Ynj3aMtDjFnZEWAvFSRfpNSDDR4BAysuqr93K52AscQ@mail.gmail.com>
Subject: Re: [RFC obexd v2 09/21] client: replace parameter dict with
 conventional ones
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Dec 8, 2011 at 5:27 PM, Mikel Astiz <mikel.astiz@bmw-carit.de> wrote:
> ---
>  client/manager.c             |   47 +++++++++++++++++++++++++++++------------
>  test/exchange-business-cards |    3 +-
>  test/ftp-client              |    3 +-
>  test/list-folders            |    2 +-
>  test/pbap-client             |    2 +-
>  test/pull-business-card      |    3 +-
>  test/send-files              |    3 +-
>  7 files changed, 39 insertions(+), 24 deletions(-)
>
> diff --git a/client/manager.c b/client/manager.c
> index 99c495a..ce3aa91 100644
> --- a/client/manager.c
> +++ b/client/manager.c
> @@ -101,9 +101,7 @@ done:
>        g_free(data);
>  }
>
> -static int parse_device_dict(DBusMessageIter *iter,
> -               const char **source, const char **dest, const char **target,
> -               uint8_t *channel)
> +static int parse_device_dict(DBusMessageIter *iter, uint8_t *channel)
>  {
>        while (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_DICT_ENTRY) {
>                DBusMessageIter entry, value;
> @@ -116,14 +114,6 @@ static int parse_device_dict(DBusMessageIter *iter,
>                dbus_message_iter_recurse(&entry, &value);
>
>                switch (dbus_message_iter_get_arg_type(&value)) {
> -               case DBUS_TYPE_STRING:
> -                       if (g_str_equal(key, "Source") == TRUE)
> -                               dbus_message_iter_get_basic(&value, source);
> -                       else if (g_str_equal(key, "Destination") == TRUE)
> -                               dbus_message_iter_get_basic(&value, dest);
> -                       else if (g_str_equal(key, "Target") == TRUE)
> -                               dbus_message_iter_get_basic(&value, target);
> -                       break;
>                case DBUS_TYPE_BYTE:
>                        if (g_str_equal(key, "Channel") == TRUE)
>                                dbus_message_iter_get_basic(&value, channel);
> @@ -160,10 +150,36 @@ static DBusMessage *create_session(DBusConnection *connection,
>        uint8_t channel = 0;
>
>        dbus_message_iter_init(message, &iter);
> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
> +               return g_dbus_create_error(message,
> +                               "org.openobex.Error.InvalidArguments", NULL);
> +
> +       dbus_message_iter_get_basic(&iter, &source);
> +       dbus_message_iter_next(&iter);
> +
> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
> +               return g_dbus_create_error(message,
> +                               "org.openobex.Error.InvalidArguments", NULL);
> +
> +       dbus_message_iter_get_basic(&iter, &dest);
> +       dbus_message_iter_next(&iter);
> +
> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
> +               return g_dbus_create_error(message,
> +                               "org.openobex.Error.InvalidArguments", NULL);
> +
> +       dbus_message_iter_get_basic(&iter, &target);
> +       dbus_message_iter_next(&iter);
> +
> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
> +               return g_dbus_create_error(message,
> +                               "org.openobex.Error.InvalidArguments", NULL);
> +
>        dbus_message_iter_recurse(&iter, &dict);
>
> -       parse_device_dict(&dict, &source, &dest, &target, &channel);
> -       if (dest == NULL || target == NULL)
> +       parse_device_dict(&dict, &channel);
> +
> +       if (*dest == '\0' || *target == '\0')
>                return g_dbus_create_error(message,
>                                "org.openobex.Error.InvalidArguments", NULL);
>
> @@ -172,6 +188,9 @@ static DBusMessage *create_session(DBusConnection *connection,
>                return g_dbus_create_error(message,
>                                        "org.openobex.Error.NoMemory", NULL);
>
> +       if (*source == '\0')
> +               source = NULL;
> +
>        data->connection = dbus_connection_ref(connection);
>        data->message = dbus_message_ref(message);
>
> @@ -219,7 +238,7 @@ static DBusMessage *remove_session(DBusConnection *connection,
>  }
>
>  static GDBusMethodTable client_methods[] = {
> -       { "CreateSession", "a{sv}", "o", create_session,
> +       { "CreateSession", "sssa{sv}", "o", create_session,
>                                                G_DBUS_METHOD_FLAG_ASYNC },

Only destination should be mandatory, the rest leave in the dictionary
as they are optional.

-- 
Luiz Augusto von Dentz

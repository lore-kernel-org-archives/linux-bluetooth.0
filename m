Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20180427140129.31658-1-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180427140129.31658-1-grzegorz.kolodziejczyk@codecoup.pl>
From: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Date: Fri, 27 Apr 2018 14:19:24 +0000
Message-ID: <CALevQMZ=LMN2dLss9zYwHnE+vAYZ8RLYotNJYnCJawL-bnkzzw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] client: Add possiblity to define maximum attribute
 value length
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

pt., 27 kwi 2018 o 16:01 Grzegorz Kolodziejczyk <
grzegorz.kolodziejczyk@codecoup.pl> napisa=C5=82(a):
> This patch allows to define maximum value length for characteristic and
> descriptor value while registering.
> ---
>    client/gatt.c | 66
+++++++++++++++++++++++++++++++++++++++++++++++------------
>    client/gatt.h |  4 ++++
>    client/main.c | 13 ++++++------
>    3 files changed, 64 insertions(+), 19 deletions(-)

> diff --git a/client/gatt.c b/client/gatt.c
> index d59d1ba1e..969a78be0 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -60,6 +60,7 @@ struct desc {
>           char *uuid;
>           char **flags;
>           int value_len;
> +       unsigned int max_val_len;
>           uint8_t *value;
>    };

> @@ -71,6 +72,7 @@ struct chrc {
>           bool notifying;
>           GList *descs;
>           int value_len;
> +       unsigned int max_val_len;
>           uint8_t *value;
>           uint16_t mtu;
>           struct io *write_io;
> @@ -612,7 +614,7 @@ static void write_attribute(GDBusProxy *proxy, char
*val_str, uint16_t offset)
>    {
>           struct iovec iov;
>           struct write_attribute_data wd;
> -       uint8_t value[512];
> +       uint8_t value[MAX_ATTR_VAL_LEN];
>           char *entry;
>           unsigned int i;

> @@ -689,7 +691,7 @@ void gatt_write_attribute(GDBusProxy *proxy, int
argc, char *argv[])
>    static bool pipe_read(struct io *io, void *user_data)
>    {
>           struct chrc *chrc =3D user_data;
> -       uint8_t buf[512];
> +       uint8_t buf[MAX_ATTR_VAL_LEN];
>           int fd =3D io_get_fd(io);
>           ssize_t bytes_read;

> @@ -1611,7 +1613,8 @@ static DBusMessage *chrc_read_value(DBusConnection
*conn, DBusMessage *msg,
>           return read_value(msg, &chrc->value[offset], chrc->value_len -
offset);
>    }

> -static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int
*len)
> +static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int
*len,
> +                                                               int
max_len)
>    {
>           DBusMessageIter array;
>           uint16_t offset =3D 0;
> @@ -1628,6 +1631,9 @@ static int parse_value_arg(DBusMessageIter *iter,
uint8_t **value, int *len)
>           if (parse_options(iter, &offset, NULL, NULL, NULL))
>                   return -EINVAL;

> +       if ((offset + read_len) > max_len)
> +               return -EOVERFLOW;
> +
>           if ((offset + read_len) > *len) {
>                   *len =3D offset + read_len;
>                   *value =3D g_realloc(*value, *len);
> @@ -1645,6 +1651,7 @@ static void authorize_write_response(const char
*input, void *user_data)
>           DBusMessageIter iter;
>           DBusMessage *reply;
>           char *err;
> +       int errsv;

>           dbus_message_iter_init(pending_message, &iter);

> @@ -1656,10 +1663,16 @@ static void authorize_write_response(const char
*input, void *user_data)

>           chrc->authorized =3D true;

> -       if (parse_value_arg(&iter, &chrc->value, &chrc->value_len)) {
> +       errsv =3D parse_value_arg(&iter, &chrc->value, &chrc->value_len,
> +
chrc->max_val_len);
> +       if (errsv =3D=3D -EINVAL) {
>                   err =3D "org.bluez.Error.InvalidArguments";

>                   goto error;
> +       } else if (errsv =3D=3D -EOVERFLOW) {
> +               err =3D "org.bluez.Error.InvalidValueLength";
> +
> +               goto error;
>           }

>           bt_shell_printf("[" COLORED_CHG "] Attribute %s written" ,
chrc->path);
> @@ -1685,6 +1698,7 @@ static DBusMessage *chrc_write_value(DBusConnection
*conn, DBusMessage *msg,
>           struct chrc *chrc =3D user_data;
>           DBusMessageIter iter;
>           char *str;
> +       int errsv;

>           dbus_message_iter_init(msg, &iter);

> @@ -1706,10 +1720,15 @@ static DBusMessage
*chrc_write_value(DBusConnection *conn, DBusMessage *msg,
>                   return NULL;
>           }

> -       if (parse_value_arg(&iter, &chrc->value, &chrc->value_len))
> +       errsv =3D parse_value_arg(&iter, &chrc->value, &chrc->value_len,
> +
chrc->max_val_len);
> +       if (errsv =3D=3D -EINVAL) {
>                   return g_dbus_create_error(msg,
> -
"org.bluez.Error.InvalidArguments",
> -                                       NULL);
> +                               "org.bluez.Error.InvalidArguments", NULL)=
;
> +       } else if (errsv =3D=3D -EOVERFLOW) {
> +               return g_dbus_create_error(msg,
> +                               "org.bluez.Error.InvalidValueLength",
NULL);
> +       }

>           bt_shell_printf("[" COLORED_CHG "] Attribute %s written" ,
chrc->path);

> @@ -1881,9 +1900,9 @@ static const GDBusMethodTable chrc_methods[] =3D {
>           { }
>    };

> -static uint8_t *str2bytearray(char *arg, int *val_len)
> +static uint8_t *str2bytearray(char *arg, int *val_len, unsigned int
max_val_len)
>    {
> -       uint8_t value[512];
> +       uint8_t value[MAX_ATTR_VAL_LEN];
>           char *entry;
>           unsigned int i;

> @@ -1908,6 +1927,12 @@ static uint8_t *str2bytearray(char *arg, int
*val_len)
>                   value[i] =3D val;
>           }

> +       if (i > max_val_len) {
> +               bt_shell_printf("Value exceeds maximum length (%i)\n",
> +
max_val_len);
> +               return NULL;
> +       }
> +
>           *val_len =3D i;

>           return g_memdup(value, i);
> @@ -1919,7 +1944,13 @@ static void chrc_set_value(const char *input, void
*user_data)

>           g_free(chrc->value);

> -       chrc->value =3D str2bytearray((char *) input, &chrc->value_len);
> +       chrc->value =3D str2bytearray((char *) input, &chrc->value_len,
> +
chrc->max_val_len);
> +
> +       if (!chrc->value) {
> +               print_chrc(chrc, COLORED_DEL);
> +               chrc_unregister(chrc);
> +       }
>    }

>    void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
> @@ -1940,7 +1971,8 @@ void gatt_register_chrc(DBusConnection *conn,
GDBusProxy *proxy,
>           chrc->uuid =3D g_strdup(argv[1]);
>           chrc->path =3D g_strdup_printf("%s/chrc%p", service->path, chrc=
);
>           chrc->flags =3D g_strsplit(argv[2], ",", -1);
> -       chrc->authorization_req =3D argc > 3 ? true : false;
> +       chrc->max_val_len =3D argc > 3 ? atoi(argv[3]) : MAX_ATTR_VAL_LEN=
;
> +       chrc->authorization_req =3D argc > 4 ? true : false;

>           if (g_dbus_register_interface(conn, chrc->path, CHRC_INTERFACE,
>                                           chrc_methods, NULL,
chrc_properties,
> @@ -2037,7 +2069,8 @@ static DBusMessage *desc_write_value(DBusConnection
*conn, DBusMessage *msg,

>           dbus_message_iter_init(msg, &iter);

> -       if (parse_value_arg(&iter, &desc->value, &desc->value_len))
> +       if (parse_value_arg(&iter, &desc->value, &desc->value_len,
> +
desc->max_val_len))
>                   return g_dbus_create_error(msg,

"org.bluez.Error.InvalidArguments",
>                                           NULL);
> @@ -2140,7 +2173,13 @@ static void desc_set_value(const char *input, void
*user_data)

>           g_free(desc->value);

> -       desc->value =3D str2bytearray((char *) input, &desc->value_len);
> +       desc->value =3D str2bytearray((char *) input, &desc->value_len,
> +
desc->max_val_len);
> +
> +       if (!desc->value) {
> +               print_desc(desc, COLORED_DEL);
> +               desc_unregister(desc);
> +       }
>    }

>    void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
> @@ -2166,6 +2205,7 @@ void gatt_register_desc(DBusConnection *conn,
GDBusProxy *proxy,
>           desc->uuid =3D g_strdup(argv[1]);
>           desc->path =3D g_strdup_printf("%s/desc%p", desc->chrc->path,
desc);
>           desc->flags =3D g_strsplit(argv[2], ",", -1);
> +       desc->max_val_len =3D argc > 3 ? atoi(argv[3]) : MAX_ATTR_VAL_LEN=
;

>           if (g_dbus_register_interface(conn, desc->path, DESC_INTERFACE,
>                                           desc_methods, NULL,
desc_properties,
> diff --git a/client/gatt.h b/client/gatt.h
> index 957ae8003..189a0aa40 100644
> --- a/client/gatt.h
> +++ b/client/gatt.h
> @@ -21,6 +21,10 @@
>     *
>     */

> +#define MAX_ATTR_VAL_LEN       512
> +#define STR_(i) #i
> +#define STR(i) STR_(i)
> +
>    void gatt_add_service(GDBusProxy *proxy);
>    void gatt_remove_service(GDBusProxy *proxy);

> diff --git a/client/main.c b/client/main.c
> index dd85a1c85..60e0f10b0 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -2013,7 +2013,7 @@ static void cmd_register_characteristic(int argc,
char *argv[])
>           if (check_default_ctrl() =3D=3D FALSE)
>                   return bt_shell_noninteractive_quit(EXIT_FAILURE);

> -       if (argc > 3 && strcmp(argv[3], "authorize")) {
> +       if (argc > 4 && strcmp(argv[4], "authorize")) {
>                   bt_shell_printf("Invalid authorize argument\n");
>                   return bt_shell_noninteractive_quit(EXIT_FAILURE);
>           }
> @@ -2437,14 +2437,15 @@ static const struct bt_shell_menu gatt_menu =3D {
>           { "unregister-service", "<UUID/object>", cmd_unregister_service=
,
>                                           "Unregister application service=
"
},
>           { "register-characteristic", "<UUID> <Flags=3Dread,write,notify=
...>
"
> -                               "[authorize]",
cmd_register_characteristic,
> -                               "Register application characteristic" },
> +                       "[max value len=3D0(default=3D" STR(MAX_ATTR_VAL_=
LEN)
")-"
> +                       STR(MAX_ATTR_VAL_LEN) "] [authorize]",
> +                       cmd_register_characteristic,
> +                       "Register application characteristic" },
>           { "unregister-characteristic", "<UUID/object>",
>                                   cmd_unregister_characteristic,
>                                   "Unregister application characteristic"
},
> -       { "register-descriptor", "<UUID> <Flags=3Dread,write...>",
> -                                       cmd_register_descriptor,
> -                                       "Register application descriptor"
},
> +       { "register-descriptor", "<UUID> <Flags=3Dread,write...> [max val=
ue
len]",
> +               cmd_register_descriptor, "Register application
descriptor" },
>           { "unregister-descriptor", "<UUID/object>",
>                                           cmd_unregister_descriptor,
>                                           "Unregister application
descriptor" },
> --
> 2.13.6

Please ommit this - it's send by accident.

Regards,
Grzegorz

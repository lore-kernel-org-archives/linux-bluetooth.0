Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20180516135230.7182-1-grzegorz.kolodziejczyk@codecoup.pl>
 <20180516135230.7182-5-grzegorz.kolodziejczyk@codecoup.pl> <CABBYNZ+7TCn6GGER8Xne134mY1S-7OQgTT48eO-vDJjr3qn3=w@mail.gmail.com>
In-Reply-To: <CABBYNZ+7TCn6GGER8Xne134mY1S-7OQgTT48eO-vDJjr3qn3=w@mail.gmail.com>
From: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Date: Tue, 22 May 2018 09:59:06 +0200
Message-ID: <CALevQMZL3bn4kyoE_EWTLag-kfP80s2fqs_VVMDwSC5zWvv-rQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 5/5] client: Add authorized property handling to
 characteristic attribute
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,
pon., 21 maj 2018 o 11:58 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
napisa=C5=82(a):

> Hi Grzegorz,

> On Wed, May 16, 2018 at 4:52 PM, Grzegorz Kolodziejczyk
> <grzegorz.kolodziejczyk@codecoup.pl> wrote:
> > This patch adds handling of authorized property to bluetoothctl.
> > ---
> >  client/gatt.c | 162
++++++++++++++++++++++++++++++++++++++++------------------
> >  1 file changed, 112 insertions(+), 50 deletions(-)
> >
> > diff --git a/client/gatt.c b/client/gatt.c
> > index 1b4e713ef..6a9ba5687 100644
> > --- a/client/gatt.c
> > +++ b/client/gatt.c
> > @@ -80,7 +80,8 @@ struct chrc {
> >         struct io *write_io;
> >         struct io *notify_io;
> >         bool authorization_req;
> > -       bool authorized;
> > +       bool authorized_read;

> Im confused why we need to track the authorization in the client? I
> thought the idea was when registering the user would be asked if
> authorization is required, or perhaps we set it along with flags, then
> if there is any read/write requires the user would have to authorize
> it. In addition to this we may actually use the trusted property to
> skip authorizations if the device is trusted.

Actually this patch set only extends authorization procedure for prepare
writes. Previous way of tracking authorization on client side behaves the
same. This is tracked to avoid auhorization requests for execute writes,
long reads (more than single iteration) and generally it's simplified to
one authorization per all write/read actions since this is only test app.
> > +       bool authorized_write;
> >  };
> >
> >  struct service {
> > @@ -1432,6 +1433,30 @@ static gboolean
chrc_notify_acquired_exists(const GDBusPropertyTable *property,
> >         return FALSE;
> >  }
> >
> > +static gboolean chrc_get_authorize(const GDBusPropertyTable *property,
> > +                                       DBusMessageIter *iter, void
*data)
> > +{
> > +       struct chrc *chrc =3D data;
> > +       dbus_bool_t value;
> > +
> > +       value =3D chrc->authorization_req ? TRUE : FALSE;
> > +
> > +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value)=
;
> > +
> > +       return TRUE;
> > +}
> > +
> > +static gboolean chrc_get_authorize_exists(const GDBusPropertyTable
*property,
> > +                                                               void
*data)
> > +{
> > +       struct chrc *chrc =3D data;
> > +
> > +       if (chrc->authorization_req)
> > +               return TRUE;
> > +
> > +       return FALSE;
> > +}
> > +
> >  static const GDBusPropertyTable chrc_properties[] =3D {
> >         { "UUID", "s", chrc_get_uuid, NULL, NULL },
> >         { "Service", "o", chrc_get_service, NULL, NULL },
> > @@ -1442,6 +1467,8 @@ static const GDBusPropertyTable chrc_properties[]
=3D {
> >                                         chrc_write_acquired_exists },
> >         { "NotifyAcquired", "b", chrc_get_notify_acquired, NULL,
> >                                         chrc_notify_acquired_exists },
> > +       { "Authorize", "b", chrc_get_authorize, NULL,
> > +
chrc_get_authorize_exists },
> >         { }
> >  };
> >
> > @@ -1460,7 +1487,8 @@ static const char *path_to_address(const char
*path)
> >  }
> >
> >  static int parse_options(DBusMessageIter *iter, uint16_t *offset,
uint16_t *mtu,
> > -                                               char **device, char
**link)
> > +                                               char **device, char
**link,
> > +                                               bool *authorize)
> >  {
> >         DBusMessageIter dict;
> >
> > @@ -1501,6 +1529,12 @@ static int parse_options(DBusMessageIter *iter,
uint16_t *offset, uint16_t *mtu,
> >                                 return -EINVAL;
> >                         if (link)
> >                                 dbus_message_iter_get_basic(&value,
link);
> > +               } else if (strcasecmp(key, "authorize") =3D=3D 0) {
> > +                       if (var !=3D DBUS_TYPE_BOOLEAN)
> > +                               return -EINVAL;
> > +                       if (authorize)
> > +                               dbus_message_iter_get_basic(&value,
> > +
authorize);
> >                 }
> >
> >                 dbus_message_iter_next(&dict);
> > @@ -1554,7 +1588,7 @@ static void authorize_read_response(const char
*input, void *user_data)
> >         reply =3D read_value(pending_message, &chrc->value[aad->offset]=
,
> >                                                 chrc->value_len -
aad->offset);
> >
> > -       chrc->authorized =3D true;
> > +       chrc->authorized_read =3D true;
> >
> >         g_dbus_send_message(aad->conn, reply);
> >
> > @@ -1578,18 +1612,15 @@ static DBusMessage
*chrc_read_value(DBusConnection *conn, DBusMessage *msg,
> >
> >         dbus_message_iter_init(msg, &iter);
> >
> > -       if (parse_options(&iter, &offset, NULL, &device, &link))
> > +       if (parse_options(&iter, &offset, NULL, &device, &link, NULL))
> >                 return g_dbus_create_error(msg,
> >
"org.bluez.Error.InvalidArguments",
> >                                         NULL);
> >
> >         bt_shell_printf("ReadValue: %s offset %u link %s\n",
> > -                       path_to_address(device), offset, link);
> > +                                       path_to_address(device),
offset, link);
> >
> > -       if (chrc->authorization_req && offset =3D=3D 0)
> > -               chrc->authorized =3D false;
> > -
> > -       if (chrc->authorization_req && !chrc->authorized) {
> > +       if (chrc->authorization_req && !chrc->authorized_read) {
> >                 struct authorize_attribute_data *aad;
> >
> >                 aad =3D g_new0(struct authorize_attribute_data, 1);
> > @@ -1616,33 +1647,31 @@ static DBusMessage
*chrc_read_value(DBusConnection *conn, DBusMessage *msg,
> >         return read_value(msg, &chrc->value[offset], chrc->value_len -
offset);
> >  }
> >
> > -static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int
*len,
> > -                                                               int
max_len)
> > +static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int
*len)
> >  {
> >         DBusMessageIter array;
> > -       uint16_t offset =3D 0;
> > -       uint8_t *read_value;
> > -       int read_len;
> >
> >         if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_ARRAY)
> >                 return -EINVAL;
> >
> >         dbus_message_iter_recurse(iter, &array);
> > -       dbus_message_iter_get_fixed_array(&array, &read_value,
&read_len);
> > +       dbus_message_iter_get_fixed_array(&array, value, len);
> >
> > -       dbus_message_iter_next(iter);
> > -       if (parse_options(iter, &offset, NULL, NULL, NULL))
> > -               return -EINVAL;
> > +       return 0;
> > +}
> >
> > -       if ((offset + read_len) > max_len)
> > +static int write_value(int *dst_len, uint8_t **dst_value, uint8_t
*src_val,
> > +                               int src_len, uint16_t offset, uint16_t
max_len)
> > +{
> > +       if ((offset + src_len) > max_len)
> >                 return -EOVERFLOW;
> >
> > -       if ((offset + read_len) > *len) {
> > -               *len =3D offset + read_len;
> > -               *value =3D g_realloc(*value, *len);
> > +       if ((offset + src_len) !=3D *dst_len) {
> > +               *dst_len =3D offset + src_len;
> > +               *dst_value =3D g_realloc(*dst_value, *dst_len);
> >         }
> >
> > -       memcpy(*value + offset, read_value, read_len);
> > +       memcpy(*dst_value + offset, src_val, src_len);
> >
> >         return 0;
> >  }
> > @@ -1651,12 +1680,26 @@ static void authorize_write_response(const char
*input, void *user_data)
> >  {
> >         struct authorize_attribute_data *aad =3D user_data;
> >         struct chrc *chrc =3D aad->attribute;
> > +       bool authorize =3D false;
> >         DBusMessageIter iter;
> >         DBusMessage *reply;
> > +       int value_len;
> > +       uint8_t *value;
> >         char *err;
> > -       int errsv;
> >
> >         dbus_message_iter_init(pending_message, &iter);
> > +       if (parse_value_arg(&iter, &value, &value_len)) {
> > +               err =3D "org.bluez.Error.InvalidArguments";
> > +
> > +               goto error;
> > +       }
> > +
> > +       dbus_message_iter_next(&iter);
> > +       if (parse_options(&iter, NULL, NULL, NULL, NULL, &authorize)) {
> > +               err =3D "org.bluez.Error.InvalidArguments";
> > +
> > +               goto error;
> > +       }
> >
> >         if (!strcmp(input, "no")) {
> >                 err =3D "org.bluez.Error.NotAuthorized";
> > @@ -1664,15 +1707,19 @@ static void authorize_write_response(const char
*input, void *user_data)
> >                 goto error;
> >         }
> >
> > -       chrc->authorized =3D true;
> > +       chrc->authorized_write =3D true;
> >
> > -       errsv =3D parse_value_arg(&iter, &chrc->value, &chrc->value_len=
,
> > -
chrc->max_val_len);
> > -       if (errsv =3D=3D -EINVAL) {
> > -               err =3D "org.bluez.Error.InvalidArguments";
> > +       /* Authorization check of prepare writes */
> > +       if (authorize) {
> > +               reply =3D g_dbus_create_reply(pending_message,
DBUS_TYPE_INVALID);
> > +               g_dbus_send_message(aad->conn, reply);
> > +               g_free(aad);
> >
> > -               goto error;
> > -       } else if (errsv =3D=3D -EOVERFLOW) {
> > +               return;
> > +       }
> > +
> > +       if (write_value(&chrc->value_len, &chrc->value, value,
value_len,
> > +                                       aad->offset,
chrc->max_val_len)) {
> >                 err =3D "org.bluez.Error.InvalidValueLength";
> >
> >                 goto error;
> > @@ -1699,18 +1746,31 @@ static DBusMessage
*chrc_write_value(DBusConnection *conn, DBusMessage *msg,
> >                                                         void *user_data=
)
> >  {
> >         struct chrc *chrc =3D user_data;
> > +       uint16_t offset =3D 0;
> > +       bool authorize =3D false;
> >         DBusMessageIter iter;
> > +       int value_len;
> > +       uint8_t *value;
> >         char *str;
> > -       int errsv;
> >
> >         dbus_message_iter_init(msg, &iter);
> >
> > -       if (chrc->authorization_req && !chrc->authorized) {
> > +       if (parse_value_arg(&iter, &value, &value_len))
> > +               return g_dbus_create_error(msg,
> > +                               "org.bluez.Error.InvalidArguments",
NULL);
> > +
> > +       dbus_message_iter_next(&iter);
> > +       if (parse_options(&iter, &offset, NULL, NULL, NULL, &authorize)=
)
> > +               return g_dbus_create_error(msg,
> > +                               "org.bluez.Error.InvalidArguments",
NULL);
> > +
> > +       if (chrc->authorization_req && !chrc->authorized_write) {
> >                 struct authorize_attribute_data *aad;
> >
> >                 aad =3D g_new0(struct authorize_attribute_data, 1);
> >                 aad->conn =3D conn;
> >                 aad->attribute =3D chrc;
> > +               aad->offset =3D offset;
> >
> >                 str =3D g_strdup_printf("Authorize attribute(%s) write
(yes/no):",
> >
chrc->path);
> > @@ -1724,15 +1784,14 @@ static DBusMessage
*chrc_write_value(DBusConnection *conn, DBusMessage *msg,
> >                 return NULL;
> >         }
> >
> > -       errsv =3D parse_value_arg(&iter, &chrc->value, &chrc->value_len=
,
> > -
chrc->max_val_len);
> > -       if (errsv =3D=3D -EINVAL) {
> > -               return g_dbus_create_error(msg,
> > -                               "org.bluez.Error.InvalidArguments",
NULL);
> > -       } else if (errsv =3D=3D -EOVERFLOW) {
> > +       /* Authorization check of prepare writes */
> > +       if (authorize)
> > +               return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> > +
> > +       if (write_value(&chrc->value_len, &chrc->value, value,
value_len,
> > +                                               offset,
chrc->max_val_len))
> >                 return g_dbus_create_error(msg,
> >                                 "org.bluez.Error.InvalidValueLength",
NULL);
> > -       }
> >
> >         bt_shell_printf("[" COLORED_CHG "] Attribute %s written" ,
chrc->path);
> >
> > @@ -1794,7 +1853,7 @@ static DBusMessage
*chrc_acquire_write(DBusConnection *conn, DBusMessage *msg,
> >                                         "org.bluez.Error.NotPermitted",
> >                                         NULL);
> >
> > -       if (parse_options(&iter, NULL, &chrc->mtu, &device, &link))
> > +       if (parse_options(&iter, NULL, &chrc->mtu, &device, &link,
NULL))
> >                 return g_dbus_create_error(msg,
> >
"org.bluez.Error.InvalidArguments",
> >                                         NULL);
> > @@ -1826,7 +1885,7 @@ static DBusMessage
*chrc_acquire_notify(DBusConnection *conn, DBusMessage *msg,
> >                                         "org.bluez.Error.NotPermitted",
> >                                         NULL);
> >
> > -       if (parse_options(&iter, NULL, &chrc->mtu, &device, &link))
> > +       if (parse_options(&iter, NULL, &chrc->mtu, &device, &link,
NULL))
> >                 return g_dbus_create_error(msg,
> >
"org.bluez.Error.InvalidArguments",
> >                                         NULL);
> > @@ -2042,7 +2101,7 @@ static DBusMessage
*desc_read_value(DBusConnection *conn, DBusMessage *msg,
> >
> >         dbus_message_iter_init(msg, &iter);
> >
> > -       if (parse_options(&iter, &offset, NULL, &device, &link))
> > +       if (parse_options(&iter, &offset, NULL, &device, &link, NULL))
> >                 return g_dbus_create_error(msg,
> >
"org.bluez.Error.InvalidArguments",
> >                                         NULL);
> > @@ -2064,21 +2123,24 @@ static DBusMessage
*desc_write_value(DBusConnection *conn, DBusMessage *msg,
> >         DBusMessageIter iter;
> >         uint16_t offset =3D 0;
> >         char *device =3D NULL, *link =3D NULL;
> > +       int value_len;
> > +       uint8_t *value;
> >
> >         dbus_message_iter_init(msg, &iter);
> >
> > -       if (parse_value_arg(&iter, &desc->value, &desc->value_len,
> > -
desc->max_val_len))
> > +       if (parse_value_arg(&iter, &value, &value_len))
> >                 return g_dbus_create_error(msg,
> > -
"org.bluez.Error.InvalidArguments",
> > -                                       NULL);
> > +                               "org.bluez.Error.InvalidArguments",
NULL);
> >
> >         dbus_message_iter_next(&iter);
> > +       if (parse_options(&iter, &offset, NULL, &device, &link, NULL))
> > +               return g_dbus_create_error(msg,
> > +                               "org.bluez.Error.InvalidArguments",
NULL);
> >
> > -       if (parse_options(&iter, &offset, NULL, &device, &link))
> > +       if (write_value(&desc->value_len, &desc->value, value,
> > +                                       value_len, offset,
desc->max_val_len))
> >                 return g_dbus_create_error(msg,
> > -
"org.bluez.Error.InvalidArguments",
> > -                                       NULL);
> > +                               "org.bluez.Error.InvalidValueLength",
NULL);
> >
> >         bt_shell_printf("WriteValue: %s offset %u link %s\n",
> >                         path_to_address(device), offset, link);
> > --
> > 2.13.6
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html



> --
> Luiz Augusto von Dentz

Grzegorz Ko=C5=82odziejczyk

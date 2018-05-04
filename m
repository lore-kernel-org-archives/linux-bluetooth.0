Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20180502091757.24190-1-grzegorz.kolodziejczyk@codecoup.pl>
 <20180502091757.24190-3-grzegorz.kolodziejczyk@codecoup.pl>
 <CABBYNZJVwKdAKPGxgOE_48=2zLvETe8oirr8w56Su5PrUh1eyA@mail.gmail.com>
 <CALevQMaqsR3YLmCWC66LNS6Avsd6eFF5sfqGZQWJ0yNHUgR1Aw@mail.gmail.com> <CABBYNZK6LdwWxZtqvvviySkCHEh8tN5BNnjFufd_=zq0NCASYQ@mail.gmail.com>
In-Reply-To: <CABBYNZK6LdwWxZtqvvviySkCHEh8tN5BNnjFufd_=zq0NCASYQ@mail.gmail.com>
From: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Date: Fri, 04 May 2018 14:03:12 +0000
Message-ID: <CALevQMYUodE8W+NgFY6V=tzwTjL+3OD3COrz-ytdqSGzDtAs9A@mail.gmail.com>
Subject: Re: [RFC 2/2] client: Add authorized property handling to
 characteristic attribute
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,
czw., 3 maj 2018 o 11:58 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
napisa=C5=82(a):

> Hi Grzegorz,
> On Wed, May 2, 2018 at 4:06 PM Grzegorz Ko=C5=82odziejczyk <
> grzegorz.kolodziejczyk@codecoup.pl> wrote:

> > Hi Luiz,
> > =C5=9Br., 2 maj 2018 o 12:42 Luiz Augusto von Dentz <luiz.dentz@gmail.c=
om>
> > napisa=C5=82(a):

> > > Hi Grzegorz,
> > > On Wed, May 2, 2018 at 1:09 PM Grzegorz Kolodziejczyk <
> > > grzegorz.kolodziejczyk@codecoup.pl> wrote:

> > > > This patch adds handling of authorized property to bluetoothctl.
> > > > ---
> > > >   client/gatt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> > > >   1 file changed, 46 insertions(+)

> > > > diff --git a/client/gatt.c b/client/gatt.c
> > > > index 6bf644c48..fffa86851 100644
> > > > --- a/client/gatt.c
> > > > +++ b/client/gatt.c
> > > > @@ -1432,6 +1432,30 @@ static gboolean
> chrc_notify_acquired_exists(const
> > > GDBusPropertyTable *property,
> > > >          return FALSE;
> > > >   }

> > > > +static gboolean chrc_get_authorized(const GDBusPropertyTable
> *property,
> > > > +                                       DBusMessageIter *iter, void
> > *data)
> > > > +{
> > > > +       struct chrc *chrc =3D data;
> > > > +       dbus_bool_t value;
> > > > +
> > > > +       value =3D chrc->authorized ? TRUE : FALSE;
> > > > +
> > > > +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
> &value);
> > > > +
> > > > +       return TRUE;
> > > > +}
> > > > +
> > > > +static gboolean chrc_get_authorized_exists(const GDBusPropertyTabl=
e
> > > *property,
> > > > +                                                               voi=
d
> > > *data)
> > > > +{
> > > > +       struct chrc *chrc =3D data;
> > > > +
> > > > +       if (chrc->authorization_req)
> > > > +               return TRUE;
> > > > +
> > > > +       return FALSE;
> > > > +}
> > > > +
> > > >   static const GDBusPropertyTable chrc_properties[] =3D {
> > > >          { "UUID", "s", chrc_get_uuid, NULL, NULL },
> > > >          { "Service", "o", chrc_get_service, NULL, NULL },
> > > > @@ -1442,6 +1466,8 @@ static const GDBusPropertyTable
> chrc_properties[]
> > =3D
> > > {
> > > >                                          chrc_write_acquired_exists
},
> > > >          { "NotifyAcquired", "b", chrc_get_notify_acquired, NULL,
> > > >                                          chrc_notify_acquired_exist=
s
> },
> > > > +       { "Authorized", "b", chrc_get_authorized, NULL,
> > > > +
> > > chrc_get_authorized_exists },
> > > >          { }
> > > >   };

> > > > @@ -1665,6 +1691,15 @@ static void authorize_write_response(const
char
> > > *input, void *user_data)

> > > >          chrc->authorized =3D true;

> > > > +       /* Authorization check of prepare writes */
> > > > +       if (!chrc->value_len) {
> > > > +               reply =3D g_dbus_create_reply(pending_message,
> > > DBUS_TYPE_INVALID);
> > > > +               g_dbus_send_message(aad->conn, reply);
> > > > +               g_free(aad);
> > > > +
> > > > +               return;
> > > > +       }
> > > > +
> > > >          errsv =3D parse_value_arg(&iter, &chrc->value,
> &chrc->value_len,

> > > chrc->max_val_len);
> > > >          if (errsv =3D=3D -EINVAL) {
> > > > @@ -1701,8 +1736,16 @@ static DBusMessage
> > > *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
> > > >          DBusMessageIter iter;
> > > >          char *str;
> > > >          int errsv;
> > > > +       uint16_t offset =3D 0;

> > > >          dbus_message_iter_init(msg, &iter);
> > > > +       /* Get offset only (second parameter) */
> > > > +       dbus_message_iter_next(&iter);
> > > > +
> > > > +       parse_options(&iter, &offset, NULL, NULL, NULL);
> > > > +
> > > > +       if (chrc->authorization_req && offset =3D=3D 0)
> > > > +               chrc->authorized =3D false;

> > > >          if (chrc->authorization_req && !chrc->authorized) {
> > > >                  struct authorize_attribute_data *aad;
> > > > @@ -1722,6 +1765,9 @@ static DBusMessage
> > *chrc_write_value(DBusConnection
> > > *conn, DBusMessage *msg,
> > > >                  return NULL;
> > > >          }

> > > > +       /* Rewind to value parameter */
> > > > +       dbus_message_iter_init(msg, &iter);

> > > I would prefer to make parse_value_arg parse the offset as well so we
> > don't
> > > have to reinit the iter.
> > Current version of bluetoothctl already parsses offset in
parse_value_arg
> > for writing value purposes (patch
> 1dd33d584ce1e4bd0f1d87e88663350a80f37f01).

> > As the offset is second parameter for write method it's needed (afaik)
to
> > recurse over iterator to offset parameter then parse value (there is no
> > need to parse value at beginnig). Currently this implementation assumes
> > that every write request with offset =3D 0 is new write request which h=
as
to
> > be authoriez/re-authorized.

> That fact that parse_value_arg is already a strong indication that we
> should reuse it, we just need to add the offset as a output parameter,
like
> it is done in parse_options, that way we will get both the value and the
> offset in the same call and don't have to reinit the iter.
For now the parse_value_arg function is not only parsing dbus message and
gets values, but also write attribute value.
I guess the idea of requesting authorization for write value with offset =
=3D
0 is not considered for now so this wouldn't be needed.

> > > >          errsv =3D parse_value_arg(&iter, &chrc->value,
> &chrc->value_len,

> > > chrc->max_val_len);
> > > >          if (errsv =3D=3D -EINVAL) {
> > > > --
> > > > 2.13.6

> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > linux-bluetooth" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html



> > > --
> > > Luiz Augusto von Dentz
> > Grzegorz Ko=C5=82odziejczyk



> --
> Luiz Augusto von Dentz
Grzegorz Ko=C5=82odziejczyk

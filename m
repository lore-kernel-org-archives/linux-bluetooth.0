Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALevQMYQdyaGVbEmkry3fYCfuNnDFMcmTbE27-bCYwa+M6jr=g@mail.gmail.com>
References: <20180528082054.4017-1-grzegorz.kolodziejczyk@codecoup.pl>
 <20180528082054.4017-4-grzegorz.kolodziejczyk@codecoup.pl>
 <CABBYNZ+Lut0zswZraUf2MqAvo2guHsbd0Mp=qsRMnB11j=ezyQ@mail.gmail.com> <CALevQMYQdyaGVbEmkry3fYCfuNnDFMcmTbE27-bCYwa+M6jr=g@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 May 2018 18:46:01 +0300
Message-ID: <CABBYNZKJCiT52x0gtvMdNPk8inM5ATzrGjVeMa7rjoEBw7y6_A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 4/4] client: Don't require authorization for
 trusted devices
To: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Mon, May 28, 2018 at 6:25 PM, Grzegorz Ko=C5=82odziejczyk
<grzegorz.kolodziejczyk@codecoup.pl> wrote:
> Hi Luiz,
> pon., 28 maj 2018 o 15:41 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> napisa=C5=82(a):
>
>> Hi Grzegorz,
>
>> On Mon, May 28, 2018 at 11:20 AM, Grzegorz Kolodziejczyk
>> <grzegorz.kolodziejczyk@codecoup.pl> wrote:
>> > This patch adds possibility to ommit authorization request from truste=
d
>> > devices.
>> > ---
>> >  client/gatt.c | 21 ++++++++++++++++++---
>> >  1 file changed, 18 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/client/gatt.c b/client/gatt.c
>> > index 3e70f365c..c7dfe42d7 100644
>> > --- a/client/gatt.c
>> > +++ b/client/gatt.c
>> > @@ -1720,6 +1720,20 @@ error:
>> >         g_free(aad);
>> >  }
>> >
>> > +static bool is_device_trusted(const char *path)
>> > +{
>> > +       GDBusProxy *proxy;
>> > +       DBusMessageIter iter;
>> > +       bool trusted;
>> > +
>> > +       proxy =3D bt_shell_get_env(path);
>> > +
>> > +       if (g_dbus_proxy_get_property(proxy, "Trusted", &iter))
>> > +               dbus_message_iter_get_basic(&iter, &trusted);
>> > +
>> > +       return trusted;
>> > +}
>> > +
>> >  static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage
> *msg,
>> >                                                         void *user_dat=
a)
>> >  {
>> > @@ -1739,7 +1753,7 @@ static DBusMessage
> *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
>> >         bt_shell_printf("ReadValue: %s offset %u link %s\n",
>> >                                         path_to_address(device),
> offset, link);
>> >
>> > -       if (chrc->authorization_req) {
>> > +       if (!is_device_trusted(device) && chrc->authorization_req) {
>> >                 struct authorize_attribute_data *aad;
>> >
>> >                 aad =3D g_new0(struct authorize_attribute_data, 1);
>> > @@ -1865,6 +1879,7 @@ static DBusMessage
> *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
>> >         struct chrc *chrc =3D user_data;
>> >         uint16_t offset =3D 0;
>> >         bool prep_authorize =3D false;
>> > +       char *device =3D NULL;
>> >         DBusMessageIter iter;
>> >         int value_len;
>> >         uint8_t *value;
>> > @@ -1877,11 +1892,11 @@ static DBusMessage
> *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
>> >                                 "org.bluez.Error.InvalidArguments",
> NULL);
>> >
>> >         dbus_message_iter_next(&iter);
>> > -       if (parse_options(&iter, &offset, NULL, NULL, NULL,
> &prep_authorize))
>> > +       if (parse_options(&iter, &offset, NULL, &device, NULL,
> &prep_authorize))
>> >                 return g_dbus_create_error(msg,
>> >                                 "org.bluez.Error.InvalidArguments",
> NULL);
>> >
>> > -       if (chrc->authorization_req) {
>> > +       if (!is_device_trusted(device) && chrc->authorization_req) {
>> >                 struct authorize_attribute_data *aad;
>> >
>> >                 aad =3D g_new0(struct authorize_attribute_data, 1);
>> > --
>> > 2.13.6
>
>> We should be able to do this in the daemon so the application wont
>> have to authorize these requests if the device is trusted.
>
> We'll be able to only avoid bothering cllient application for authorizing
> prepare writes of trusted devices - with this I agree. In  all other case=
s
> it must be checked in app AFAIK.

That is what I had in mind, if it is not to authorize anything then
Trusted shall not be checked.


--=20
Luiz Augusto von Dentz

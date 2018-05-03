Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20180502091757.24190-1-grzegorz.kolodziejczyk@codecoup.pl>
 <20180502091757.24190-2-grzegorz.kolodziejczyk@codecoup.pl>
 <CABBYNZKbHnKF_GbFq3qQpzjtb0s-EwdR=9RwMb34r-T7D0kT+Q@mail.gmail.com> <CALevQMa0KqNd46MBuL6PPTUodXrWOyC4U_J-xgv-KQ1CBNH3HQ@mail.gmail.com>
In-Reply-To: <CALevQMa0KqNd46MBuL6PPTUodXrWOyC4U_J-xgv-KQ1CBNH3HQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 03 May 2018 09:54:25 +0000
Message-ID: <CABBYNZKEgmGppXhSZgumquvxR9-wNOBhKGa6x96Hts_Z-SMu=Q@mail.gmail.com>
Subject: Re: [RFC 1/2] shared/gatt-server: Request authorization for prepare writes.
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,
On Wed, May 2, 2018 at 4:31 PM Grzegorz Ko=C5=82odziejczyk <
grzegorz.kolodziejczyk@codecoup.pl> wrote:

> Hi Luiz,
> =C5=9Br., 2 maj 2018 o 13:33 Luiz Augusto von Dentz <luiz.dentz@gmail.com=
>
> napisa=C5=82(a):

> > Hi Grzegorz,
> > On Wed, May 2, 2018 at 1:09 PM Grzegorz Kolodziejczyk <
> > grzegorz.kolodziejczyk@codecoup.pl> wrote:

> > > This patch adds gatt-server possibility to request authorization from
> > > application if needed and previously wasn't authorized. Authorization
is
> > > requested by sending write request with no data to application.
> > > ---
> > >   doc/gatt-api.txt         |  8 ++++++
> > >   src/gatt-database.c      |  6 +++++
> > >   src/shared/gatt-server.c | 64
> > +++++++++++++++++++++++++++++++++++++++++-------
> > >   3 files changed, 69 insertions(+), 9 deletions(-)

> > > diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> > > index 0f1cc9029..b9bdc9352 100644
> > > --- a/doc/gatt-api.txt
> > > +++ b/doc/gatt-api.txt
> > > @@ -251,6 +251,14 @@ Properties string UUID [read-only]
> > >                                  "secure-read" (Server only)
> > >                                  "secure-write" (Server only)

> > Documentation changes should be split in a different patch.

> > > +               boolean Authorized [read-only, optional] (Server only=
)
> > > +
> > > +                       True, if read/write operation was previously
> > authorized
> > > +                       and attribute requires authorization. If no
> > Authorized
> > > +                       property is available along with
characteristic
> > or this
> > > +                       property is set to true, then daemon don't
send
> > empty
> > > +                       write request for authorization.

> > I guess we are missing the authorization flag, otherwise the daemon
cannot
> > tell if authorization is required on not, or we assume it is always
> > required if Authorized is set to false? In that case, we should make it
> If there is no authorization request then there is no property on client
> (chrc_get_authorized_exists checks for prop existence).
> There are 3 ways of handling this property:
> 1) No property - means that writing behaves as before without issuing
> authorization request part, only gatt database asks for property
existence.
> 2) Property set to False - means that there is authorization request for
> preparing write this property, once authorized it sets to True
> 3) Property set to True - means that write was previously authorized and
> any continous (offset > 0) write can be issued. If write will be issued
> with offset =3D 0, new authorization request will be required.

I don't quite follow why we want the property to transit states? Ins't it
simpler to just check the reply of WriteValue and then just continue?

> > clearer in the documentation. Perhaps we should make the property state
if
> > the authorization is required like boolean Authorization, if it is not
> > present it would be assumed to be false meaning authorization is not
> > required. We should also state how it affects the calls stating that a
> > prepare write would cause WriteValue to be called with empty data if
> > authorization is required, and perhaps we should attempt to call
> WriteValue
> > just once per procedure which means the authorization would be valid
until
> > execute, or we change the property to be string that can assume the
> values:
> > always, once, never. Btw, I don't think we can support Authorization
with
> Every time write request will be issued with offset =3D 0 - application w=
ill
> be asked for authorization - that was my assumption.
> > AcquireWrite since there is no reply to writes on the pipe, so we might
as
> > well document that those properties cannot be used together.
> Right, I'll update it in next version.

Did you actually read about the suggestion above, I guess that will get us
the same result without the application having to change the value of the
property, which btw I don't think works with concurrent devices since
Authorized would mean it is authorized for every device while we should
track the authorization per prepare write.


> > >   Characteristic Descriptors hierarchy
> > >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> > > diff --git a/src/gatt-database.c b/src/gatt-database.c
> > > index 0ac5b75b0..419db909c 100644
> > > --- a/src/gatt-database.c
> > > +++ b/src/gatt-database.c
> > > @@ -2614,6 +2614,12 @@ static void chrc_write_cb(struct
> gatt_db_attribute
> > *attrib,
> > >                  goto fail;
> > >          }

> > > +       if (offset && g_dbus_proxy_get_property(chrc->proxy,
> "Authorized",
> > > +
&iter))
> {
> > > +               gatt_db_attribute_write_result(attrib, id, 0);
> > > +               return;
> > > +       }

> > What is the logic behind checking the offset? Is this check here becaus=
e
> > the prepare writes are now passed up the stack? Afaik the offset can be
> set
> > to 0 even with prepare write which means we should check the opcode
> instead
> > which might be required for execute as well otherwise nothing that has
> > offset set will be ever written to the application.

You haven't ack or nack this comment.

> > >          if (chrc->write_io) {
> > >                  if (pipe_io_send(chrc->write_io, value, len) < 0) {
> > >                          error("Unable to write: %s",
strerror(errno));
> > > diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> > > index 4b554f665..cdade76f8 100644
> > > --- a/src/shared/gatt-server.c
> > > +++ b/src/shared/gatt-server.c
> > > @@ -1208,6 +1208,45 @@ static bool store_prep_data(struct
bt_gatt_server
> > *server,
> > >          return prep_data_new(server, handle, offset, length, value);
> > >   }

> > > +struct prep_write_complete_data {
> > > +       void *pdu;
> > > +       uint16_t length;
> > > +       struct bt_gatt_server *server;
> > > +};
> > > +
> > > +static void prep_write_complete_cb(struct gatt_db_attribute *attr,
int
> > err,
> > > +                                                               void
> > *user_data)
> > > +{
> > > +       struct prep_write_complete_data *pwcd =3D user_data;
> > > +       uint16_t handle =3D 0;
> > > +       uint16_t offset;
> > > +
> > > +       handle =3D get_le16(pwcd->pdu);
> > > +
> > > +       if (err) {
> > > +               bt_att_send_error_rsp(pwcd->server->att,
> > > +                                       BT_ATT_OP_PREP_WRITE_REQ,
> handle,
> > err);
> > > +               free(pwcd->pdu);
> > > +               free(pwcd);
> > > +
> > > +               return;
> > > +       }
> > > +
> > > +       offset =3D get_le16(pwcd->pdu + 2);
> > > +
> > > +       if (!store_prep_data(pwcd->server, handle, offset,
pwcd->length
> -
> > 4,
> > > +                                               &((uint8_t *)
> > pwcd->pdu)[4]))
> > > +               bt_att_send_error_rsp(pwcd->server->att,
> > > +                                       BT_ATT_OP_PREP_WRITE_RSP,
> handle,
> > > +
> > BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
> > > +
> > > +       bt_att_send(pwcd->server->att, BT_ATT_OP_PREP_WRITE_RSP,
> > pwcd->pdu,
> > > +                                               pwcd->length, NULL,
> NULL,
> > NULL);
> > > +
> > > +       free(pwcd->pdu);
> > > +       free(pwcd);
> > > +}
> > > +
> > >   static void prep_write_cb(uint8_t opcode, const void *pdu,
> > >                                          uint16_t length, void
> *user_data)
> > >   {
> > > @@ -1215,7 +1254,8 @@ static void prep_write_cb(uint8_t opcode, const
> > void *pdu,
> > >          uint16_t handle =3D 0;
> > >          uint16_t offset;
> > >          struct gatt_db_attribute *attr;
> > > -       uint8_t ecode;
> > > +       struct prep_write_complete_data *pwcd;
> > > +       uint8_t ecode, status;

> > >          if (length < 4) {
> > >                  ecode =3D BT_ATT_ERROR_INVALID_PDU;
> > > @@ -1245,15 +1285,21 @@ static void prep_write_cb(uint8_t opcode,
const
> > void *pdu,
> > >          if (ecode)
> > >                  goto error;

> > > -       if (!store_prep_data(server, handle, offset, length - 4,
> > > -                                               &((uint8_t *)
pdu)[4]))
> {
> > > -               ecode =3D BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
> > > -               goto error;
> > > -       }
> > > +       pwcd =3D new0(struct prep_write_complete_data, 1);
> > > +       pwcd->pdu =3D malloc(length);
> > > +       memcpy(pwcd->pdu, pdu, length);
> > > +       pwcd->length =3D length;
> > > +       pwcd->server =3D server;

> > > -       bt_att_send(server->att, BT_ATT_OP_PREP_WRITE_RSP, pdu,
length,
> > NULL,
> > > -                                                               NULL,
> > NULL);
> > > -       return;
> > > +       status =3D gatt_db_attribute_write(attr, offset, NULL, 0,
> > > +
> BT_ATT_OP_PREP_WRITE_REQ,
> > > +                                               server->att,
> > > +
prep_write_complete_cb,
> > pwcd);
> > > +       if (status)
> > > +               return;
> > > +
> > > +       ecode =3D BT_ATT_ERROR_UNLIKELY;

> > >   error:
> > >          bt_att_send_error_rsp(server->att, opcode, handle, ecode);
> > > --
> > > 2.13.6

> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html



> > --
> > Luiz Augusto von Dentz
> Grzegorz Ko=C5=82odziejczyk



--=20
Luiz Augusto von Dentz

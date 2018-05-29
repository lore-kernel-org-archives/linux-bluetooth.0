Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20180529083218.32603-1-grzegorz.kolodziejczyk@codecoup.pl>
 <20180529083218.32603-2-grzegorz.kolodziejczyk@codecoup.pl> <CABBYNZK4Aq24R9=K89Fu8oeX3aN1FV4sFj2vvnre4t4a+jQdEA@mail.gmail.com>
In-Reply-To: <CABBYNZK4Aq24R9=K89Fu8oeX3aN1FV4sFj2vvnre4t4a+jQdEA@mail.gmail.com>
From: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Date: Tue, 29 May 2018 12:05:43 +0200
Message-ID: <CALevQMbEjYWTWqmKtVHpDmuGbLTahuq7X_WL4+Pi+ozQNxPueQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] gatt: Don't require prepare write authorization
 for trusted devices
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


wt., 29 maj 2018 o 11:39 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
napisa=C5=82(a):

> Hi Grzegorz,

> On Tue, May 29, 2018 at 11:32 AM, Grzegorz Kolodziejczyk
> <grzegorz.kolodziejczyk@codecoup.pl> wrote:
> > This patch adds possibility to ommit prepare write authorization
> > request from trusted devices.
> > ---
> >  src/gatt-database.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/src/gatt-database.c b/src/gatt-database.c
> > index 22c78e840..99c8ea231 100644
> > --- a/src/gatt-database.c
> > +++ b/src/gatt-database.c
> > @@ -2569,7 +2569,8 @@ static void desc_write_cb(struct
gatt_db_attribute *attrib,
> >         }
> >
> >         if (opcode =3D=3D BT_ATT_OP_PREP_WRITE_REQ) {
> > -               if (!desc->prep_authorized &&
desc->req_prep_authorization)
> > +               if (!device_is_trusted(device) &&
!desc->prep_authorized &&
> > +
desc->req_prep_authorization)
> >                         send_write(device, attrib, desc->proxy,
> >                                         desc->pending_writes, id,
value, len,
> >                                         offset,
bt_att_get_link_type(att),
> > @@ -2672,7 +2673,8 @@ static void chrc_write_cb(struct
gatt_db_attribute *attrib,
> >                 queue =3D NULL;
> >
> >         if (opcode =3D=3D BT_ATT_OP_PREP_WRITE_REQ) {
> > -               if (!chrc->prep_authorized &&
chrc->req_prep_authorization)
> > +               if (!device_is_trusted(device) &&
!chrc->prep_authorized &&
> > +
chrc->req_prep_authorization)
> >                         send_write(device, attrib, chrc->proxy, queue,
> >                                         id, value, len, offset,
> >                                         bt_att_get_link_type(att),
true, true);
> > --
> > 2.13.6

> I guess I can ignore the first patch and just apply this one, or do
> you still have any use for checking the trusted flag on the client
> side?

Yes, I have use for checking the trusted flag on client side.

For example:
- Read/write,
- Long read, long write,
- Execute write

In all those cases user will be bothered with authorization request if
trusted won't be checked.

This patch 2/2 reduce redundant authorization request for prepare writes
only since we know that device is trusted on daemon side. In other cases
operation is authorized on client side, so I think there is no other place
where we can check if device is trusted.

> --
> Luiz Augusto von Dentz

Regards,
Grzegorz

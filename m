Return-Path: <fugang.duan@nxp.com>
From: Fugang Duan <fugang.duan@nxp.com>
To: Johan Hedberg <johan.hedberg@gmail.com>, "b38611@freescale.com"
	<b38611@freescale.com>
CC: "gustavo@padovan.org" <gustavo@padovan.org>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: add hdev check to avoid passing null pointer
Date: Thu, 21 Jan 2016 09:23:30 +0000
Message-ID: <VI1PR04MB16324B1AC9D51D55C8E2FD1BFFC30@VI1PR04MB1632.eurprd04.prod.outlook.com>
References: <1453199661-7918-1-git-send-email-b38611@freescale.com>
 <20160119130404.GA27411@t440s.ice.intel.com>
In-Reply-To: <20160119130404.GA27411@t440s.ice.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com> Sent: Tuesday, January 19, 20=
16 9:04 PM
> To: b38611@freescale.com
> Cc: gustavo@padovan.org; marcel@holtmann.org; linux-
> bluetooth@vger.kernel.org
> Subject: Re: [PATCH] Bluetooth: add hdev check to avoid passing null poin=
ter
>=20
> Hi Fuang,
>=20
> On Tue, Jan 19, 2016, Fugang Duan wrote:
> > Function hci_mgmt_cmd() may pass hdev with null pointer to
> > hci_mgmt_handler->func() like below code:
> > 	err =3D handler->func(sk, hdev, cp, len);
> >
> > Add hdev check to avoid passing null pointer.
> >
> > Signed-off-by: Fugang Duan <B38611@freescale.com>
> > ---
> >  net/bluetooth/hci_sock.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c index
> > 1298d72..7fdfc80 100644
> > --- a/net/bluetooth/hci_sock.c
> > +++ b/net/bluetooth/hci_sock.c
> > @@ -1186,6 +1186,8 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan
> > *chan, struct sock *sk,
> >
> >  	if (hdev && chan->hdev_init)
> >  		chan->hdev_init(sk, hdev);
> > +	else if (!hdev)
> > +		goto done;
> >
> >  	cp =3D buf + sizeof(*hdr);
>=20
> Nack. There are handlers which are not hci-dev specific, such as reading =
version
> number, supported commands, or the index list. There's a special flag
> HCI_MGMT_NO_HDEV that handlers can set to say that they expect to be
> called without a hdev. The code in hci_mgmt_cmd() already makes sure that
> any handler that doesn't set it will not be called with NULL hdev.
>=20
> Johan

Thanks for your comments, the below piece of code can guarantee that any ha=
ndler doesn't set HCI_MGMT_NO_HDEV will not be called with NULL hdev.

        no_hdev =3D (handler->flags & HCI_MGMT_NO_HDEV);
        if (no_hdev !=3D !hdev) {
                err =3D mgmt_cmd_status(sk, index, opcode,
                                      MGMT_STATUS_INVALID_INDEX);
                goto done;
        }

Regards,
Andy

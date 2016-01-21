Return-Path: <fugang.duan@nxp.com>
From: Fugang Duan <fugang.duan@nxp.com>
To: Johan Hedberg <johan.hedberg@gmail.com>, "b38611@freescale.com"
	<b38611@freescale.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "johannes.berg@intel.com"
	<johannes.berg@intel.com>, "jslaby@suse.cz" <jslaby@suse.cz>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: add hdev check to avoid passing null pointer
Date: Thu, 21 Jan 2016 09:06:08 +0000
Message-ID: <VI1PR04MB163235D06097739E704A8039FFC30@VI1PR04MB1632.eurprd04.prod.outlook.com>
References: <1453351558-7726-1-git-send-email-b38611@freescale.com>
 <20160121084310.GA4046@t440s>
In-Reply-To: <20160121084310.GA4046@t440s>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com> Sent: Thursday, January 21, 2=
016 4:43 PM
> To: b38611@freescale.com
> Cc: marcel@holtmann.org; johannes.berg@intel.com; jslaby@suse.cz; linux-
> bluetooth@vger.kernel.org; Fugang Duan <fugang.duan@nxp.com>
> Subject: Re: [PATCH] Bluetooth: add hdev check to avoid passing null poin=
ter
>=20
> Hi Fuang,
>=20
> On Thu, Jan 21, 2016, Fugang Duan wrote:
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
>=20
> Why are you resending this? Did you see my response to your earlier
> submission?
>=20
> Johan

Sorry,  maybe I missed some mail and guessed I didn't send the previous mai=
l successfully. =20
Let's check my mailbox=20

Regards,
Andy

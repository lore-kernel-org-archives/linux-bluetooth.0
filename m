Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] bluetooth: hci_bcsp: Clean up code Fix
Date: Tue, 9 Jun 2015 11:54:57 +0000
Message-ID: <20150609115449.GA19437@ubuntu>
References: <20150604070848.GA8533@ubuntu>
 <A1AA5BA0-D94C-46CF-BA06-3CF378C8B3D0@holtmann.org>
In-Reply-To: <A1AA5BA0-D94C-46CF-BA06-3CF378C8B3D0@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jun 06, 2015 at 06:49:19AM +0200, Marcel Holtmann wrote:
> Hi Prasanna,
>=20
> > Fix for spaces prohibited around that '->' reported by checkpatch
> > and space prohibited between function name and open parenthesis '('
> >=20
> > Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
> > ---
> > drivers/bluetooth/hci_bcsp.c |   28 ++++++++++++++--------------
> > 1 files changed, 14 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.=
c
> > index dc8e3d4..94e0046 100644
> > --- a/drivers/bluetooth/hci_bcsp.c
> > +++ b/drivers/bluetooth/hci_bcsp.c
> > @@ -285,7 +285,7 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart=
 *hu)
> > 	struct bcsp_struct *bcsp =3D hu->priv;
> > 	unsigned long flags;
> > 	struct sk_buff *skb;
> > -=09
> > +
> > 	/* First of all, check for unreliable messages in the queue,
> > 	   since they have priority */
> >=20
> > @@ -436,7 +436,7 @@ static inline void bcsp_unslip_one_byte(struct bcsp=
_struct *bcsp, unsigned char
> > 			break;
> > 		default:
> > 			memcpy(skb_put(bcsp->rx_skb, 1), &byte, 1);
> > -			if ((bcsp->rx_skb-> data[0] & 0x40) !=3D 0 &&=20
> > +			if ((bcsp->rx_skb->data[0] & 0x40) !=3D 0 &&
> > 					bcsp->rx_state !=3D BCSP_W4_CRC)
>=20
> if you do this, then also adjust the indentation to follow the network su=
bsystem style. This driver has most likely plenty of them. --strict for che=
ckpatch in case you wonder.
>=20
> Regards
>=20
> Marcel
>
Sorry for the mess up, Sent V3 with cleaned up Patch=

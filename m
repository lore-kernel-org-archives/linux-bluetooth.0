Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
        "Gustavo
 F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Avinash Patil <patila@marvell.com>, Chin-Ran Lo <crlo@marvell.com>,
        Xinming Hu <huxm@marvell.com>
Date: Wed, 16 Jul 2014 14:20:58 -0700
Subject: RE: [PATCH 1/2] Bluetooth: add public address configuration for
 Marvell USB devices
Message-ID: <477F20668A386D41ADCC57781B1F7043122FCE9980@SC-VEXCH1.marvell.com>
References: <1405538486-23533-1-git-send-email-bzhao@marvell.com>
 <968A8F45-B932-4343-A9C4-AA25BC91344A@holtmann.org>
In-Reply-To: <968A8F45-B932-4343-A9C4-AA25BC91344A@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thanks for your comments.

> > +static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
> > +				    const bdaddr_t *bdaddr)
> > +{
> > +	struct sk_buff *skb;
> > +	u8 buf[8];
> > +	long ret;
> > +
> > +	buf[0] =3D 0xfe;
> > +	buf[1] =3D sizeof(bdaddr_t);
> > +	bacpy((bdaddr_t *)&buf[2], bdaddr);
>=20
> you could define a packed struct for this or just use memcpy here instead=
.

In Amitkumar's original patch, it was like this:

+	memcpy((u8 *)buf + 2, bdaddr, sizeof(bdaddr_t));

I felt that it'd be better to use bacpy so I changed memcpy to bacpy while =
applying the patch.
I can change it back to memcpy if it looks ok to you. Otherwise I can defin=
e a packed struct.

>=20
> > +
> > +	skb =3D __hci_cmd_sync(hdev, 0xfc22, sizeof(buf), buf, HCI_INIT_TIMEO=
UT);
>=20
> Is this opcode writing the address into flash and making it permanent or =
will a reboot restore it to
> its original address?

A reboot restores it to its original address. I will add this information i=
n v2.

>=20
> I am asking because for Ericsson chips this exact command with user_id 0x=
fe was actually making a
> permanent change of the BD_ADDR. What we want here is a volatile change o=
f the address.

For Marvell devices it makes a temporary bdaddr change.

Thanks,
Bing

>=20
> Regards
>=20
> Marcel

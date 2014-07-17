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
Date: Thu, 17 Jul 2014 11:31:45 -0700
Subject: RE: [PATCH 2/2] Bluetooth: btmrvl: add public address configuration
 support
Message-ID: <477F20668A386D41ADCC57781B1F7043122FCE9C75@SC-VEXCH1.marvell.com>
References: <1405538486-23533-1-git-send-email-bzhao@marvell.com>
 <1405538486-23533-2-git-send-email-bzhao@marvell.com>
 <A5D7B02F-3913-4501-A007-B11A3E7FA7EB@holtmann.org>
In-Reply-To: <A5D7B02F-3913-4501-A007-B11A3E7FA7EB@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> > +	ret =3D btmrvl_send_sync_cmd(priv, BT_CMD_SET_BDADDR, buf, sizeof(buf=
));
>=20
> So I keep wondering why you need the btmrvl_send_sync_cmd here. The HCI t=
ransport is up and running
> at this stage and sending vendor command should do the right thing. Simil=
ar to what you do in btusb
> driver.
>=20
> You might have explained this to, but I must have clearly not understood =
it.

We will check if btmrvl_send_sync_cmd() can be replaced by __hci_cmd_sync()=
 and get back to you.

Thanks,
Bing

>=20
> Regards
>=20
> Marcel

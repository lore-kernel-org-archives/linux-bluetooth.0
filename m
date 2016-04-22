Return-Path: <akarwar@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <gbhat@marvell.com>, Cathy Luo
	<cluo@marvell.com>
Subject: RE: [PATCH v7] Bluetooth: hci_uart: Support firmware download for
 Marvell
Date: Fri, 22 Apr 2016 11:24:00 +0000
Message-ID: <2119fc93636742459899d50f2c1fcb8d@SC-EXCH04.marvell.com>
References: <1459845266-2771-1-git-send-email-akarwar@marvell.com>
 <2A69CC2B-1FC2-4148-8564-38335A87CCD7@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>=20
> > > +
> > > +static int mrvl_setup(struct hci_uart *hu) {
> > > +	struct mrvl_data *mrvl =3D hu->priv;
> > > +
> > > +	mrvl_init_fw_data(hu);
> > > +	set_bit(HCI_UART_DNLD_FW, &mrvl->flags);
> > > +
> > > +	return hci_uart_dnld_fw(hu);
> > > +}
> >
> > So this is clearly the wrong spot. When ->setup is called it is
> > expected that HCI is ready. You are misusing it here.
> >
>=20
> Sure. We will move this to mrvl_open() where HCI is not yet initialized.

We tried moving firmware download to mrvl_open(), but it's not feasible. "h=
u->proto" is not yet initialized at that time. So when the data/ack is rece=
ived during firmware download, we can't have Marvell specific handling. Als=
o, I can see other vendor's (broadcomm, Intel) have done firmware download =
in setup handler.

I will send V8 patch shortly. Please check.

Regards,
Amitkumar

Return-Path: <akarwar@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <gbhat@marvell.com>
Subject: RE: [PATCH v7] Bluetooth: hci_uart: Support firmware download for
 Marvell
Date: Wed, 20 Apr 2016 14:34:05 +0000
Message-ID: <d3b0292dba1f4951ad5aaf8a683b8b7a@SC-EXCH04.marvell.com>
References: <1459845266-2771-1-git-send-email-akarwar@marvell.com>
 <2A69CC2B-1FC2-4148-8564-38335A87CCD7@holtmann.org>
In-Reply-To: <2A69CC2B-1FC2-4148-8564-38335A87CCD7@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thanks for your review.
We will address these comments in updated version.

> > +
> > +/* Receive data */
> > +static int mrvl_recv(struct hci_uart *hu, const void *data, int
> > +count) {
> > +	struct mrvl_data *mrvl =3D hu->priv;
> > +
> > +	if (test_bit(HCI_UART_DNLD_FW, &mrvl->flags)) {
> > +		mrvl->fwdata->skb =3D mrvl_process_fw_data(hu, mrvl->fwdata-
> >skb,
> > +							 (u8 *)data, count);
> > +		if (IS_ERR(mrvl->fwdata->skb)) {
> > +			int err =3D PTR_ERR(mrvl->fwdata->skb);
> > +
> > +			bt_dev_err(hu->hdev,
> > +				   "Receive firmware data failed (%d)", err);
> > +			mrvl->fwdata->skb =3D NULL;
> > +			return err;
> > +		}
> > +		return 0;
> > +	}
>=20
> This part actually worries me a bit. Yes, we can do it this way, but in
> general it sounds a bit more like we need a generic approach in
> hci_ldisc.c to handle pre-HCI firmware loading and/or setup.
>=20
> In the btusb.c driver we added ->setup_on_usb callback. And for it
> sounds like we need something similar here. So that hci_ldisc.c can
> handle most of the basic TX/RX.

Even if we added "->setup_on_usb" in hci_ldisc.c, we will need protocol spe=
cific changes in receive path during firmware download.
With this patch, those changes are smoothly handled in hci_mrvl.c file.
[hci_uart_tty_receive] -> [proto->recv] -> [mrvl_recv] -> [normal Rx path/F=
W download Rx handling]

> > +
> > +static int mrvl_setup(struct hci_uart *hu) {
> > +	struct mrvl_data *mrvl =3D hu->priv;
> > +
> > +	mrvl_init_fw_data(hu);
> > +	set_bit(HCI_UART_DNLD_FW, &mrvl->flags);
> > +
> > +	return hci_uart_dnld_fw(hu);
> > +}
>=20
> So this is clearly the wrong spot. When ->setup is called it is expected
> that HCI is ready. You are misusing it here.
>=20

Sure. We will move this to mrvl_open() where HCI is not yet initialized.

Regards,
Amitkumar

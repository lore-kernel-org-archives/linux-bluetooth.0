Return-Path: <akarwar@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat
	<gbhat@marvell.com>
Subject: RE: [PATCH v9 3/3] Bluetooth: hci_uart: Support firmware download for
 Marvell
Date: Wed, 4 May 2016 14:40:10 +0000
Message-ID: <7a96f0ab0acb4b97a4590ba037cc8dd2@SC-EXCH04.marvell.com>
References: <1461925478-31851-1-git-send-email-akarwar@marvell.com>
 <1461925478-31851-3-git-send-email-akarwar@marvell.com>
 <D3B4A169-777A-4235-B3C9-EBFA2117CE3D@holtmann.org>
In-Reply-To: <D3B4A169-777A-4235-B3C9-EBFA2117CE3D@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thanks for your comments.
We are working to resolve them.

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
> So I really want to get rid of this part in the driver ->recv should be
> kept compartmentalized between before HCI is ready and when HCI is
> ready.
>=20

We already have HCI_UART_REGISTERED bit in "hu->flags". I think, we can use=
 it to know if HCI is ready or not.
We will define two recv handlers. "->recv" and "->recv_for_prepare"

OR let us know if you want us to use single "->recv" and have code under "i=
f (HCI_UART_REGISTERED)" and "else" in our handler.

Regards,
Amitkumar

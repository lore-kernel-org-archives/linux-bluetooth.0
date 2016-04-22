Return-Path: <akarwar@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <gbhat@marvell.com>, Cathy Luo
	<cluo@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>
Subject: RE: [PATCH v7] Bluetooth: hci_uart: Support firmware download for
 Marvell
Date: Fri, 22 Apr 2016 15:01:52 +0000
Message-ID: <3f9ff7c183624e568e60681c86bcfdfd@SC-EXCH04.marvell.com>
References: <1459845266-2771-1-git-send-email-akarwar@marvell.com>
 <2A69CC2B-1FC2-4148-8564-38335A87CCD7@holtmann.org>
 <2119fc93636742459899d50f2c1fcb8d@SC-EXCH04.marvell.com>
 <E16A47DE-611D-4C65-B407-1D78280308B4@holtmann.org>
In-Reply-To: <E16A47DE-611D-4C65-B407-1D78280308B4@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Friday, April 22, 2016 6:19 PM
> To: Amitkumar Karwar
> Cc: Linux Bluetooth; LKML; Ganapathi Bhat; Cathy Luo
> Subject: Re: [PATCH v7] Bluetooth: hci_uart: Support firmware download
> for Marvell
>=20
> Hi Amitkumar,
>=20
> >>>> +
> >>>> +static int mrvl_setup(struct hci_uart *hu) {
> >>>> +	struct mrvl_data *mrvl =3D hu->priv;
> >>>> +
> >>>> +	mrvl_init_fw_data(hu);
> >>>> +	set_bit(HCI_UART_DNLD_FW, &mrvl->flags);
> >>>> +
> >>>> +	return hci_uart_dnld_fw(hu);
> >>>> +}
> >>>
> >>> So this is clearly the wrong spot. When ->setup is called it is
> >>> expected that HCI is ready. You are misusing it here.
> >>>
> >>
> >> Sure. We will move this to mrvl_open() where HCI is not yet
> initialized.
> >
> > We tried moving firmware download to mrvl_open(), but it's not
> feasible. "hu->proto" is not yet initialized at that time. So when the
> data/ack is received during firmware download, we can't have Marvell
> specific handling. Also, I can see other vendor's (broadcomm, Intel)
> have done firmware download in setup handler.
>=20
> firmware download in ->setup() is fine as long as it uses HCI commands.
> If it does not use HCI commands, then we need to come up with something
> new.
>=20
> The problem here is that for all intense and purposes once ->setup() is
> called, then assumption is that you are in an HCI capable transport and
> it is ready.
>=20

We have maintained a flag(in mrvl->flags) which remains on until firmware d=
ownload gets completed. We drop HCI frames in "->enqueue" if firmware downl=
oad is in progress. I don't see any possible issues if firmware download is=
 included in ->setup().

request_firmware() API expects a device pointer (hdev->dev). We won't get v=
alid pointer until HCI is ready.
Also, we are downloading firmware data chunks through normal Tx path(schedu=
ling hu->write_work etc) where hdev comes into picture.

Let me know your thoughts.

Regards,
Amitkumar

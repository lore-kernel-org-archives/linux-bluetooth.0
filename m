Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 2 Jun 2009 12:05:20 -0700
Subject: RE: [PATCH 1/4 v2] bluetooth: add btmrvl driver to support Marvell
 bluetooth devices
Message-ID: <477F20668A386D41ADCC57781B1F704301E90677EA@SC-VEXCH1.marvell.com>
References: <1243640590-31666-1-git-send-email-bzhao@marvell.com>
 <1243667360.3523.28.camel@localhost.localdomain>
In-Reply-To: <1243667360.3523.28.camel@localhost.localdomain>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thanks for reviewing our patches.

> Hi Bing,
>=20
> > This driver provides basic definitions and library functions to
> > support Marvell Bluetooth enabled devices, such as 88W8688 WLAN/BT
> > combo chip.
>=20
> we still have to talk about the handling of vendor commands. Handling
> these inside the driver is a bad idea. We can just let the core forward
> them to you if you are interested. I have to think about it a little
> bit.

I don't know how the vendor specific commands can be handled outside of btm=
rvl.ko driver.
Please share with me once you have any idea on the handling of the vendor c=
ommands.
=20
> > +struct btm_thread {
> > +	struct task_struct *task;
> > +	wait_queue_head_t wait_q;
> > +	void *priv;
> > +};
>=20
> Please prefix everything with btmrvl_* for cleaner namespace. Especially
> for the exported symbol it is important that you have a clean namespace.

I've made this change. Do you want me to resend the new patch now, or wait =
a while for more feedbacks?

>=20
> Regards
>=20
> Marcel
>=20

Thanks,

Bing

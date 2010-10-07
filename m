Return-Path: <cyrus@holtmann.org>
From: "Savoy, Pavan" <pavan_savoy@ti.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "greg@kroah.com"
	<greg@kroah.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Date: Thu, 7 Oct 2010 20:53:09 +0530
Subject: RE: [PATCH 1/2] drivers:bluetooth: TI_ST bluetooth driver
Message-ID: <19F8576C6E063C45BE387C64729E739404AA21D1B4@dbde02.ent.ti.com>
References: <1286404493-23816-1-git-send-email-pavan-savoy@ti.com>
	 <1286404493-23816-2-git-send-email-pavan-savoy@ti.com>
	 <1286445948.6145.70.camel@aeonflux>
	 <19F8576C6E063C45BE387C64729E739404AA21D19E@dbde02.ent.ti.com>
 <1286464659.6145.144.camel@aeonflux>
In-Reply-To: <1286464659.6145.144.camel@aeonflux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Thursday, October 07, 2010 10:18 AM
> To: Savoy, Pavan
> Cc: linux-bluetooth@vger.kernel.org; johan.hedberg@gmail.com; greg@kroah.=
com;
> linux-kernel@vger.kernel.org
> Subject: RE: [PATCH 1/2] drivers:bluetooth: TI_ST bluetooth driver
>=20
> Hi Pavan,
>=20
> > > Registering the Bluetooth HCI driver in module_init/module_exit is no=
t
> > > acceptable. Turn your shared transport into a proper bus.
> >
> > Yes, you did comment on it before, I remember, I did prototype the driv=
er as
> > a bus driver, However I didn't find any advantages by converting it to =
a bus
> > driver.
> > As in, currently the shared transport driver is a line discipline drive=
r
> because
> > it is the only way it can communicate over TTY without being tightly co=
upled
> with the UART driver.
> >
> > > We want to be able to have generic kernels where this module is enabl=
ed,
> > > but no Shared Transport is available.
> >
> > Oh if this is the reason I cannot have hci_register/_unregister in
> module_init/_exit, Can I do this module "depends" on TI_ST, Then it would=
 not
> > even be visible to build if TI_ST is not selected.
>=20
> this is not helping either. Then TI_ST can not be selected and so you
> still end up with some weird platform specific kernels. We don't want
> that. We want generic kernels that can detect the hardware they are
> running on.
>=20
> As I said, I will not accept this driver if it registers HCI device in
> module_init. No other driver is doing this and it is in general a really
> really really bad idea.
>=20

Ok, now I am beginning to get what you say, Let me check, may be what
I can do is, have something like a st_prepare() function called in the
module_init, and a _probe function of the bluetooth driver will be called,
_ONLY_ if the _probe of my platform driver has been called..
Do you think this would be a good idea?

Note: the TI_ST driver is also a platform device driver, so that TI_ST's
Probe is not called, if a arch/xx/board-xx doesn't add it.

Please suggest.


>=20
> Marcel
>=20

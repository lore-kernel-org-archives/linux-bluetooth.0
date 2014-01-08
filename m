Return-Path: <cyrus@holtmann.org>
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH v2] Bluetooth: Add hci_h4p driver
Date: Wed, 8 Jan 2014 22:36:24 +0100
Cc: Marcel Holtmann <marcel@holtmann.org>,
 =?utf-8?q?=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE?=
 =?utf-8?q?_=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2?= <freemangordon@abv.bg>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Pavel Machek <pavel@ucw.cz>,
 "linux-kernel" <linux-kernel@vger.kernel.org>,
 "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
References: <1379703710-5757-1-git-send-email-pali.rohar@gmail.com> <201312301531.29768@pali> <20131230145250.GA16904@earth.universe>
In-Reply-To: <20131230145250.GA16904@earth.universe>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201401082236.25135@pali>
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 30 December 2013 15:52:51 Sebastian Reichel wrote:
> > > > +MODULE_DESCRIPTION("Bluetooth h4 driver with nokia
> > > > extensions"); +MODULE_LICENSE("GPL");
> > > > +MODULE_AUTHOR("Ville Tervo");
> > > > +MODULE_FIRMWARE(FW_NAME_TI1271_PRELE);
> > > > +MODULE_FIRMWARE(FW_NAME_TI1271_LE);
> > > > +MODULE_FIRMWARE(FW_NAME_TI1271);
> > > > +MODULE_FIRMWARE(FW_NAME_BCM2048);
> > > > +MODULE_FIRMWARE(FW_NAME_CSR);
> > >=20
> > > Do we actually have all these firmware files still
> > > available. If not, then focus on the ones we have.
> >=20
> > Firmware files are available for download from nemo project:
> >=20
> > https://api.merproject.org/public/source/nemo:devel:hw:ti:om
> > ap3:n900/bcm-bt-firmware/bcm-bt-firmware-0.21rc3.tar.bz2
> > https://api.merproject.org/public/source/nemo:devel:hw:ti:o
> > map3:n950-n9/ti-wl1273-bt-firmware/bt-firmware-ti1273_0.23+0
> > m6.tar.gz
>=20
> Would be nice to have them added to the linux-firmware.git.
>=20
> -- Sebastian

Can somebody send firmware files for inclusion to linux-firmware?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

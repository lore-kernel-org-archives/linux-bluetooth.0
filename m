Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Szymon Janc <szymon.janc@tieto.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Date: Fri, 8 May 2015 06:59:10 -0700
Subject: RE: [PATCH] Bluetooth: btmrvl: add manufacturing mode support
Message-ID: <5FF020A1CFFEEC49BD1E09530C4FF5951B17110717@SC-VEXCH1.marvell.com>
References: <1431012963-2754-1-git-send-email-akarwar@marvell.com>
 <9058872.bsh93WddjV@leonov>
In-Reply-To: <9058872.bsh93WddjV@leonov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> > +
> > +	strcpy(mfg_firmware, buf);
>=20
> if len =3D=3D sizeof(mfg_firmware) you will write 1 byte after mfg_firmwa=
re
>=20
> > +	mfg_firmware[len - 1] =3D '\0';
>=20
> if len =3D=3D 0 you will write 1 byte before mfg_firmware
>=20
> > +

Thanks for your review. We will take care of this in updated version.

Regards,
Amit

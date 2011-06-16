Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        "anderson.briglia@openbossa.org"
	<anderson.briglia@openbossa.org>,
        "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>,
        Bruna Moreira
	<bruna.moreira@openbossa.org>
Date: Thu, 16 Jun 2011 16:19:34 +0200
Subject: RE: [RFC 7/7] Update Management API documentation
Message-ID: <7769C83744F2C34A841232EF77AEA20C01D395E0F5@dnce01.ent.ti.com>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	<1308175855.2196.7.camel@aeonflux>
	<BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01D395DC90@dnce01.ent.ti.com>
 <BANLkTikn6b+8yezsPOAc77P5dfi2XA8TZA@mail.gmail.com>
In-Reply-To: <BANLkTikn6b+8yezsPOAc77P5dfi2XA8TZA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


> -----Original Message-----
> From: Anderson Lizardo [mailto:anderson.lizardo@openbossa.org]
> Sent: Thursday, June 16, 2011 4:45 PM
> To: Ganir, Chen
> Cc: Marcel Holtmann; anderson.briglia@openbossa.org; linux-
> bluetooth@vger.kernel.org; Bruna Moreira
> Subject: Re: [RFC 7/7] Update Management API documentation
>=20
> Hi Chen,
>=20
> On Thu, Jun 16, 2011 at 2:03 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> > Please note that this is currently true for LE connection, but may
> change
> > in the future.
>=20
> If you read the latest Proximity draft (not from bluetooth.org, from
> the mailing lists), you will see that the recommendation to read TX
> power once on LE is to conserve power (specially on the single mode
> device, I suppose, but it would waste power on the BlueZ side as
> well). Unfortunately, if they change the recommendation again (in this
> case they would be returning to a previous decision), we would
> inevitably have to change implementation anyway.

Anderson,
>From the version I have (d10), it is clearly seen that it can support both
BR/EDR and LE as well (service discovery for example is explained for both
BR/EDR and LE). In addition, it is stated in this version of the spec that
The TX power characteristic should return the current TX power level. This
means that if there is any chance that this level changes, it must be updat=
ed
periodically, or read each time the characteristic is accessed for reading
(with the suggested GATT server callback mechanism).Furthermore, it is clea=
rly=20
specified that on BR/EDR, when the TX Power level changes, the reporter=20
should notify the monitor about the change, if it's registered for these=20
notifications.

I see no reason to implement different behavior or logic for BE/EDR or LE.=
=20
In addition, I do not believe it is the responsibility of the bluez stack=20
(adapter in this case) to set the intervals for getting this info - it is=20
the responsibility of the profile, whether it is implemented as a bluez plu=
gin=20
(so the plugin initiates the RSSI/TX Power readings according to its own=20
timing) or by an external profile (if future bluez implementation allows th=
is).



Thanks,
Chen Ganir

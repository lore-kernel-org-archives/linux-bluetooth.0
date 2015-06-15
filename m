Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Guenter Roeck <linux@roeck-us.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Frederic Danis
	<frederic.danis@linux.intel.com>, BlueZ development
	<linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: RE: Build error -in -next due to 'Bluetooth: hci_uart: Support
 operational speed during setup'
Date: Mon, 15 Jun 2015 16:51:12 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E9426232D@IRVEXCHMB15.corp.ad.broadcom.com>
References: <557ED81D.7090908@roeck-us.net>
 <7CF3D545-DAE4-4510-9726-5D40740DDC5D@holtmann.org>
 <557EE045.2090503@roeck-us.net>
 <E0D3336E15B58B4294723AC879BA5E94262266@IRVEXCHMB15.corp.ad.broadcom.com>
 <7F15059F-B180-4722-8167-864C4A24CE9B@holtmann.org>
In-Reply-To: <7F15059F-B180-4722-8167-864C4A24CE9B@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Monday, June 15, 2015 10:43 AM
To: Ilya Faenson
Cc: Guenter Roeck; linux-kernel@vger.kernel.org; Frederic Danis; BlueZ deve=
lopment; linux-serial@vger.kernel.org
Subject: Re: Build error -in -next due to 'Bluetooth: hci_uart: Support ope=
rational speed during setup'

Hi Ilya,

>>> alpha:allmodconfig fails to build in -next with
>>>=20
>>> drivers/bluetooth/hci_ldisc.c: In function 'hci_uart_set_baudrate':
>>> drivers/bluetooth/hci_ldisc.c:276:22: error: 'BOTHER' undeclared
>>>=20
>>> BOTHER is not defined for all architectures and otherwise only
>>> used with '#ifdef BOTHER'.
>>=20
>> thanks for the report. Is this something that should be #ifdef at the us=
ing side or maybe just fixed for the other architectures.
>>=20
>=20
> So far it has been fixed with #ifdef, and this is the first code which
> uses it outside drivers/tty. So my first tendency would be to fix it
> on the user side.
>=20
> However, looking into it, I think only alpha and avr32 are affected.
> Let me submit patches against those and see where it goes.
>=20
> IF: The BOTHER flag should not be involved in setting the baud rate at al=
l. I've published a patch last week that implements the hci_uart_set_baudra=
te properly (in my opinion).

can you extract this and just submit that version. We might just take that =
into hci_ldisc.c right away.

IF: I've published my version now, thanks.

However fixing the #ifdef around BOTHER is useful as well since they look u=
nneeded. At least I can not see a reason why a platform would not define th=
em.

Regards

Marcel

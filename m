Return-Path: <cyrus@holtmann.org>
From: "Cooper Xu" <cooper.xu@mapleworks.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1660E2CC4AF24655A1FFE788570A34FF@mapleworks.com> <1268609330.3897.51.camel@localhost.localdomain> <7ED1002624DD4A3BB31F08AF5DC6090E@mapleworks.com> <1268707083.2700.14.camel@localhost.localdomain>
Subject: RE: A strange compatible problem for eSCO audio with CSR USB Bluetooth dongle
Date: Mon, 15 Mar 2010 23:06:21 -0400
Message-ID: <AD89715662C34356B6C5C4CD64709319@mapleworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1268707083.2700.14.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Another thing worth to say is that so far I found the pattern is like the
following:

If the sender side is CSR chipset USB dongle with Bluez and receiver side is
also Bluez, it will most likely read all zero.  

If the sender side is CSR chipset USB dongle with Bluez and receiver side is
NOT Bluez, it seems OK.

If the sender side is another chipset and receiver side is also Bluez, it
seems OK, but voice is a little choppy.

Cooper

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org] 
Sent: Monday, March 15, 2010 10:38 PM
To: Cooper Xu
Cc: linux-bluetooth@vger.kernel.org
Subject: RE: A strange compatible problem for eSCO audio with CSR USB
Bluetooth dongle

Hi Cooper,

no top posting on this mailing list. We do proper inline quoting.

> I used the attached scotest.c to do the test for both client and server.
> This file is from Bluez 4.58. I modified a little because the original is
> sending packets too fast. I turned off eSCO according to Nick's
suggestion.

the scotest.c tool is just for basic testing. There is no guarantee that
it does the right job. Some devices might send silence if the Headset or
Handsfree profile is not fully setup.

Regards

Marcel

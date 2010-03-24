Return-Path: <cyrus@holtmann.org>
From: "Cooper Xu" <cooper.xu@mapleworks.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1660E2CC4AF24655A1FFE788570A34FF@mapleworks.com> <1268609330.3897.51.camel@localhost.localdomain> <7ED1002624DD4A3BB31F08AF5DC6090E@mapleworks.com> <1268707083.2700.14.camel@localhost.localdomain>
Subject: RE: A strange compatible problem for eSCO audio with CSR USB Bluetooth dongle
Date: Wed, 24 Mar 2010 17:08:03 -0400
Message-ID: <D070EF80DA534D739F86A07520CA6300@mapleworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1268707083.2700.14.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Do you have any clue what happened? I tried the same test with the latest
Linux 2.6.34-rc2 kernel and had the same result. This seemed to be easily
reproducible with two CSR USB dongles of LMP Subver 0xc5c.

Thanks

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

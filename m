Return-Path: <cyrus@holtmann.org>
From: "Cooper Xu" <cooper.xu@mapleworks.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1660E2CC4AF24655A1FFE788570A34FF@mapleworks.com> <1268609330.3897.51.camel@localhost.localdomain> <7ED1002624DD4A3BB31F08AF5DC6090E@mapleworks.com> <1268707083.2700.14.camel@localhost.localdomain>
Subject: RE: A strange compatible problem for eSCO audio with CSR USB Bluetooth dongle
Date: Mon, 15 Mar 2010 22:53:18 -0400
Message-ID: <D35076D90CB4405DA3D5032BCFECCA47@mapleworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1268707083.2700.14.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I had tried with device class to 0x200404 and it didn't make any difference.
I use the "scotest.c" to simplify the debug. The actual application is much
more complicated. But the issue is similar with test result of "scotest.c".
I assume the "scotest.c" should give me some valid data, as I sent so many
real data from one side. I can actually receive real data with some USB
dongles. But I have problem CSR chipset USB dongles with relatively newer
firmware. That is something real confused me. 

Regards,
Cooper





-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org
[mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Marcel Holtmann
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


--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

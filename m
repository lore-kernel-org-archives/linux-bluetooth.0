Return-Path: <cyrus@holtmann.org>
Subject: RE: A strange compatible problem for eSCO audio with CSR USB
 Bluetooth dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Cooper Xu <cooper.xu@mapleworks.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <7ED1002624DD4A3BB31F08AF5DC6090E@mapleworks.com>
References: <1660E2CC4AF24655A1FFE788570A34FF@mapleworks.com>
	 <1268609330.3897.51.camel@localhost.localdomain>
	 <7ED1002624DD4A3BB31F08AF5DC6090E@mapleworks.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Mar 2010 19:38:03 -0700
Message-ID: <1268707083.2700.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Cooper,

no top posting on this mailing list. We do proper inline quoting.

> I used the attached scotest.c to do the test for both client and server.
> This file is from Bluez 4.58. I modified a little because the original is
> sending packets too fast. I turned off eSCO according to Nick's suggestion.

the scotest.c tool is just for basic testing. There is no guarantee that
it does the right job. Some devices might send silence if the Headset or
Handsfree profile is not fully setup.

Regards

Marcel



Return-Path: <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: BCM2033 firmware loader
From: Max Krasnyansky <maxk@qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074302399.2629.137.camel@pegasus>
References: <1074193649.2629.23.camel@pegasus>
	 <1074196213.2559.255.camel@localhost>  <1074197813.2629.52.camel@pegasus>
	 <1074287664.2559.422.camel@localhost>  <1074302399.2629.137.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074626856.1707.108.camel@localhost>
Mime-Version: 1.0
Date: Tue, 20 Jan 2004 11:27:36 -0800
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2004-01-16 at 17:19, Marcel Holtmann wrote:
> On the other hand it is also possible to make the firmware loading
> routine of the bcm203x driver a compile time option of the hci_usb
> driver. Of course this is also a waste inside the kernel, but you don't
> have an extra module to load. Do you think this is a better approach?
No no. I actually quite liked the idea of making it a separate driver.
Because it makes an unloading possible. I mean it won't be unloaded
automatically but at least you can do it manually.

I'll play with latest 2.6 and bluefw to see what's wrong with usbfs.

Thanks
Max

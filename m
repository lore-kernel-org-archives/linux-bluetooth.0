Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Oct 2014 13:27:44 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Naveen Kumar Parna <pnaveenkos@gmail.com>
cc: Oliver Neukum <oneukum@suse.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <acho@suse.com>
Subject: Re: btusb_intr_complete returns -EPIPE
In-Reply-To: <CAG0bkvJv0VdeKXMOg-6+LVYJU1qD5bQboJ3MNGrUY9xPNMTALw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1410281324190.1213-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 28 Oct 2014, Naveen Kumar Parna wrote:

> >> You should also run a similar test when you connect the device through
> >> a USB-2 hub.  In fact, you should run two tests.  In one test, connect
> >> the analyzer to the cable segment between the computer and the hub; in
> >> the other test, connect the analyzer to the cable segment between the
> >> hub and the device.
> >>
> >
> 
> I connected the USB analyzer to the cable segment between the computer
> and the external USB-2 hub(devices are attached to this external USB-2
> hub). In this scenario , got the stall in usbmon trace, but not in
> analyzer log. But USB analyzer log shows “Incomplete IN transaction”.
> Please check the attached "Elisys_Usb_log.png".
> 
> 
> 
> Incomplete IN transaction           2              1
> INCOMPLETE     HS           No data                884.626 273 217

> Does it gives any clue?

Not really.  I think your analyzer output is incomplete.  For example,
a high-speed Interrupt transaction to a full-speed device should have a
Start Split packet and a Complete Split packet.  I don't see either of
those in your picture.

> For the second test(connect the analyzer to the cable segment between
> the hub and the device): Is it possible with single external USB hub?

Of course it is.  What's the difficulty?

Alan Stern


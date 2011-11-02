Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Nov 2011 12:17:29 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Al Cho <acho@suse.com>
Cc: marcel@holtmann.org, padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org, oneukum@suse.com, jlee@suse.com
Subject: Re: How to add firmware uploader function to Bluez?
Message-ID: <20111102101712.GC12653@aemeltch-MOBL1>
References: <CAKzePapHJwC2VMpjgS_uK=NCUPCEAQt5+zDSEqRJNdPth-Aztw@mail.gmail.com>
 <20111102080259.GB12653@aemeltch-MOBL1>
 <CAKzePaq3pgktQeb9y9HzeGa-JO5aXYuo5e1WgQ+sE=FOVf5pPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAKzePaq3pgktQeb9y9HzeGa-JO5aXYuo5e1WgQ+sE=FOVf5pPw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi AL,

On Wed, Nov 02, 2011 at 06:00:48PM +0800, Al Cho wrote:
> Hi Andrei,
> 
> On Wed, Nov 2, 2011 at 4:03 PM, Andrei Emeltchenko
> <andrei.emeltchenko.news@gmail.com> wrote:
> > Hi AL,
> >
> > On Wed, Nov 02, 2011 at 03:55:50PM +0800, Al Cho wrote:
> >> Hi All,
> >>
> >> Broadcom BT4.0 module 0a5c:21e1 and 0a5c:21e3 need firmware
> >> to setup(enable) at the first time we use.
> >> We got the firmware and firmware uploader (brcm_patchram_plus_usb )
> >> ( user space tool ) from Broadcom ,the Licence is GPLv2,
> >> would it possible that add those to bluez package?or any idea for this?
> >
> > Should firmware come to linux-firmware package?
> >
> 
> Yes, I think so,
> but 0a5c:21e1 and 0a5c:21e3 use btusb driver,
> this firmware use at the first time to enable only,
> and that firmware uploader need to use the bluez hci library.

IMO the standard way is to use request_firmware like for ath3k:

request_firmware(&firmware, "ath3k-1.fw", &udev->dev)

> So I guess add those to bluez would be better.

Most probably that "firmware loader" might be implemented in module as for
other devices as it is usually just a sequence of HCI commands.

Have a look at other BCM modules in drivers/bluetooth/bcm*

Best regards 
Andrei Emeltchenko 

> 
> > Description: Firmware for Linux kernel drivers
> >  This package provides firmware used by Linux kernel drivers.
> >
> > Do not know about "firmware-loader", probably we need to use available tools.
> >


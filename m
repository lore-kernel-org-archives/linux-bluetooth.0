Return-Path: <jungle@saphire.dk>
Subject: Re: [Bluez-users] Logitech MX900 mouse not working.
From: Kim Pedersen <jungle@saphire.dk>
Reply-To: jungle@saphire.dk
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Cc: marcel@holtmann.org
In-Reply-To: <1090771873.31693.6.camel@pegasus>
References: <1090765201.983.13.camel@aquarius>
	 <200407251632.32162.cijoml@volny.cz>  <1090769444.983.19.camel@aquarius>
	 <1090770122.31693.2.camel@pegasus>  <1090770937.983.26.camel@aquarius>
	 <1090771873.31693.6.camel@pegasus>
Content-Type: text/plain
Message-Id: <1090773233.2890.2.camel@aquarius>
Mime-Version: 1.0
Date: Sun, 25 Jul 2004 18:33:53 +0200
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

On Sun, 2004-07-25 at 18:11, Marcel Holtmann wrote:
> Hi Kim,
> 
> > > the error message is different, so I assume that you either don't
> > > activated the hiddev support in your kernel or you use the dynamic USB
> > > minor allocation. Check your kernel config for CONFIG_USB_DYNAMIC_MINORS
> > > and CONFIG_USB_HIDDEV.
> > 
> > I checked my kernel configuration and found that
> > CONFIG_USB_DYNAMIC_MINORS is nowhere to be found (not configured),
> > however CONFIG_USB_HIDDEV is:
> > 
> > #
> > # USB Human Interface Devices (HID)
> > #
> > CONFIG_USB_HID=m
> > CONFIG_USB_HIDINPUT=y
> > CONFIG_USB_HIDDEV=y
> > 
> > It is also loaded (usbhid,usbkbd,usbmouse).
> 
> don't load usbkbd and usbmouse. Actually I don't know how you get them
> compiled at the same time. Read the help text for those modules and
> check your kernel config again. Mine looks like this:
> 
> <snip>
> 
> CONFIG_USB=m
> # CONFIG_USB_DEBUG is not set
> CONFIG_USB_DEVICEFS=y
> # CONFIG_USB_BANDWIDTH is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> CONFIG_USB_EHCI_HCD=m
> # CONFIG_USB_EHCI_SPLIT_ISO is not set
> # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
> CONFIG_USB_OHCI_HCD=m
> CONFIG_USB_UHCI_HCD=m
> 
> <snip>
> 
> CONFIG_USB_HID=m
> CONFIG_USB_HIDINPUT=y
> CONFIG_USB_HIDDEV=y
> # CONFIG_USB_KBD is not set
> # CONFIG_USB_MOUSE is not set
> 
> <snip>
> 

That did the trick!! THANKS!!

I am now writing this with both the keyboard and the mouse running
Bluetooth..

Again, Thanks alot :)


Sincerely,

// Kim Pedersen
  -- Freedom Matters!

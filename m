Return-Path: <jungle@saphire.dk>
Subject: Re: [Bluez-users] Logitech MX900 mouse not working.
From: Kim Pedersen <jungle@saphire.dk>
Reply-To: jungle@saphire.dk
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1090770122.31693.2.camel@pegasus>
References: <1090765201.983.13.camel@aquarius>
	 <200407251632.32162.cijoml@volny.cz>  <1090769444.983.19.camel@aquarius>
	 <1090770122.31693.2.camel@pegasus>
Content-Type: text/plain
Message-Id: <1090770937.983.26.camel@aquarius>
Mime-Version: 1.0
Date: Sun, 25 Jul 2004 17:55:37 +0200
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

On Sun, 2004-07-25 at 17:42, Marcel Holtmann wrote:

> > and hid2hci also still reports:
> > Switching device 046d:c703 to HCI mode failed (No such device)
> 
> the error message is different, so I assume that you either don't
> activated the hiddev support in your kernel or you use the dynamic USB
> minor allocation. Check your kernel config for CONFIG_USB_DYNAMIC_MINORS
> and CONFIG_USB_HIDDEV.

I checked my kernel configuration and found that
CONFIG_USB_DYNAMIC_MINORS is nowhere to be found (not configured),
however CONFIG_USB_HIDDEV is:

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y

It is also loaded (usbhid,usbkbd,usbmouse).

Sorry to keep pestering :)

Sincerely,

// Kim Pedersen
  -- Freedom Matters!

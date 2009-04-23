Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: add support for Integrated System Solution
 devices
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <6b53b1990904230857p22c97be7oa8bd6fb66d4a6c72@mail.gmail.com>
References: <1240169747-15998-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <6b53b1990904230857p22c97be7oa8bd6fb66d4a6c72@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 23 Apr 2009 17:07:53 +0100
Message-Id: <1240502873.15894.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > Just add the device id to btusb. I tested with obexd and hcitool info
> > <baddr> and it works. But there is an issue yet, l2ping disconnects after
> > 10 seconds.
> >
> > Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
> > ---
> >  drivers/bluetooth/btusb.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index e70c57e..9df83a7 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -131,6 +131,9 @@ static struct usb_device_id blacklist_table[] = {
> >        { USB_DEVICE(0x08fd, 0x0001), .driver_info = BTUSB_DIGIANSWER },
> >        { USB_DEVICE(0x08fd, 0x0002), .driver_info = BTUSB_IGNORE },
> >
> > +       /* Integrated System Solution devices */
> > +       { USB_DEVICE(0x1131, 0x1004), .driver_info = BTUSB_WRONG_SCO_MTU },
> > +
> >        /* CSR BlueCore Bluetooth Sniffer */
> >        { USB_DEVICE(0x0a12, 0x0002), .driver_info = BTUSB_SNIFFER },
> >
> > --
> > 1.6.0.6
> 
> 
> Proving that we need this:
> 
> before patch:
>  - /proc/bus/usb/devices: http://pastebin.com/m18d4d0a1
>  - hciconfig -a: http://pastebin.com/m44e553cb
> 
> after patch:
>  - /proc/bus/usb/devices:http://pastebin.com/m5d7add7d
>  - hciconfig -a: http://pastebin.com/m58522f0c

you are confusing me. Can you make sure you local Broadcom dongle is off
via the RFKILL switch and doesn't show up in lsusb.

Regards

Marcel



Return-Path: <jjjessen@control.auc.dk>
Date: Tue, 26 Aug 2003 13:24:00 +0200 (MEST)
From: "Jan J. Jessen" <jjjessen@control.auc.dk>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Digianswer USB driver
In-Reply-To: <1060951166.952.57.camel@pegasus>
Message-ID: <Pine.GSO.4.40.0308261317320.19084-100000@prosit.control.auc.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,

On 15 Aug 2003, Marcel Holtmann wrote:

> Hi Jan,
>
> thanks for this information. I always tried to get my hands on the
> Digianswer Bluetooth devices, but I never got one. Do you have a spare
> one for me?

Unfortunately no. Aalborg University has a history of cooperation with
Digianswer, and they have partly sponsered the equipment for use in
student projects. So I don't own the devices.

> Changing the bRequestType is such an ugly hack, but on the other side it
> is a very simple change to get these devices supported by hci_usb. I
> will write a patch for supporting Digianswer devices and H:2 Bluetooth
> devices at the same time, but I need some more information about the
> your device. Please send me the output of "cat /proc/bus/usb/devices"
> and "hciconfig -a".
>
> Regards
>
> Marcel

At the moment my Linux dist is having a vacation! Can you do with vendor
and product IDs? From my own driver:

/* Digianswer specific values */
#define USB_DIGI_VENDOR_ID    0x08fd
#define USB_DIGI_PRODUCT_ID   0x1
#define BLUETOOTH_REQ_TYPE    0x40

I hope this will do.

Best regards, Jan Jakob
------------------------------------
Jan Jakob Jessen
Ph.D. Student, M.Sc.E.E.
Center for Embedded Software Systems
Aalborg University
Fredrik Bajers Vej 7C, B2-212
DK-9220 Aalborg East

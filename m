Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jul 2015 17:01:07 -0400
From: Chris Mason <clm@fb.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] I have no idea what I'm doing
Message-ID: <20150714210107.GF27622@ret.masoncoding.com>
References: <20150714191612.GA27622@ret.masoncoding.com>
 <47D2BE08-D7D0-4B1A-8B5B-17C99E0A3CF7@holtmann.org>
 <20150714195929.GB27622@ret.masoncoding.com>
 <06F4677F-AFFD-4728-AF99-ACCC1B602AEB@holtmann.org>
 <20150714205339.GE27622@ret.masoncoding.com>
 <2C969CCF-92B3-4835-B9F5-550A9DEC4FF2@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <2C969CCF-92B3-4835-B9F5-550A9DEC4FF2@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 14, 2015 at 10:58:50PM +0200, Marcel Holtmann wrote:
> Hi Chris,
> 
> >>>> Actually can you run something like "hciconfig hci0 version" and see
> >>>> if it really is a Broadcom chip in there or if Apple switched vendors
> >>>> and we are accidentally assuming it is Broadcom while in reality it is
> >>>> not. If it is not then the quirk might actually not apply either
> >>>> anymore.
> >>> 
> >>> mason@ret ~> hciconfig hci0 version
> >>> hci0:	Type: BR/EDR  Bus: USB
> >>> 	BD Address: 60:03:08:8D:0D:A9  ACL MTU: 1021:8  SCO MTU: 64:1
> >>> 	HCI Version: 4.0 (0x6)  Revision: 0x21ae
> >>> 	LMP Version: 4.0 (0x6)  Subversion: 0x414e
> >>> 	Manufacturer: Broadcom Corporation (15)
> >> 
> >> so it is a Broadcom. What MacBook is this anyway?
> > 
> > macbookpro 13" from 2013 (newer model in '13)
> 
> besides having that Bluetooth module for testing, I also have that actual Macbook. And I did test this. It worked fine for me. Maybe some OS X update messed with the firmware. Worth while checking.

This only runs linux, I don't dual boot.

-chris

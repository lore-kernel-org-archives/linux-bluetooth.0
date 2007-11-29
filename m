Return-Path: <jikos@jikos.cz>
Date: Thu, 29 Nov 2007 21:43:58 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Dave Young <hidave.darkstar@gmail.com>, bgsmith@bendcable.com,
        BlueZ users <bluez-users@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bluez-users] Lost connections - mouse and keyboard
In-Reply-To: <6EE8D368-C303-400A-B4FE-811228391639@holtmann.org>
Message-ID: <Pine.LNX.4.64.0711292141220.19853@twin.jikos.cz>
References: <1196009038.14897.6.camel@pico> <1196056187.4217.54.camel@aeonflux>
 <1196305426.23029.12.camel@pico> <a8e1da0711290006x4bd3cc45x1ae8dcaa9c0ab462@mail.gmail.com>
 <6EE8D368-C303-400A-B4FE-811228391639@holtmann.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

On Thu, 29 Nov 2007, Marcel Holtmann wrote:

> > >Nov 28 18:53:39 pico kernel: WARNING: at drivers/hid/hid-core.c:784
[ ... ]

> > Does bluetooth input devices have something to do with usbhid? I don't 
> > know, perhaps this is another problem in kernel.
> in case you have a HID proxy dongle the usbhid driver can be involved. And
> since this is hiddev, then it will be caused by the hid2hci program.

Absolutely.

This particular warning means, that someone (usually indeed hid2hci) 
passed usage through hiddev that was out of bounds, with respect to the 
device's report descriptor.

This usually means that hid2hci has chosen the wrong method to switch the 
modes. Unfortunately, it's not easy to implement always the switching 
properly, if we don't know the vendor-specific packet that has to be sent.

-- 
Jiri Kosina

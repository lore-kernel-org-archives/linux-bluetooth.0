Return-Path: <hidave.darkstar@gmail.com>
Message-ID: <a8e1da0711291706h68d1d19ajc3819f8836cf51e8@mail.gmail.com>
Date: Fri, 30 Nov 2007 09:06:52 +0800
From: "Dave Young" <hidave.darkstar@gmail.com>
To: "Jiri Kosina" <jikos@jikos.cz>
Subject: Re: [Bluez-users] Lost connections - mouse and keyboard
Cc: "Marcel Holtmann" <marcel@holtmann.org>, bgsmith@bendcable.com,
        "BlueZ users" <bluez-users@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0711292141220.19853@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1196009038.14897.6.camel@pico> <1196056187.4217.54.camel@aeonflux>
	 <1196305426.23029.12.camel@pico>
	 <a8e1da0711290006x4bd3cc45x1ae8dcaa9c0ab462@mail.gmail.com>
	 <6EE8D368-C303-400A-B4FE-811228391639@holtmann.org>
	 <Pine.LNX.4.64.0711292141220.19853@twin.jikos.cz>
List-ID: <bluez-users.lists.sourceforge.net>

On Nov 30, 2007 4:43 AM, Jiri Kosina <jikos@jikos.cz> wrote:
> On Thu, 29 Nov 2007, Marcel Holtmann wrote:
>
> > > >Nov 28 18:53:39 pico kernel: WARNING: at drivers/hid/hid-core.c:784
> [ ... ]
>
> > > Does bluetooth input devices have something to do with usbhid? I don't
> > > know, perhaps this is another problem in kernel.
> > in case you have a HID proxy dongle the usbhid driver can be involved. And
> > since this is hiddev, then it will be caused by the hid2hci program.
>
> Absolutely.
>
> This particular warning means, that someone (usually indeed hid2hci)
> passed usage through hiddev that was out of bounds, with respect to the
> device's report descriptor.

Is this behaviour the normal one? IMHO, userspace program should not
cause kernel warnings like this no mater what input from users.

>
> This usually means that hid2hci has chosen the wrong method to switch the
> modes. Unfortunately, it's not easy to implement always the switching
> properly, if we don't know the vendor-specific packet that has to be sent.
>
> --
> Jiri Kosina
>

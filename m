Return-Path: <jikos@jikos.cz>
Date: Fri, 30 Nov 2007 10:15:33 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Dave Young <hidave.darkstar@gmail.com>
cc: Marcel Holtmann <marcel@holtmann.org>, bgsmith@bendcable.com,
        BlueZ users <bluez-users@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bluez-users] Lost connections - mouse and keyboard
In-Reply-To: <a8e1da0711291706h68d1d19ajc3819f8836cf51e8@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0711301011330.19853@twin.jikos.cz>
References: <1196009038.14897.6.camel@pico> <1196056187.4217.54.camel@aeonflux>
  <1196305426.23029.12.camel@pico>  <a8e1da0711290006x4bd3cc45x1ae8dcaa9c0ab462@mail.gmail.com>
  <6EE8D368-C303-400A-B4FE-811228391639@holtmann.org>
 <Pine.LNX.4.64.0711292141220.19853@twin.jikos.cz>
 <a8e1da0711291706h68d1d19ajc3819f8836cf51e8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

On Fri, 30 Nov 2007, Dave Young wrote:

> > This particular warning means, that someone (usually indeed hid2hci) 
> > passed usage through hiddev that was out of bounds, with respect to 
> > the device's report descriptor.
> Is this behaviour the normal one? IMHO, userspace program should not
> cause kernel warnings like this no mater what input from users.

It has been on my todo list to convert that WARN_ON() to something that 
won't scare users that much, especially the stacktrace shouldn't certainly 
be there. I will do it.

-- 
Jiri Kosina

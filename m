Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Date: Thu, 18 Aug 2016 16:04:49 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcel Holtmann
 <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>,
        Sebastian Reichel
 <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Peter Hurley
 <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>,
        "Dr . H . Nikolaus
 Schaller" <hns@goldelico.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij
 <linus.walleij@linaro.org>,
        linux-bluetooth@vger.kernel.org,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Message-ID: <20160818160449.328b2eec@lxorguk.ukuu.org.uk>
In-Reply-To: <CAL_Jsq+Va2OF1pYTivH8YN1GKsiaT1eTOaSv607K_V+H+0Buvw@mail.gmail.com>
References: <20160818011445.22726-1-robh@kernel.org>
	<20160818102208.GA20476@kroah.com>
	<CAL_Jsq+Va2OF1pYTivH8YN1GKsiaT1eTOaSv607K_V+H+0Buvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

> No, the code should be fast as it is so simple. I assume there is some
> reason the tty buffering is more complex than just a circular buffer.

I would suggest you read n_tty.c carefully and then it'll make a fair bit
of sense. It has to interlock multiple reader/writes with discipline
changes and flushes of pending data. At the same time a received
character may cause output changes including bytes to be queued for
transmit and the entire lot must not excessively recurse.

It's fun and it took years to make work safely but basically you need to
handle a simultaneous ldisc change, config change, read of data from the
buffers, receive, transmit and the receive causing the transmit status to
change and maybe other transmits, that might have to be sent with
priority. It's fun 8)

The good news is that nobody but n_tty and maybe n_irda cares on the rx
side. Every other ldisc consumes the bytes immediately. IRDA hasn't worked
for years anyway.

> My best guess is because the tty layer has to buffer things for
> userspace and userspace can be slow to read? Do line disciplines make
> assumptions about the tty buffering? Is 4KB enough buffering?

RTFS but to save you a bit of effort

1. 4K is not enough, 64K is not always sufficient, this is why we have
all the functionality you appear to want to re-invent already in the tty
buffer logic of the tty_port
2. Only n_tty actually uses the tty_port layer buffering
3. The ring buffer used for dumb uarts is entirely about latency limits
on low end processors and only used by some uarts anyway.

> Also, the current receive implementation has no concept of blocking or
> timeout. Should the uart_dev_rx() function return when there's no more
> data or wait (with timeout) until all requested data is received?
> (Probably do all of them is my guess).

Your rx routine needs to be able to run in IRQ context, not block and
complete in very very short time scales because on some hardware you have
exactly 9 bit times to recover the data byte and clear the IRQ done.
Serial really stretches some of the low end embedded processors running
at 56K/115200, and RS485 at 4Mbits even with 8 bytes of buffering is
pretty tight. Thus you need very fast buffers for just about any use case.
Dumb uarts you'll need to keep the existing ring buffer or similar
(moving to a kfifo would slightly improve performance I think) and queue
after.

> >> - Convert a real driver/line discipline over to UART bus.  
> >
> > That's going to be the real test, I recommend trying that as soon as
> > possible as it will show where the real pain points are :)

The locking. It's taken ten years to debug the current line discipline
change locking. If you want to be able to switch stuff kernel side
however it's somewhat easier.

The change should be

Add tty_port->rx(uint8_t *data,uint8_t *flags, unsigned int len)

The semantics of tty_port->rx are

- You may not assume a tty is bound to this port
- You may be called in IRQ context, but are guaranteed not to get
  parallel calls for the same port
- When you return the bytes you passed are history

At that point you can set tty_port->rx to point to the
tty_flip_buffer_push() and everyone can use it. Slow ones will want to
queue to a ring buffer then do tty_port->rx (where we do the flush_buffer
now), fast ones will do the ->rx directly.

Having done that you can switch all the drivers over and test nothing
breaks.

Now you can add your kernel mode support because you can do an
atomic_xchg of the tty_port->rx pointer between the classic queue model
and your direct interfaces. Not only that but so can n_ppp and some of
the other performance sensitive interfaces.

With that done you can tweak the tty_port methods to permit a ttyless
open/close and as everything else sits on top of that tty_port
abstraction providing you manage the tty_port the rest works.

Some of that ripples into the drivers as there are few places the tty
leaks into the tty_port methods but those are not hard to solve given the
need. The port needs a copy of the termios flags, a few other helpers are
needed to do non tty port opens/closes and call the relevant activation
methods.

Alan

Return-Path: <cyrus@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
To: "Par-Gunnar Hjalmdahl" <pghatwork@gmail.com>
Subject: Re: [PATCH 5/9] mfd: Add UART support for the ST-Ericsson CG2900.
Date: Thu, 11 Nov 2010 16:12:30 +0100
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linus.walleij@stericsson.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukasz.Rymanowski@tieto.com
References: <AANLkTi=XTUau_GbASJEUBgsZ_FYYmRAX6W43YtRdv2wS@mail.gmail.com> <AANLkTinzcRv5Mc+9HRwxYgxZCBNER_RdTVHTOyVtozJf@mail.gmail.com> <AANLkTi=J_K0sEwyfr4PoFBzEYp4yqYVm3NCRLv6mfLBx@mail.gmail.com>
In-Reply-To: <AANLkTi=J_K0sEwyfr4PoFBzEYp4yqYVm3NCRLv6mfLBx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201011111612.30515.arnd@arndb.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 11 November 2010, Par-Gunnar Hjalmdahl wrote:
> > One option would of course be to modify the existing hci_ldisc.c but I
> > feel that be rather dangerous and which could create a lot of
> > problems.
>
> After looking again at the code I see that I was wrong.
> For the receiving path the data will go ldics->protocol->stack. It's
> actually the TX path (to the chip) that is a bit strange where
> Bluetooth data is going to stack->ldisc->protocol->ldisc->uart. Here
> we would have a separate path for FM and GPS.

Ok, but is that a problem? You really should not be afraid of
touching existing code in order to make it more generic or removing
strange code paths like the one you just described. Cleaning up
code is usually better than duplicating it when you notice something
wrong with the existing implementation.

Simply calling the underlying ldisc module from the FM and GPS modules
should not even require changes, right?

> I still don't like the idea of making a tty/ldisc for the SPI
> transport. I definitely would prefer instead a new ldisc which doesn't
> register to any stack on top.

Yes, agreed. You had already convinced me in the previous reply, sorry
if that wasn't clear.

> My preference would be to keep the
> solutions independent, where we use tty/ldisc for UART and a direct
> transport protocol driver for SPI (i.e. registering using
> spi_register_driver).

Yes. However, you can probably share substantial parts of the code
between the spi_driver and the hci_uart_proto implementations.
You can do this either by making them a single module that registers
to both hci_ldisc and spi_bus, or having a common cg2900 base module
that does the common parts and add separate modules for spi and
hci_uart that register a small wrapper to the respective subsystems.

	Arnd

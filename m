Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Oct 2010 17:22:14 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linus.walleij@stericsson.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukasz.Rymanowski@tieto.com
Subject: Re: [PATCH 5/9] mfd: Add UART support for the ST-Ericsson CG2900.
Message-ID: <20101029172214.25b14c2a@pyx>
In-Reply-To: <AANLkTinh3D8V8UaN8FyCouwUQ98A4RRWEHXU7Tr9XMbs@mail.gmail.com>
References: <AANLkTi=XTUau_GbASJEUBgsZ_FYYmRAX6W43YtRdv2wS@mail.gmail.com>
	<20101022135130.617f0ce8@lxorguk.ukuu.org.uk>
	<AANLkTik-S50ZX6mFG+vWhBv0x_WmipP=t+4VqmAgssRC@mail.gmail.com>
	<201010281422.46687.arnd@arndb.de>
	<AANLkTinh3D8V8UaN8FyCouwUQ98A4RRWEHXU7Tr9XMbs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> > Shouldn't you instead be using the drivers/bluetooth/hci_{ldisc,h4} code?
> 
> We also need the ldisc code to handle events from FM and GPS and since
> that is chip specific we cannot add that to the generic hci_ldisc
> code.

Agreed - it's a different protocol.

> I agree that we might run into problems if two drivers try to register
> the same line discipline. It might then be better to introduce a new

If your ldisc is written properly it shouldn't matter. Each tty has a
private ldisc pointer to keep the per ldisc instance data.

> line discipline then even though that could cause other problems. I do
> not know if it is possible to add a condition in Kconfig otherwise so
> the CG2900 ldisc cannot be active while the "normal" ldisc driver is
> selected.

Not sure I follow the concern here ?

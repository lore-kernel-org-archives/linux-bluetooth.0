Return-Path: <cyrus@holtmann.org>
Date: Sun, 31 Oct 2010 12:04:29 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Par-Gunnar Hjalmdahl" <pghatwork@gmail.com>,
	linus.walleij@stericsson.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lukasz.Rymanowski@tieto.com
Subject: Re: [PATCH 5/9] mfd: Add UART support for the ST-Ericsson CG2900.
Message-ID: <20101031120429.1ca38140@pyx>
In-Reply-To: <201010300201.01940.arnd@arndb.de>
References: <AANLkTi=XTUau_GbASJEUBgsZ_FYYmRAX6W43YtRdv2wS@mail.gmail.com>
	<AANLkTinh3D8V8UaN8FyCouwUQ98A4RRWEHXU7Tr9XMbs@mail.gmail.com>
	<20101029172214.25b14c2a@pyx>
	<201010300201.01940.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> It's about the ldisc number. Both bluetooth and cg2900 register themselves
> to ldisc 15 (N_HCI). A user doing TIOCSETD can only get one of the two.

Ah I see - I had assumed any actual final merge would be assigning it a
new LDISC code as is required.

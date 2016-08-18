Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Date: Thu, 18 Aug 2016 16:38:09 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>, Jiri
 Slaby <jslaby@suse.com>,
        Sebastian Reichel <sre@kernel.org>, Pavel Machek
 <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>, NeilBrown
 <neil@brown.name>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij
 <linus.walleij@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Message-ID: <20160818163809.1b2fcfe5@lxorguk.ukuu.org.uk>
In-Reply-To: <227BE734-C9C1-4059-B0B4-EB47819703A8@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org>
	<20160818152528.569eb426@lxorguk.ukuu.org.uk>
	<227BE734-C9C1-4059-B0B4-EB47819703A8@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

> > Your changes also don't work because serial uart drivers are not obliged
> > to use any of the uart buffering helpers and particularly on the rx side
> > many do not do so and the performance hit would be too high.  
> 
> The SoC I have, is using it.

The Linux kernel does generalised implementations. Yes it may work on
your board but it doesn't work for everything. It's the difference
between doing it properly and hacking your board to work.

Alan

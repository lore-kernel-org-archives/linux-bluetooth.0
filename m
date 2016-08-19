Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Date: Fri, 19 Aug 2016 12:03:05 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>, Jiri
 Slaby <jslaby@suse.com>,
        Pavel Machek <pavel@ucw.cz>, Peter Hurley
 <peter@hurleysoftware.com>,
        NeilBrown <neil@brown.name>,
        "Dr . H . Nikolaus
 Schaller" <hns@goldelico.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij
 <linus.walleij@linaro.org>,
        "open list:BLUETOOTH DRIVERS"
 <linux-bluetooth@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Message-ID: <20160819120305.4a3b1b54@lxorguk.ukuu.org.uk>
In-Reply-To: <20160819052125.ze5zilppwoe3f2lx@earth>
References: <20160818011445.22726-1-robh@kernel.org>
	<20160818202900.hyvm4hfxedifuefn@earth>
	<CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
	<20160819052125.ze5zilppwoe3f2lx@earth>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

> I meant "Either some function similar to userspace's poll() is
> needed, ...". Something like uart_dev_wait_for_rx()

You can't really do that - it might never return and then how do you want
to handle timeouts and cleanups

> Alternatively the rx function could be a callback, that
> is called when there is new data.

That's what the existing API gives you as an ldisc, it can't be immediate
in many cases however but must be buffered.

> > I'm assuming the only immediate consumers are in-kernel.  
> 
> Yes, but the driver should be notified about incoming data.

Alan

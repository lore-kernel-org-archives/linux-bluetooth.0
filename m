Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Oct 2010 21:35:03 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Savoy, Pavan" <pavan_savoy@ti.com>
Cc: Jiri Slaby <jirislaby@gmail.com>,
	"gregkh@suse.de" <gregkh@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers:staging:ti-st: move TI_ST from staging
Message-ID: <20101007213503.657bcab0@lxorguk.ukuu.org.uk>
In-Reply-To: <19F8576C6E063C45BE387C64729E739404AA21D23B@dbde02.ent.ti.com>
References: <1286381895-11329-1-git-send-email-pavan_savoy@ti.com>
	<1286381895-11329-2-git-send-email-pavan_savoy@ti.com>
	<4CACD234.7020900@gmail.com>
	<19F8576C6E063C45BE387C64729E739404AA21CEA1@dbde02.ent.ti.com>
	<4CACF5A7.3010601@gmail.com>
	<19F8576C6E063C45BE387C64729E739404AA21CEC6@dbde02.ent.ti.com>
	<4CAD7DAB.8030209@gmail.com>
	<19F8576C6E063C45BE387C64729E739404AA21D193@dbde02.ent.ti.com>
	<4CAE10C0.9000106@gmail.com>
	<19F8576C6E063C45BE387C64729E739404AA21D220@dbde02.ent.ti.com>
	<20101007203801.1c55a1d3@lxorguk.ukuu.org.uk>
	<19F8576C6E063C45BE387C64729E739404AA21D23B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> ldisc is the ONLY way to do it, isn't it? Do I have any other option?

Userspace but even then it wouldn't solve your problem

> The situation was something similar here.
> What I was trying to get to is how we can have a per-device context if a driver is just a line discipline driver?

tty->driver_data
		TTY private data
tty->disc_data
		LDISC per instance private data

So when your ldisc is opened attach your data to the tty->disc_data, and
when it is closed free the data.

> I have 3 sub-devices if you will on a device which is interfaced over UART,
> One of them is Bluetooth which requires any UART Bluetooth device to have its
> Own line discipline - N_HCI.

The problem is that your chip by the sound of it does not talk the
bluetooth ldisc - it talks something more complex.

The obvious question then is

Does it talk

1.	HCI with bits nailed on
2.	Something rather different which contains muxed data some of
which is reformatted up to create HCI

In the first case it may be worth seeing if the existing N_HCI could
support forwarding unknown frame types to a helper. In the latter it's a
lot trickier. It is possible to create a mux tty layer (see n_gsm.c) but
that is almost certainly overkill for this.

I wonder what Marcel thinks in terms of re-using the bluetooth ldisc ?


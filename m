Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Date: Thu, 18 Aug 2016 16:13:07 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        "H. Nikolaus Schaller"
 <hns@goldelico.com>,
        Rob Herring <robh@kernel.org>, Jiri Slaby
 <jslaby@suse.com>,
        Sebastian Reichel <sre@kernel.org>, Pavel Machek
 <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>, NeilBrown
 <neil@brown.name>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij
 <linus.walleij@linaro.org>,
        "open list:BLUETOOTH DRIVERS"
 <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Message-ID: <20160818161307.5c5d1635@lxorguk.ukuu.org.uk>
In-Reply-To: <20160818112435.GA20876@kroah.com>
References: <20160818011445.22726-1-robh@kernel.org>
	<118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com>
	<28DDAF2B-2341-403B-80D8-DA0A63F51FF1@holtmann.org>
	<20160818105521.GB7031@kroah.com>
	<6A3D5EFF-AC8B-4039-AFF8-652687EB8EDA@holtmann.org>
	<20160818112435.GA20876@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

> > we have a GPS line discipline? What is that one doing? As far as I
> > know all GPS implementations are fully userspace.  
> 
> Hm, for some reason I thought that was what n_gsm.c was being used for,
> but I could be wrong, I've never seen the hardware that uses that
> code...

You probably have actually. It's the standard multiplexing protocol on
lots of 3G modems. It's an AT command that switches mode.

However it illustrates the kind of problems with trying to short circuit
the tty_port code. It's entirely possible for a modem to expose the GPS
on a channel of the multiplex on the USB connection to the modem which is
itself dynamic and can be hot unplugged.

Short circuiting the tty_port layer is not a trivial exercise.

Alan

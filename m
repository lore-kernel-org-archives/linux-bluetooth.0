Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Date: Thu, 18 Aug 2016 16:14:00 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20160818161400.4ccd0468@lxorguk.ukuu.org.uk>
In-Reply-To: <00D14BD1-B1DA-4242-B2F6-54F70CF72EF1@holtmann.org>
References: <20160818011445.22726-1-robh@kernel.org>
	<118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com>
	<28DDAF2B-2341-403B-80D8-DA0A63F51FF1@holtmann.org>
	<20160818105521.GB7031@kroah.com>
	<6A3D5EFF-AC8B-4039-AFF8-652687EB8EDA@holtmann.org>
	<20160818112435.GA20876@kroah.com>
	<00D14BD1-B1DA-4242-B2F6-54F70CF72EF1@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

> > Hm, for some reason I thought that was what n_gsm.c was being used for,
> > but I could be wrong, I've never seen the hardware that uses that
> > code...  
> 
> the n_gsm.c is for 3GPP TS 07.10. Which is a TTY multiplexer. Has nothing to do with GPS.

Except that you may get GPS over 3GPP TS 07.10 (ditto firmware upload!)

Alan

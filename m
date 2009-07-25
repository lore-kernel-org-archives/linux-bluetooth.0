Return-Path: <cyrus@holtmann.org>
Date: Sat, 25 Jul 2009 13:10:46 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Oliver Hartkopp <oliver@hartkopp.net>,
        Linux Netdev List
 <netdev@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: Re: tty_register_device NULL pointer dereference in 2.6.31-rc4
Message-ID: <20090725131046.0f076f37@lxorguk.ukuu.org.uk>
In-Reply-To: <1248520053.28545.156.camel@violet>
References: <4A6AD807.6060706@hartkopp.net>
	<20090725115011.7ddf8d00@lxorguk.ukuu.org.uk>
	<1248520053.28545.156.camel@violet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

> > tty_register_device appears to have been called with a NULL pointer. Not
> > sure why however.
> 
> if that is the pointer for the struct device, then that used to be fine
> in the past. Not all RFCOMM device have a parent when they are created.

The tty layer doesn't care about the struct device really. Nothing there
has changed. The NULL passed appears to be the driver argument.

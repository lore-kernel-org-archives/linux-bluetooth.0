Return-Path: <cyrus@holtmann.org>
Date: Sat, 25 Jul 2009 11:50:11 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Hartkopp <oliver@hartkopp.net>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Linux Netdev List
 <netdev@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: Re: tty_register_device NULL pointer dereference in 2.6.31-rc4
Message-ID: <20090725115011.7ddf8d00@lxorguk.ukuu.org.uk>
In-Reply-To: <4A6AD807.6060706@hartkopp.net>
References: <4A6AD807.6060706@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 25 Jul 2009 12:01:43 +0200
Oliver Hartkopp <oliver@hartkopp.net> wrote:

> Hello Alan and Marcel,
> 
> this morning i got a NULL pointer dereference in tty_register_device() that
> looked similar to the one, i posted here on 03-jun-2009:
> 
> http://marc.info/?l=linux-bluetooth&m=124404919324542&w=2
> 
> As the boot sequence stopped after this point, i was only able to take a
> picture of it - see attached jpg.
> 
> I was able to shut down the system gracefully by pressing the power button.
> 
> The problem emerges really seldom.
> 
> Any idea?

tty_register_device appears to have been called with a NULL pointer. Not
sure why however.

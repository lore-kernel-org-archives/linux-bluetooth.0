Return-Path: <crosser@average.org>
Subject: Re: [Bluez-devel] Re: Reproducible kernel oops on PPP session start
From: Eugene Crosser <crosser@average.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073913755.3126.48.camel@pegasus>
References: <1073475736.6998.9.camel@pccross.average.org>
	 <1073477754.2508.135.camel@pegasus>
	 <1073483871.2816.9.camel@pccross.average.org>
	 <1073736024.7742.12.camel@pccross.average.org>
	 <1073736666.12699.4.camel@pccross.average.org>
	 <1073833166.3126.24.camel@pegasus>
	 <1073889186.3923.27.camel@pccross.average.org>
	 <1073913755.3126.48.camel@pegasus>
Content-Type: text/plain
Message-Id: <1073919178.7667.41.camel@ariel.sovam.com>
Mime-Version: 1.0
Date: Mon, 12 Jan 2004 17:52:58 +0300
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, 2004-01-12 at 16:22, Marcel Holtmann wrote:

> > Interesting that running "rfcomm bind" or "rfcomm listen" does not
> > increase l2cap's refcount.  It gets increased at the moment when
> > incoming connection actually takes place.  And is decreased (by 2) when
> > it terminates.
[...]
> Let us summarize this problem a little bit. We know that this is
> refcount bug and it happens in __module_get(). It also seems that we
> only get hit by this bug if we got in incoming connection. Is this
> right? Do the refcounting work correct on outgoing? My question is if
> this is a L2CAP only problem or if it only happens in conjunction with
> RFCOMM? Can you reproduce it with the l2test program only? Don't load
> the rfcomm.ko module and don't start the sdpd, so you have a better
> starting refcount.

I don't think that I have a device capable of anything but rfcomm...  I
have a cellphone (can use obex that works over rfcomm) and a palm (ppp
or hotsync over rfcomm).

I'll check outgoing connections to the cellphone (obex push) and report.

I can try to get a second usb dongle and connect from another linux
machine, but that will take time to arrange.

OTOH I could throw a few printk()s into the kernel but I don't know
where to put them.  The only place in l2cap.c that looks relevant to
refcount management that I can see is at line 353 -
"sk_set_owner(sk, THIS_MODULE);", but there must be other places too...

Eugene

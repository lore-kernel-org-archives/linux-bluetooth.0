Return-Path: <crosser@average.org>
Subject: Re: [Bluez-devel] Re: Reproducible kernel oops on PPP session start
From: Eugene Crosser <crosser@average.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073833166.3126.24.camel@pegasus>
References: <1073475736.6998.9.camel@pccross.average.org>
	 <1073477754.2508.135.camel@pegasus>
	 <1073483871.2816.9.camel@pccross.average.org>
	 <1073736024.7742.12.camel@pccross.average.org>
	 <1073736666.12699.4.camel@pccross.average.org>
	 <1073833166.3126.24.camel@pegasus>
Content-Type: text/plain
Message-Id: <1073889186.3923.27.camel@pccross.average.org>
Mime-Version: 1.0
Date: Mon, 12 Jan 2004 09:33:06 +0300
List-ID: <bluez-devel.lists.sourceforge.net>

On Sun, 2004-01-11 at 17:59, Marcel Holtmann wrote:

> > > As far as I can tell from analyzing the dump, and objdump of l2cap.o
> > > object, BUG() happens when "sk_set_owner(sk, THIS_MODULE);" in
> > > net/bluetooth/l2cap.c line 353 encounters zero refcount of the module. 
> > > So, probably somebody incorrectly decreases the l2cap's refcount
> > > elsewhere...
> > 
> > yes, this seems to be true (and explains the fixed number of attempts). 
> > Reference count increases by one every time session starts, and
> > decreases by *two* when it is finished.  Why initial refcount is 5 is
> > still unclear to me...
> 
> I thought all refcount bugs were fixed, but the initial refcount is easy
> to explain. It should be raised by the RFCOMM module and the sdpd. Try
> to not load RFCOMM and disable the starting of the sdpd.

Interesting that running "rfcomm bind" or "rfcomm listen" does not
increase l2cap's refcount.  It gets increased at the moment when
incoming connection actually takes place.  And is decreased (by 2) when
it terminates.

I do not understand how refcount is maintained well enough to do further
investigation myself.  Anything I can do to help you (or anybody) to fix
the problem?

Eugene

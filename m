Return-Path: <crosser@average.org>
Subject: Re: [Bluez-devel] Re: Reproducible kernel oops on PPP session start
From: Eugene Crosser <crosser@average.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073920544.3126.100.camel@pegasus>
References: <1073475736.6998.9.camel@pccross.average.org>
	 <1073477754.2508.135.camel@pegasus>
	 <1073483871.2816.9.camel@pccross.average.org>
	 <1073736024.7742.12.camel@pccross.average.org>
	 <1073736666.12699.4.camel@pccross.average.org>
	 <1073833166.3126.24.camel@pegasus>
	 <1073889186.3923.27.camel@pccross.average.org>
	 <1073913755.3126.48.camel@pegasus>
	 <1073919178.7667.41.camel@ariel.sovam.com>
	 <1073920544.3126.100.camel@pegasus>
Content-Type: text/plain
Message-Id: <1073942535.5527.7.camel@pccross.average.org>
Mime-Version: 1.0
Date: Tue, 13 Jan 2004 00:22:15 +0300
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, 2004-01-12 at 18:15, Marcel Holtmann wrote:

> > I can try to get a second usb dongle and connect from another linux
> > machine, but that will take time to arrange.
> 
> please do so.

I'll ask a friend and we'll try pan during this week.

In the meanwhile, I tried incoming and outgoing OBEX with a cellphone.
This is how refcounts change:

                  incoming        outgoing
                start   stop    start   stop
 
rfcomm          +1      -1      +3      -3
l2cap           +1      -2      +2      -2

Eugene

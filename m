Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Qualification Testing
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Daryl Van Vorst <daryl@wideray.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1052637555.24170.7.camel@localhost.localdomain>
References: <000c01c313f5$b57ae030$1a01010a@baked>
	<000c01c313f5$b57ae030$1a01010a@baked>
	<5.1.0.14.2.20030508171149.01c082c0@unixmail.qualcomm.com>
	<1052442873.1069.35.camel@pegasus.local>
	<1052545687.10456.235.camel@localhost.localdomain>
	<1052584255.1133.13.camel@pegasus.local>
	<1052637555.24170.7.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1052639076.1133.22.camel@pegasus.local>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 11 May 2003 09:44:29 +0200

Hi Max,

> > > Ok. I've fixed that (and pushed changes to BK). My idea about 
> > > with TX_THROTTLED flag didn't work. Well, it worked but only in 
> > > one direction :). Changing state machine would've been fairly big
> > > change and could've affected compatibility.
> > > So I added a simple logic to track MSC exchange state. Works beautifully
> > 
> > I like to see this logic in the state machine, but I agree with with you
> > that it is not the right time for changing it. Your patch works also
> > fine for me and I have a new 2.4.20 with all patches up and running.
> > 
> Actually MSC exchange is not part of the connect procedure. After UA is
> received DLC is considered connected. Which means some implementations
> might not send first MSC before they have data to send, that's what
> meant that changing state machine could affect compatibility.
> Besides MSC exchange, just like L2CAP config, doesn't have strict  
> sequence which makes it hard to track with a single state. i.e they 
> sent MSC first, we sent MSC first, etc. So I think we're ok.

good point. And with your argument, I feel that you have choosen the
absolute correct way to implement this.

Regards

Marcel




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Hendrik Sattler <post@hendrik-sattler.de>
In-Reply-To: <200712200229.40589.post@hendrik-sattler.de>
References: <200712192341.02293.post@hendrik-sattler.de>
	<1198107273.8050.228.camel@aeonflux>
	<200712200229.40589.post@hendrik-sattler.de>
Date: Thu, 20 Dec 2007 03:09:39 +0100
Message-Id: <1198116580.8050.232.camel@aeonflux>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SDP services cannot be unregistered
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Hendrik,

> > > since several versions of bluez userspace libs and utils, I am unable to
> > > unregister local SDP server records. Everything I tried so far fails to
> > > unregister the record:
> > > I use sdp_connect() and sdp_device_record_register() to register the SDP
> > > record and use the return result of the latter for
> > > sdp_device_record_unregister() and then sdp_close().
> > >
> > > In earlier versions, the unregistering and explicit closing of the
> > > session handle wasn't even necessary but that broke. That can be handled
> > > but unregistering a record in an explicit way like above should work,
> > > doesn't it?
> > >
> > > When the bug appeared, I though that waiting some versions might suffice.
> > > But obviously, nobody ever noticed.
> > > Is there a possibility that this gets fixed?
> >
> > not sure about that. Never heard about it. Are you using the sdpd daemon
> > or do you use hcid -s and the embedded SDP server?
> >
> > I might have introduced a bug when switching everything over to the
> > embedded SDP server and the automatic service classes handling. Do you
> > have a simple reproducer that I can try?
> 
> Yes, current obexpushd from my repository at
> https://www.hendrik-sattler.de/svn/obexpushd/trunk/
> 
> I see this since about 3.11 when that entered Debian testing, current is 3.22. 
> I assume that the embedded SDP server might be the cause, at least Debian 
> uses it. BTW: kdebluetooth has the same problem.
> I also reported that as Debian bug report 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=445677

first of all you are using the unregister function wrongly. You have to
give it the exact record structure you gave the register function. So
when you allocate a new record, then the unregister has no idea what to
do with it.

Why it doesn't cleanup after program termination is unclear to me. That
should actually work. You might wanna investigate on that one.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Michal Semler <cijoml@volny.cz>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040810163203.GA1963@bougret.hpl.hp.com>
References: <20040805013335.GA13608@bougret.hpl.hp.com>
	 <1091976547.2773.29.camel@pegasus>
	 <20040809185159.GA21899@bougret.hpl.hp.com>
	 <1092078516.4564.40.camel@pegasus>
	 <20040809195448.GA24140@bougret.hpl.hp.com>
	 <1092125599.4564.76.camel@pegasus>
	 <20040810163203.GA1963@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1092178402.4564.204.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [PATCH 2.6] link trigger for AODV and +
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 11 Aug 2004 00:53:23 +0200

Hi Jean,

> > If the HCI connections themself are fully integrated into the driver and
> > device model an event through hotplug would be the best. Comments?
> 
> 	I personally don't like hotplug for this application. Hotplug
> force the event to go through a bunch of scripts, which is good for
> simple config and daemon-less stuff, but bad for daemons.
> 	Let say you have a big daemon monitoring a bunch of stuff and
> keeping track of state. Examples are pand, waproamd, MobileIP... With
> hotplug you have to write a script that somehow forward the event to
> the daemon. As events are usually passed via Unix sockets, shared
> memory or something similar, the scripts need to call a little program
> generating the event.
> 	Therefore you have :
> 		hotplug event ->
> 			-> my shell script
> 				-> my tiny program
> 					-> Unix socket or shared memory
> 						-> My daemon
> 	For each event, you need to create two processes (shell script
> and tiny program) than need to be paged from disk. Yuck...
> 	If you look at waproamd, it uses exclusively the RtNetlink
> events, even though the equivalent events exist in Hotplug.

you are right, but there are pros and cons on both sides and I like to
find the best solution. However I never looked at RtNetlink before. I
think that I should educate myself a little bit more.

> > > > I sent the full patch for inclusion, but it came out that one part
> > > > causes troubles and so I removed this part. I didn't found the time for
> > > > a further investigation.
> > > 
> > > 	That's what I said : I'm going to test it properly. If you
> > > could remember the issue, that would help.
> > 
> > I searched the email exchange between Michal and me from the mailing
> > list archives for you. Check out this thread:
> > 
> > 	http://thread.gmane.org/gmane.linux.bluez.user/2672
> 
> 	The bug is obvious, you forgot that in 2.4.X the list doesn't
> point to struct sock but to struct bluez_pinfo. Compare your patch to
> the version below.

What a stupid mistake. I must been blind at that time :(

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

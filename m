Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040809185159.GA21899@bougret.hpl.hp.com>
References: <20040805013335.GA13608@bougret.hpl.hp.com>
	 <1091976547.2773.29.camel@pegasus>
	 <20040809185159.GA21899@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1092078516.4564.40.camel@pegasus>
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
Date: Mon, 09 Aug 2004 21:08:36 +0200

Hi Jean,

> > no problem, I got the point. However I am not sure about applying your
> > patch. I don't like the way the event is propagated. It is a connection
> > related event and so I like to send it to the sockets that are using
> > that ACL connection. Or at least I should introduce the per device stack
> > internal events.
> 
> 	The typical application is to monitor a BNEP connection (AODV
> deals with TCP/IP traffic). The L2CAP socket for the BNEP traffic is
> owned by the PAN deamon. However, you may want to feed the event
> directly to AODV without having to modify the PAN daemon and having to
> relay events.

this is a good point and I do think that this patch is a nice additional
feature for BlueZ, but I am not fully comfortable with it in its current
shape. Actually some time ago I thought about removing the support for
stack internal events.

Any additional comments are welcome.

> > Another question is, do we need a compile option for it? Is there any
> > disadvantage to compile it always and disable by default?
> 
> 	For a (still) experimental feature, it make sense to keep it
> encapsualted. It's easier to remove #define than to add it. Your call.

When I include it in my -mh patch I will always enable it, but keep the
ifdefs.

> 	Note that the patch for the poll/listen bug was only partially
> applied to 2.4.X, I have a patch for it, I still need to test it.

I sent the full patch for inclusion, but it came out that one part
causes troubles and so I removed this part. I didn't found the time for
a further investigation.

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

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040809195448.GA24140@bougret.hpl.hp.com>
References: <20040805013335.GA13608@bougret.hpl.hp.com>
	 <1091976547.2773.29.camel@pegasus>
	 <20040809185159.GA21899@bougret.hpl.hp.com>
	 <1092078516.4564.40.camel@pegasus>
	 <20040809195448.GA24140@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1092125599.4564.76.camel@pegasus>
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
Date: Tue, 10 Aug 2004 10:13:19 +0200

Hi Jean,

> > this is a good point and I do think that this patch is a nice additional
> > feature for BlueZ, but I am not fully comfortable with it in its current
> > shape. Actually some time ago I thought about removing the support for
> > stack internal events.
> 
> 	In my stuff, I use internal events to know when hci interfaces
> go up and down and when they appear and disappear. As far as I know,
> those events are not available by any other means. They are not
> available through RtNetlink because hci interfaces are not real netdev
> interfaces.

these events should be available via hotplug and the bluetooth.agent and
because of this I was thinking about removing the stack internal stuff.

If the HCI connections themself are fully integrated into the driver and
device model an event through hotplug would be the best. Comments?

> > I sent the full patch for inclusion, but it came out that one part
> > causes troubles and so I removed this part. I didn't found the time for
> > a further investigation.
> 
> 	That's what I said : I'm going to test it properly. If you
> could remember the issue, that would help.

I searched the email exchange between Michal and me from the mailing
list archives for you. Check out this thread:

	http://thread.gmane.org/gmane.linux.bluez.user/2672

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

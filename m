Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] pand/main.c, restore signals for dev-up
	script
From: Marcel Holtmann <marcel@holtmann.org>
To: James Cameron <james.cameron@hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040629105508.GC2133@hp.com>
References: <20040628095541.GB8871@hp.com>
	 <1088417629.3774.177.camel@pegasus> <20040628101927.GC8871@hp.com>
	 <1088419197.3774.183.camel@pegasus> <20040628120612.GF8871@hp.com>
	 <1088427271.3774.198.camel@pegasus> <20040628224803.GA20139@hp.com>
	 <1088465177.6030.221.camel@pegasus> <20040629052317.GQ20139@hp.com>
	 <1088499480.6030.239.camel@pegasus>  <20040629105508.GC2133@hp.com>
Content-Type: text/plain
Message-Id: <1088508403.6030.265.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 29 Jun 2004 13:26:43 +0200

Hi James,

> > I like to have only one and clear way to achieve a goal. And this is the
> > Linux hotplug mechanism from my view. However dev-up is in pand and
> > there was a bug, so I applied your patch.
> 
> It's not in CVS yet.  An update of main.c takes me to revision 1.5,
> which was the "olen = sizeof(l2o);" addition.

the anonymous CVS is not updated in real time. It is a Sourceforge
problem and the only thing you can do is wait :(

> > But be aware of that I might remove it in a new major release, now I
> > know of it ;)
> 
> Oh dear.  I'll keep watch then, and fork if I have to.  ;-)

Or come up with a solution that makes the peer address available through
hotplug and net.agent.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] making a cellphone ring using bluetooth message
From: Code Logic <codelogic@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200507201748.02597.puggy@gentoo.org>
References: <baec107c05072005529550ac5@mail.gmail.com>
	 <1121876820.24456.273.camel@santafe>  <200507201748.02597.puggy@gentoo.org>
Content-Type: text/plain
Message-Id: <1121962591.24456.279.camel@santafe>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 21 Jul 2005 10:16:31 -0600

You're most probably right. Google for this file :

r320at_r1a.pdf

It has a complete list of AT commands (form Ericsson), including some
that looked like commands to generate a ring. Also, you should take a
look at the source code of Float's Mobile Agent (fma.sourceforge.net)
This program, I think, makes extensive use of the AT command set
(through bluetooth and IR) to perform all kinds of cool things.


On Wed, 2005-07-20 at 17:48 +0100, Douglas Russell wrote:
> Actually, I'm pretty sure you can do this with an AT command. Don't ask me 
> what it might be though. :-)
> 
> On Wednesday 20 Jul 2005 17:27, Code Logic wrote:
> > I'm not sure if you can actually do that, at least not with only a BT
> > client. You will probably need an app that listens for BT messages on
> > the phone and plays some sound upon receiving the specific BT command.
> > Depending on the type of phone you are targeting, there might already be
> > some apps out there (Bemused) that can help you out.
> >
> > On Wed, 2005-07-20 at 08:52 -0400, Tri Ngo wrote:
> > > Hi,
> > > I apologize that this may not be the perfect place to post this
> > > question but I was hoping that someone would be able to point me in
> > > the right direction. I would like to make a cellphone ring by sending
> > > a bluetooth message.  I was wondering if anyone on this list knows if
> > > this functionality is possible to implement.
> > >
> > > Thanks,
> > > Tri
> > >
> > >
> > > -------------------------------------------------------
> > > SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> > > from IBM. Find simple to follow Roadmaps, straightforward articles,
> > > informative Webcasts and more! Get everything you need to get up to
> > > speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id492&op=click
> > > _______________________________________________
> > > Bluez-devel mailing list
> > > Bluez-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> > -------------------------------------------------------
> > SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> > from IBM. Find simple to follow Roadmaps, straightforward articles,
> > informative Webcasts and more! Get everything you need to get up to
> > speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

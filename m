Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] making a cellphone ring using bluetooth message
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1121876820.24456.273.camel@santafe>
References: <baec107c05072005529550ac5@mail.gmail.com>
	 <1121876820.24456.273.camel@santafe>
Content-Type: text/plain
Message-Id: <1121878162.7415.22.camel@panic>
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
Date: Wed, 20 Jul 2005 18:49:22 +0200

Hi,

some cellphones, e.g. all Siemens phones have a special AT command to
turn on the ring, this works quite nice :) Google should give you the
right command, I don't have it on my mind right now.

Maybe this helps.

... Collin

On Wed, 2005-07-20 at 10:27 -0600, Code Logic wrote:
> I'm not sure if you can actually do that, at least not with only a BT
> client. You will probably need an app that listens for BT messages on
> the phone and plays some sound upon receiving the specific BT command.
> Depending on the type of phone you are targeting, there might already be
> some apps out there (Bemused) that can help you out. 
> 
> On Wed, 2005-07-20 at 08:52 -0400, Tri Ngo wrote:
> > Hi,
> > I apologize that this may not be the perfect place to post this
> > question but I was hoping that someone would be able to point me in
> > the right direction. I would like to make a cellphone ring by sending
> > a bluetooth message.  I was wondering if anyone on this list knows if
> > this functionality is possible to implement.
> > 
> > Thanks,
> > Tri
> > 
> > 
> > -------------------------------------------------------
> > SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> > from IBM. Find simple to follow Roadmaps, straightforward articles,
> > informative Webcasts and more! Get everything you need to get up to
> > speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id492&op=click
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
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
--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
Real C programmers never die, they cast to void...



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

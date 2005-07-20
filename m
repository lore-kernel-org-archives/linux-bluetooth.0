Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <baec107c05072011129b1402f@mail.gmail.com>
From: Tri Ngo <tringo@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] making a cellphone ring using bluetooth message
In-Reply-To: <1121878162.7415.22.camel@panic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <baec107c05072005529550ac5@mail.gmail.com>
	 <1121876820.24456.273.camel@santafe> <1121878162.7415.22.camel@panic>
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
Date: Wed, 20 Jul 2005 14:12:54 -0400

Thanks everyone. I havea  follow up question, is it possible to
establish an rfcomm connection with a bluetooth phone automatically.=20
As in, can the connection be established totally through a script
without interaction with the phone or the computer.  I have read some
sites that mention that the phone asks if the connection with computer
is to be allowed, but is there a way to allow the phone to connect
automatically, without asking?  I can't test this yet since I don't
have a bluetooth phone currently.  My goal is to make the phone ring
without having to do anything on the phone.

Thanks again,
Tri

On 7/20/05, Collin R. Mulliner <collin@betaversion.net> wrote:
> Hi,
>=20
> some cellphones, e.g. all Siemens phones have a special AT command to
> turn on the ring, this works quite nice :) Google should give you the
> right command, I don't have it on my mind right now.
>=20
> Maybe this helps.
>=20
> ... Collin
>=20
> On Wed, 2005-07-20 at 10:27 -0600, Code Logic wrote:
> > I'm not sure if you can actually do that, at least not with only a BT
> > client. You will probably need an app that listens for BT messages on
> > the phone and plays some sound upon receiving the specific BT command.
> > Depending on the type of phone you are targeting, there might already b=
e
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
> > > SF.Net email is sponsored by: Discover Easy Linux Migration Strategie=
s
> > > from IBM. Find simple to follow Roadmaps, straightforward articles,
> > > informative Webcasts and more! Get everything you need to get up to
> > > speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=3Dclick
> > > _______________________________________________
> > > Bluez-devel mailing list
> > > Bluez-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> >
> >
> > -------------------------------------------------------
> > SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> > from IBM. Find simple to follow Roadmaps, straightforward articles,
> > informative Webcasts and more! Get everything you need to get up to
> > speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dcl=
ick
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> --
> Collin R. Mulliner <collin@betaversion.net>
> BETAVERSiON Systems [www.betaversion.net]
> info/pgp: finger collin@betaversion.net
> Real C programmers never die, they cast to void...
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

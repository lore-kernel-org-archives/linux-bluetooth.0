Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] python error on bluepin
From: Fredy P <digitalfredy@debiancolombia.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050613201611.36779.qmail@web50709.mail.yahoo.com>
References: <20050613201611.36779.qmail@web50709.mail.yahoo.com>
Content-Type: text/plain;
	charset=iso-8859-1
Message-Id: <1118908231.3826.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 16 Jun 2005 02:50:31 -0500

El lun, 13-06-2005 a las 13:15 -0700, John H. escribi=F3:
John, another option if bluepin don`t work is bluez-pin (it es the
default in debian)
> ah ok.  it's not getting called no matter what,
> though, what is supposed to call it?  It never pops
> anything up when I tell my phone to search and pair.
>=20
>=20
> --- Marco Trudel <mtrudel@gmx.ch> wrote:
>=20
> > You've to supply the apropriate parameters if you
> > wan't to call it=20
> > yourself. It won't work withhout them.
> > It's a pyton script, you can look at the source...
> >=20
> > regards
> > Marco
> >=20
> >=20
> > John H. wrote:
> > > I ran this from X:)
> > >=20
> > > --- Fredy P <digitalfredy@debiancolombia.org>
> > wrote:
> > >=20
> > >=20
> > >>El dom, 12-06-2005 a las 19:50 -0700, John H.
> > >>escribi=F3:
> > >>
> > >>> bluepin
> > >>>Xlib: connection to ":0.0" refused by server
> > >>>Xlib: No protocol specified
> > >>>
> > >>>Traceback (most recent call last):
> > >>>  File "/usr/bin/bluepin", line 39, in ?
> > >>>    import gtk
> > >>>  File
> > >>>
> > >>
> > >
> >
> "/var/tmp/pygtk2-2.6.2-root/usr/lib/python2.3/site-packages/gtk-2.0/gtk/_=
_init__.py",
> > >=20
> > >>>line 37, in ?
> > >>>RuntimeError: could not open display
> > >>
> > >>its becouse your blue_pin needs X, for use without
> > x
> > >>you can made a
> > >>simple pin_helper, you can see it in:
> > >>
> > >=20
> > >
> >
> http://el-directorio.org/index.php/Bluetooth_en_debian
> > >=20
> > >>In spanish, but if you read the congig files you
> > can
> > >>understand
> > >>
> > >>
> > >>>
> >
> >>>__________________________________________________
> > >>>Do You Yahoo!?
> > >>>Tired of spam?  Yahoo! Mail has the best spam
> > >>
> > >>protection around=20
> > >>
> > >>>http://mail.yahoo.com=20
> > >>>
> > >>>
> > >>>
> > >>
> > >
> >
> -------------------------------------------------------
> > >=20
> > >>>This SF.Net email is sponsored by: NEC IT Guy
> > >>
> > >>Games.  How far can you shotput
> > >>
> > >>>a projector? How fast can you ride your desk
> > chair
> > >>
> > >>down the office luge track?
> > >>
> > >>>If you want to score the big prize, get to know
> > >>
> > >>the little guy. =20
> > >>
> > >>>Play to win an NEC 61" plasma display:
> > >>
> > >>http://www.necitguy.com/?r=3D20
> > >>
> > >>>_______________________________________________
> > >>>Bluez-users mailing list
> > >>>Bluez-users@lists.sourceforge.net
> > >>>
> > >>
> > >
> >
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> > >=20
> > >>
> > >>
> > >>
> > >
> >
> -------------------------------------------------------
> > >=20
> > >>This SF.Net email is sponsored by: NEC IT Guy
> > Games.
> > >> How far can you shotput
> > >>a projector? How fast can you ride your desk chair
> > >>down the office luge track?
> > >>If you want to score the big prize, get to know
> > the
> > >>little guy.
> > >>Play to win an NEC 61" plasma display:
> > >>http://www.necitguy.com/?r=20
> > >>_______________________________________________
> > >>Bluez-users mailing list
> > >>Bluez-users@lists.sourceforge.net
> > >>
> > >=20
> > >
> >
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> > >=20
> > >=20
> > >=20
> > >=20
> > > 	=09
> > > __________________________________=20
> > > Discover Yahoo!=20
> > > Have fun online with music videos, cool games, IM
> > and more. Check it out!=20
> > > http://discover.yahoo.com/online.html
> > >=20
> > >=20
> > >
> >
> -------------------------------------------------------
> > > This SF.Net email is sponsored by: NEC IT Guy
> > Games.  How far can you shotput
> > > a projector? How fast can you ride your desk chair
> > down the office luge track?
> > > If you want to score the big prize, get to know
> > the little guy. =20
> > > Play to win an NEC 61" plasma display:
> > http://www.necitguy.com/?r=3D20
> > > _______________________________________________
> > > Bluez-users mailing list
> > > Bluez-users@lists.sourceforge.net
> > >
> >
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> > >=20
> > >=20
> >=20
> >=20
> >=20
> >
> -------------------------------------------------------
> > This SF.Net email is sponsored by: NEC IT Guy Games.
> >  How far can you shotput
> > a projector? How fast can you ride your desk chair
> > down the office luge track?
> > If you want to score the big prize, get to know the
> > little guy. =20
> > Play to win an NEC 61" plasma display:
> > http://www.necitguy.com/?r=3D20
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> >
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> >=20
>=20
>=20
>=20
> 	=09
> __________________________________=20
> Do you Yahoo!?=20
> Read only the mail you want - Yahoo! Mail SpamGuard.=20
> http://promotions.yahoo.com/new_mail=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you sho=
tput
> a projector? How fast can you ride your desk chair down the office luge t=
rack?
> If you want to score the big prize, get to know the little guy. =20
> Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=3D20
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

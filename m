Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Florian Evers <florian-evers@gmx.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] HID report mode protocol support in 2.6.11-mh1 broken/missing?
References: <1110498275.3040.6.camel@pc.vesuri.net> <1110796090.8158.56.camel@pegasus>
In-Reply-To: <1110796090.8158.56.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200503141344.03345.florian-evers@gmx.de>
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
Date: Mon, 14 Mar 2005 13:44:02 +0100

Hi List,

Am Montag, 14. M=E4rz 2005 11:28 schrieb Marcel Holtmann:
> > I upgraded my kernel from 2.6.10-mh2 to 2.6.11-mh1 and now my mouse and
> > keyboard operate in boot protocol mode again so the special keys don't
> > work. Does 2.6.11-mh1 lack full support for the report mode protocol, is
> > it broken or has something else changed I'd have to know about? I'm
> > using bluez-libs and -utils 2.15. The keyboard is a Logitech Elite
> > keyboard and the mouse is Logitech MX900.
>
> maybe I made a mistake when porting the report mode to 2.6.11. Last time
> I checked it, it worked for me.

I have the same problem here. I'm owner of a Microsoft Wireless Desktop
Elite for BT 2.0. The only kernel that offered me support for the
mouse wheel was 2.6.10-mh2. It had some quirks (left mouse button does
not work properly after reconnection, I've to press all mouse-buttons
simultaneously with mouse cursor over background in KDE. Then it
works again) but basically it is _far_ better than having no wheel
support.

=2Dmh3 and -mh4 didn't work for me. They were not able to detect my bluetoo=
th
dongle. Vanilla 2.6.11 and 2.6.11-mh1 detect my MS-BT 2.0 dongle correctly,=
=20
but keyboard and mouse are accessed in boot protocol mode. So I'm using
2.6.10-mh2 again...

Perhaps this is the same problem like Vesa has... on different hardware.
I'm using Gentoo Linux and bluez-utils/-libs 2.15.


Regards,

=46lorian Evers

P.S. I had some troubles subscribing to this mailinglist. I tried several=20
times in the last weeks, but I never got a confirmation of subscription. Bu=
t=20
now it works :-)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

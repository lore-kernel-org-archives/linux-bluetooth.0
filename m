Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] auto pairing between client & server
From: Fredy P <digitalfredy@debiancolombia.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1114205889.10706.9.camel@pegasus>
References: <2621d9af05042213064d0df1dc@mail.gmail.com>
	<1114205889.10706.9.camel@pegasus>
Content-Type: text/plain;
	charset=iso-8859-1
Message-Id: <1114359474.3926.13.camel@localhost.localdomain>
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
Date: Sun, 24 Apr 2005 11:17:54 -0500

El vie, 22-04-2005 a las 23:38 +0200, Marcel Holtmann escribi=F3:
> Hi,
>=20
> > I have a laptop which runs my application as server, and another
> > cellphone as client. Both of them communicate to each other using
> > Bluetooth (Bluez implementation).
> >=20
> > What should I do in order to perform automatic pairing between these 2
> > devices (knowing the BD_ADDR) inside my application?
>=20
> there is no such thing than automatic pairing.
>=20
> > How can I detect if the pairing had been done between these
> > client-server devices inside my application? And from that, how to do
> > pairing using the "givepin" script?
> >=20
> > I want to avoid the pop-ups window asking for entering the PIN.
>=20
> Write your own PIN helper shell script that uses a fixed PIN. Check the
> link key file for the current state of the pairing.
/usr/local/bin/bluez-localpin:
#!/bin/sh
echo "PIN":$(cat /etc/bluetooth/pin)

and put in /etc/bluetooth/hcid.conf:
pin_helper /usr/local/bin/bluez-localpin;=20
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

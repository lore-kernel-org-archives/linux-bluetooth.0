Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How can you give the pin without using
	thekeyboard?
From: Fredy P <digitalfredy@debiancolombia.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42B1E0EA.7010304@lesagepono.be>
References: <42B1E0EA.7010304@lesagepono.be>
Content-Type: text/plain;
	charset=iso-8859-1
Message-Id: <1118985948.3946.2.camel@localhost.localdomain>
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
Date: Fri, 17 Jun 2005 00:25:46 -0500

El jue, 16-06-2005 a las 20:28 +0000, Laurent Lesage escribi=F3:

Hi, see http://el-directorio.org/index.php/Bluetooth_en_debian
First make /usr/local/bin/bluez-localpin
#!/bin/sh
echo "PIN":$(cat /etc/bluetooth/pin)

After put this line in your /etc/bluetooth/hcid.conf

        pin_helper /usr/local/bin/bluez-localpin; #este no es el que trae p=
or defecto, ver arriba

> Hi all,
>=20
> I would like to pair my headset without typing the pin on the keyboard.=20
> I use the "auto" value for security in "hcid.conf" but the PIN is asked=20
> every time I start to use the headset (once paired, it is ok). I have a=20
> file 'pin' with the vlaue of the pin but it seems to be of no use.
>=20
> Thanks
>=20
> Laurent
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
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

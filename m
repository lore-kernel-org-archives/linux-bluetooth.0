Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Matias Pablo Brutti <matiasbrutti@ciudad.com.ar>
Reply-To: matiasbrutti@ciudad.com.ar
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] can't get bthid
References: <408C4D8D.7090104@yahoo.com.au> <1082937237.28880.109.camel@pegasus> <40926BAF.1040604@yahoo.com.au>
In-Reply-To: <40926BAF.1040604@yahoo.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200405011842.27076.matiasbrutti@ciudad.com.ar>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 1 May 2004 18:42:19 -0300

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I was wondering if you could share all the step that you took to make your =
=2E.=20
MX900 to work . because I have been trying but there is no way to make it=20
work as a bluetooth device ...  what modules you load .. and where you=20
configure you mouse to work .. because I managed to connect the mouse and=20
hcidump.. gives me all kind of info everytime I move the mouse .. but .. th=
e=20
pointer does not move ..=20

Please if you have some way of how to ... that you did .. please .. share=20
it .. I will mean the world to me ..=20

THanks ..=20

On Friday 30 April 2004 12:07, pro wrote:
> thanks ... both keyboard and mouse are working fine now.
>
> The fn key doesn't seems to work thou.
>
> also i noticed that when i run hid2hci, it doesn't always switch the
> dodgle from hid to hci.
> Sometimes i have to run it 2nd time to get it to work.
>
> >Hi,
> >
> >>    The problem i'm having is i get the follow error when i try to start
> >>bthid,
> >>
> >>Can't connect to HID service: No such file or directory
> >
> >you must start a bthid daemon instance with "bthid -d" first.
> >
> >>Now the bluetooth i'm using is the logitech MX900 with the logitech
> >>bluetooth dodge. The software i'm using are lib2 and utils2 both from
> >>the cvs. I managed to get hid2hci working and from the
> >>/proc/bus/usb/devices i can tell the hub is in bluetooth mode. Running
> >>"hciconfig hci0 up" to bring the bluetooth interface up, which works
> >>fine. "hcid" also ran fine. I could manually linked up the mouse with
> >>the hub by using "hcitool cc <mouse address>". Other command such as
> >>"hcitool scan" "hcitool inq" all works fine.
> >
> >Don't play with "hcitool cc". The HCI connection is created automaticly
> >when needed.
> >
> >Regards
> >
> >Marcel
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g.
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUBQJQZvmXJj+mzTB70AQK7JQgAgsFuk8GqAziZBDbYaS0n/5R/IlYlzxrT
o4KSZoTYYAHTsS2uVwboR2lEtAcv+uMUGrvvanJoKHfSDFXYPVmfxPItdcMq7H8F
bDz7EmNWNOvII9wFi0zvYMEIo6kRKBP7AIqskpS7nmewQtJy9VVt8mV+tLSAlnxG
teHm0HKNhb07oFFc+txmGYU6vCk7Rw90CVVcmBdNxoYSmnsAK6v+RjBmJhAHNWSv
mXirAaMsrrXqJ6gzY+DyDbNJn4RrbRN9yFFVhqnGEYKPwRU9+Rb88AVMdl5P0n48
KQLG6hZ66ftuJgu1I+bmoKszkIDeCdfplptcuc2OBhL/E1/Ql4Oy+A=3D=3D
=3D9/9I
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

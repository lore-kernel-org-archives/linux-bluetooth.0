Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hidd
References: <200405300037.53081.puggy@gentoo.org>
In-Reply-To: <200405300037.53081.puggy@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405300200.53882.cijoml@volny.cz>
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
Date: Sun, 30 May 2004 02:00:53 +0200

You must modprobe hidp and uinput first

Michal

On Sunday 30 of May 2004 01:37, Douglas Russell wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> I'm assuming that hidd is the equivalent of bthid from utils2 in cvs. bth=
id
> works fine, but with utils-2.7 (and libs-2.7) hidd gives me:
>
> Can't open HIDP control socket: Invalid argument
>
> whatever commands I choose.
>
> Thanks in advance for any help.
>
> Puggy
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
>
> iD8DBQFAuR7QXYnvgFdTojMRAofgAKDz8GT5mhIvCTE1sRvkH3iAGWUhhwCfdC5z
> WIJ4KRbdhza1cfdFN2//0mA=3D
> =3DER31
> -----END PGP SIGNATURE-----
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g.
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id149&alloc_id=8166&op=3DClick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

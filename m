Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41AB248C.5060803@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hello
References: <41AA81F0.8080005@bielefeld.ccc.de> <1101694796.9527.13.camel@pegasus> <41AB1804.8070807@Uni-Bielefeld.de> <1101732250.10115.3.camel@pegasus> <41AB1B6B.5010004@soft.uni-linz.ac.at> <41AB471C.7030609@bielefeld.ccc.de>
In-Reply-To: <41AB471C.7030609@bielefeld.ccc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 29 Nov 2004 14:30:52 +0100

no,
these extensions are csr-specific (but they are well documented) -- they=20
use extended
hci commands to access the configuration registers of the bt dongle.
simon

Nick wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Simon Vogl wrote:
>
> | well there is one tool: get the csr reset utility, it contains
> | source code to also alter the hci mapping (which I used on my
> | vaio):
> |
> http://www.soft.uni-linz.ac.at/_wiki/tiki-index.php?page=3DProjectBluez=
Handsfree=20
>
> |
> |
> | no guarantees given, no questions asked ;) simon
>
> excellent it works. that was easy. i think i=B4ll take a look at the
> source code, to know what the tool is doing. ;)
>
> is this a vaio specific thing, got a vaio v505cp myself.
>
>
> ~         ,nick
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.6 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>
> iD8DBQFBq0ac40bmwXROfRURApRaAKC4H9Bl5g0Y4bSd1UIjpi6s/C+d1wCbBbqu
> fQ2ottOEke4GmhOsowxbZvk=3D
> =3DEh5o
> -----END PGP SIGNATURE-----
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.=20
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



--=20
_______________________________________________________________________
Dr. Simon Vogl
Institut f=FCr Pervasive Computing, Johannes Kepler Universit=E4t Linz =20
Altenberger Stra=DFe 69, A-4040 Linz, Austria =20
 =20
Tel: +43 732 2468-8517, Fax: +43 732 2468-8426 =20
mailto: vogl@soft.uni-linz.ac.at,  http://www.soft.uni-linz.ac.at/








-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

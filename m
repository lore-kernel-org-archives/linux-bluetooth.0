Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ruben Jenster <ruben@hotheads.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco - unknown symbol snd_hwdep_new undefined!
References: <200411270038.51554.ruben@hotheads.de> <1101524868.6514.67.camel@pegasus>
In-Reply-To: <1101524868.6514.67.camel@pegasus>
MIME-Version: 1.0
Message-Id: <200411271059.42204.ruben@hotheads.de>
Content-Type: multipart/signed;
  boundary="nextPart19003356.rAk7l2aaUX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
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
Date: Sat, 27 Nov 2004 10:59:36 +0100

--nextPart19003356.rAk7l2aaUX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



=46irst Marcel,
I want to excuse my impatience. I received two confirmation e-mails this=20
morning. I'm now shure that is was the problem of my mail provider (1und1).
But let's switch to my problem:

> you may need to make "depmod -e" first or simply load the "snd-hwdep"
> kernel module.

The problem is that there doesn't exist a module called snd-hwdep.
=46or my last kernel I generated a kernel patch from the cvs kernel module.
Building only the module that is included in the cvs btsco module doesn't=20
work.

Do you have to apply the cvs kernel module although?

>
> > >>compile process of the kernel module:
> >
> > 22:57 root [/home/ruben/temp/btsco/btsco/kernel] : make
> > make[1]: Entering directory `/usr/src/linux-2.6.9-gentoo-r6'
> >   CC [M]  /home/ruben/temp/btsco/btsco/kernel/btsco.o
> > /home/ruben/temp/btsco/btsco/kernel/btsco.c: In Funktion
> > =BBsnd_card_bt_sco_thread=AB:
> > /home/ruben/temp/btsco/btsco/kernel/btsco.c:809: Warnung: ISO C90 forbi=
ds
> > mixed declarations and code
>
> This one is now fixed in CVS.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

--nextPart19003356.rAk7l2aaUX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBqFAO0gsecz4c07sRAuOOAKDI1XyiEUZIfguFvuq6to+oQRTFoQCgyzX2
k/namTArD6MVg6y57LddaiA=
=AWcF
-----END PGP SIGNATURE-----

--nextPart19003356.rAk7l2aaUX--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

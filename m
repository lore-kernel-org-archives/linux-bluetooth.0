Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thomas Kear <qupada@initng.org>
To: bluez-users@lists.sourceforge.net
Date: Tue, 21 Nov 2006 22:57:17 +1300
References: <b5dccebe0611210124h5076b396xa2e9c0617658cf13@mail.gmail.com>
In-Reply-To: <b5dccebe0611210124h5076b396xa2e9c0617658cf13@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200611212257.25266.qupada@initng.org>
Subject: Re: [Bluez-users] concurrent operations
Reply-To: qupada@initng.org, BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0978479938=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0978479938==
Content-Type: multipart/signed; boundary="nextPart3201880.e6Uetlh9Rq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3201880.e6Uetlh9Rq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

You pretty much summed up everything there is to say.  I see someone replie=
d=20
off the list, but I'll add what I know, in any case.

As you noted, any regular data connection can be paired with others.  The=20
limit is 7 connections, but you do have to remember that there's less than=
=20
800kbps to go around on Bluetooth 1.2 and only a couple of megabits on=20
Bluetooth 2.0.  I have managed a file transfer from my cellphone (only ever=
=20
manages 25kB/s, ~200kbps) while talking on my bluetooth headset (not sure=20
about bandwidth use for it) but I don't think I'd like to test anything els=
e=20
simultaneously.

=2D-Thomas


On Tuesday 21 November 2006 10:24 pm, Mikael Lindqvist wrote:
> Hi,
>
> This is a general bluetooth question...
>
> I have been experimenting with bluetooth for some time now and I'm
> wondering what is actually possible to do simultaneously. My
> application is doing device discovery, service search and obex push.
> It seems as if it is possible to do several obex pushes at the same
> time (guess that would go for any kind of RFCOMM  connections), but
> it's just possible to do one device discovery or one service search
> simultaneously. I. e. it's not possible to do service search at the
> same time as device discovery, and it's only possible to do service
> search for one remote device at the same time.
>
> So to sort things out once and for all, what is actually possible? And
> why does this limitation exist, is it something fundamental to
> bluetooth or just because of current implementations?
>
> -- Mikael

--nextPart3201880.e6Uetlh9Rq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFYs2FBzwCEOHNMbURAsgBAJ9v3fgQf6N2S1mALPaPytDkJFPnHQCcDiE2
uw/oHNmVrg5+QxgMB/zgfNQ=
=Rejx
-----END PGP SIGNATURE-----

--nextPart3201880.e6Uetlh9Rq--


--===============0978479938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0978479938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0978479938==--

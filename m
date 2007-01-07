Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 7 Jan 2007 17:51:03 +0100
From: magon@yo.cz
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070107165103.GB9894@dobaledova.net>
References: <20070103202243.GC9844@dobaledova.net>
	<BAY19-F22CACDB090BCC4A96E0C04A9BE0@phx.gbl>
MIME-Version: 1.0
In-Reply-To: <BAY19-F22CACDB090BCC4A96E0C04A9BE0@phx.gbl>
Subject: Re: [Bluez-devel] BCM2035 over UART on Palm T|T3
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2084071062=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============2084071062==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ok, thanks, but question is, do BCM2035 response to BT reset? or just
reset itself.
	I tried BT version command, should it response to that one? Or
	it have to be BT reset? Does it depend on something to response
	to version, and does BT reset response anytime?

		Martin Kupec
On Sat, Jan 06, 2007 at 11:38:48PM +0800, ?? ???? wrote:
> Hi Kupec,
>   Maybe you should  validate your UART has been drived by your OS,and you=
=20
> can test it using oscillograph or electronic multimeter.
>  In my experience, no need to send any special character, just send=20
> bluetooth reset command.=20
>  gao
> >From: magon@yo.cz
> >Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
> >To: bluez-devel@lists.sourceforge.net
> >Subject: [Bluez-devel] BCM2035 over UART on Palm T|T3
> >Date: Wed, 3 Jan 2007 21:22:43 +0100
> >
> >Hi all,
> >	It happend that I have Palm T|T3 and hack linux for it(don't ask=20
> >	how).
> >	This gadget have Broadcom's BCM2035 connected over UART
> >	interface and PXA261 CPU.
> >	The biggest problem is, that I haven't managed to get even single=20
> >	byte
> >	from it. And I am shure it is on UART I am trying(when i disable
> >	it in Palm OS BT stops working).
> >	My plan was to kick off Palm OS and just before booting linux
> >	start to talk to BT. I have copied get version command from
> >	hciattach to end of bootloader(Garux). Than enabled BT in Palm
> >	OS, and executed bootloader and it simple doesn't return single
> >	byte.
> >
> >	My question is, do I need to send any special character(like
> >	break) or something else, UART should be properly configured
> >	from Palm OS. And what should be proper testing command to send
> >	to get response.
> >
> >	And also if anyone have seen that chip's wiring, are there any
> >	other wires that should be connected to CPU and I should find in
> >	order to communicate with it.
> >
> >			Martin Kupec
>=20
> _________________________________________________________________
> ???????????????????????????? MSN Messenger:  http://messenger.msn.com/cn =
=20
>=20
>=20

> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFoST3bXfhpu3tp+4RAkURAJ9BJOXHnx11XHFjveqd9hnV74XEHACgx18e
ql2r8ElEcLBbOsnVXzYIShM=
=hCpM
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--


--===============2084071062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2084071062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2084071062==--

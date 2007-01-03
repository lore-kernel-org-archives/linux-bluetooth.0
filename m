Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 3 Jan 2007 21:22:43 +0100
From: magon@yo.cz
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070103202243.GC9844@dobaledova.net>
MIME-Version: 1.0
Subject: [Bluez-devel] BCM2035 over UART on Palm T|T3
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1389708057=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1389708057==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,
	It happend that I have Palm T|T3 and hack linux for it(don't ask how).
	This gadget have Broadcom's BCM2035 connected over UART
	interface and PXA261 CPU.
	The biggest problem is, that I haven't managed to get even single byte
	from it. And I am shure it is on UART I am trying(when i disable
	it in Palm OS BT stops working).
	My plan was to kick off Palm OS and just before booting linux
	start to talk to BT. I have copied get version command from
	hciattach to end of bootloader(Garux). Than enabled BT in Palm
	OS, and executed bootloader and it simple doesn't return single
	byte.

	My question is, do I need to send any special character(like
	break) or something else, UART should be properly configured
	from Palm OS. And what should be proper testing command to send
	to get response.

	And also if anyone have seen that chip's wiring, are there any
	other wires that should be connected to CPU and I should find in
	order to communicate with it.

			Martin Kupec

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFnBCTbXfhpu3tp+4RAutjAJ0S2reOGnm6rYUfWRjXurjq/KJbWwCePQ32
Q6Rta1YGTRO/t9s09Yz/MPo=
=eF1P
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--


--===============1389708057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1389708057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1389708057==--

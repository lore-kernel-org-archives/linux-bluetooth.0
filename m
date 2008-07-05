Return-Path: <cyrus@holtmann.org>
From: Rui Pedro Lopes <rlopes@ipb.pt>
To: bluez-devel@lists.sourceforge.net
Date: Sat, 05 Jul 2008 08:00:01 +0100
Message-Id: <1215241201.17606.7.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Forward and Backward keys on presenter
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2053508511=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============2053508511==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Tt/KEyBA7uH4txM3OJLU"


--=-Tt/KEyBA7uH4txM3OJLU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all!

I have a microsoft notebook presenter mouse 8000
(http://www.microsoft.com/hardware/Presenter/productdetails.aspx?pid=3D085)=
 and I have managed to have it working (as a mouse). When switching to pres=
enter mode, the multimedia keys work (volume up and down), but the forward =
and backword keys do not. I tried to get the key codes with xev, but nothin=
g shows up. Even the scan code (with showkey -s or with getscancode - http:=
//keytouch.sourceforge.net/) nothing shows up.

However, with hcidump I can see that something goes through:

(as a mouse)
> 02 32 20 0B 00 07 00 41 00 A1 11 00 FF 00 00 00=20
> 02 32 20 0B 00 07 00 41 00 A1 11 00 FE FF 00 00=20
> 02 32 20 0B 00 07 00 41 00 A1 16 00 00 0F 00 00=20
> 04 14 06 00 2E 00 00 00 00=20
> 02 32 20 0B 00 07 00 41 00 A1 16 00 00 00 00 00=20
(switching to presenter)
> 04 14 06 00 2E 00 02 A2 00=20
> 04 14 06 00 32 00 00 00 00=20
> 04 14 06 00 32 00 02 4E 00=20
(pressing forward key)
> 02 32 20 0B 00 07 00 41 00 A1 16 00 00 00 00 00=20
> 02 32 20 0B 00 07 00 41 00 A1 16 00 00 00 00 00=20
(switching to mouse)
> 04 14 06 00 32 00 00 00 00=20
> 04 14 06 00 32 00 02 1E 00=20
> 04 14 06 00 32 00 00 00 00=20
> 04 14 06 00 32 00 02 4E 00=20

(as a mouse)
> ACL data: handle 50 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 0]
      A1 16 00 00 08 00 00=20
> HCI Event: Mode Change (0x14) plen 6
  00 32 00 00 00 00=20
> HCI Event: Mode Change (0x14) plen 6
  00 32 00 02 1E 00=20
> ACL data: handle 50 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 0]
      A1 16 00 00 00 00 00=20
(switching to presenter)
> HCI Event: Mode Change (0x14) plen 6
  00 32 00 00 00 00=20
> HCI Event: Mode Change (0x14) plen 6
  00 32 00 02 4E 00=20
(pressing forward key)
> ACL data: handle 50 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 0]
      A1 16 00 00 0E 00 00=20
> HCI Event: Mode Change (0x14) plen 6
  00 32 00 00 00 00=20
> HCI Event: Mode Change (0x14) plen 6
  00 32 00 02 1E 00=20
> ACL data: handle 50 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 0]
      A1 16 00 00 00 00 00=20
(back to mouse mode)
> HCI Event: Mode Change (0x14) plen 6
  00 32 00 00 00 00=20
> HCI Event: Mode Change (0x14) plen 6
  00 32 00 02 4E 00=20

I do not know how to interpret this information. Does anyone knows if
the problem is related to the bluetooth part or to X?
Is there any possibility of getting it working?

Cheers,

/rp

--=-Tt/KEyBA7uH4txM3OJLU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIbxvxAhGrHSs5PNIRAtJJAJ9T4mQBp5uZsvmt7cIBepmQkDAI6ACg30pd
VjQwNqhmssWdWt4iiBZ8kAQ=
=GKHR
-----END PGP SIGNATURE-----

--=-Tt/KEyBA7uH4txM3OJLU--



--===============2053508511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============2053508511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2053508511==--

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Paul LeoNerd Evans <leonerd@leonerd.org.uk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] New User
Message-ID: <20050927095829.41367ac0@nim.leo>
In-Reply-To: <d73fa6c305092623184b76249f@mail.gmail.com>
References: <d73fa6c305092623184b76249f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Tue__27_Sep_2005_09_58_29_+0100_Kb2MMlrkN5FIm+YE;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
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
Date: Tue, 27 Sep 2005 09:58:29 +0100

--Signature_Tue__27_Sep_2005_09_58_29_+0100_Kb2MMlrkN5FIm+YE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Sep 2005 16:18:09 +1000
valen willie <valen.willie@gmail.com> wrote:

> Hi,
>=20
> I just bought myself a USB Bluetooth Adapter.
> I'm very new to Bluetooth and intend to learn more about it.
> I'm using Slackware 10.1.
> I have bluez module loaded automatically when I plug in my bluetooh
> adapter into my USB port.
> But then, what should I do, what application should I start or install
> now to utilize my bluetooth adapter?

Well, it'll depend on your distro. One tool you might find useful
initially is "hcitool"; it does some initial diagnostics...

$ hcitool devices
Devices:
        hci0    00:07:61:19:7A:BA

$ hcitool scan
Scanning ...
        00:02:EE:C6:41:B2       LeoPhone

hcitool --help  for a full list.

I run debian, and this program is provided by the bluez-utils package;
but other distros may vary.

--=20
Paul "LeoNerd" Evans

leonerd@leonerd.org.uk
ICQ# 4135350       |  Registered Linux# 179460
http://www.leonerd.org.uk/

--Signature_Tue__27_Sep_2005_09_58_29_+0100_Kb2MMlrkN5FIm+YE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDOQm4vcPg11V/1hgRAsqVAJ9QnLoXLq6RSYvnlzyD+YDvFwc0WACfdHBG
AZcvs9wwjqyYz1YnZCJBDdA=
=8yGT
-----END PGP SIGNATURE-----

--Signature_Tue__27_Sep_2005_09_58_29_+0100_Kb2MMlrkN5FIm+YE--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

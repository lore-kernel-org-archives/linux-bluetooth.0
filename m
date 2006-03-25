Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Robin Roevens <robin.roevens1@pandora.be>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2105930.JGIkffF301";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200603251551.45792.robin.roevens1@pandora.be>
Subject: [Bluez-users] bluetooth seems to be working but no /var/lib/bluetooth directory is generated
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
Date: Sat, 25 Mar 2006 15:51:36 +0100

--nextPart2105930.JGIkffF301
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I have a logitech dinovo bluetooth media desktop Laser which works perfect =
in=20
HID mode, but I want more bluetooth functionality so I followed all=20
instructions on http://linux.yes.nu/diNovo/ and=20
http://forums.gentoo.org/viewtopic-t-231506-postdays-0-postorder-asc-start-=
0.html=20
to get it running in HCI mode. I'm running gentoo-sources kernel 2.6.15-r1 =
+=20
mh2 patch from bluez.org.
I have these bluez packages installed: bluez-utils-2.24 bluez-libs-2.24=20
bluez-hciemu-1.2 bluez-hcidump-1.30
hid2hci succesfully replies with

Switching device 046d:c70c to HCI mode was successful
Switching device 046d:c70b to HCI mode was successful

hciconfig gives me this:

hci0: Type: USB
BD Address: 00:07:61:41:F5:80 ACL MTU: 1017:8 SCO MTU: 64:0
UP RUNNING PSCAN ISCAN
RX bytes:490 acl:11 sco:0 events:35 errors:0
TX bytes:771 acl:8 sco:0 commands:25 errors:0

and hcitool finds all devices needed, so everything looks good but my=20
keyboard, -pad nor mouse work...
Every time I press a key on my keyboard, it connects succesfully, and gives=
 me=20
this message in /var/log/messages:
hidd: HID create error 2 (No such file or directory)
and gets disconnected again

I ran an strace on the hidd deamon and the moment I press a key I see this:
open("/var/lib/bluetooth/00:07:61:41:F5:80/hidd", O_RDONLY) =3D -1 ENOENT (=
No=20
such file or directory)

so I went checking my /var/lib/bluetooth directory and I found out, that=20
directory indeed doesn't exist..
As far as I understand the whole bluez bluetooth thing, that directory shou=
ld=20
be generated automaticaly, but I can't seem to find anything about the=20
directory not being generated nor what process/module/whatever should=20
generate that directory...So I don't have any clue where to start searching=
=20
for a solution to this problem...
Can anyone help me? any suggestions are fine since I am starting to get rea=
ly=20
desperate.. Everyone but me with a dinovo desktop seems to have his hardwar=
e=20
working in linux. What am I missing?

Greetz
Robin.
=2D-=20
100% MS FREE
Absolutely no component of Microsoft was used
in the generation or posting of this e-mail. So it is virus free

--nextPart2105930.JGIkffF301
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEJVkBHy/MOxtbPTsRAu4hAJ4xpDZLdnFuxuJ6iSfBLqJXRrMuoACfUdXU
fXihaF8yJgxcSqsA0KckT5w=
=H8P7
-----END PGP SIGNATURE-----

--nextPart2105930.JGIkffF301--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

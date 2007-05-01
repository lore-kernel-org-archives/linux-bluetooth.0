Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Andreas Ntaflos <daff@dword.org>
To: bluez-users@lists.sourceforge.net
Date: Tue, 1 May 2007 05:32:29 +0200
MIME-Version: 1.0
Message-Id: <200705010532.30291.daff@dword.org>
Subject: [Bluez-users] K800i sends correct usage IDs,
	get mis-interpreted by Xorg
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1246190435=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1246190435==
Content-Type: multipart/signed; boundary="nextPart1553187.y3PspA0Zcd";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1553187.y3PspA0Zcd
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello list,=20

this is my first post here and I am not sure whether I've come to the=20
right forum for my problem. I'll try nonetheless.

Using bluez-* 3.9 on Kubuntu 7.04 (Feisty), with Xorg 7.2.

I use my Sony Ericsson K800i to remote control my desktop and it works=20
almost fine. I defined an HID profile using the USB HID usage tables=20
[1] and the Bluetooth HID remote control developer information [2] by=20
Sony Ericsson.

The problem is that some usage IDs don't get interpreted correctly by=20
Xorg. An example:

<KEY_VOL_UP>
  <ACTION>
    <KEYBOARD MODIFIERS =3D "00" USAGEID =3D "4E" />  <!-- Page Down -->
  </ACTION>
</KEY_VOL_UP>

This sets the phone's volume up key to send the usage ID 4E (unmodified)=20
which is the keyboard equivalent of Page Down according to the HID=20
specs.

However, testing this with xev yields the following:

KeyPress event, serial 31, synthetic NO, window 0x1800001,
    root 0x1a5, subw 0x0, time 3560039, (107,75), root:(1705,822),
    state 0x0, keycode 117 (keysym 0xffaf, KP_Divide), same_screen YES,
    XKeysymToKeycode returns keycode: 112
    XLookupString gives 1 bytes: (2f) "/"
    XmbLookupString gives 1 bytes: (2f) "/"
    XFilterEvent returns: False

Apparently Xorg interprets that usage ID as KP_Divide ("/") or keycode=20
117, which it definitely is not.

This is just a real example, other usage IDs are also problematic.=20

Also of note should be that I set up an Xorg input device for the phone.=20
Without it no mouse events would ever occur:

Section "InputDevice"
    Identifier              "k800i"
    Driver                  "evdev"
    Option  "Protocol"      "Auto"
    Option "Name"           "Sony Ericsson Remote Control of PC=20
applications and other devices"
    Option  "Buttons"       "3"
    Option  "SendCoreEvents"
EndSection

Before getting into any more detail, could this a problem of Xorg or is=20
this the doing of bluez?=20

Where can I check if bluez receives the correct usage ID and translates=20
it into the wrong Xorg keycode, should that be the case?

Or can anybody suggest anything else? Any other information I haven't=20
looked at yet? Should I try my luck at the Xorg mailing list (they'd=20
probably just send me back here :))?

Thanks a lot in advance!

Andreas

[1] http://www.usb.org/developers/devclass_docs/Hut1_11.pdf
[2] http://developer.sonyericsson.com/getDocument.do?docId=3D66147
=2D-=20
Andreas "daff" Ntaflos=20
Vienna, Austria=20

GPG Fingerprint: 6234 2E8E 5C81 C6CB E5EC  7E65 397C E2A8 090C A9B4

--nextPart1553187.y3PspA0Zcd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGNrTOOXziqAkMqbQRApACAJ4u8783YZPV8U0rfvmxTRIS269i3wCdEPHb
bGRh3HmT0O5lILTUgvOL6K4=
=kKeo
-----END PGP SIGNATURE-----

--nextPart1553187.y3PspA0Zcd--


--===============1246190435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1246190435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1246190435==--

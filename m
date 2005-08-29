Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Rutger Hendriks <Loial@home.nl>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7464293.Bx7UQgVftC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200508291336.13270.Loial@home.nl>
Subject: [Bluez-devel] missing keys from logitech dinovo keyboard
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
Date: Mon, 29 Aug 2005 13:36:13 +0200

--nextPart7464293.Bx7UQgVftC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>From: Marcel Holtmann <marcel <at> holtmann.org>
> Subject: Re: missing keys from logitech dinovo keyboard
> Newsgroups: gmane.linux.bluez.devel
> Date: 2004-07-06 10:40:33 GMT (1 year, 7 weeks, 4 days, 18 hours and 30=20
minutes ago)
>
>Hi Dick,
>
>> I'm playing with showkey from kbd (http://freshmeat.net/projects/kbd/)
>> All keys are shown except "New" (FnF1), "Reply" (FnF2), "Forward" (FnF3)=
,=20
>> "Send" (FnF4), "Redo" (FnF6), "Print" (FnF7), "Save" (FnF8), "My=20
>> Doc" (FnF10), "My Pic" (FnF11) and "My Music" (FnF12) (you get those by=
=20
>> enabling F-Lock)
>> Undo (FnF5) and MyComp (FnF9) work though, giving keycode 144 and 145
>> I'm using 2.6.7-mh1 and bluez-(utils/libs)2.7
>> Is this a bug or am I missing something?
>
>I don't know. I never checked the extra keys of my diNovo desktop, but
>maybe the HID parser didn't take them into account and transforms them
>into the correct key events. Feel free to look at the kernel code.
>
>Regards
>
>Marcel

Hi list,

This is a reply to a message sent over 1 year ago :)
Unfortunately, the issue described in the original message still seems to=20
occur and is troubling me now. I.e. the function keys F1 - F12 are working=
=20
fine, but when I press F-Lock, the special keys FnF1 to FnF4 and FnF6 to Fn=
=468=20
and FnF10 to FnF12 are not working for me. Nothing is shown in xev, or in=20
showkeys or in dmesg.
=46nF5 and FnF9 give "keycode 199 (keysym 0x0, NoSymbol)" and "keycode 198=
=20
(keysym 0x0, NoSymbol)" respectively in xev, which is different from the=20
original post. I am using 2.6.12-gentoo-r6 on AMD64 with bluez-(utils/libs)=
=20
2.19.

I have been unable to find anything useful in the kernel code. Is there a=20
specific place I should look? There seem to be quite some tables with=20
keycodes/scancodes, and I can not seem to find the one that is used by my=20
Dinovo keyboard in bluetooth mode (i.e. not in bootmode).

Thanks,

Rutger

--nextPart7464293.Bx7UQgVftC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDEvMtZNkx8LIJzQ4RAkkDAJsFVX8Xw/OinZY68kktAKS0bKv5XwCggzCd
0w6sfhmBodY4d4Ip8XK6Lyg=
=MDfc
-----END PGP SIGNATURE-----

--nextPart7464293.Bx7UQgVftC--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

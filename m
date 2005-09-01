Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Rutger Hendriks <Loial@home.nl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] missing keys from logitech dinovo keyboard
References: <200508291336.13270.Loial@home.nl>
In-Reply-To: <200508291336.13270.Loial@home.nl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1394164.rp5iEDWQhc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200509012058.02028.Loial@home.nl>
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
Date: Thu, 1 Sep 2005 20:57:54 +0200

--nextPart1394164.rp5iEDWQhc
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 29 August 2005 13:36, Rutger Hendriks wrote:
> >> All keys are shown except "New" (FnF1), "Reply" (FnF2), "Forward"
> >> (FnF3), "Send" (FnF4), "Redo" (FnF6), "Print" (FnF7), "Save" (FnF8), "=
My
> >> Doc" (FnF10), "My Pic" (FnF11) and "My Music" (FnF12) (you get those by
> >> enabling F-Lock)
> >> Undo (FnF5) and MyComp (FnF9) work though, giving keycode 144 and 145
> >> I'm using 2.6.7-mh1 and bluez-(utils/libs)2.7
>
> Unfortunately, the issue described in the original message still seems to
> occur and is troubling me now. I.e. the function keys F1 - F12 are working
> fine, but when I press F-Lock, the special keys FnF1 to FnF4 and FnF6 to
> FnF8 and FnF10 to FnF12 are not working for me. Nothing is shown in xev, =
or
> in showkeys or in dmesg.
> FnF5 and FnF9 give "keycode 199 (keysym 0x0, NoSymbol)" and "keycode 198
> (keysym 0x0, NoSymbol)" respectively in xev, which is different from the
> original post. I am using 2.6.12-gentoo-r6 on AMD64 with bluez-(utils/lib=
s)
> 2.19.
>
> I have been unable to find anything useful in the kernel code. Is there a
> specific place I should look? There seem to be quite some tables with
> keycodes/scancodes, and I can not seem to find the one that is used by my
> Dinovo keyboard in bluetooth mode (i.e. not in bootmode).

Hi again,

I tried fiddling some in the kernel code, but that doesn't seem to help. I=
=20
thought that the keytable in Marcel's patch should be the one that is used =
by=20
the DiNovo keyboard, so I tried replacing all the "unk" entries in the tabl=
e=20
with a number so something should happen when I press F1 after enabling=20
=46-Lock.
Man, was I mistaken. Still nothing happens.
I'm wondering, does anyone else have the DiNovo keyboard and do they have A=
LL=20
keys working? What can I try to get this working?

Thanks for any info,

Regards

Rutger

--nextPart1394164.rp5iEDWQhc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDF085ZNkx8LIJzQ4RAteMAJ4wy8K76a4hzKArP+II0cWf6V/CGgCfQxob
rw7500VmhOAa8UxeoVaZJG4=
=vN8u
-----END PGP SIGNATURE-----

--nextPart1394164.rp5iEDWQhc--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

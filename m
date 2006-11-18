Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455F78B9.1040508@prolly.org>
Date: Sat, 18 Nov 2006 16:18:49 -0500
From: Douglas Ward <douglas.ward@prolly.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1163882230.3025.18.camel@TesterBox.tester.ca>
In-Reply-To: <1163882230.3025.18.camel@TesterBox.tester.ca>
Subject: Re: [Bluez-devel] Hiddev support
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

i have the same keyboard set, I'd be happy to help you with testing
any code you may write for the set. so far there is no way to contorl
the screen as far as i know. i pointed someone towards g15deamon etc
but i'm not very good at hacking drivers or hardware support (though i
did manage to produce the patch for hid2hci for this set)

Olivier Cr=EAte wrote:
> Hi,
>
> I recently got a logitech mx5000 bluetooth desktop. I got it to work
> with bluez without too many problems (with the CVS hid2hci). It seems to
> behave mostly like the bluetooth dinovo. I also want to control the
> display and use the special keys. But they are carried in hidp input
> reports of type 3 (what the bluetooth hid spec calls "features"). I
> looked at the 2.6.18-mh7 patch and it has support for full HID or at
> least a way to get/send reports from userspace, but it seems that hiddev
> has been removed from it? Why? Also, can't the HID code just be shared
> with the USB version since its essentially the same anmd you'd get free
> hiddev. There are events comments in the HID code saying it should be
> independant from USB, might be a good occasion to do it.
>
> Also, where is the mh patch from, is there a git tree somewhere? I was
> gonna try to hook it up with hid/hiddev from usb, but I got lazy seing
> have the work had already been done.
>
>
> ----------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
>
> ----------------------------------------------------------------------
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRV94uVKDmmHy9Q32AQJmhBAAmOmWE7NcyjXMtsjpyiHA0/6eNq80GBns
QflXOTcoQeWvUHwVgKEr8rILNsCCKVPceMRyVgansfAqgeNbZeyAdFSEIcnzfIJO
ivwCmgHsJfBRH7teKQgZsT8UeRdEjCY5Ioj5TxljRf0iItCmLHQYhE9Si+pBKeCQ
7I3YmtY56R4LZeLG/50FmVhQQsYU1tWSwydF0cgXhzFERzMeb6g1CZ3u3IGVtcfB
uPqc7dBm4dhH8a1tfPFIsnkibYCYGiHWDOLTOT7Q9T6MzuGJWh8F7FnfrD76gqy/
rs1wvu2Sszhj25WX91Jiid/30paK0+rqGGGqg+vqvZ/1n8Js8eahqU95MlYU5vN4
Lzdw0N1T7zH51e4aBrTexNOHPJdDGB+qhzj5EdPvAXcaPI2muNFS/H/4vZkpwqpp
W58svbfAOsLrR2IDSi1VuPATY1mcXzubEDra1hmotyL8pnqf9UwIZChgILYdeStI
5Qa3meV+PIq58j8/AF6x8Ro3+e+wuj1A83Ndq8z4fEh3KXaYmYYgi7fj/mfBLqc+
10uybP4nSljPJz/Y7dY8x/EN0B0VBhbAUqNb4JpszHuXsJWuvNRXf7fY1lHPCySQ
QNLwo7SfnhsNlsED6EhY2fP9pPtUTuwp1c+Mt9RcCJz9al6IXzQ11LxrGQo5DFyH
VrrOezdOGOw=3D
=3DX20H
-----END PGP SIGNATURE-----


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4276724C.1070803@kernelconcepts.de>
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] internal bluetooth on laptop
References: <427670B5.2060708@citromail.hu>
In-Reply-To: <427670B5.2060708@citromail.hu>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Mon, 02 May 2005 20:32:44 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Szilágyi Szilveszter wrote:
> hi,
Hi!

> I have an ibm thinkpad laptop with an internal bluetooth
> with my external usb-bluetooth key I can use my mobile phone
> but I cannot use my internal bluetooth,
> the hciconfig cannot find my internal bluetooth, so I cannot use
> hciconfig hci0 up && hcitool scan && rfcomm connect 0 00:09:D9:26:70:46 2
> 
> because hciconfig gives error:
> root:~# hciconfig hci0 up
> Can't get device info: No such device
> 
> (with the external key
> root:~# hciconfig hci0 up
> root:~#
> )

Umpf... did you enable the Bluetooth device in your Thinkpad?

The Thinkpads contain a USB Bluetooth device but it can be switched on
and off using the "embedded controller", i.e. usually a hot-key like
FN-F5, will turn it on and off. You will also see the Bluetooth LED
backlit Logo on the base of the LCD when the device is active.

If it is not active you will not see it anwhere under Linux - it is
similar as having pulled it off from the USB port.

CU
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCdnJLJXeIURG1qHgRAmpvAKC9fWQcuXXZOg76a/S0BH0uzyPAeQCdGhsa
BJxzb/7MoO8orP67oKP8Ilo=
=aJYx
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

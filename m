Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051105120515.89752.qmail@web8309.mail.in.yahoo.com>
From: manish pal <manu_ashishiitd@yahoo.co.in>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Bluetooth on FLASH Drive
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
Date: Sat, 5 Nov 2005 12:05:15 +0000 (GMT)

I installed linux on 32 MB Flash Drive.
It only has busybox commands so GLIBC is not there.

To incorporate bluetooth i recmpiled kernel on my PC 
including the drivers in kernel itself and put the
image in the /boot folder of flash

Also I compiled the bluez binaries statically on my PC
and put the binaries on flash drive.I had to compile
statically because the linux running on flash doesn;t
have GLIBC .

After this when i run hciconfig by booting from flash
i get the address of my USB Dongle.
Also it can search for the bluetooth enabled devices
in the vicinity.
But when i run sdpd and sdptool add NAP
it doesn;t say NAP service registered but when i run 
the same executables on my PC it does say that.

My problem is how do i start the SDP server on Linux
running on flash drive because the sdpd i compiled
works fine on my Desktop PC 

Or is it a kernel problem

Please Somebody help.

Manish


		
____________________________________________________
Enjoy this Diwali with Y! India Click here http://in.promos.yahoo.com/fabmall/index.html


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

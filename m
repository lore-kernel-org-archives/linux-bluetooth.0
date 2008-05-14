Return-Path: <cyrus@holtmann.org>
From: Petr =?iso-8859-1?q?Palack=FD?= <petr.palacky@coduco.com>
To: bluez-users@lists.sourceforge.net
Date: Wed, 14 May 2008 10:58:13 +0200
MIME-Version: 1.0
Message-Id: <200805141058.13430.petr.palacky@coduco.com>
Subject: [Bluez-users] Bluez and more than two USB dongles in one HUB
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi all,

I have problem with using more than two USB dongles in one USB port using 4
(and more)-port USB-HUB (with or without power supply)...

I have many USB dongles for testing purposes, the same with USB HUBs.
If I connect two dongles into HUB everything works well, but if I want to 
attach third (and more) they will not be activated via bluez stack...

# hciconfig hciX up
Can't activate device: Input/output error

This USB dongle is visible using `hciconfig` but its state is everytime "DOWN" 
and cannot be changed to "UP".

I can successfully connect only two USB bluetooth dongles into one USB HUB.
I can attach many more USB devices into one HUB (like printer, phone, modem, 
flash, next USB-HUBs in tree...). All USB devices works well but only two USB 
bluetooth dongles can operate in one HUB at the same time...

I'm using latest stable kernels and bluez on top of Gentoo, Debian/Ubuntu and 
Knoppix with PCs like AMD-64b, AMD-32b, Intel P4, Intel Core, VIA EPIA - this 
problem applies in all configurations.

Where can be problem, what is solution?

Thank for all ideas
-- 
Best regards

Petr Palacky

Coduco, s.r.o.
Velflikova 6
16000 Praha 6
Tel./fax: +420 224 310 732
--
Outgoing message is virus free
because we use Linux (http://www.linux.org)
version 2.6.20-gentoo-r8 / Gentoo Linux

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

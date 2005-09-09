Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: "Kilian Lackhove" <Pommeskalle@web.de>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Message-ID: <op.swuhkyyjjitc0a@rechenknecht>
Subject: [Bluez-users] Apple Wireless Keyboard on PC: "Can't create connection: Input/output error"
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
Date: Fri, 09 Sep 2005 19:01:36 +0200


Hi there!
I am using an apple wireless keyboard pro with a Gigabyte GN-BTD02  
USB-Dongle and Kernel-2.6.12-gentoo-r9 with bluetooth, L2CAP, and HIDP as  
modules. The modules are loeaded and /etc/init.d/bluetooth has started.

Now the problem:

> rechenknecht kilian # hcitool inq
> Inquiring ...
>        00:0A:95:38:CA:58       clock offset: 0x1272    class: 0x002540

ok, this is my keyboard - now i try:

> rechenknecht kilian # hcitool cc 00:0A:95:38:CA:58
> Can't create connection: Input/output error

but "name" works:

> rechenknecht kilian # hcitool scan
> Scanning ...
>        00:0A:95:38:CA:58       meine Tastatur

So whats wrong? Please help me!

PS: In windows everything works fine, so the hardware must be alright


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

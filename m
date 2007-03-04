Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <721148.87368.qm@web31712.mail.mud.yahoo.com>
References: <721148.87368.qm@web31712.mail.mud.yahoo.com>
Date: Sun, 04 Mar 2007 03:59:18 +0100
Message-Id: <1172977158.5752.3.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] patch failed...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Tim,

> thanks for the help,
> 
> ok i tried again using the kernel form
> http://www.kernel.org/
> and still get this:
> 
> sudo zcat patch-2.6.20-mh1.gz | patch -p
> patch: option requires an argument -- p
> patch: Try `patch --help' for more information.
> root@arc:/usr/src/linux# sudo zcat patch-2.6.20-mh1.gz
> | patch -p1
> patching file drivers/bluetooth/bcm203x.c
> patching file drivers/bluetooth/bfusb.c
> patching file drivers/bluetooth/bt3c_cs.c
> patching file Makefile
> Hunk #1 FAILED at 1.
> 1 out of 1 hunk FAILED -- saving rejects to file
> Makefile.rej
> patching file net/bluetooth/hci_core.c
> patching file net/bluetooth/hidp/core.c
> patching file net/bluetooth/hidp/hidp.h
> patching file net/bluetooth/hidp/Kconfig
> patching file net/bluetooth/hidp/sock.c
> root@arc:/usr/src/linux# 

can't be. The patch has been build with a script against 2.6.20 and will
apply perfectly.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

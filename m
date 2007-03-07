Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 6 Mar 2007 16:15:27 -0800 (PST)
From: tim culwins <mail0123456789101112@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1172977158.5752.3.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Message-ID: <82281.25127.qm@web31713.mail.mud.yahoo.com>
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

well, im using 2.6.20.1. will the patch work on this
version?
if not where can i find the correct version of the
kernel?

if i have the correct version what could i be doing
wrong?

Thanks

--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Tim,
> 
> > thanks for the help,
> > 
> > ok i tried again using the kernel form
> > http://www.kernel.org/
> > and still get this:
> > 
> > sudo zcat patch-2.6.20-mh1.gz | patch -p
> > patch: option requires an argument -- p
> > patch: Try `patch --help' for more information.
> > root@arc:/usr/src/linux# sudo zcat
> patch-2.6.20-mh1.gz
> > | patch -p1
> > patching file drivers/bluetooth/bcm203x.c
> > patching file drivers/bluetooth/bfusb.c
> > patching file drivers/bluetooth/bt3c_cs.c
> > patching file Makefile
> > Hunk #1 FAILED at 1.
> > 1 out of 1 hunk FAILED -- saving rejects to file
> > Makefile.rej
> > patching file net/bluetooth/hci_core.c
> > patching file net/bluetooth/hidp/core.c
> > patching file net/bluetooth/hidp/hidp.h
> > patching file net/bluetooth/hidp/Kconfig
> > patching file net/bluetooth/hidp/sock.c
> > root@arc:/usr/src/linux# 
> 
> can't be. The patch has been build with a script
> against 2.6.20 and will
> apply perfectly.
> 
> Regards
> 
> Marcel
> 
> 
> 
>
-------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get
> the chance to share your
> opinions on IT & business topics through brief
> surveys-and earn cash
>
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



 
____________________________________________________________________________________
TV dinner still cooling? 
Check out "Tonight's Picks" on Yahoo! TV.
http://tv.yahoo.com/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 3 Mar 2007 11:24:00 -0800 (PST)
From: tim culwins <mail0123456789101112@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1172921796.24446.20.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Message-ID: <940356.30151.qm@web31715.mail.mud.yahoo.com>
Subject: [Bluez-users] patch failed...
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

so im trying to apply the new patch to my ubuntu
kernel. and i get this error message. any idea whats
wrong?

thanks,


root@arc:/usr/src/linux# zcat patch-2.6.20-mh1.gz |
patch -p1 --dry-run
patching file drivers/bluetooth/bcm203x.c
Hunk #1 succeeded at 309 (offset 2 lines).
patching file drivers/bluetooth/bfusb.c
Hunk #1 succeeded at 800 (offset -2 lines).
patching file drivers/bluetooth/bt3c_cs.c
patching file Makefile
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED -- saving rejects to file
Makefile.rej
patching file net/bluetooth/hci_core.c
Hunk #1 succeeded at 850 (offset -3 lines).
patching file net/bluetooth/hidp/core.c
Hunk #1 succeeded at 38 with fuzz 1.
Hunk #2 succeeded at 50 (offset -1 lines).
Hunk #3 succeeded at 124 (offset -1 lines).
Hunk #4 succeeded at 171 (offset -1 lines).
Hunk #5 succeeded at 241 (offset -1 lines).
Hunk #6 succeeded at 404 (offset -1 lines).
Hunk #7 succeeded at 466 (offset -1 lines).
Hunk #8 succeeded at 539 (offset -1 lines).
Hunk #9 succeeded at 596 (offset 1 line).
Hunk #10 succeeded at 651 (offset -19 lines).
Hunk #11 succeeded at 704 (offset -19 lines).
Hunk #12 succeeded at 771 (offset -19 lines).
Hunk #13 succeeded at 807 (offset -19 lines).
patching file net/bluetooth/hidp/hidp.h
patching file net/bluetooth/hidp/Kconfig
patching file net/bluetooth/hidp/sock.c
Hunk #1 FAILED at 189.
1 out of 1 hunk FAILED -- saving rejects to file
net/bluetooth/hidp/sock.c.rej




 
____________________________________________________________________________________
Need Mail bonding?
Go to the Yahoo! Mail Q&A for great tips from Yahoo! Answers users.
http://answers.yahoo.com/dir/?link=list&sid=396546091

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

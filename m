Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 18 Sep 2006 14:05:11 -0700 (PDT)
From: William Kreuter <billyk@drizzle.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10609181354210.8015-100000@froya.boat.washington.edu>
MIME-Version: 1.0
Subject: [Bluez-users] rfcomm broken in RHEL-WS-3 kernel 2.4.21
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

I've installed the bluez RPMs that I saw on rpmfind for Red Hat
Enterprise 3, which are bluez-libs-2.10-1.1.el3.rf.i386.rpm,
bluez-utils-2.9-1.1.fc3.rf.i386.rpm and
bluez-bluefw-1.0-1.rhel3.dag.i386.rpm.  These did not enable
rfcomm nor install /dev/rfcomm*.  The rfcomm executable always
reports, "Can't open RFCOMM control socket: Address family not
supported by protocol."

I then tried installing bluez-libs and bluez-utils from their
tarballs.  This changed nothing; /dev/rfcomm* still isn't there
and I still get the same error from the rfcomm executable.

My machine is RHEL-WS-3, kernel 2.4.21-32.0.1.ELsmp.  I use
whatever kernel rpm up2date gives and I don't compile kernels
myself anymore.

I got pretty much identical results from a second machine which
also runs Red Hat Enterprise Workstation 3 and kernel 2.4.15.

There were a few clues on this list's archives and elsewhere
that I should add these lines to /etc/modules.conf:

alias net-pf-31 bluez
alias bt-proto-0 l2cap
alias bt-proto-2 sco
alias bt-proto-3 rfcomm

Adding these didn't change anything.  Also, modprobe rfcomm
reports, "Can't locate module rfcomm".

So what should I do about the broken rfcomm?  I hope to use a
USB bluetooth dongle to send faxes through my cellphone.

Billy


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

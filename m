Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200501302046.ALU31339@ms12.netsolmail.com>
From: Chris Taylor <cht@imipolex-g.com>
Subject: Re: [Bluez-users] D-Link DWB-120M and BlueZ 2.14
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Sun, 30 Jan 2005 12:46:41 -0800


>do a "make install DESTDIR=$PWD/x" and then check what it is in the
>directory "x". Show us the result of a "find x".

Okay so I did this:
./configure --enable-bcm203x
 make install DESTDIR=$PWD/x

here's what's in x:

x
x/usr
x/usr/sbin
x/usr/sbin/hcid
x/usr/sbin/hciattach
x/usr/sbin/hciconfig
x/usr/sbin/sdpd
x/usr/share
x/usr/share/man
x/usr/share/man/man5
x/usr/share/man/man5/hcid.conf.5
x/usr/share/man/man8
x/usr/share/man/man8/hcid.8
x/usr/share/man/man8/hciattach.8
x/usr/share/man/man8/hciconfig.8
x/usr/share/man/man8/sdpd.8
x/usr/share/man/man1
x/usr/share/man/man1/hcitool.1
x/usr/share/man/man1/l2ping.1
x/usr/share/man/man1/sdptool.1
x/usr/share/man/man1/ciptool.1
x/usr/share/man/man1/rfcomm.1
x/usr/share/man/man1/dund.1
x/usr/share/man/man1/pand.1
x/usr/share/man/man1/hidd.1
x/usr/bin
x/usr/bin/hcitool
x/usr/bin/l2ping
x/usr/bin/sdptool
x/usr/bin/ciptool
x/usr/bin/rfcomm
x/usr/bin/dund
x/usr/bin/pand
x/usr/bin/hidd
x/usr/bin/bluepin
x/etc
x/etc/bluetooth
x/etc/bluetooth/hcid.conf
x/etc/bluetooth/pin
x/etc/bluetooth/rfcomm.conf

That's it...? Thanks for your help.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

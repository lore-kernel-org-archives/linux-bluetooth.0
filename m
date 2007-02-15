Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45D3F804.5030601@mojo-working.com>
Date: Wed, 14 Feb 2007 22:04:52 -0800
From: Art Rothstein <art@mojo-working.com>
MIME-Version: 1.0
To: Bluez-devel <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Role switch: Detecting, predicting, preventing
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I am running two BTPROTO_RFCOMM applications on a PC with Ubuntu 2.6.17-11-386, 
each bound to its own USB dongle.  One is a client, the other a server.  Both 
use the existing link mode settings of SLAVE ACCEPT.  Yet an Accept Connection 
Request (traced with hcidump) shows Role Master, and the client receives a Role 
Change.

If I put the same application, with the same USB dongles, on a PC running 
Xubuntu 2.6.17-10-generic, the server's Accept Connection Request shows Role 
Slave, and the Role Change packet does not flow.

My questions:

(1) What causes the role switch?

(2) Can I detect the role switch programmatically after it has occurred?  Both 
hci_devinfo and getsockopt( s, SOL_RFCOMM, RFCOMM_LM, ...  ) claim the server is 
still a slave.

(3) Can I predict the role switch before it occurs?  Again, hci_devinfo and 
getsockopt provide no clues.

(4) Can I programmatically instruct the 2.6.17-11-386 server not to perform the 
role switch?  If hci_devinfo is already set to SLAVE, calling 
ioctl(HCISETLINKMODE) sounds unpromising.

What makes the role switch interesting, and undesirable, is that several 
Bluetooth devices (all devices with link manager 1.x?) are limited to two slave 
connections.  A third Create Connection fails with Command Disallowed, reflected 
to the Linux client application as "File descriptor in bad state".

As for motivation, I plan to use one Linux PC with lots of dongles to model the 
behavior of a large piconet.  A configuration that includes PCs running 
Microsoft's stack, or Macs running Apple's stack, is stuck with the role switch, 
but there are lots of configurations that use only peer-friendly devices.
-----
McKinley Systems
San Francisco
415-827-7575
http://www.mojo-working.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 28 Sep 2006 11:18:54 +0200
Message-Id: <1159435134.21120.7.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] L2CAP device specific information
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

Hi,

with the release of bluez-utils-3.6 and bluez-utils-3.6.1, I added an
additional command to the l2test program to determine the extended
features of the remote L2CAP implementation. This will help us to
identify which devices will support retransmission and flow control
and/or connectionless connections.

# ./l2test -z 00:04:76:*:*:*
Connectionless MTU size is 670
Extended feature mask is not supported

The program must be run as root and can be found in the test directory
of bluez-utils. The switch --enable-test for configure enables its
compilation. There is not need to install it, you can run it from that
directory directly. If it stalls, then this might be a bug in the remote
L2CAP implementation when it doesn't answer to information requests. In
this case you might wanna run hcidump and check what happens.

So please report back information about your devices and I will collect
them and make them public at this location:

	http://www.holtmann.org/linux/bluetooth/l2cap.html

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

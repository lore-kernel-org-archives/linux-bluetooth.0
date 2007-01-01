Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 1 Jan 2007 20:51:15 +0800
To: bluez-devel <bluez-devel@lists.sourceforge.net>
Message-ID: <20070101125115.GA4041@163.com>
MIME-Version: 1.0
From: amateur <ztl.post@gmail.com>
Subject: [Bluez-devel] Data Transmission Error with OHCI Host Controller
Reply-To: amateur <tlzhao@nudt.edu.cn>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi Guys,

I have a problem with bluez on a arm platform. Here is the detail:
On the arm embedded platform, I invoke this command
	l2ping -s 667 BDADDR
to test the bluetooth L2CAP connection, where BDADDR is the bluetooth
address of my Linux/Bluez laptop. At the same time, I use 
	hcidump -x -R
on my laptop to monitor the bluetooth traffic. The problem is that the
data I sent from the embedded arm platform got corrupted on
receptioin.  After a careful check, I found that the error has the
following pattern: Some bytes of the ACL data packet, which
corresponding to the L2CAP Echo Request Command, will have some 4
bytes of its content changed from valid data to 4 bytes of zero on
occasion. And this change-to-zero error may occur several times in a
ACL Packet sometimes. The distance between consecutive errors is
always a multiple of 64-bytes which is the maxPacketSize of the USB
pipe of the bluetooth dongle.  The offset of the error position in the
ACL Packet is always 64*i+4-64*i+7(4 bytes), where 'i' is an integer.

I am really confused. I have checked the skb and urb associated with
the ACL Packet. And they both looks fine(content correct). So where
could the problem lies in? Has anyone have had such a problem before?
Any clue or hints are welcome!

Is this an known bug of OHCI HC driver usb-ohci in kernel 2.4.21? What
makes me more confused is that the Usb Storage Disk works great on the
embedded system.

I'm using linux-2.4.21 with patch-linux-2.4.21-mh10 and a cirrus edb9312
embedded arm platform which has a OHCI-Compatible USB Host Controller.
The bluetooth dongle is a CSR one which works normally on my laptop
PC.

Thank you in advance, guys.

Regards

Tianlei


-- 
For the fashion of Minas Tirith was such that it was built on seven levels,
each delved into a hill, and about each was set a wall, and in each wall
was a gate.
		-- J.R.R. Tolkien, "The Return of the King"

	[Quoted in "VMS Internals and Data Structures", V4.4, when
	 referring to system overview.]


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

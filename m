Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Matthias =?utf-8?b?QnJ1bsOp?= <matthiasbrune@gmx.de>
Message-ID: <loom.20050119T121309-507@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Sending own L2CAP packets to HCI
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 19 Jan 2005 11:21:49 +0000 (UTC)

Dear Marcel,
I wrote a program that builds its own L2CAP packets together.
And now I want to inject these L2CAP packets to a mobile phone.
I begin the transmission with a simple "connection request", but the command is 
rejected with reason 0 (command not understood).
Can you tell me how to inject L2CAP packets to HCI without using the BlueZ 
L2CAP layer?

best regards 
Matthias

hci dump:
HCIDump - HCI packet analyzer ver 1.7
device: hci0 snap_len: 1028 filter: 0xffffffff
 HCI Command: Create Connection(0x01|0x0005) plen 13
 HCI Event: Command Status(0x0f) plen 4
 HCI Event: Connect Complete(0x03) plen 11
 HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
 ACL data: handle 0x0029 flags 0x02 dlen 12
   L2CAP(s): Connect req: psm 1 scid 0x005d
 HCI Event: Number of Completed Packets(0x13) plen 5
 HCI Event: Command Complete(0x0e) plen 6
 HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
 HCI Event: Max Slots Change(0x1b) plen 3
 ACL data: handle 0x0029 flags 0x02 dlen 16
   L2CAP(s): Connect rsp: dcid 0x0040 scid 0x005d result 0 status 0
 ACL data: handle 0x0029 flags 0x02 dlen 10
   L2CAP(s): Command rej: reason 0
 ACL data: handle 0x0029 flags 0x02 dlen 12
   L2CAP(s): Config req: dcid 0x005d flags 0x0000 clen 0
 ACL data: handle 0x0029 flags 0x02 dlen 10
   L2CAP(s): Command rej: reason 0
 HCI Event: Number of Completed Packets(0x13) plen 5
 HCI Event: Number of Completed Packets(0x13) plen 5
 ACL data: handle 0x0029 flags 0x02 dlen 12
   L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
 HCI Event: Number of Completed Packets(0x13) plen 5
 ACL data: handle 0x0029 flags 0x02 dlen 14
   L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 ACL data: handle 0x0029 flags 0x02 dlen 14
   L2CAP(s): Command rej: reason 2
 HCI Event: Number of Completed Packets(0x13) plen 5
 ACL data: handle 0x0029 flags 0x02 dlen 12
   L2CAP(s): Disconn req: dcid 0x0040 scid 0x005d
 HCI Event: Number of Completed Packets(0x13) plen 5
 ACL data: handle 0x0029 flags 0x02 dlen 14
   L2CAP(s): Command rej: reason 2
 HCI Command: Disconnect(0x01|0x0006) plen 3
 HCI Event: Command Status(0x0f) plen 4
 HCI Event: Disconn Complete(0x05) plen 4



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

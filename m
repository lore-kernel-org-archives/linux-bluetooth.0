Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Matthias Brune <matthiasbrune@gmx.de>
Message-ID: <loom.20050121T013101-9@post.gmane.org>
References: <loom.20050119T121309-507@post.gmane.org> <1106136563.8190.89.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: Sending own L2CAP packets to HCI
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
Date: Fri, 21 Jan 2005 00:31:33 +0000 (UTC)

Hi Marcel, 
 
i tried to change the l2ping program by using another command header.  
Instead of L2CAP_ECHO_REQ and L2CAP_ECHO_RES i used L2CAP_CONN_REQ and 
L2CAP_CONN_RES, because i want to build a full connection with connect, 
configure and disconnect later... 
It seemed that it works, but hcidump said that the connect request is 
rejected.  
Is it in general possible to inject own L2CAP packets (with configure 
requests) to a phone by using the l2ping programm. I mean is the socket setup 
in this program for this use sufficient or do i have to inject the packets 
directly to the usb driver? Because i think the command reject comes from the 
Bluez stack and i have to inject the L2CAP packets without using the BlueZ 
stack? 
 
HCI Command: Create Connection(0x01|0x0005) plen 13 
65 CF 93 EE 02 00 18 CC 02 00 00 00 01 
HCI Event: Command Status(0x0f) plen 4 
00 01 05 04 
HCI Event: Connect Complete(0x03) plen 11 
00 29 00 65 CF 93 EE 02 00 01 00 
HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4 
29 00 0F 00 
ACL data: handle 0x0029 flags 0x02 dlen 28 
L2CAP(s): Connect req: psm 17989 scid 0x4847 
HCI Event: Number of Completed Packets(0x13) plen 5 
01 29 00 01 00 
HCI Event: Command Complete(0x0e) plen 6 
01 0D 08 00 29 00 
HCI Event: Page Scan Repetition Mode Change(0x20) plen 7 
65 CF 93 EE 02 00 01 
HCI Event: Max Slots Change(0x1b) plen 3 
29 00 05 
ACL data: handle 0x0029 flags 0x02 dlen 16 
 
L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0000 result 2 status 0 
 
ACL data: handle 0x0029 flags 0x02 dlen 10 
L2CAP(s): Command rej: reason 0 
 
HCI Event: Number of Completed Packets(0x13) plen 5 
01 29 00 01 00 
HCI Command: Disconnect(0x01|0x0006) plen 3 
29 00 13 
HCI Event: Command Status(0x0f) plen 4 
00 01 06 04 
HCI Event: Disconn Complete(0x05) plen 4 
00 29 00 16 
 



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

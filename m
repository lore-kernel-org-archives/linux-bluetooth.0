Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46F38209.1050507@tfh-berlin.de>
Date: Fri, 21 Sep 2007 10:34:17 +0200
From: David Rehle <rehle@tfh-berlin.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] can't etablish more than two connections
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi all,

depending on my previous post on bluez-devel list, i want to tell same 
issue with more informations.

i can not establish more than two clientconnections with my bluetooth 
server. I use sockets in C. Server allocates a socket, bind(), listen() 
and accepts incomming client-requests in a loop.

I tried both, rfcomm and l2cap. But the third client always gets a "Host 
is down" error during connect();

First i used only one rfcomm port 1, where two connections can be 
established.
Next i tried to build two sockets with different rfcomm channels, but it 
fails with same error.
After that i built two server-apps with different rfcomm channels with 
same error.

I do not understand why there can be two connections on only one rfcomm 
port (or l2cap psm) established. It is not clear to me, why there can 
connect two clients on one rfcomm-channel 1 and not only one client, or 
more than two??? (same for l2cap)

I am using bluez-libs and utils version 3.9 on ubuntu linux (feisty fawn).

hciconfing -a tells me the following:

hci0:   Type: USB
         BD Address: myBDaddress ACL MTU: 384:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:1842 acl:55 sco:0 events:103 errors:0
         TX bytes:1307 acl:53 sco:0 commands:24 errors:0
         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy:
         Link mode: SLAVE ACCEPT
         Name: 'myPCname'
         Class: 0x000000
         Service Classes: Unspecified
         Device Class: Miscellaneous,
         HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP 
Subver: 0x7a6
         Manufacturer: Cambridge Silicon Radio (10)

i tried another USB-BT device with samme issue, where hciconfig -a told 
me the following:

hci0:   Type: USB
         BD Address: myBDaddress ACL MTU: 384:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:15077 acl:139 sco:0 events:424 errors:0
         TX bytes:3337 acl:129 sco:0 commands:120 errors:0
         Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'myPCname'
         Class: 0x3e0100
         Service Classes: Networking, Rendering, Capturing, Object 
Transfer, Audio
         Device Class: Computer, Uncategorized
         HCI Ver: 2.0 (0x3) HCI Rev: 0x976 LMP Ver: 2.0 (0x3) LMP 
Subver: 0x976
         Manufacturer: Cambridge Silicon Radio (10)

I called the manufacturer to ask him if his hardware supports only two 
connections, but he told me that it has to be possible to connect seven 
devices, like bluetooth specification says.

Does somebody got same issues?
Has anybody an idea why only two connections can be established?

Thank you for any suggestions.


with kind regards

David

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

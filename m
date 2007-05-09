Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4641EFF2.5090903@idlum.be>
Date: Wed, 09 May 2007 17:59:46 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] "ACL Connection Already Exists" while using only DBus
	calls
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

I've a system with several dongles, which are driven by a custom app, 
using only DBus calls to hcid.

Using dongle hci4, I connected to a device, performed some operations, 
and disconnected:

2007-05-09 17:11:23,997 hci4  < HCI Command: Disconnect (0x01|0x0006) plen 3
2007-05-09 17:11:23,997 hci4      handle 11 reason 0x13
2007-05-09 17:11:23,997 hci4      Reason: Remote User Terminated Connection
2007-05-09 17:11:23,999 hci4  > HCI Event: Command Status (0x0f) plen 4
2007-05-09 17:11:23,999 hci4      Disconnect (0x01|0x0006) status 0x00 
ncmd 1
2007-05-09 17:11:24,031 hci4  > HCI Event: Disconn Complete (0x05) plen 4
2007-05-09 17:11:24,031 hci4      status 0x00 handle 11 reason 0x16
2007-05-09 17:11:24,032 hci4      Reason: Connection Terminated by Local 
Host

A very few seconds later,  the app tried to reconnect (requesting a SDP 
record) using another dongle, hci3. And I got that error:

2007-05-09 17:11:26,892 hci3  < HCI Command: Create Connection 
(0x01|0x0005) plen 13
2007-05-09 17:11:26,892 hci3      bdaddr 00:60:57:BB:4D:92 ptype 0xcc18 
rswitch 0x00 clkoffset 0x0000
2007-05-09 17:11:26,892 hci3      Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-05-09 17:11:26,908 hci3  > HCI Event: Command Status (0x0f) plen 4
2007-05-09 17:11:26,908 hci3      Create Connection (0x01|0x0005) status 
0x0b ncmd 1
2007-05-09 17:11:26,908 hci3      Error: ACL Connection Already Exists

It tried again 30s latter, with the same result.


2007-05-09 17:11:56,623 hci3  < HCI Command: Create Connection 
(0x01|0x0005) plen 13
2007-05-09 17:11:56,623 hci3      bdaddr 00:60:57:BB:4D:92 ptype 0xcc18 
rswitch 0x00 clkoffset 0x0000
2007-05-09 17:11:56,623 hci3      Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-05-09 17:11:56,638 hci3  > HCI Event: Command Status (0x0f) plen 4
2007-05-09 17:11:56,638 hci3      Create Connection (0x01|0x0005) status 
0x0b ncmd 1
2007-05-09 17:11:56,638 hci3      Error: ACL Connection Already Exists

At that point, I did shut the application down.

How can such a thing happen?

Thanks in advance,
Best Regards

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

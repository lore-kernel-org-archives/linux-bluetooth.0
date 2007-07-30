Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46ADD0F9.4010501@belkam.com>
Date: Mon, 30 Jul 2007 16:52:25 +0500
From: Dmitry Melekhov <dm@belkam.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] athentification problem
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

Hello!

My colleague tries to connect gps device over bluethooth.
He uses ubuntu 7.04

He starts

$ passkey-agent --default 0000

Then

$ sudo rfcomm connect 00:15:7F:00:4F:0C
Can't connect RFCOMM socket: Connection refused

< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< ACL data: handle 1 flags 0x02 dlen 12
   L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> ACL data: handle 1 flags 0x02 dlen 16
   L2CAP(s): Connect rsp: dcid 0x01fd scid 0x0040 result 1 status 2
     Connection pending - Authorization pending
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Read Remote Supported Features (0x0b) plen 11
> HCI Event: Remote Name Req Complete (0x07) plen 255
> ACL data: handle 1 flags 0x02 dlen 16
   L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 4 status 0
     Connection refused - no resources available
> HCI Event: Disconn Complete (0x05) plen 4


l2ping works OK.

He also tried to compile latest bluez code and have the same result.

Could you help us?

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: monetr@web.de
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200504262235.43441.monetr@web.de>
Subject: [Bluez-users] Encryption Mode Not Acceptable
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
Date: Tue, 26 Apr 2005 22:35:43 +0200

Hello,
i am trying to connect my zaurus (2.4.18-rmk7-pxa3-embedix  + dtl1_cs) with my 
linux host (2.6.11 hci_usb).
The zaurus says
ZAURUS# hcitool cc XXX
Can't create connection: Connection timeout
HOST# hcidump -a -V -x
HCI sniffer - Bluetooth packet analyzer ver 1.17
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:E0:03:25:0B:EF class 0x000000 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x24 handle 41 bdaddr 00:E0:03:25:0B:EF type ACL encrypt 0x00
    Error: Encryption Mode Not Acceptable


i played with different configurations in hcid.conf, but they make no 
difference.
Strangely A connection from host to zaurus works fine. After that the zaurus 
can create a bnep connection to the host.

Has anyone a clue how to solve the problem?


Best regards

Rainer



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

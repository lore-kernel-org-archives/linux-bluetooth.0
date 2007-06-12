Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: CIJOML <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Date: Tue, 12 Jun 2007 22:56:12 +0200
MIME-Version: 1.0
Message-Id: <200706122256.12825.cijoml@volny.cz>
Subject: [Bluez-users] hid2hci in utils-3.11 at x86_64 (P4 with 64bit
	extension) doesn't switch Logitech dongle
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

Hi,

at i386 I getts:

notas:/usr/src# lsusb
Bus 008 Device 001: ID 0000:0000
Bus 007 Device 008: ID 046d:c70c Logitech, Inc.
Bus 007 Device 007: ID 046d:c70b Logitech, Inc.
Bus 007 Device 006: ID 046d:0b02 Logitech, Inc.
Bus 007 Device 001: ID 0000:0000
Bus 006 Device 001: ID 0000:0000
Bus 005 Device 001: ID 0000:0000
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000
notas:/usr/src# hid2hci
Switching device 046d:c70c to HCI mode was successful
Switching device 046d:c70b to HCI mode was successful
notas:/usr/src# lsusb
Bus 008 Device 001: ID 0000:0000
Bus 007 Device 009: ID 046d:c709 Logitech, Inc.
Bus 007 Device 008: ID 046d:c70c Logitech, Inc.
Bus 007 Device 007: ID 046d:c70b Logitech, Inc.
Bus 007 Device 006: ID 046d:0b02 Logitech, Inc.
Bus 007 Device 001: ID 0000:0000
Bus 006 Device 001: ID 0000:0000
Bus 005 Device 001: ID 0000:0000
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000


At x86_64 I getts successfull enable, but Bus 007 Device 006: ID 046d:0b02 
Logitech, Inc. doesn't show up and hciconfig see NO dongle.

Thanks a lot for fix

Michal

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

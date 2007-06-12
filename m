Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <52222.190.30.202.149.1181668125.squirrel@www.y2knetworks.com.ar>
Date: Tue, 12 Jun 2007 14:08:45 -0300 (ART)
From: msaglietto@y2knetworks.com.ar
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Multi Dongle Problem
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
im making a program in C ... and was trying to use multi dongles ...
this is the hcitool dev output:

Devices:
        hci0    00:11:F6:0A:06:7B
        hci1    00:11:F6:0A:06:63

and that i make in my program is this...

str2ba("00:11:F6:0A:06:7B",&bdaddr);
dev_id = hci_get_route(&bdaddr);

but when u see the light of the dongles the hci1 is in use ...
and the hci0 is in use when the program use sdp...
to solve this i make the link mode of hci0 MASTER ... but then dont care
what i punt on the hci_get_route function... im making something wrong??
almost forgot... in some case the program finish with this error
Failed to connect to SDP server: Interrupted system call ... what can be?...

Regards, Mauricio




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

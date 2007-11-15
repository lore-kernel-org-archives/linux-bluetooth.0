Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <473BFAD7.6090107@omepet.es>
Date: Thu, 15 Nov 2007 08:52:55 +0100
From: jm <jmtoro@omepet.es>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] device doesn't support
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

Hi!

I want to know if my dongle supports the HCI_Write_Page_Timeout command, 
so I do:

#hcitool -i hci0 cmd 0x04 0x0003 (informational commands, read supported 
commands)

and I get:

< HCI Command: ogf 0x04, ocf 0x0003, plen 0
 > HCI Event: 0x0e plen 12
  01 03 10 00 FF FF 8F FE 9B F9 00 80
                                       ^
According to this results, the dongle supports HCI_Write_Page_Timeout,
but I am getting 12 octets instead of 16 (BT spec.), Why?

Am I doing something wrong? Something related to bit-byte ordering?
Is the information returned by hcitool correct? Please reply.

Thanks!

JM

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

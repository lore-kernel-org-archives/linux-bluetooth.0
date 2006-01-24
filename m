Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: <darrylkuhn@cox.net>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <20060124174123.RKWZ15695.fed1rmmtao01.cox.net@[172.18.180.8]>
Subject: [Bluez-users] Bluetooth on d610
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
Date: Tue, 24 Jan 2006 12:42:21 -0500

To all,

Greetings. I'm new to the group and very much interested in getting bluetooth up and running on my dell D610. I've searched the mailing list for some hints and found a conversation between Marcel and Tomas Honzak, but have been unable to piece together exactly how the problem was solved. So here are some details on my box and if there are any suggestions I'd be much obliged...

uname -a:
Linux vannevar 2.6.10 #1 Fri Jul 8 14:33:24 PDT 2005 i686 GNU/Linux

dpkg -l | grep bluez:
ii  bluez-bcm203x  2.10-5         Firmware loader for Broadcom 203x based Blue
ii  bluez-firmware 1.0-2          Firmware for Bluetooth devices
ii  bluez-hcidump  1.12-1         Analyses Bluetooth HCI packets
ii  bluez-pin      0.24-1         Bluetooth PIN helper with D-BUS support
ii  bluez-utils    2.24-1         Bluetooth tools and daemons

lsusb:
Bus 005 Device 001: ID 0000:0000
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 007: ID 413c:8103 Dell Computer Corp.
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000

(it's my understanding that Bus 002 Device 007: ID 413c:8103 Dell Computer Corp. is the bloothdevice)

hciconfig:
gives me nothing (d'oh)

Thanks in advance!
-Darryl



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

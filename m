Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4086DDFC.5000107@over-here.org>
From: Eran <eran_l@over-here.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Ambicom BT2000E card, can't get hciattach to work
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 21 Apr 2004 23:47:56 +0300

Hello,
I recently purchased at BT2000E card and tried making it work with bluez.
I have installed bluetooth drivers and according to the instructions 
from this page 
(http://www.zaurususergroup.com/modules.php?op=modload&name=phpWiki&file=index&pagename=Bluetooth) 
and I had to mess around a bit with the /etc/init.d/bluetooth file in 
order to make things work.
I can get an RFCOMM to work, but when trying to work with hci I fail:
1) on /etc/init.d/bluetooth I have a line that does hciattach:
root@thumper:/etc/pcmcia# /usr/sbin/hciattach /dev/ttyS3 bcsp 57600
Can't get port settings: Input/output error
Can't initialize device: Input/output error

2) hcitool scan and cc <phone> works, but hci lq fails:
root@thumper:/etc/pcmcia# hcitool lq 00:80:37:D6:93:D5
HCI get_link_quality cmd failed (0x01)

This command worked for me with another bluetooth card (those cheap 
mavin cards) and I assume it has something to do with the hciattach failing.

Extra info:
I'm on sharp zarusu SL-5500 with OZ 3.3.5 and kernel  
2.4.18-rmk7-pxa3-embedix (default OZ).
cardctl ident output:
root@thumper:/etc/pcmcia# cardctl ident
Socket 0:
  product info: "AmbiCom,Inc", "BT2000E", "Bluetooth PC/CF Card"
  manfid: 0x022d, 0x2000
  function: 2 (serial)
dmesg of bluez drivers doesn't show anything special, And before I 
installed bluetooth drivers the card showed as serial device on /dev/ttyS3.

Thank you all and keep up the good work,
ERan



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

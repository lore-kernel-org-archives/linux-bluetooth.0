Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Rainer Dorsch <rdorsch@web.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200411282132.37941.rdorsch@web.de>
Subject: [Bluez-users] Setting up an hotplug connection with USB dongles
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
Date: Sun, 28 Nov 2004 21:32:37 +0100

Hello,

I am wondering, if there is a way to setup a hotplug connection between two 
Linux machines using two bluetooth dongles. One of them is a NAP (with 
Internet access) and booted first, the other box a PANU.

My problem is that I need the pand running on both sides first before I can do 
an ifconfig for the bnep0 interface on the NAP.



What I did on both Debian Linux systems is:

Add a file

/etc/hotplug/usb/libbt.usermap

The file contains a line for an epox DG02A dongle

epoxbt                0x0003 0x0a12   0x0001    0x0000       0x0000       0x00         
0x00            0x00            0x00            0x00            0x00            
0x00000000

with the vendor ID (here 0x0a12) and the product ID (here 0x0001).

Then add the script epoxbt to the same directory:

# cat epoxbt
echo "Load epox bluetooth dongle..."

modprobe bnep
pand --master --listen --role NAP
#

and 

topsi:~# cat /etc/hotplug/usb/epoxbt
#!/bin/bash

echo "Load epox bluetooth dongle..."
modprobe bnep
pand --role PANU --connect <BT-ID>
topsi:~#


Then I do on the NAP an 

# ifconfig 192.128.2.1

and on the PANU

# dhclient

This works fine, I can access the Internet from the PANU.


The problem is that the ifconfig on the NAP fails when I do not have the PANU 
connected before....thus I can't add the network configuration part into the 
expobt scripts.

Does anyone have an idea or pointer for that problem.

Thanks,
Rainer

-- 
Rainer Dorsch
Alzentalstr. 28
D-71083 Herrenberg
07032-919495
Icq: 32550367


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

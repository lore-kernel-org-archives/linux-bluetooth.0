Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Colin Pinkney <bluez-devel@cpinkney.org.uk>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403312311.00434.bluez-devel@cpinkney.org.uk>
Subject: [Bluez-devel] Ambicom BT2000C CF Card Driver
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 31 Mar 2004 23:11:00 +0100

I've got a contact at Ambicom now that is being quite helpful with technical 
questions and as I still have a BT2000C CF card on loan from someone I hope 
to push forward with writing a driver for it (or modify an existing driver).

The Ambicom BT2000C card still uses the OX16c950 UART chip like the BT2000E 
(which the bt950 driver is for), but now uses the CSR Bluetooth chip instead 
of the Ericsson chip.

So I was wondering if there might be a quick(er) way of developing a driver. 
Could I...

1) Take the OX16c950 support from the bt950_cs and combine it with, say, the 
CSR support in btuart_cs?

or

2) Add OX16c950 support to hciattach and use hci_uart as is?

I am quite familiar with using and setting up BlueZ but I'm new to developing 
for it, so I might be talking rubbish.

Has anyone any thoughts on this? Is there a better way of going about this? 
I'm guessing Marcel would like the support to be put in an existing driver if 
possible, instead of having yet another driver to maintain.

I will be looking through the existing driver source code, but it would be 
nice to have a plan of attack so to speak to make it easier.

Thanks,

-- 
Colin Pinkney
http://www.cpinkney.org.uk


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

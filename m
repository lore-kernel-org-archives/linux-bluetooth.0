Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <424780AA.4020705@coloradocollege.edu>
From: Jonathan Bredin <jbredin@coloradocollege.edu>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] creating the bnep0 device
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
Date: Sun, 27 Mar 2005 20:57:30 -0700

hello all,

I have a pretty remedial question involving setting up bluettoth in 
Linux, but I don't think that I've seen any answers in the documentation 
or mailing list. 

I'm using kernel 2.6.11 with a LinkSys USBBT100 adaptor.  The adaptor 
can scan and ping other bluetooth devices with l2ping, but I'm having 
problems getting bnep0 recognized as a network interface.

ifconfig bnep0 returns
bnep0: error fetching interface information: Device not found

The fedora utility sees bnep0, but cannot activate it and returns
SIOCGIFFLAGS: No such device
when I try to deactivate it.

I get the same results when I use bluez/benp compiled into the kernel or 
loading them as modules.  /var/log/messages has the bluetooth messages:
Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: L2CAP ver 2.7
Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: L2CAP socket layer initialized
Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: RFCOMM ver 1.5
Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: RFCOMM socket layer 
initialized
Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: RFCOMM TTY layer initialized
Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: BNEP (Ethernet Emulation) 
ver 1.2
Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: BNEP filters: protocol 
multicast
Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: HIDP (Human Interface 
Emulation) ver 1.1

Does anyone have suggestions to get bnep0 off the ground?

Thanks,

jonathan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Victor Shcherbatyuk <victor@win.tue.nl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Connection with aphonestaysopenafterclosingRFCOMM
 channel
Message-ID: <Pine.LNX.4.44.0503032110450.24841-100000@antilope>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 3 Mar 2005 21:16:03 +0100 (MET)

And now with modules:

_before:

Module                  Size  Used by
rfcomm                 35100  0 
hidp                   27136  2 
l2cap                  23044  10 rfcomm,hidp
hci_usb                12744  2 
bluetooth              43908  8 rfcomm,hidp,l2cap,hci_usb

_listening:

Module                  Size  Used by
rfcomm                 35100  3 
hidp                   27136  2 
l2cap                  23044  10 rfcomm,hidp
hci_usb                12744  2 
bluetooth              43908  8 rfcomm,hidp,l2cap,hci_usb

_connected:

Module                  Size  Used by
rfcomm                 35100  3 
hidp                   27136  2 
l2cap                  23044  12 rfcomm,hidp
hci_usb                12744  3 
bluetooth              43908  8 rfcomm,hidp,l2cap,hci_usb

_afrer:

Module                  Size  Used by
rfcomm                 35100  1                  <---------- ?
hidp                   27136  2 
l2cap                  23044  12 rfcomm,hidp
hci_usb                12744  3 
bluetooth              43908  8 rfcomm,hidp,l2cap,hci_usb


Hope that explains....

Regards,

Victor.


----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sent: Thursday, March 03, 2005 00:54
Subject: Re: [Bluez-devel] Connection with 
aphonestaysopenafterclosingRFCOMM channel


> Hi Victor,
> 
>> 2.6.10-mh4  - did not help
> 
> so this is still a problem with the current Bluetooth subsystem.
> 
>> lsmod - /proc/modules is empty, but i have no modules (everything i 
>> need is compiled into kernel)...
> 
> Too bad, because I don't know of any other way to check the module
> reference counting. If there is something wrong we would be sure that I
> have to look for that.
> 
>> l2cap:
>> 72:FF:28:C6:10:00 42:E4:11:DE:0F:00 1 3 0x0040 0x0043 1024 251 0x0
>> 00:00:00:00:00:00 00:00:00:00:00:00 4 19 0x0000 0x0000 48 48 0x0
>> 00:00:00:00:00:00 00:00:00:00:00:00 4 17 0x0000 0x0000 48 48 0x0
>> 00:00:00:00:00:00 00:00:00:00:00:00 4 1 0x0000 0x0000 672 0 0x0
>> 00:00:00:00:00:00 00:00:00:00:00:00 4 3 0x0000 0x0000 1024 0 0x0
> 
> The L2CAP PSM 3 for RFCOMM is still connected. It's actually that what I
> expected.
> 
>> Am I missing something?
> 
> No, because we should simply close the DLCI 0 when no other RFCOMM
> channel is open.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

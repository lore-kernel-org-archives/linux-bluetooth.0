Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BlueFritz! AP-x working as a Bluetooth device?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200503261218.00580.ch.schuetz@addcom.de>
References: <200503261218.00580.ch.schuetz@addcom.de>
Content-Type: text/plain
Message-Id: <1111836216.9195.162.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 26 Mar 2005 12:23:36 +0100

Hi Christoph,

>  I try to get a connection between two pc using bluetooth.
>  My hardware: AVM Fritz AP-X ISDN and one AVM BlueFritz USB Stick.
> The AVM-Web-Page says that it is possible on Windows so perhaps it is possible 
> on linux as well?

how should this work if you only have one BlueFRITZ! USB? To connect two
machines you need at least a second USB adapter.

> I have Suse Linux 9.1. The USB Stick is working under linux. I get internet 
> connection and can see the access point with hcitool scan. 
> As I connect just the AP-x to my computer hcitool scan finds no device. 

If you are connected then sometimes no other devices are shown. This
depends on the link manager firmware inside the dongle.

> Perhaps my question is answered in the feature page of holtmann.org but I 
> don't really understand it. The following information is given there:
> 
> Vendor  	Model  			Type  	Features  			HCI Ver	LMP Version  	Manufacturer
> AVM  	BlueFRITZ! AP-X  	ISDN  	0x2f 0x06 0x04 0x00  	   	1.1  (0x0001)  	AVM
> AVM 	BlueFRITZ! AP-X 	ISDN 	0x2f 0xbe 0x05 0x00 	  		1.1  (0x0001) 	AVM
> 
> What does the numbers for "Featrues" mean? And what is LMP?

Check the Bluetooth specification for more details about LMP.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

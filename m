Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't initialize bluetooth dongle with CBT100U
	chipset!
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1110643712.7592.7.camel@tux>
References: <1110643712.7592.7.camel@tux>
Content-Type: text/plain
Message-Id: <1110645441.8572.0.camel@pegasus>
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
Date: Sat, 12 Mar 2005 17:37:21 +0100

Hi Tamer,

> I bought a conceptronic bluetooth stick with the CBT100U chipset.
> 
> I compiled inside the kernel 2.6.11.1 the bluetooth option (not as
> module) and loaded the module: hci_usb and the applications (deamons):
> 
> hcid
> sdpd
> 
> After then, I run hciconfig and the output is still empty. How could it
> come? 

what does the content of /proc/bus/usb/devices say and do you see and
errors when calling dmesg?

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

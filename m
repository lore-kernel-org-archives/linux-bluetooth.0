Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Fujitsu-Siemens Celsius
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexander Kulakov <a.kulakov@mail.ru>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40AE57B3.2040808@mail.ru>
References: <40AD87B3.6020805@mail.ru> <1085154942.22191.6.camel@pegasus>
	 <40AE54A6.3070500@mail.ru> <1085167156.22191.34.camel@pegasus>
	 <40AE57B3.2040808@mail.ru>
Content-Type: text/plain
Message-Id: <1085167965.22191.44.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 21 May 2004 21:32:45 +0200

Hi Alexander,

> >>I just tried to boot 2.6.6 kernel with "acpi=off" and got some 
> >>interesting lines in syslog after loading hotplug subsystem:
> >>
> >>uhci_hcd 0000:00:1d.2: Intel Corp. 82801CA/CAM USB (Hub #3)
> >>PCI: Setting latency timer of device 0000:00:1d.2 to 64
> >>uhci_hcd 0000:00:1d.2: irq 10, io base 00001840
> >>uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
> >>hub 3-0:1.0: USB hub found
> >>hub 3-0:1.0: 2 ports detected
> >>usb 3-1: new full speed USB device using address 2
> >>usb 3-1: device descriptor read/8, error -71
> >>usb 3-1: new full speed USB device using address 3
> >>usb 3-1: device descriptor read/8, error -71
> >>
> >>This way it can see some device connected.
> >>    
> >>
> >
> >so show us /proc/bus/usb/devices.
> >
> >  
> >
> Still nothind but hubs

talk to the USB guys about the error -71 and the problem with reading
the device descriptor. It seems that you must solve this first, before
you can continue with Bluetooth.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

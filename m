Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] 2.6.5 problems turned to 2.6.3 but also problems
From: Marcel Holtmann <marcel@holtmann.org>
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200404121317.52361.wim.delvaux@adaptiveplanet.com>
References: <200404120349.34338.wim.delvaux@adaptiveplanet.com>
	 <1081767326.5398.87.camel@pegasus>
	 <200404121317.52361.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1081776828.5398.109.camel@pegasus>
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
Date: Mon, 12 Apr 2004 15:33:48 +0200

Hi Wim,

> I have tried with that version. (Applied the 2.6.5-mh3 patch)
> However then I get these 'bad atomic' errors

where do you get them? In the hci_usb driver or in the USB subsystem?

> I just retried with the 2.6.3 kernel and saw
> 
> 'device not accepting address' messages error -110
> And then

Know problem. Some broken device which needs a longer timeout value.

> drivers/usb/host/uhci-hcd.c: uhci_result_control() failed with status 440000
> [ceb01240] link (0eb011e2) element (0ecb9040)
>   0: [cecb9040] link (0ecb9080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 
> EndPt=0 Dev=0, PID=2d(SETUP) (buf=0bd05e40)
>   1: [cecb9080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 
> Dev=0, PID=69(IN) (buf=00000000)
> 
> after a few inserts it gives
> 
> usb 1-1: new full speed USB device using address 10
> usb 1-1: new device strings: Mfr=0, Product=0, SerialNumber=0
> drivers/usb/core/usb.c: usb_hotplug
> usb 1-1: registering 1-1:1.0 (config #1, interface 0)
> drivers/usb/core/usb.c: usb_hotplug
> usb 1-1: registering 1-1:1.1 (config #1, interface 1)
> drivers/usb/core/usb.c: usb_hotplug
> usb 1-1: registering 1-1:1.2 (config #1, interface 2)
> drivers/usb/core/usb.c: usb_hotplug
> Bluetooth: HCI USB driver ver 2.4
> hci_usb 1-1:1.0: usb_probe_interface
> hci_usb 1-1:1.0: usb_probe_interface - got id
> hci_usb 1-1:1.1: usb_probe_interface
> hci_usb 1-1:1.2: usb_probe_interface
> hci_usb 1-1:1.2: usb_probe_interface - got id
> drivers/usb/core/usb.c: registered new driver hci_usb
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb c4d61214 err -22
> hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb c4d61214 err -22

Bug in the hci_usb driver. Disable CONFIG_BT_HCIUSB_SCO.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

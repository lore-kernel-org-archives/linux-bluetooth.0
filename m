Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4223E423.4030603@cloutier-vilhuber.net>
From: Lars Vilhuber <lists.all@cloutier-vilhuber.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <20050228143635.6E7668844B@sc8-sf-spam1.sourceforge.net>
In-Reply-To: <20050228143635.6E7668844B@sc8-sf-spam1.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Report of working dongle: IOGear GBU311 and question
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
Date: Mon, 28 Feb 2005 22:40:19 -0500

I can happily report that my new IOGear GBU311 works under stock SuSE 
9.2 (connections tested with Palm T3 and Sony-Ericsson T610, using 
OBEX-FTP, OBEX-transfer, DUN).

However, I am curious: when plugging it in, the logs show a USB *HUB*, 
and registers keyboard and mouse drivers. Is this something SuSE 
specific, something driver-specific? Is SuSE misconfigured? or what does 
it mean when the USB dongle registers as a keyboard/mouse?


iveshall kernel: hub 1-2:1.0: USB hub found
iveshall kernel: hub 1-2:1.0: 3 ports detected
iveshall kernel: usb 1-2.1: new full speed USB device using address 3
iveshall kernel: usb 1-2.1: Product: BCM92035DGL
iveshall kernel: usb 1-2.1: Manufacturer: Broadcom
iveshall kernel: usb 1-2.1: SerialNumber: 000272C09F18
iveshall kernel: usb 1-2.2: new full speed USB device using address 4
iveshall kernel: usb 1-2.2: SerialNumber: 000272C09F18
iveshall kernel: usb 1-2.3: new full speed USB device using address 5
iveshall kernel: usb 1-2.3: SerialNumber: 000272C09F18
iveshall kernel: Bluetooth: HCI USB driver ver 2.7
iveshall kernel: usbcore: registered new driver hci_usb
iveshall hcid[4926]: HCI dev 0 registered
iveshall kernel: usbcore: registered new driver hiddev
iveshall kernel: evdev_connect: evdev e4fffe60 handle e4fffe7c name event4
iveshall kernel: input: USB HID v1.11 Keyboard [0a5c:3502] on 
usb-0000:00:1d.0-2.2
iveshall kernel: evdev_connect: evdev e6ae45c0 handle e6ae45dc name event5
iveshall kernel: input: USB HID v1.11 Mouse [0a5c:3503] on 
usb-0000:00:1d.0-2.3
iveshall kernel: usbcore: registered new driver usbhid
iveshall kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver


-- 
Lars Vilhuber                    lists.all@cloutier-vilhuber.net


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

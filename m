Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3F048FF4.4080609@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] hci_usb module interrupts?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 03 Jul 2003 21:20:04 +0100

I have the following bluez modules loaded: -
hci_usb                 8088   1
bluez                  32356   1  [hci_usb]

hciconfig hci0 down
No interrupts from the bluetooth device.
hciconfig hci0 up
About 100 interrupts per second from the bluetooth device.
hciconfig hci0 down
No more interrupts from the bluetooth device.

There is no actual data coming from the bluetooth device, as I can check 
with hcidump. We get a few lines of output at the transition from up to 
down and down to up, but nothing in between.

Is this activity normal?
Does is happen with the PC card or PCI card usb adapters ?
It seems to me that these interrupts should not be there.

Can anybody shed some light on this problem?

Cheers
James




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

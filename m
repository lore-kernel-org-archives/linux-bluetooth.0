Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] USB - Stable connection
From: Marcel Holtmann <marcel@holtmann.org>
To: "P. Elias" <p_ilias@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY17-F24SjJVBFdAhT0002d945@hotmail.com>
References: <BAY17-F24SjJVBFdAhT0002d945@hotmail.com>
Content-Type: text/plain
Message-Id: <1085686133.8896.45.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 27 May 2004 21:28:53 +0200

Hi,

> I'm not sure if this is a bluez related issue but it might help some people 
> who have l2cap connection problems.
> 
> I'm running kernel 2.4.22 on both machines (1 desktop, 1 laptop) without any 
> patch installed. USB and Bluetooth support compiled as modules.
> 
> I had troubles getting a stable l2cap link between them. The connection was 
> breaking after some packet transmission, even by surfing the web. The cause 
> of the problem was the UHCI module (laptop side) which was crashing 
> unexpectedly after removing it with the bluetooth dongle plugged. I tried to 
> load the USB-UHCI instead and the link works fine now. I tested it overnight 
> downloading 1.5 GB at 75Kbps stable speed without any interrupt.
> 
> Have a look at my loaded modules:
> 
> usb-uhci             23500   0  (unused)
> hci_usb              8088     1
> usbcore              62624   1  [usb-uhci hci_usb]
> bnep                  10324   1
> crc32                  2880    0  [bnep]
> l2cap                 16876   2  [bnep]
> bluez                 32196   1  [hci_usb bnep l2cap]
> 
> I hope this will help you guys..

thanks for the information, but this is an USB problem and not Bluetooth
related.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

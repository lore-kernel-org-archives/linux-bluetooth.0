Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] HCI forwarding
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A5FC8B00118FAC@resmta05.ono.com> (added by postmaster@resmta05.ono.com)
References: <41A5FC8B00118FAC@resmta05.ono.com>
	 (added by postmaster@resmta05.ono.com)
Content-Type: text/plain
Message-Id: <1104687145.8894.14.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 02 Jan 2005 18:32:25 +0100

Hi,

> > Set the device into raw mode. This should stop any processing.
> 
> Thanks, this really helped, with de hci device in raw mode now bluez does
> not attend the hci requests, but... how do I transmit hci frames?, simply by
> using send() function with the raw socket? (I'm doing this. I hope the
> frames to be sent to all bt devices in range of my usb dongle).

the HCI is for using the local Bluetooth chip. You can deal with HCI
interfaces of remote chips. You write HCI commands and read HCI event on
the HCI raw socket.

> > Use the hci_vhci driver.
> 
> How would be useful the virtual hci driver for this purpose? Did you mean
> that I must set a virtual hci device for receiving and transmitting hci
> traffic?, would it work even if hci_vhci is not attached to a real bt radio?

Look at hciemu. It uses hci_vhci to emulate a Bluetooth device.

> - Will do all game and application traffic (L2CAP and RFCOMM connections are
> used only) go trough the hci traffic I'm forwarding? (I've seen that device
> discovery (COD detection, clock offset....) is not sniffed with the raw
> socket).

Parts of this are LMP or lower. You won't get them.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

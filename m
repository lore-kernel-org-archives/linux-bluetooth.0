Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A7074C0036241B@resmta03.ono.com> (added by postmaster@resmta03.ono.com)
From: "radeX" <radex@ono.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] HCI forwarding
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1104687145.8894.14.camel@pegasus>
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
Date: Sun, 2 Jan 2005 20:02:28 +0100

Understood!
Device detection is not a problem since bluez does it for me (I only have to
set the local class of device to the correct value (0x500204) in order to
deceiving mobile phones in both sides). I conform with forwarding L2CAP and
RFCOMM profile connection data, SDP and the rest of necessary HCI commands
and events to make possible a long-distance L2CAP / RFCOMM session.

Is this possible in this way?, In other?, Am I wrong?
(I wrote the app sniffing and forwarding hci frames (it seems that "works")
but I had no chance for testing it).

Hciemu reading in progess ;)

Regards.

-----Mensaje original-----
De: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] En nombre de Marcel
Holtmann
Enviado el: domingo, 02 de enero de 2005 18:32
Para: BlueZ Mailing List
Asunto: RE: [Bluez-devel] HCI forwarding

Hi,

> > Set the device into raw mode. This should stop any processing.
> 
> Thanks, this really helped, with de hci device in raw mode now bluez does
> not attend the hci requests, but... how do I transmit hci frames?, simply
by
> using send() function with the raw socket? (I'm doing this. I hope the
> frames to be sent to all bt devices in range of my usb dongle).

the HCI is for using the local Bluetooth chip. You can deal with HCI
interfaces of remote chips. You write HCI commands and read HCI event on
the HCI raw socket.

> > Use the hci_vhci driver.
> 
> How would be useful the virtual hci driver for this purpose? Did you mean
> that I must set a virtual hci device for receiving and transmitting hci
> traffic?, would it work even if hci_vhci is not attached to a real bt
radio?

Look at hciemu. It uses hci_vhci to emulate a Bluetooth device.

> - Will do all game and application traffic (L2CAP and RFCOMM connections
are
> used only) go trough the hci traffic I'm forwarding? (I've seen that
device
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




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A5FC8B00118FAC@resmta05.ono.com> (added by postmaster@resmta05.ono.com)
From: "radeX" <radex@ono.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] HCI forwarding
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1104665949.8286.7.camel@pegasus>
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
Date: Sun, 2 Jan 2005 17:58:05 +0100

> Set the device into raw mode. This should stop any processing.

Thanks, this really helped, with de hci device in raw mode now bluez does
not attend the hci requests, but... how do I transmit hci frames?, simply by
using send() function with the raw socket? (I'm doing this. I hope the
frames to be sent to all bt devices in range of my usb dongle).

> Use the hci_vhci driver.

How would be useful the virtual hci driver for this purpose? Did you mean
that I must set a virtual hci device for receiving and transmitting hci
traffic?, would it work even if hci_vhci is not attached to a real bt radio?

- Will do all game and application traffic (L2CAP and RFCOMM connections are
used only) go trough the hci traffic I'm forwarding? (I've seen that device
discovery (COD detection, clock offset....) is not sniffed with the raw
socket).

I think that's all.

Regards.

Thank you very much - I'll give you credit in the authors section. ;)

-----Mensaje original-----
De: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] En nombre de Marcel
Holtmann
Enviado el: domingo, 02 de enero de 2005 12:39
Para: BlueZ Mailing List
Asunto: Re: [Bluez-devel] HCI forwarding

Hi,

> I'm developing an application to connect two Bluetooth-enabled phones
> via internet using two Bluetooth-enabled PCs both connected to
> internet. I mean that I can transmit files and play Bluetooth
> multiplayer games to my friend that is 25 miles away like if it were
> in my device's Bluetooth radio range. (I know that ping times would be
> very ugly!).
> 
> I use a raw socket as hcidump does, then I send the data trough TCP to
> the other peer, when received is sent over Bluetooth hoping that the
> other device receives it, this is more complex than it seems since
> bluez handles and answers all HCI requests, i.e (when a device
> performs a SDP request to find a service UUID bluez handles and
> answers the request) but this is not correct for my application, hci
> responses and data acks may be received via TCP from the other peer,
> in other words: no bluez support, only HCI frames sniffing, sending,
> receiving and transmitting. Now my questions are:
> 
>  
> 
> -         Can I send HCI frames with a raw socket ?

yes, you can.

> -         How can I tell the bluez stack not to answer HCI requests
> (receiving only, leave the sends to me).

Set the device into raw mode. This should stop any processing.

> -     Is there a better way to make this application?

Use the hci_vhci driver.

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

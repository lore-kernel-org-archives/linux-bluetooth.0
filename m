Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI forwarding
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A7074C00357A08@resmta03.ono.com> (added by postmaster@resmta03.ono.com)
References: <41A7074C00357A08@resmta03.ono.com>
	 (added by postmaster@resmta03.ono.com)
Content-Type: text/plain; charset=iso-8859-13
Message-Id: <1104665949.8286.7.camel@pegasus>
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
Date: Sun, 02 Jan 2005 12:39:09 +0100

Hi,

> I=FFm developing an application to connect two Bluetooth-enabled phones
> via internet using two Bluetooth-enabled PCs both connected to
> internet. I mean that I can transmit files and play Bluetooth
> multiplayer games to my friend that is 25 miles away like if it were
> in my device=FFs Bluetooth radio range. (I know that ping times would b=
e
> very ugly!).
>=20
> I use a raw socket as hcidump does, then I send the data trough TCP to
> the other peer, when received is sent over Bluetooth hoping that the
> other device receives it, this is more complex than it seems since
> bluez handles and answers all HCI requests, i.e (when a device
> performs a SDP request to find a service UUID bluez handles and
> answers the request) but this is not correct for my application, hci
> responses and data acks may be received via TCP from the other peer,
> in other words: no bluez support, only HCI frames sniffing, sending,
> receiving and transmitting. Now my questions are:
>=20
> =20
>=20
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

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A7074C00364239@resmta03.ono.com> (added by postmaster@resmta03.ono.com)
From: "radeX" <radex@ono.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] HCI forwarding
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1104693661.8894.25.camel@pegasus>
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
Date: Sun, 2 Jan 2005 21:26:42 +0100

Hi again Marcel:

Ok, I'll keep track of the ACL MTU's.

I'm a little lost in other implementation point:
If we have the A peer and B peer connected trough tcp, Imagine that the A
phone wants to connect B one, then it inquires and finds the hci device of
the A PC and sends the connection requests and all other stuff, these data
is sniffed with the A raw socket and forwarded to the B PC by TCP where is
sent over B's hci device again, but... hci frames from A phone may be sent
to the A PC's hci device's bluetooth address, not to B phone's Bluetooth
address, may this be a problem? Would I need to parse the frames to change
the destination address or change the A hci device address to B phone's
address and B one to A phone address?

Can I change the local chip BT address?

I'll try to get more familiar with this low-level Bluetooth stuff.

Thank you for spending your time helping me.

-----Mensaje original-----
De: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] En nombre de Marcel
Holtmann
Enviado el: domingo, 02 de enero de 2005 20:21
Para: BlueZ Mailing List
Asunto: RE: [Bluez-devel] HCI forwarding

Hi,

> Device detection is not a problem since bluez does it for me (I only have
to
> set the local class of device to the correct value (0x500204) in order to
> deceiving mobile phones in both sides). I conform with forwarding L2CAP
and
> RFCOMM profile connection data, SDP and the rest of necessary HCI commands
> and events to make possible a long-distance L2CAP / RFCOMM session.

forwarding L2CAP channels or also ACL data packets is very easy. However
the ACL MTU should match. The role switches might be a little tricky.
Forwarding the HCI commands and events is not that easy. You must keep
an eye on the flow control mechanism of HCI, but this is all still
doable and there are more ways for doing it.

> Is this possible in this way?, In other?, Am I wrong?
> (I wrote the app sniffing and forwarding hci frames (it seems that
"works")
> but I had no chance for testing it).

It is possible and the best way depends on what you wanna do. Basically
I used L2CAP and RFCOMM forwarding a lot of this to crack protocol stuff
that was going on between some devices. Best example is the Nokia PhoNet
protocol.

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
